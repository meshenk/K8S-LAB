#### 在服务器导出表结构

docker exec -it mysql mysqldump -u iot_user -p'J0ck@2023' --databases x1 --no-data > schema.sql

#### Mysql操作
<!-- 查看当前连接 -->
SHOW PROCESSLIST;
<!-- 查看完整的连接 -->
SHOW FULL PROCESSLIST;
<!-- 统计各状态的连接数（快速查看有多少 Sleep） -->
SELECT Command, COUNT(*) FROM information_schema.processlist GROUP BY Command;
<!-- 查看当前限制 -->
SHOW VARIABLES LIKE 'max_connections';
<!-- 修改为 1000（根据你的内存情况调整） -->
SET GLOBAL max_connections = 1000;
<!-- 查看所有数据库 -->
SHOW DATABASES;
<!-- 查看当前库的所有表 -->
SHOW TABLES;
<!-- 查看表名数量 -->
SELECT COUNT(*) AS table_count
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_TYPE = 'BASE TABLE';
<!-- 查询表sys_user记录的数量 -->
SELECT COUNT(*) AS sys_user_record_count FROM sys_user;

#### 查看docker中的Mysql状态

docker stats mysql

chmod +x /home/x1/linux_deploy.sh
chmod +x /home/x1/deploy_mac.sh

#### 停止Dokcer容器 删除容器 删除镜像

docker stop $(docker ps -q) && docker rm $(docker ps -a -q) && docker rmi $(docker images -q)

#### 从服务器同步文件到本地

rsync -avzP "root@10.118.23.91:/home/x1-docker/nginx/conf.d/*" /Users/zjr/x1-docker/nginx/conf.d
