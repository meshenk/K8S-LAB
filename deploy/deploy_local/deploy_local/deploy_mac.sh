#!/bin/bash
# 移除 set -e，允许脚本继续执行即使遇到错误

# ===================== 配置项（根据实际情况修改）=====================
# 获取脚本所在目录的父目录作为部署根目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEPLOY_DIR="$(dirname "$SCRIPT_DIR")"  # 部署根目录（docker_images和yml所在目录）
MOUNT_BASE="$HOME/x1-docker"  # 本地挂载目录
# ===================================================================

# 检测Docker Compose命令
get_compose_command() {
    if docker compose version >/dev/null 2>&1; then
        echo "docker compose"
    elif docker-compose --version >/dev/null 2>&1; then
        echo "docker-compose"
    else
        echo ""
    fi
}

# 步骤1：检查Docker是否运行
check_docker() {
    if ! docker info >/dev/null 2>&1; then
        echo "❌ Docker未启动，请先打开Docker Desktop！"
        open -a Docker
        # 等待Docker启动
        echo "⏳ 等待Docker启动..."
        sleep 10
        if ! docker info >/dev/null 2>&1; then
            echo "❌ Docker启动失败，请手动检查！"
            exit 1
        fi
    fi
    echo "✅ Docker环境检查完成"
}

# 步骤2：创建本地临时目录并复制nginx配置
create_mount_dirs() {
    # 确保nginx挂载目录存在
    NGINX_CONF_DIR="$HOME/x1-docker/nginx/conf.d"
    NGINX_HTML_DIR="$HOME/x1-docker/nginx/html"
    
    echo "📁 正在准备nginx配置目录..."
    mkdir -p "$NGINX_CONF_DIR"
    mkdir -p "$NGINX_HTML_DIR"
    
    # 复制当前目录下的conf.d和html到挂载目录
    if [ -d "${SCRIPT_DIR}/conf.d" ]; then
        echo "📄 正在复制conf.d配置..."
        cp -r "${SCRIPT_DIR}/conf.d/"* "$NGINX_CONF_DIR/"
        
        # 替换 conf.d 中文件的 x1-admin-api 为服务器 IP
        echo "🔧 正在替换 nginx 配置中的 x1-admin-api 为服务器 IP..."
        # 获取服务器 IP
        SERVER_IP=$(ipconfig getifaddr en0 || ipconfig getifaddr en1 || echo "127.0.0.1")
        echo "🌐 服务器 IP: $SERVER_IP"
        
        # 替换所有 conf.d 文件中的 x1-admin-api
        for conf_file in "$NGINX_CONF_DIR"/*.conf; do
            if [ -f "$conf_file" ]; then
                echo "🔄 替换 $conf_file 中的 x1-admin-api 为 $SERVER_IP"
                # 只替换proxy_pass中的域名部分，保留路径部分
                sed -i '' "s|proxy_pass  http://x1-admin-api:9092/x1-admin-api/|proxy_pass  http://$SERVER_IP:9092/x1-admin-api/|g" "$conf_file"
            fi
        done
        echo "✅ conf.d配置复制和IP替换完成"
    else
        echo "⚠️  未找到conf.d目录，跳过复制"
    fi
    
    if [ -d "${SCRIPT_DIR}/html" ]; then
        echo "📄 正在复制html文件..."
        cp -r "${SCRIPT_DIR}/html/"* "$NGINX_HTML_DIR/"
        echo "✅ html文件复制完成"
    else
        echo "⚠️  未找到html目录，跳过复制"
    fi
    
    echo "✅ 本地目录检查和nginx配置复制完成"
}

# 步骤2.1：检查数据库初始化脚本
copy_sql_scripts() {
    # 检查 x1.sql 是否存在
    if [ -f "${SCRIPT_DIR}/x1.sql" ]; then
        echo "✅ x1.sql 文件存在，大小：$(ls -lh "${SCRIPT_DIR}/x1.sql" | awk '{print $5}')"
    else
        echo "❌ 未找到 x1.sql 文件，请确保文件存在于脚本所在目录！"
        echo "📁 脚本目录：${SCRIPT_DIR}"
        echo "📁 文件列表：$(ls -la "${SCRIPT_DIR}")"
        exit 1
    fi
}

# 步骤3：加载镜像
load_images() {
    cd ${DEPLOY_DIR}
    # 检查并解压压缩包
    if [ -f "docker_images.tar.gz" ]; then
        echo "📦 发现 tar.gz 压缩包，先解压..."
        tar -zxvf docker_images.tar.gz
    elif [ -f "docker_images.zip" ]; then
        echo "📦 发现 zip 压缩包，先解压..."
        unzip docker_images.zip
    fi

    if [ -d "docker_images" ]; then
        for tar_file in ${DEPLOY_DIR}/docker_images/*.tar; do
            if [ -f "$tar_file" ]; then
                # 跳过emqx镜像加载（使用在线拉取以适配Mac架构）
                if [[ "$tar_file" == *"emqx"* ]]; then
                    echo "⚠️  跳过本地EMQX镜像（将使用在线镜像以适配架构）：$tar_file"
                    continue
                fi
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
start_services() {
    # 获取Docker Compose命令
    COMPOSE_CMD=$(get_compose_command)
    if [ -z "$COMPOSE_CMD" ]; then
        echo "❌ 未找到Docker Compose命令，请确保Docker Desktop已安装！"
        exit 1
    fi
    echo "✅ 使用命令: $COMPOSE_CMD"
    
    cd ${SCRIPT_DIR}
    # 检查docker-compose.yml或docker-compose.yml文件
    COMPOSE_FILE=""
    if [ -f "docker-compose.yml" ]; then
        COMPOSE_FILE="docker-compose.yml"
    elif [ -f "docker-compose.yml" ]; then
        COMPOSE_FILE="docker-compose.yml"
    fi
    
    if [ -n "$COMPOSE_FILE" ]; then
        # 获取本机IP
        LOCAL_IP=$(ipconfig getifaddr en0 || ipconfig getifaddr en1)
        if [ -n "$LOCAL_IP" ]; then
            echo "🌐 检测到本机IP: $LOCAL_IP，正在更新配置..."
            # 替换配置文件中的 IP (兼容 macOS sed)
            sed -i '' "s/emqx@[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/emqx@$LOCAL_IP/g" "$COMPOSE_FILE"
        fi

        # 动态替换路径为当前用户的主目录
        echo "📁 正在适配路径配置..."
        # 替换Linux风格路径为Mac风格
        sed -i '' "s|/home/x1-docker|$HOME/x1-docker|g" "$COMPOSE_FILE"
        # 替换Windows风格路径为Mac风格
        sed -i '' "s|D:/x1-docker|$HOME/x1-docker|g" "$COMPOSE_FILE"
        # 替换硬编码的用户路径
        sed -i '' "s|/Users/zjr|$HOME|g" "$COMPOSE_FILE"

        # 停止并移除现有的 MySQL 容器，删除数据目录以确保新的配置生效
        echo "🔧 正在准备 MySQL 容器配置..."
        if docker ps -a | grep -q mysql; then
            echo "📦 停止并移除现有的 MySQL 容器..."
            $COMPOSE_CMD -f "$COMPOSE_FILE" stop mysql
            $COMPOSE_CMD -f "$COMPOSE_FILE" rm -f mysql
        fi
        
        # 删除 MySQL 数据目录，确保新的 lower_case_table_names 配置生效
        MYSQL_DATA_DIR="$HOME/x1-docker/mysql/mysql-data"
        if [ -d "$MYSQL_DATA_DIR" ]; then
            echo "🗑️ 删除 MySQL 数据目录以应用新配置..."
            rm -rf "$MYSQL_DATA_DIR"
            mkdir -p "$MYSQL_DATA_DIR"
            echo "✅ MySQL 数据目录清理完成"
        fi

        echo "🚀 启动容器服务（使用 $COMPOSE_FILE）..."
        $COMPOSE_CMD -f "$COMPOSE_FILE" up -d
        echo "✅ 容器启动完成，当前状态："
        $COMPOSE_CMD -f "$COMPOSE_FILE" ps
        
        # 等待 MySQL 完全启动
        echo "⏳ 等待 MySQL 服务完全启动（最多 60 秒）..."
        max_wait=60
        wait_count=0
        MYSQL_PASSWORD=""
        while [ $wait_count -lt $max_wait ]; do
            # 先尝试空密码
            if docker exec mysql mysqladmin -u root ping --silent 2>/dev/null; then
                MYSQL_PASSWORD=""
                echo "✅ MySQL 服务已成功启动（使用空密码）！"
                break
            fi
            # 再尝试指定密码
            if docker exec mysql mysqladmin -u root -proot@123456 ping --silent 2>/dev/null; then
                MYSQL_PASSWORD="-proot@123456"
                echo "✅ MySQL 服务已成功启动（使用指定密码）！"
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
        
        # 额外等待 20 秒，确保 MySQL 服务完全初始化完成
        echo "⏳ 额外等待 20 秒，确保 MySQL 服务完全初始化完成..."
        for i in {1..20}; do
            echo -n "🔄 等待中... $i/20 秒\r"
            sleep 1
        done
        echo "✅ MySQL 服务初始化完成，准备开始数据库导入！\n"
        
        # 检查 MySQL 容器日志，验证 schema.sql 执行情况
        echo "🔍 检查 MySQL 容器启动日志，验证 schema.sql 执行情况..."
        # 显示更详细的日志，特别是错误信息
        echo "📊 完整的 MySQL 初始化日志："
        docker logs mysql | grep -A 50 -B 5 "schema.sql"
        echo "\n❌ 检查是否有错误信息："
        docker logs mysql | grep -i "error"
        echo "📋 MySQL 日志检查完成"
        
        # 手动导入 x1.sql 文件，确保表结构创建
        echo "📥 手动导入 x1.sql 文件，确保表结构创建..."
        if [ -f "${SCRIPT_DIR}/x1.sql" ]; then
            echo "📄 正在处理并导入 x1.sql 文件..."
            echo "📊 x1.sql 文件大小：$(ls -lh "${SCRIPT_DIR}/x1.sql" | awk '{print $5}')"
            
            # 创建临时文件，移除所有无效信息
            TEMP_SQL="/tmp/schema_clean.sql"
            # 跳过以 "mysqldump:" 开头的行、空行以及错误信息行
            grep -v "^mysqldump:" "${SCRIPT_DIR}/x1.sql" | grep -v "^$" | grep -v "Access denied" > "$TEMP_SQL"
            echo "✅ 已处理 x1.sql 文件，移除无效警告和错误信息"
            echo "📊 处理后文件大小：$(ls -lh "$TEMP_SQL" | awk '{print $5}')"
            
            # 确保 x1 数据库存在
            echo "🔍 确保 x1 数据库存在..."
            # 尝试使用空密码连接
            if docker exec mysql mysql -u root -e "CREATE DATABASE IF NOT EXISTS x1 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;" 2>/dev/null; then
                echo "✅ 数据库检查完成（使用空密码）"
                MYSQL_PASSWORD=""
            elif docker exec mysql mysql -u root -proot@123456 -e "CREATE DATABASE IF NOT EXISTS x1 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;" 2>/dev/null; then
                echo "✅ 数据库检查完成（使用密码 root@123456）"
                MYSQL_PASSWORD="-proot@123456"
            else
                echo "❌ 无法连接到 MySQL，请检查密码配置"
                IMPORT_SUCCESS=false
            fi
            
            # 统计导入内容
            echo "📊 统计导入内容..."
            TABLE_COUNT=$(grep -c "CREATE TABLE" "$TEMP_SQL")
            INSERT_COUNT=$(grep -c "INSERT INTO" "$TEMP_SQL")
            echo "📋 统计结果："
            echo "   - 表结构数量：$TABLE_COUNT"
            echo "   - 数据插入语句数量：$INSERT_COUNT"
            
            # 再次检查 MySQL 服务状态，确保完全可用
            echo "🔍 再次检查 MySQL 服务状态..."
            check_count=0
            max_check=30
            while [ $check_count -lt $max_check ]; do
                if docker exec mysql mysqladmin -u root $MYSQL_PASSWORD ping --silent 2>/dev/null; then
                    echo "✅ MySQL 服务已完全可用，可以开始导入！"
                    break
                fi
                echo "🔄 等待 MySQL 服务就绪... ($check_count/$max_check 秒)"
                sleep 2
                check_count=$((check_count + 2))
                if [ $check_count -ge $max_check ]; then
                    echo "❌ MySQL 服务未就绪，请检查容器状态！"
                    docker logs mysql | tail -n 30
                    IMPORT_SUCCESS=false
                    break
                fi
            done
            
            if [ "$IMPORT_SUCCESS" = true ]; then
                # 执行导入命令并捕获错误
                echo "🚀 开始导入 SQL 文件（请耐心等待，这可能需要几分钟）..."
                
                # 使用时间戳记录开始时间
                START_TIME=$(date +%s)
                
                # 创建一个包含优化设置的临时文件
                ALL_SQL="/tmp/full_import.sql"
                echo "SET foreign_key_checks = 0; SET unique_checks = 0; SET autocommit = 0;" > "$ALL_SQL"
                cat "$TEMP_SQL" >> "$ALL_SQL"
                echo "COMMIT; SET foreign_key_checks = 1; SET unique_checks = 1; SET autocommit = 1;" >> "$ALL_SQL"
                
                # 尝试使用已确定的密码导入
                if docker exec -i mysql mysql -h localhost -u root $MYSQL_PASSWORD x1 < "$ALL_SQL"; then
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
                    ACTUAL_TABLE_COUNT=$(docker exec mysql mysql -h localhost -u root $MYSQL_PASSWORD -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'x1';" 2>/dev/null | tail -1)
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
                    docker exec -i mysql mysql -h localhost -u root $MYSQL_PASSWORD --verbose --show-warnings x1 < "$ALL_SQL" || true
                    # 查看 MySQL 日志
                    echo "📋 MySQL 容器日志："
                    docker logs mysql | tail -n 30
                    IMPORT_SUCCESS=false
                    
                    # 检查临时文件内容
                    echo "📋 检查处理后的 SQL 文件前 10 行："
                    head -10 "$TEMP_SQL"
                fi
            fi
            
            # 清理临时文件
            rm "$ALL_SQL"
            
            # 清理临时文件
            rm "$TEMP_SQL"
            echo "✅ 临时文件清理完成"
        else
            echo "❌ 未找到 x1.sql 文件，请确保文件存在于脚本所在目录！"
            echo "📁 当前目录：$(pwd)"
            echo "📁 脚本目录：${SCRIPT_DIR}"
            echo "📁 文件列表：$(ls -la "${SCRIPT_DIR}")"
        fi
        
        # 再次验证数据库表结构
        echo "🔍 再次验证数据库表结构..."
        docker exec mysql mysql -h localhost -u root $MYSQL_PASSWORD -e "USE x1; SHOW TABLES LIKE 'act_app_appdef';"
        docker exec mysql mysql -h localhost -u root $MYSQL_PASSWORD -e "USE x1; SELECT COUNT(*) as '表数量' FROM information_schema.tables WHERE table_schema = 'x1';"
        
        # 验证数据库表结构是否创建成功
        echo "✅ 验证数据库表结构..."
        # 使用TCP连接确保可靠性
        docker exec mysql mysql -h localhost -u root $MYSQL_PASSWORD -e "USE x1; SHOW TABLES LIKE 'act_app_appdef';"
        
        # 检查所有表数量
        echo "📊 检查数据库表数量..."
        docker exec mysql mysql -h localhost -u root $MYSQL_PASSWORD -e "USE x1; SELECT COUNT(*) as '表数量' FROM information_schema.tables WHERE table_schema = 'x1';"
        
        # 显示前 10 个表名，验证导入结果
        echo "📋 显示前 10 个表名，验证导入结果："
        docker exec mysql mysql -h localhost -u root $MYSQL_PASSWORD -e "USE x1; SHOW TABLES;" | head -10
    else
        echo "❌ 未找到docker-compose.yml或docker-compose.yml文件，请检查！"
        exit 1
    fi
}

# 主流程
main() {
    echo "===== 开始一键部署 ====="
    check_docker
    create_mount_dirs
    copy_sql_scripts
    load_images
    start_services
    
    # 确保即使前面有错误，也能执行到数据库验证
    echo "===== 验证数据库状态 ====="
    if docker ps | grep -q mysql; then
        echo "✅ MySQL 容器正在运行"
        
        # 手动导入 x1.sql 文件
        echo "📥 手动导入 x1.sql 文件..."
        if [ -f "${SCRIPT_DIR}/x1.sql" ]; then
            echo "📄 正在处理 x1.sql 文件..."
            
            # 创建临时文件，移除所有无效信息
            TEMP_SQL="/tmp/schema_clean.sql"
            # 跳过以 "mysqldump:" 开头的行、空行以及错误信息行
            grep -v "^mysqldump:" "${SCRIPT_DIR}/x1.sql" | grep -v "^$" | grep -v "Access denied" > "$TEMP_SQL"
            echo "✅ 已处理 x1.sql 文件，移除无效警告和错误信息"
            
            # 确保 x1 数据库存在
            echo "🔍 确保 x1 数据库存在..."
            # 尝试使用空密码
            if docker exec mysql mysql -h localhost -u root -e "CREATE DATABASE IF NOT EXISTS x1 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;" 2>/dev/null; then
                echo "✅ 数据库检查完成（使用空密码）"
                FINAL_MYSQL_PASSWORD=""
            elif docker exec mysql mysql -h localhost -u root -proot@123456 -e "CREATE DATABASE IF NOT EXISTS x1 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;" 2>/dev/null; then
                echo "✅ 数据库检查完成（使用密码 root@123456）"
                FINAL_MYSQL_PASSWORD="-proot@123456"
            else
                echo "❌ 数据库创建失败，请检查容器状态！"
                FINAL_MYSQL_PASSWORD=""
            fi
            
            # 执行导入命令
            echo "🚀 开始导入 SQL 文件..."
            if docker exec -i mysql mysql -h localhost -u root $FINAL_MYSQL_PASSWORD x1 < "$TEMP_SQL"; then
                echo "✅ x1.sql 文件导入完成"
            else
                echo "❌ x1.sql 文件导入失败，尝试使用详细模式..."
                docker exec -i mysql mysql -h localhost -u root $FINAL_MYSQL_PASSWORD --verbose --show-warnings x1 < "$TEMP_SQL"
            fi
            
            # 清理临时文件
            rm "$TEMP_SQL"
            
            # 验证数据库表结构
            echo "🔍 验证数据库表结构..."
            docker exec mysql mysql -h localhost -u root $FINAL_MYSQL_PASSWORD -e "USE x1; SHOW TABLES LIKE 'act_app_appdef';"
            docker exec mysql mysql -h localhost -u root $FINAL_MYSQL_PASSWORD -e "USE x1; SELECT COUNT(*) as '表数量' FROM information_schema.tables WHERE table_schema = 'x1';"
            docker exec mysql mysql -h localhost -u root $FINAL_MYSQL_PASSWORD -e "USE x1; SHOW TABLES;" | head -10
        else
            echo "❌ 未找到 x1.sql 文件"
        fi
    else
        echo "❌ MySQL 容器未运行"
    fi
    
    echo "===== 部署完成 ====="
}

main