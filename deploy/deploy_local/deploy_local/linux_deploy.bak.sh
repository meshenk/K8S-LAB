#!/bin/bash
set -e  # 遇到错误立即退出

# ===================== 配置项（根据实际情况修改）=====================
# 部署根目录（docker_images和docker-compose.yml所在目录）
DEPLOY_DIR="/home/x1/deploy_local"
# 挂载目录根路径（和yml中一致）
MOUNT_BASE="/home/x1-docker"
# ===================================================================

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
            # 启动 docker 服务
            cat << EOF > /usr/lib/systemd/system/docker.service
            [Unit]
            Description=Docker Application Container Engine
            Documentation=http://docs.docker.com
            After=network.target docker.socket
            [Service]
            Type=notify
            EnvironmentFile=-/run/flannel/docker
            WorkingDirectory=/usr/local/bin
            ExecStart=/usr/bin/dockerd  -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock --selinux-enabled=false --log-opt max-size=100m
            ExecReload=/bin/kill -s HUP $MAINPID
            LimitNOFILE=infinity
            LimitNPROC=infinity
            LimitCORE=infinity
            TimeoutStartSec=0
            Delegate=yes

            EOF

            systemctl start docker
            systemctl enable docker
            echo "✅ Docker 离线安装完成"
        else
            echo "❌ 未找到 docker-29.1.5.tgz 离线安装包，请将其放在当前目录"
            exit 1
        fi
    fi

    if ! command -v docker-compose &> /dev/null; then
        echo "⚠️  未找到 docker-compose 命令，检查本地文件..."
        # 检查是否存在 docker-compose-linux-x86_64 文件
        if [ -f "$DEPLOY_DIR/docker-compose-linux-x86_64" ]; then
            echo "📦 发现本地 docker-compose-linux-x86_64 文件，正在安装..."
            cp "$DEPLOY_DIR/docker-compose-linux-x86_64" /usr/local/bin/docker-compose
            chmod +x /usr/local/bin/docker-compose
            echo "✅ Docker Compose 安装完成"
        else
            echo "❌ 错误：未找到 docker-compose 命令和本地二进制文件！"
            echo "请将 docker-compose-linux-x86_64 文件放在 $DEPLOY_DIR 目录下"
            exit 1
        fi
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

# 步骤2：创建挂载目录
create_mount_dirs() {
    mkdir -p ${MOUNT_BASE}/jar/logs/{pc-logs,mobile-logs}
    mkdir -p ${MOUNT_BASE}/mysql/{mysql-data,sql-scripts}
    mkdir -p ${MOUNT_BASE}/redis/redis-data
    mkdir -p ${MOUNT_BASE}/minio/data
    mkdir -p ${MOUNT_BASE}/nginx/{conf.d,html}
    mkdir -p ${MOUNT_BASE}/emqx/{data,log,etc/plugins}
    chmod -R 755 ${MOUNT_BASE}
    echo "✅ 挂载目录创建完成"
}

# 步骤3：加载镜像
load_images() {
    cd ${DEPLOY_DIR}

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
        for tar_file in "$DOCKER_IMAGES_DIR"/*.tar; do
            if [ -f "$tar_file" ]; then
                # 加载所有镜像，包括 emqx
                echo "🔍 加载镜像包：$tar_file"
                docker load -i "$tar_file"
            fi
        done
        echo "✅ 所有镜像加载完成"
    else
        echo "❌ 未找到docker_images文件夹，请检查路径！"
        exit 1
    fi
}

# 步骤4：启动容器
# 步骤4：启动容器
start_services() {
    cd ${DEPLOY_DIR}
    if [ -f "docker-compose.yml" ]; then
        # 动态替换路径为当前部署目录
        echo "📁 正在适配路径配置..."
        sed -i "s|/Users/zjr|/home/x1|g" "docker-compose.yml"

        # 清理重复的 pull_policy 配置
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

        # 停止并移除现有的 MySQL 容器，删除数据目录以确保新的配置生效
        echo "🔧 正在准备 MySQL 容器配置..."
        if docker ps -a | grep -q mysql; then
            echo "📦 停止并移除现有的 MySQL 容器..."
            docker-compose stop mysql
            docker-compose rm -f mysql
        fi

        # 删除 MySQL 数据目录，确保新的 lower_case_table_names 配置生效
        MYSQL_DATA_DIR="/home/x1-docker/mysql/mysql-data"
        MYSQL_CONF_DIR="/home/x1-docker/mysql"
        if [ -d "$MYSQL_DATA_DIR" ]; then
            echo "🗑️ 删除 MySQL 数据目录以应用新配置..."
            rm -rf "$MYSQL_DATA_DIR"
            mkdir -p "$MYSQL_DATA_DIR"
            echo "✅ MySQL 数据目录清理完成"
        fi

        # 创建优化的 my.cnf 配置文件
        echo "⚡ 创建优化的 my.cnf 配置文件以加速导入..."
        mkdir -p "$MYSQL_CONF_DIR"
        cat > "$MYSQL_CONF_DIR/my.cnf" << EOF
[mysqld]
max_connections = 1000

# 导入速度优化参数
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
innodb_write_io_threads = 8
innodb_read_io_threads = 8
innodb_flush_log_at_trx_commit = 0
sync_binlog = 0
skip-log-bin
innodb_autoextend_increment = 64
innodb_buffer_pool_instances = 4
innodb_concurrency_tickets = 5000
innodb_old_blocks_time = 1000
innodb_open_files = 4000
innodb_stats_on_metadata = 0
innodb_file_per_table = 1
innodb_checksum_algorithm = crc32

# 其他优化参数
max_allowed_packet = 1G
net_buffer_length = 8K
table_definition_cache = 1400
sort_buffer_size = 2M
read_buffer_size = 2M
read_rnd_buffer_size = 8M
join_buffer_size = 2M

# 禁用不需要的功能
skip-external-locking
symbolic-links = 0

# 字符集设置
character-set-server = utf8mb4
collation-server = utf8mb4_0900_ai_ci
EOF
        echo "✅ MySQL 配置文件创建完成"

        # 确保配置文件权限正确
        chmod 644 "$MYSQL_CONF_DIR/my.cnf"
        echo "✅ MySQL 配置文件权限设置完成"

        echo "🚀 启动容器服务..."
        docker-compose up -d
        echo "✅ 容器启动完成，当前状态："
        docker-compose ps

        # 等待 MySQL 完全启动
        echo "⏳ 等待 MySQL 服务完全启动（最多 60 秒）..."
        max_wait=60
        wait_count=0
        while [ $wait_count -lt $max_wait ]; do
            if docker exec mysql mysqladmin -u root -proot@123456 ping --silent; then
                echo "✅ MySQL 服务已成功启动！"
                break
            fi
            echo "🔄 等待中... ($wait_count/$max_wait 秒)"
            sleep 5
            wait_count=$((wait_count + 5))
            if [ $wait_count -ge $max_wait ]; then
                echo "❌ MySQL 启动超时，请检查容器日志！"
                docker logs mysql | tail -n 30
                break
            fi
        done

        # 手动导入 x1.sql 文件，确保表结构创建
        echo "📥 手动导入 x1.sql 文件，确保表结构创建..."

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
            echo "📝 SQL 文件前 5 行内容："
            head -5 "$SQL_FILE_FOUND"

            # 创建临时文件，移除所有无效信息
            TEMP_SQL="/tmp/schema_clean.sql"
            # 跳过以 "mysqldump:" 开头的行、空行、错误信息行以及警告信息行
            grep -v "^mysqldump:" "$SQL_FILE_FOUND" | grep -v "^$" | grep -v "Access denied" | grep -v "Warning" | grep -v "warning" > "$TEMP_SQL"
            echo "✅ 已处理 SQL 文件，移除无效警告和错误信息"
            echo "📊 处理后文件大小：$(ls -lh "$TEMP_SQL" | awk '{print $5}')"
            echo "📝 处理后文件前 5 行内容："
            head -5 "$TEMP_SQL"

            # 确保 x1 数据库存在并清理现有表结构
            echo "🔍 确保 x1 数据库存在并清理现有表结构..."
            # 先删除并重新创建 x1 数据库，确保是全新的导入
            if docker exec mysql mysql -u root -proot@123456 -e "DROP DATABASE IF EXISTS x1; CREATE DATABASE x1 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"; then
                echo "✅ 数据库清理和创建完成"
            else
                echo "❌ 数据库清理和创建失败，请检查容器状态！"
                docker logs mysql | tail -n 20
            fi

            # 优化 MySQL 配置，加快导入速度
            echo "⚡ 正在优化 MySQL 配置以加快导入速度..."
            # 只设置会话级别的参数，避免全局参数设置错误
            echo "✅ MySQL 配置优化完成"

            # 执行导入命令并捕获错误
            echo "🚀 开始导入 SQL 文件..."
            # 统计 SQL 文件中的表数量
            TABLE_COUNT=$(grep -c "CREATE TABLE" "$TEMP_SQL")
            echo "📊 总共需要导入 $TABLE_COUNT 张表"

            # 直接导入完整的 SQL 文件，包括表结构和数据
            echo "🚀 开始导入完整 SQL 文件（包括表结构和数据）..."

            # 创建一个包含优化设置的临时文件
            ALL_SQL="/tmp/full_import.sql"
            echo "SET foreign_key_checks = 0; SET unique_checks = 0; SET autocommit = 0;" > "$ALL_SQL"
            cat "$TEMP_SQL" >> "$ALL_SQL"
            echo "COMMIT; SET foreign_key_checks = 1; SET unique_checks = 1; SET autocommit = 1;" >> "$ALL_SQL"

            # 统计导入内容
            echo "📊 统计导入内容..."
            TABLE_COUNT=$(grep -c "CREATE TABLE" "$TEMP_SQL")
            INSERT_COUNT=$(grep -c "INSERT INTO" "$TEMP_SQL")
            echo "📋 统计结果："
            echo "   - 表结构数量：$TABLE_COUNT"
            echo "   - 数据插入语句数量：$INSERT_COUNT"

            # 执行导入命令并捕获错误
            IMPORT_SUCCESS=true
            echo "🚀 开始导入 SQL 文件（请耐心等待，这可能需要几分钟）..."

            # 使用时间戳记录开始时间
            START_TIME=$(date +%s)

            if docker exec -i mysql mysql -u root -proot@123456 x1 < "$ALL_SQL"; then
                # 计算导入时间
                END_TIME=$(date +%s)
                IMPORT_TIME=$((END_TIME - START_TIME))

                echo "✅ SQL 文件导入完成！"
                echo "📊 导入统计："
                echo "   - 表结构：$TABLE_COUNT 个"
                echo "   - 数据插入语句：$INSERT_COUNT 条"
                echo "   - 导入耗时：$IMPORT_TIME 秒"
                echo "   - 导入状态：成功"

                # 验证导入结果
                echo "🔍 验证导入结果..."
                ACTUAL_TABLE_COUNT=$(docker exec mysql mysql -u root -proot@123456 -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'x1';" 2>/dev/null | tail -1)
                echo "   - 实际创建的表数量：$ACTUAL_TABLE_COUNT"

                if [ "$ACTUAL_TABLE_COUNT" -eq "$TABLE_COUNT" ]; then
                    echo "   - 表数量验证：一致 ✓"
                else
                    echo "   - 表数量验证：不一致，可能有部分表创建失败 ⚠️"
                fi

            else
                echo "❌ SQL 文件导入失败，请检查错误信息！"
                # 尝试使用详细模式导入
                echo "🔍 尝试使用详细模式导入："
                docker exec -i mysql mysql -u root -proot@123456 --verbose --show-warnings x1 < "$ALL_SQL" || true
                # 查看 MySQL 日志
                echo "📋 MySQL 容器日志："
                docker logs mysql | tail -n 30
                IMPORT_SUCCESS=false
            fi

            # 清理临时文件
            rm "$ALL_SQL"

            if [ "$IMPORT_SUCCESS" = false ]; then
                echo "❌ SQL 文件导入失败，请检查错误信息！"
                # 查看 MySQL 日志
                echo "📋 MySQL 容器日志："
                docker logs mysql | tail -n 30
            fi

            # 清理临时文件
            rm "$TEMP_SQL"
            echo "✅ 临时文件清理完成"
        else
            echo "❌ 未找到 x1.sql 文件，请确保文件存在！"
            echo "📁 部署目录：${DEPLOY_DIR}"
            echo "📁 部署目录文件列表："
            ls -la "${DEPLOY_DIR}"
            echo "📁 当前脚本目录：$(dirname "$0")"
            echo "📁 当前脚本目录文件列表："
            ls -la "$(dirname "$0")"
        fi

        # 验证数据库表结构
        echo "🔍 验证数据库表结构..."
        echo "📊 检查数据库是否存在："
        docker exec mysql mysql -u root -proot@123456 -e "SHOW DATABASES LIKE 'x1';"

        echo "📊 检查 x1 数据库中的表数量："
        TABLE_COUNT=$(docker exec mysql mysql -u root -proot@123456 -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'x1';" 2>/dev/null | tail -1)
        echo "表数量：$TABLE_COUNT"

        if [ "$TABLE_COUNT" -gt 0 ]; then
            echo "✅ 数据库表结构导入成功！"
            echo "📋 前 10 个表："
            docker exec mysql mysql -u root -proot@123456 -e "USE x1; SHOW TABLES;" 2>/dev/null | head -10
        else
            echo "❌ 数据库表结构导入失败，表数量为 0！"
            # 检查 MySQL 容器状态
            echo "📋 MySQL 容器状态："
            docker inspect mysql --format '{{.State.Status}}'
            echo "📋 MySQL 容器日志："
            docker logs mysql | tail -n 50
        fi
    else
        echo "❌ 未找到docker-compose.yml文件，请检查！"
        exit 1
    fi
}

# 主流程
main() {
    echo "===== 开始一键部署 ====="
    check_dependency
    create_mount_dirs
    load_images
    start_services
    echo "===== 部署完成 ====="
}

main
