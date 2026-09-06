#!/bin/bash
set -e  # 遇到错误立即退出
export PATH=$PATH:/usr/local/bin

# ===================== 配置项（根据实际情况修改）=====================
# 部署根目录（docker_images和docker-compose.yml所在目录）
# 使用脚本所在目录的绝对路径
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEPLOY_DIR="$SCRIPT_DIR"
# 挂载目录根路径（和yml中一致）
MOUNT_BASE="/home/x1-docker"
# ===================================================================

# 步骤1：检查docker和docker-compose是否安装
# 步骤1：检查docker和docker-compose是否安装
check_dependency() {
    # 创建部署目录
    if [ ! -d "$DEPLOY_DIR" ]; then
        echo "📁 部署目录 $DEPLOY_DIR 不存在，正在创建..."
        mkdir -p "$DEPLOY_DIR"
        echo "✅ 部署目录创建完成"
    fi

    if ! command -v docker &> /dev/null; then
        echo "❌ 未安装docker，开始离线安装..."
        # 检查 docker 离线包是否存在
        if [ -f "docker-29.1.5.tgz" ]; then
            echo "📦 发现 docker-29.1.5.tgz 离线安装包，开始安装..."
            # 解压到临时目录
            tar -xzf docker-29.1.5.tgz -C /tmp
            # 复制二进制文件到系统目录
            cp /tmp/docker/* /usr/bin/
            # ========== 新增：配置systemd服务文件 ==========
            echo "📝 配置docker systemd服务..."
            mkdir -p /etc/systemd/system/
            cat > /etc/systemd/system/docker.service << EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service containerd.service
Wants=network-online.target

[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP \$MAINPID
TimeoutSec=0
RestartSec=2
Restart=always

# Note that StartLimit* options were moved from "Service" to "Unit" in systemd 229.
# Both the old, and new location are accepted by systemd 229 and up, so using the old location
# to make them work for either version of systemd.
StartLimitBurst=3

# Note that StartLimitInterval was renamed to StartLimitIntervalSec in systemd 230.
# Both the old, and new name are accepted by systemd 230 and up, so using the old name to make
# this option work for either version of systemd.
StartLimitInterval=60s

# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity

# Comment TasksMax if your systemd version does not support it.
# Only systemd 226 and above support this option.
TasksMax=infinity

# set delegate yes so that systemd does not reset the cgroups of docker containers
Delegate=yes

# kill only the docker process, not all processes in the cgroup
KillMode=process
OOMScoreAdjust=-500

[Install]
WantedBy=multi-user.target
EOF
            # 重新加载systemd配置
            systemctl daemon-reload
            # ========== 结束：新增systemd配置 ==========
            # 启动 docker 服务
            systemctl start docker
            systemctl enable docker
            echo "✅ Docker 离线安装完成"
        else
            echo "❌ 未找到 docker-29.1.5.tgz 离线安装包，请将其放在当前目录"
            exit 1
        fi
    fi

    # 剩余部分（docker-compose、unzip检查）保持不变

    if ! command -v docker-compose &> /dev/null; then
        echo "⚠️  未找到 docker-compose 命令，强制本地安装..."

        # 强制从当前目录安装
        BIN_TARGET="/usr/local/bin/docker-compose"
        if [ -f "$DEPLOY_DIR/docker-compose-linux-x86_64" ]; then
            echo "📦 发现本地 docker-compose 文件，正在安装..."
            cp "$DEPLOY_DIR/docker-compose-linux-x86_64" "$BIN_TARGET"
            chmod +x "$BIN_TARGET"
            echo "✅ docker-compose 已安装到 $BIN_TARGET"
        else
            echo "❌ 错误：未找到 docker-compose-linux-x86_64 文件！"
            exit 1
        fi

        # 强制让命令立即生效（关键修复）
        export PATH=$PATH:/usr/local/bin
        hash -r
        echo "✅ 环境变量已刷新，docker-compose 命令可用"
    fi

    # 检查是否安装了 unzip
    if ! command -v unzip &> /dev/null; then
        echo "❌ 未安装 unzip，请先手动安装 unzip 工具"
        echo "   建议：在有外网的环境中下载 unzip 离线安装包并安装"
        echo "   Debian/Ubuntu: apt download unzip && dpkg -i unzip*.deb"
        echo "   CentOS/RHEL: yumdownloader unzip && rpm -ivh unzip*.rpm"
        exit 1
    fi

    echo "✅ Docker环境检查完成"
}

# 步骤2：创建挂载目录并复制nginx配置
create_mount_dirs() {
    mkdir -p ${MOUNT_BASE}/jar/logs/{pc-logs,mobile-logs}
    # 只创建 sql-scripts 目录，不创建 mysql-data 目录
    # 让 MySQL 容器在启动时自动创建 mysql-data 目录
    mkdir -p ${MOUNT_BASE}/mysql/sql-scripts
    mkdir -p ${MOUNT_BASE}/redis/redis-data
    mkdir -p ${MOUNT_BASE}/minio/data
    mkdir -p ${MOUNT_BASE}/nginx/{conf.d,html}
    mkdir -p ${MOUNT_BASE}/emqx/{data,log,etc/plugins}
    chmod -R 755 ${MOUNT_BASE}
    
    # 复制当前目录下的conf.d和html到挂载目录
    SCRIPT_DIR="$(dirname "$0")"
    NGINX_CONF_DIR="${MOUNT_BASE}/nginx/conf.d"
    NGINX_HTML_DIR="${MOUNT_BASE}/nginx/html"
    
    echo "📄 正在复制nginx配置..."
    # 检查 MOUNT_BASE 目录是否存在
    echo "🔍 检查挂载目录是否存在..."
    if [ ! -d "$MOUNT_BASE" ]; then
        echo "📁 创建挂载目录：$MOUNT_BASE"
        mkdir -p "$MOUNT_BASE"
        echo "✅ 挂载目录创建完成"
    fi
    
    # 确保 nginx 配置目录存在
    echo "📁 确保 nginx 配置目录存在..."
    mkdir -p "$NGINX_CONF_DIR"
    echo "✅ nginx 配置目录已准备就绪"
    
    if [ -d "${SCRIPT_DIR}/conf.d" ]; then
        echo "📄 正在复制conf.d配置..."
        # 显示源目录和目标目录
        echo "📁 源目录：${SCRIPT_DIR}/conf.d"
        echo "📁 目标目录：$NGINX_CONF_DIR"
        # 复制配置文件
        cp -r "${SCRIPT_DIR}/conf.d/"* "$NGINX_CONF_DIR/"
        echo "✅ conf.d配置复制完成"
        
        # 检查复制结果
        echo "🔍 检查复制结果..."
        ls -la "$NGINX_CONF_DIR/"
        
        # 替换 conf.d 中文件的 x1-admin-api 为服务器 IP
        echo "🔧 正在替换 nginx 配置中的 x1-admin-api 为服务器 IP..."
        # 获取服务器 IP
        echo "🌐 获取服务器 IP..."
        SERVER_IP=$(hostname -I | awk '{print $1}')
        echo "   - hostname -I 结果：$SERVER_IP"
        if [ -z "$SERVER_IP" ]; then
            SERVER_IP=$(ip addr | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d'/' -f1 | head -1)
            echo "   - ip addr 结果：$SERVER_IP"
        fi
        if [ -z "$SERVER_IP" ]; then
            SERVER_IP="127.0.0.1"
            echo "   - 使用默认 IP：$SERVER_IP"
        fi
        echo "🌐 最终服务器 IP: $SERVER_IP"
        
        # 替换所有 conf.d 文件中的 x1-admin-api
        echo "🔄 开始替换配置文件中的 x1-admin-api..."
        for conf_file in "$NGINX_CONF_DIR"/*.conf; do
            if [ -f "$conf_file" ]; then
                echo "🔄 处理文件：$conf_file"
                # 检查文件中是否包含 x1-admin-api
                if grep -q "x1-admin-api" "$conf_file"; then
                    echo "   - 发现 x1-admin-api，开始替换..."
                    # 执行替换 - 只替换proxy_pass中的域名部分，保留路径部分
                    sed -i "s|proxy_pass  http://x1-admin-api:9092/x1-admin-api/|proxy_pass  http://$SERVER_IP:9092/x1-admin-api/|g" "$conf_file"
                    # 验证替换结果
                    echo "   - 验证替换结果..."
                    grep -n "x1-admin-api\|$SERVER_IP" "$conf_file"
                    echo "   - 替换完成"
                else
                    echo "   - 文件中未发现 x1-admin-api，跳过"
                fi
            fi
        done
        echo "✅ nginx 配置替换完成"
    else
        echo "⚠️  未找到conf.d目录，跳过复制"
        echo "📁 当前目录：$(pwd)"
        echo "📁 脚本目录：$SCRIPT_DIR"
        ls -la "$SCRIPT_DIR/"
    fi
    
    if [ -d "${SCRIPT_DIR}/html" ]; then
        echo "📄 正在复制html文件..."
        cp -r "${SCRIPT_DIR}/html/"* "$NGINX_HTML_DIR/"
        echo "✅ html文件复制完成"
    else
        echo "⚠️  未找到html目录，跳过复制"
    fi
    
    echo "✅ 挂载目录创建和nginx配置复制完成"
}

# 步骤3：加载镜像
load_images() {
    cd ${DEPLOY_DIR}
    
    # 检查是否已经存在所需的镜像
    echo "🔍 检查是否已经存在所需的镜像..."
    
    # 需要的镜像列表
    required_images=("mysql:8.0" "redis:latest" "minio:latest" "nginx:latest" "emqx/emqx:4.4.19")
    
    # 检查镜像是否存在
    missing_images=()
    for image in "${required_images[@]}"; do
        if ! docker images | grep -q "$(echo $image | cut -d: -f1)" | grep -q "$(echo $image | cut -d: -f2)"; then
            missing_images+=("$image")
        fi
    done
    
    # 如果所有镜像都已存在，跳过加载步骤
    if [ ${#missing_images[@]} -eq 0 ]; then
        echo "✅ 所有所需镜像都已存在，跳过加载步骤"
        return
    fi
    
    # 显示缺少的镜像
    echo "⚠️ 缺少以下镜像："
    for image in "${missing_images[@]}"; do
        echo "   - $image"
    done
    echo "🔄 开始加载镜像..."
    
    # 检查 docker_images 目录位置（同级目录）
    DOCKER_IMAGES_DIR=""
    if [ -d "../docker_images" ]; then
        DOCKER_IMAGES_DIR="../docker_images"
        echo "📁 发现同级目录中的 docker_images 文件夹"
    elif [ -d "./docker_images" ]; then
        DOCKER_IMAGES_DIR="./docker_images"
        echo "📁 发现当前目录中的 docker_images 文件夹"
    else
        echo "❌ 未找到docker_images文件夹，请检查路径！"
        echo "请确保 docker_images 目录与 deploy_local 目录同级，或在 deploy_local 目录内部"
        exit 1
    fi

    # 检查并解压压缩包
    if [ -f "../docker_images.tar.gz" ]; then
        echo "📦 发现同级目录中的 tar.gz 压缩包，先解压..."
        tar -zxvf "../docker_images.tar.gz"
    elif [ -f "../docker_images.zip" ]; then
        echo "📦 发现同级目录中的 zip 压缩包，先解压..."
        unzip "../docker_images.zip"
    elif [ -f "./docker_images.tar.gz" ]; then
        echo "📦 发现当前目录中的 tar.gz 压缩包，先解压..."
        tar -zxvf "./docker_images.tar.gz"
    elif [ -f "./docker_images.zip" ]; then
        echo "📦 发现当前目录中的 zip 压缩包，先解压..."
        unzip "./docker_images.zip"
    fi
    if [ -d "$DOCKER_IMAGES_DIR" ]; then
        # 修改：过滤掉admin和mobile相关的tar包
        for tar_file in "$DOCKER_IMAGES_DIR"/*.tar; do
            if [ -f "$tar_file" ]; then
                # 跳过admin和mobile镜像包
                if [[ $tar_file != *"admin"* && $tar_file != *"mobile"* ]]; then
                    echo "🔍 加载镜像包：$tar_file"
                    docker load -i "$tar_file"
                else
                    echo "⏭️  跳过admin/mobile镜像包：$tar_file"
                fi
            fi
        done
        echo "✅ 非自定义镜像加载完成"
    fi
}

build_custom_images() {
    # 固定部署根目录，匹配你实际路径
    DEPLOY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
    ADMIN_BUILD_DIR="${DEPLOY_DIR}/jar/admin"
    MOBILE_BUILD_DIR="${DEPLOY_DIR}/jar/mobile"

    # 自动获取本机内网IP
    SERVER_IP=$(hostname -I | awk '{print $1}')
    if [ -z "$SERVER_IP" ]; then
        SERVER_IP=$(ip addr | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d'/' -f1 | head -1)
    fi
    if [ -z "$SERVER_IP" ]; then
        SERVER_IP="127.0.0.1"
    fi
    echo "===== 开始构建admin、mobile镜像，服务器IP：$SERVER_IP ====="

    # 构建admin镜像：先替换Dockerfile里旧IP
    ADMIN_DOCKER="${ADMIN_BUILD_DIR}/Dockerfile"
    if [ -f "$ADMIN_DOCKER" ]; then
        sed -i -E "s/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/$SERVER_IP/g" "$ADMIN_DOCKER"
        cd "$ADMIN_BUILD_DIR"
        docker build -t admin:latest .
        cd "$DEPLOY_DIR"
        echo "✅ admin:latest 镜像构建完成"
    else
        echo "❌ 错误：$ADMIN_DOCKER 文件不存在"
        exit 1
    fi

    # 构建mobile镜像：先替换Dockerfile里旧IP
    MOBILE_DOCKER="${MOBILE_BUILD_DIR}/Dockerfile"
    if [ -f "$MOBILE_DOCKER" ]; then
        sed -i -E "s/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/$SERVER_IP/g" "$ADMIN_DOCKER"
        cd "$MOBILE_BUILD_DIR"
        docker build -t mobile:latest .
        cd "$DEPLOY_DIR"
        echo "✅ mobile:latest 镜像构建完成"
    else
        echo "❌ 错误：$MOBILE_DOCKER 文件不存在"
        exit 1
    fi

    echo "===== 自定义镜像全部构建完毕 ====="
}



# 步骤4：启动容器
start_services() {
    cd ${DEPLOY_DIR}
    if [ ! -f "docker-compose.yml" ]; then
        echo "❌ 未找到 docker-compose.yml"
        exit 1
    fi

    # 步骤1：路径适配 - 将 Mac 风格路径替换为 Linux 宿主机路径
    echo "📁 正在适配路径配置..."
    # 替换所有可能的路径格式为 Linux 风格
    sed -i "s|D:/x1-docker|${MOUNT_BASE}|g" "docker-compose.yml"
    sed -i "s|/Users/zjr/x1-docker|${MOUNT_BASE}|g" "docker-compose.yml"

    # 步骤2：IP 适配
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    if [ -z "$LOCAL_IP" ]; then
        LOCAL_IP=$(ip addr | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d'/' -f1 | head -1)
    fi
    if [ -z "$LOCAL_IP" ]; then
        LOCAL_IP="127.0.0.1"
    fi
    echo "🌐 检测到本机IP: $LOCAL_IP，正在更新emqx配置..."
    # 替换emqx配置中的IP
    sed -i "s/emqx@[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/emqx@$LOCAL_IP/g" "docker-compose.yml"

    # 步骤3：核心修复 - 清理旧的 MySQL 数据字典
    echo "⚠️ 正在清理 MySQL 旧数据以应用大小写不敏感配置..."
    # 停止并移除现有的 MySQL 容器
    if docker ps -a | grep -q mysql; then
        echo "📦 停止并移除现有的 MySQL 容器..."
        docker-compose stop mysql
        docker-compose rm -f mysql
    fi
    # 彻底删除旧的数据目录，防止 lower_case_table_names 冲突
    echo "🗑️ 删除所有可能的 MySQL 数据目录以应用新配置..."
    # 原始路径
    ORIG_MYSQL_DATA_DIR="/Users/zjr/x1-docker/mysql/mysql-data"
    # 可能的替换路径
    ALT_MYSQL_DATA_DIR="/home/x1-docker/mysql/mysql-data"
    # 使用 MOUNT_BASE 的路径
    MOUNT_MYSQL_DATA_DIR="${MOUNT_BASE}/mysql/mysql-data"
    
    # 删除所有可能的数据目录
    for data_dir in "$ORIG_MYSQL_DATA_DIR" "$ALT_MYSQL_DATA_DIR" "$MOUNT_MYSQL_DATA_DIR"; do
        if [ -d "$data_dir" ]; then
            echo "🗑️ 删除 MySQL 数据目录：$data_dir"
            rm -rf "$data_dir"
            echo "✅ MySQL 数据目录清理完成：$data_dir"
        fi
    done
    # 确保文件系统同步
    sync
    echo "✅ 所有旧数据清理完毕，准备启动新实例"

    # 步骤4：创建必要的目录结构
    echo "📁 正在创建必要的目录结构..."
    # 只创建 sql-scripts 目录，不创建 mysql-data 目录
    # 让 MySQL 容器在启动时自动创建 mysql-data 目录
    mkdir -p "${MOUNT_BASE}/mysql/sql-scripts"
    # 确保 MySQL 配置目录存在
    mkdir -p "${MOUNT_BASE}/mysql"

    # 步骤5：创建优化的 my.cnf 配置文件
    echo "⚡ 创建优化的 my.cnf 配置文件以应用大小写不敏感设置..."
    # 创建配置文件内容
    cat > "${MOUNT_BASE}/mysql/my.cnf" << EOF
[mysqld]
max_connections = 1000

# 大小写敏感设置（必须在初始化时设置）
lower_case_table_names = 1

# 导入速度优化参数
innodb_buffer_pool_size = 2G
innodb_log_file_size = 512M
innodb_write_io_threads = 16
innodb_read_io_threads = 16
innodb_flush_log_at_trx_commit = 0
sync_binlog = 0
skip-log-bin
innodb_autoextend_increment = 64
innodb_buffer_pool_instances = 8
innodb_concurrency_tickets = 10000
innodb_old_blocks_time = 1000
innodb_open_files = 8000
innodb_stats_on_metadata = 0
innodb_file_per_table = 1
innodb_checksum_algorithm = crc32

# 其他优化参数
max_allowed_packet = 1G
net_buffer_length = 16K
table_definition_cache = 2000
sort_buffer_size = 4M
read_buffer_size = 4M
read_rnd_buffer_size = 16M
join_buffer_size = 4M

# 超时设置
wait_timeout = 3600
interactive_timeout = 3600
net_read_timeout = 3600
net_write_timeout = 3600

# 禁用不需要的功能
skip-external-locking
symbolic-links = 0
host_cache_size = 0

# 字符集设置
character-set-server = utf8mb4
collation-server = utf8mb4_0900_ai_ci

# 导入优化
bulk_insert_buffer_size = 128M
myisam_sort_buffer_size = 128M
EOF
    
    echo "✅ MySQL 配置文件创建完成"
    # 确保配置文件权限正确
    chmod 644 "${MOUNT_BASE}/mysql/my.cnf"
    echo "✅ MySQL 配置文件权限设置完成"

    # 步骤6：清理重复的配置
    echo "🔧 清理重复的配置..."
    # 移除所有 pull_policy 配置
    sed -i "/pull_policy: never/d" "docker-compose.yml"
    
    # 修改 nginx 镜像标签为 latest，以匹配实际加载的镜像
    echo "🔧 修改 nginx 镜像标签..."
    sed -i "s|image: nginx:stable|image: nginx:latest|g" "docker-compose.yml"
    
    # 添加 pull_policy: never 配置
    echo "🔧 添加镜像拉取策略..."
    sed -i "s|image: admin:latest|image: admin:latest\n    pull_policy: never|g" "docker-compose.yml"
    sed -i "s|image: mobile:latest|image: mobile:latest\n    pull_policy: never|g" "docker-compose.yml"
    sed -i "s|image: mysql:8.0|image: mysql:8.0\n    pull_policy: never|g" "docker-compose.yml"
    sed -i "s|image: redis:latest|image: redis:latest\n    pull_policy: never|g" "docker-compose.yml"
    sed -i "s|image: minio:latest|image: minio:latest\n    pull_policy: never|g" "docker-compose.yml"
    sed -i "s|image: nginx:latest|image: nginx:latest\n    pull_policy: never|g" "docker-compose.yml"
    sed -i "s|image: emqx/emqx:4.4.19|image: emqx/emqx:4.4.19\n    pull_policy: never|g" "docker-compose.yml"
    
    # 步骤7：清理自动导入目录，避免MySQL Entrypoint脚本干扰
    echo "🔧 清理自动导入目录，避免MySQL Entrypoint脚本干扰..."
    SQL_SCRIPTS_DIR="${MOUNT_BASE}/mysql/sql-scripts"
    echo "📁 自动导入目录：$SQL_SCRIPTS_DIR"
    if [ -d "$SQL_SCRIPTS_DIR" ]; then
        echo "📁 清理目录中的SQL文件..."
        rm -f "$SQL_SCRIPTS_DIR"/*.sql 2>/dev/null
        echo "✅ 自动导入目录已清理"
        echo "📁 清理后目录内容："
        ls -la "$SQL_SCRIPTS_DIR/"
    else
        echo "📁 目录不存在，创建目录..."
        mkdir -p "$SQL_SCRIPTS_DIR"
        echo "✅ 目录创建完成"
    fi
    
    # 步骤8：修改nginx配置，处理x1-mobile-api未启动的情况
    echo "🔧 修改nginx配置，处理x1-mobile-api未启动的情况..."
    X1MOBILE_CONF="${MOUNT_BASE}/nginx/conf.d/x1mobile.conf"
    if [ -f "$X1MOBILE_CONF" ]; then
        echo "📄 正在修改 $X1MOBILE_CONF..."
        # 备份原始配置
        cp "$X1MOBILE_CONF" "$X1MOBILE_CONF.bak"
        # 修改配置，将x1-mobile-api替换为localhost，避免nginx启动失败
        sed -i "s|proxy_pass  http://x1-mobile-api:9094/x1-mobile-api/|proxy_pass  http://localhost:9094/x1-mobile-api/|g" "$X1MOBILE_CONF"
        echo "✅ x1mobile.conf 配置已修改"
        # 验证修改结果
        echo "📋 验证修改结果..."
        grep -n "proxy_pass" "$X1MOBILE_CONF"
    else
        echo "⚠️ 未找到 $X1MOBILE_CONF，跳过修改"
    fi
    
    # 步骤9：再次执行 nginx 配置替换（确保配置正确）
    echo "🔧 再次执行 nginx 配置替换，确保 IP 配置正确..."
    # 获取服务器 IP
    echo "🌐 获取服务器 IP..."
    SERVER_IP=$(hostname -I | awk '{print $1}')
    echo "   - hostname -I 结果：$SERVER_IP"
    if [ -z "$SERVER_IP" ]; then
        SERVER_IP=$(ip addr | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d'/' -f1 | head -1)
        echo "   - ip addr 结果：$SERVER_IP"
    fi
    if [ -z "$SERVER_IP" ]; then
        SERVER_IP="127.0.0.1"
        echo "   - 使用默认 IP：$SERVER_IP"
    fi
    echo "🌐 最终服务器 IP: $SERVER_IP"
    
    # 替换所有 conf.d 文件中的 x1-admin-api
    NGINX_CONF_DIR="${MOUNT_BASE}/nginx/conf.d"
    echo "📁 nginx 配置目录：$NGINX_CONF_DIR"
    echo "🔍 检查目录是否存在..."
    if [ -d "$NGINX_CONF_DIR" ]; then
        echo "✅ 目录存在"
        echo "📁 目录内容："
        ls -la "$NGINX_CONF_DIR/"
        
        echo "🔄 开始替换配置文件中的 x1-admin-api..."
        for conf_file in "$NGINX_CONF_DIR"/*.conf; do
            if [ -f "$conf_file" ]; then
                echo "🔄 处理文件：$conf_file"
                # 检查文件中是否包含 x1-admin-api
                if grep -q "x1-admin-api" "$conf_file"; then
                    echo "   - 发现 x1-admin-api，开始替换..."
                    # 执行替换 - 只替换proxy_pass中的域名部分，保留路径部分
                    sed -i "s|proxy_pass  http://x1-admin-api:9092/x1-admin-api/|proxy_pass  http://$SERVER_IP:9092/x1-admin-api/|g" "$conf_file"
                    # 验证替换结果
                    echo "   - 验证替换结果..."
                    grep -n "x1-admin-api\|$SERVER_IP" "$conf_file"
                    echo "   - 替换完成"
                else
                    echo "   - 文件中未发现 x1-admin-api，跳过"
                fi
            fi
        done
        echo "✅ nginx 配置替换完成"
    else
        echo "❌ 目录不存在，请检查路径设置"
        echo "📁 当前 MOUNT_BASE：$MOUNT_BASE"
        echo "📁 尝试创建目录..."
        mkdir -p "$NGINX_CONF_DIR"
        echo "✅ 目录创建完成"
    fi

    # 步骤8：启动容器
    echo "🚀 启动容器服务..."
    # 先停止并移除所有容器，确保配置完全重新加载
    echo "🔄 停止并移除所有容器，确保配置完全重新加载..."
    docker-compose down
    echo "✅ 所有容器已停止并移除"
    
    # 启动容器 - 先只启动MySQL相关服务
    echo "🚀 启动MySQL相关服务..."
    docker-compose up -d mysql redis minio nginx emqx
    echo "✅ MySQL相关服务启动完成，当前状态："
    docker-compose ps
    
    # 步骤9：验证 nginx 配置是否正确应用
    echo "🔍 验证 nginx 配置是否正确应用到容器中..."
    # 增加等待时间，确保所有容器都完全启动
    echo "⏳ 等待所有容器完全启动..."
    sleep 15  # 等待容器完全启动
    
    # 检查容器状态
    echo "📋 检查所有容器状态..."
    docker-compose ps
    
    # 等待 nginx 容器完全启动并稳定运行
    echo "⏳ 等待 nginx 容器完全启动并稳定运行..."
    max_wait=60
    wait_count=0
    while [ $wait_count -lt $max_wait ]; do
        NGINX_STATUS=$(docker inspect --format '{{.State.Status}}' nginx 2>/dev/null)
        if [ "$NGINX_STATUS" == "running" ]; then
            # 检查容器重启次数
            RESTART_COUNT=$(docker inspect --format '{{.RestartCount}}' nginx 2>/dev/null)
            if [ "$RESTART_COUNT" -lt 3 ]; then
                echo "✅ nginx 容器已稳定运行！"
                break
            else
                echo "⚠️ nginx 容器重启次数过多 ($RESTART_COUNT 次)，可能存在配置问题..."
                sleep 5
            fi
        else
            echo "⚠️ nginx 容器状态：$NGINX_STATUS，等待恢复..."
        fi
        echo "🔄 等待 nginx 容器稳定运行... ($wait_count/$max_wait 秒)"
        sleep 3
        wait_count=$((wait_count + 3))
        if [ $wait_count -ge $max_wait ]; then
            echo "⚠️ nginx 容器状态不稳定，跳过配置验证"
            break
        fi
    done
    
    # 检查容器内的 nginx 配置 - 添加错误处理
    echo "📋 检查容器内的 nginx 配置..."
    if docker exec nginx cat /etc/nginx/conf.d/x1pad.conf 2>/dev/null | grep -n "proxy_pass"; then
        echo "✅ x1pad.conf 配置检查完成"
    else
        echo "⚠️ 无法检查 x1pad.conf，容器可能未完全启动"
    fi
    
    if docker exec nginx cat /etc/nginx/conf.d/x1.conf 2>/dev/null | grep -n "proxy_pass"; then
        echo "✅ x1.conf 配置检查完成"
    else
        echo "⚠️ 无法检查 x1.conf，容器可能未完全启动"
    fi
    
    if docker exec nginx cat /etc/nginx/conf.d/x1mobile.conf 2>/dev/null | grep -n "proxy_pass"; then
        echo "✅ x1mobile.conf 配置检查完成"
    else
        echo "⚠️ 无法检查 x1mobile.conf，容器可能未完全启动"
    fi
    
    echo "✅ nginx 配置验证完成"
    
    # 简化版本：容器启动后等待30秒直接导入数据
    echo "⏳ MySQL 容器已启动，等待30秒让服务完全就绪..."
    for i in {1..30}; do
        echo -n "🔄 等待中... $i/30 秒\r"
        sleep 1
    done
    echo "\n✅ 等待完成，开始导入数据库..."
    
    # 检查容器状态
    echo "🔍 检查 MySQL 容器状态..."
    docker ps | grep mysql
    
    # 直接导入 SQL 文件，确保所有表都被创建
    echo "🚀 准备导入 SQL 文件..."
    # 检查 x1.sql 文件的多个可能位置
    SQL_FILES=("${DEPLOY_DIR}/x1.sql" "$(dirname "$0")/x1.sql")
    SQL_FILE_FOUND=""
    
    for sql_file in "${SQL_FILES[@]}"; do
        if [ -f "$sql_file" ]; then
            SQL_FILE_FOUND="$sql_file"
            echo "✅ 找到 x1.sql 文件：$SQL_FILE_FOUND"
            break
        fi
    done
    
    if [ -n "$SQL_FILE_FOUND" ]; then
        echo "📄 正在处理并导入 SQL 文件..."
        echo "📊 SQL 文件大小：$(ls -lh "$SQL_FILE_FOUND" | awk '{print $5}')"
        
        # 创建临时文件，移除所有无效信息
        TEMP_SQL="/tmp/schema_clean.sql"
        # 跳过以 "mysqldump:" 开头的行、空行、错误信息行以及警告信息行
        grep -v "^mysqldump:" "$SQL_FILE_FOUND" | grep -v "^$" | grep -v "Access denied" | grep -v "Warning" | grep -v "warning" > "$TEMP_SQL"
        echo "✅ 已处理 SQL 文件，移除无效警告和错误信息"
        
        # 确保 x1 数据库存在（带重试机制）
        echo "🔍 确保 x1 数据库存在..."
        CREATE_SUCCESS=false
        MAX_RETRIES=10
        RETRY_COUNT=0
        
        while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
            echo "🔄 尝试连接 MySQL 并创建数据库... 第 $((RETRY_COUNT + 1))/$MAX_RETRIES 次"
            if docker exec mysql mysql -h 127.0.0.1 -u root -proot@123456 -e "CREATE DATABASE IF NOT EXISTS x1 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;" 2>&1; then
                echo "✅ 数据库创建成功！"
                CREATE_SUCCESS=true
                break
            else
                echo "⚠️ 连接失败，等待 3 秒后重试..."
                sleep 3
                RETRY_COUNT=$((RETRY_COUNT + 1))
            fi
        done
        
        if [ "$CREATE_SUCCESS" = false ]; then
            echo "❌ 无法创建数据库，请检查容器状态！"
            docker logs mysql | tail -n 30
            exit 1
        fi
        
        # 检查并清理自动导入目录，避免MySQL Entrypoint脚本干扰
        echo "🔧 检查并清理自动导入目录..."
        docker exec mysql rm -f /docker-entrypoint-initdb.d/x1.sql 2>/dev/null
        echo "✅ 自动导入目录已清理"
        
        # 执行导入命令并捕获错误
        echo "🚀 开始导入 SQL 文件（请耐心等待，这可能需要几分钟）..."
        
        # 创建一个包含优化设置的临时文件
        ALL_SQL="/tmp/full_import.sql"
        echo "SET foreign_key_checks = 0; SET unique_checks = 0; SET autocommit = 0;" > "$ALL_SQL"
        cat "$TEMP_SQL" >> "$ALL_SQL"
        echo "COMMIT; SET foreign_key_checks = 1; SET unique_checks = 1; SET autocommit = 1;" >> "$ALL_SQL"
        
        # 统计 SQL 文件中的表数量
        EXPECTED_TABLE_COUNT=$(grep -c "CREATE TABLE" "$TEMP_SQL")
        INSERT_COUNT=$(grep -c "INSERT INTO" "$TEMP_SQL")
        echo "📊 统计结果："
        echo "   - 表结构数量：$EXPECTED_TABLE_COUNT"
        echo "   - 数据插入语句数量：$INSERT_COUNT"
        
        # 执行导入命令并捕获错误
        IMPORT_SUCCESS=true
        
        # 使用时间戳记录开始时间
        START_TIME=$(date +%s)
        
        # 执行导入并捕获详细错误信息
        echo "🚀 开始导入 SQL 文件..."
        echo "📊 导入信息："
        echo "   - SQL文件大小：$(ls -lh "$ALL_SQL" | awk '{print $5}')"
        echo "   - 预计表数量：$EXPECTED_TABLE_COUNT"
        echo "   - 预计数据插入语句：$INSERT_COUNT"
        echo "   - 开始时间：$(date '+%Y-%m-%d %H:%M:%S')"
        
        # 增加超时设置，确保大型SQL文件能够完整导入
        # 使用更可靠的方式执行导入，确保错误能够被正确捕获
        echo "🔄 正在执行导入命令..."
        echo "📋 导入命令：docker exec -i mysql mysql --max-allowed-packet=1G --net-read-timeout=3600 --net-write-timeout=3600 -u root -proot@123456 x1"
        
        # 先测试MySQL连接
        echo "🔍 测试MySQL连接..."
        if docker exec mysql mysql -u root -proot@123456 -e "SELECT 1;" 2>&1; then
            echo "✅ MySQL连接测试成功"
        else
            echo "❌ MySQL连接测试失败"
            echo "📋 检查MySQL容器状态..."
            docker ps | grep mysql
            echo "📋 检查MySQL容器日志..."
            docker logs mysql | tail -n 20
        fi
        
        # 执行导入，显示实时进度
        echo "🔄 执行导入..."
        echo "📋 导入前检查 MySQL 服务状态..."
        docker ps | grep mysql
        echo "📋 检查 MySQL 服务是否可访问..."
        docker exec mysql mysqladmin -u root -proot@123456 ping --silent
        
        # 使用更可靠的方式执行导入
        echo "🔄 开始执行导入命令..."
        # 直接执行导入，使用TCP连接，确保命令能够完成
        (cat "$ALL_SQL" | docker exec -i mysql mysql -h 127.0.0.1 --max-allowed-packet=1G -u root -proot@123456 x1)
        IMPORT_EXIT_CODE=$?
        
        echo "📋 导入后检查 MySQL 服务状态..."
        docker ps | grep mysql
        echo "📋 检查 MySQL 服务是否仍可访问..."
        docker exec mysql mysqladmin -h 127.0.0.1 -u root -proot@123456 ping --silent || echo "❌ MySQL 服务可能已关闭"
        
        echo "   - 结束时间：$(date '+%Y-%m-%d %H:%M:%S')"
        echo "🔄 导入命令执行完成，退出码：$IMPORT_EXIT_CODE"
        
        # 检查导入结果
        echo "🔍 检查导入结果..."
        if [ $IMPORT_EXIT_CODE -eq 0 ]; then
            echo "✅ 导入命令执行成功"
        else
            echo "❌ 导入命令执行失败"
            echo "📋 检查MySQL容器状态..."
            docker ps | grep mysql
            echo "📋 检查MySQL容器日志..."
            docker logs mysql | tail -n 30
        fi
        
        # 计算导入时间
        END_TIME=$(date +%s)
        IMPORT_TIME=$((END_TIME - START_TIME))
        
        if [ $IMPORT_EXIT_CODE -eq 0 ]; then
            echo "✅ SQL 文件导入完成！"
            echo "📊 导入统计："
            echo "   - 表结构：$EXPECTED_TABLE_COUNT 个"
            echo "   - 数据插入语句：$INSERT_COUNT 条"
            echo "   - 导入耗时：$IMPORT_TIME 秒"
            echo "   - 导入状态：成功"
            
            # 验证导入结果
            echo "🔍 验证导入结果..."
            ACTUAL_TABLE_COUNT=$(docker exec mysql mysql -h 127.0.0.1 -u root -proot@123456 -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'x1';" 2>/dev/null | tail -1)
            echo "   - 实际创建的表数量：$ACTUAL_TABLE_COUNT"
            echo "   - 预期表数量：$EXPECTED_TABLE_COUNT"
            
            if [ "$ACTUAL_TABLE_COUNT" -eq "$EXPECTED_TABLE_COUNT" ]; then
                echo "   - 表数量验证：一致 ✓"
            else
                echo "   - 表数量验证：不一致 ⚠️"
                echo "   - 差异数量：$((EXPECTED_TABLE_COUNT - ACTUAL_TABLE_COUNT)) 个表"
                echo "   - 检查未创建的表..."
                # 尝试获取已创建的表列表
                echo "   - 已创建的表："
                docker exec mysql mysql -u root -proot@123456 -e "USE x1; SHOW TABLES;" 2>/dev/null
            fi
            
        else
            echo "❌ SQL 文件导入失败，请检查错误信息！"
            echo "📋 导入错误信息："
            echo "$IMPORT_OUTPUT"
            # 查看 MySQL 日志
            echo "📋 MySQL 容器日志："
            docker logs mysql | tail -n 100
            IMPORT_SUCCESS=false
        fi
        
        # 清理临时文件
        rm -f "$ALL_SQL" "$TEMP_SQL"
        echo "✅ 临时文件清理完成"
    else
        echo "❌ 未找到 x1.sql 文件，请确保文件存在！"
    fi
    
    # 步骤15：验证数据库表结构
    echo "🔍 验证数据库表结构..."
    echo "📊 检查数据库是否存在："
    docker exec mysql mysql -h 127.0.0.1 -u root -proot@123456 -e "SHOW DATABASES LIKE 'x1';"
    
    echo "📊 检查 x1 数据库中的表数量："
    TABLE_COUNT=$(docker exec mysql mysql -h 127.0.0.1 -u root -proot@123456 -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'x1';" 2>/dev/null | tail -1)
    echo "表数量：$TABLE_COUNT"
    
    if [ "$TABLE_COUNT" -gt 0 ]; then
        echo "✅ 数据库表结构导入成功！"
        echo "📋 前 10 个表："
        docker exec mysql mysql -h 127.0.0.1 -u root -proot@123456 -e "USE x1; SHOW TABLES;" 2>/dev/null | head -10
        
        # 启动admin和mobile服务
        echo "🚀 启动admin服务..."
        docker-compose up -d x1-admin-api
        echo "🚀 启动mobile服务..."
        docker-compose up -d x1-mobile-api
        echo "✅ 服务启动完成，当前状态："
        docker-compose ps
    else
        echo "❌ 数据库表结构导入失败，表数量为 0！"
        # 检查 MySQL 容器状态
        echo "📋 MySQL 容器状态："
        docker inspect mysql --format '{{.State.Status}}'
        echo "📋 MySQL 容器日志："
        docker logs mysql | tail -n 50
    fi
}
# 主流程
main() {
    echo "===== 开始一键部署 ====="
    check_dependency
    create_mount_dirs
    load_images
    build_custom_images   # 新增这一行调用构建函数
    start_services
    echo "===== 部署完成 ====="
}

main
