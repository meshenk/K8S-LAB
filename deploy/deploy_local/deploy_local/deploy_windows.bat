@echo off
setlocal enabledelayedexpansion

:: 设置基础变量 
set "DEPLOY_DIR=%~dp0"
set "MOUNT_BASE=D:\x1-docker"   #如果服务器没有D盘时，需要修改
:: set "IMAGES_DIR=D:\Aitu平台部署\deploy\deploy_local\docker_images"   #需要修改成你真实的镜像路径
set "IMAGES_DIR=%DEPLOY_DIR%..\docker_images"
:: set "IMAGES_ZIP=D:\deploy\deploy_local\docker_images.zip"


echo ===== Start one-click deployment ===== 

:: 检查 Docker 是否安装 
docker --version >nul 2>&1
if errorlevel 1 (
    echo Docker not found. Checking installer...
    if exist "Docker Desktop Installer.exe" (
        echo Starting Docker Installation... [cite: 2]
        start "" "Docker Desktop Installer.exe"
        pause
        exit /b 1
    ) else (
        echo Please install Docker Desktop first! [cite: 3, 4]
        pause
        exit /b 1
    )
)

:: 创建挂载目录 [cite: 5]
echo Creating directories in %MOUNT_BASE%...
if not exist "%MOUNT_BASE%" md "%MOUNT_BASE%"
md "%MOUNT_BASE%\jar\logs\pc-logs" 2>nul
md "%MOUNT_BASE%\jar\logs\mobile-logs" 2>nul
md "%MOUNT_BASE%\mysql\mysql-data" 2>nul
md "%MOUNT_BASE%\mysql\sql-scripts" 2>nul
md "%MOUNT_BASE%\redis\redis-data" 2>nul
md "%MOUNT_BASE%\minio\data" 2>nul
md "%MOUNT_BASE%\nginx\conf.d" 2>nul
md "%MOUNT_BASE%\nginx\html" 2>nul
md "%MOUNT_BASE%\emqx\data" 2>nul
md "%MOUNT_BASE%\emqx\log" 2>nul
md "%MOUNT_BASE%\emqx\etc\plugins" 2>nul

:: 解压镜像压缩包 (如果存在) [cite: 5]
if not exist "%IMAGES_DIR%" (
    if exist "%IMAGES_ZIP%" (
        echo Extracting docker_images.zip...
        powershell.exe -Command "Expand-Archive -Path '%IMAGES_ZIP%' -DestinationPath 'D:\deploy\deploy_local' -Force"
    )
)

:: 加载 Docker 镜像 [cite: 6]
echo Loading images from %IMAGES_DIR%...
for %%f in ("%IMAGES_DIR%\*.tar") do (
    if /I not "%%~nxf"=="mobile.tar" (
        if /I not "%%~nxf"=="admin.tar" (
            echo Loading %%~nxf ...
            docker load -i "%%f"
        )
    )
)


:: 获取本机 WLAN IP
for /f "tokens=2 delims=:" %%i in ('netsh interface ip show addresses "WLAN" ^| findstr "IP 地址"') do (
    set HOST_IP=%%i
)

set HOST_IP=%HOST_IP: =%

echo.
echo HOST_IP=%HOST_IP%
echo.



:: 更新mobile Dockerfile
powershell -ExecutionPolicy Bypass -Command "$fp='%~dp0jar\mobile\Dockerfile';$txt=Get-Content $fp -Raw;$txt=$txt -replace '(?<=--host_ip=)\d+\.\d+\.\d+\.\d+','%HOST_IP%' -replace '(?<=--mysql_ds1_ip=)\d+\.\d+\.\d+\.\d+','%HOST_IP%' -replace '(?<=--host_ai_ip=)\d+\.\d+\.\d+\.\d+','%HOST_IP%';Set-Content $fp $txt -Encoding UTF8"
:: build mobile
cd /d "%DEPLOY_DIR%jar\mobile"
docker build -t mobile .


:: 更新admin Dockerfile
powershell -ExecutionPolicy Bypass -Command "$fp='%~dp0jar\admin\Dockerfile';$txt=Get-Content $fp -Raw;$txt=$txt -replace '(?<=--host_ip=)\d+\.\d+\.\d+\.\d+','%HOST_IP%' -replace '(?<=--mysql_ds1_ip=)\d+\.\d+\.\d+\.\d+','%HOST_IP%' -replace '(?<=--host_ai_ip=)\d+\.\d+\.\d+\.\d+','%HOST_IP%';Set-Content $fp $txt -Encoding UTF8"
:: build admin
cd /d "%DEPLOY_DIR%jar\admin"
docker build -t admin .

echo.
echo Build Finished.


:: ===================== 【在此处插入目录替换逻辑】 =====================
echo Start replacing conf.d、html、jar directories...
xcopy "%DEPLOY_DIR%conf.d" "%MOUNT_BASE%\nginx\conf.d\" /E /H /Y /C
xcopy "%DEPLOY_DIR%html" "%MOUNT_BASE%\nginx\html\" /E /H /Y /C
xcopy "%DEPLOY_DIR%jar" "%MOUNT_BASE%\jar\" /E /H /Y /C
echo Directory replacement completed!
:: =====================================================================


:: 启动容器 [cite: 7]
cd /d "%DEPLOY_DIR%"
if exist "docker-compose_window.yml" (
    echo Stopping old mysql if exists... [cite: 7]
    docker-compose -f docker-compose_window.yml stop mysql >nul 2>&1
    docker-compose -f docker-compose_window.yml rm -f mysql >nul 2>&1

    :: 清理旧数据 [cite: 8]
    if exist "%MOUNT_BASE%\mysql\mysql-data" (
        rd /s /q "%MOUNT_BASE%\mysql\mysql-data" [cite: 8]
        md "%MOUNT_BASE%\mysql\mysql-data"
    )

    echo Starting MySQL and dependencies first...
    docker-compose -f docker-compose_window.yml up -d mysql redis minio nginx emqx
    
    :: 等待 MySQL 完全初始化并准备好接受连接 [cite: 9]
    echo Waiting for MySQL to initialize... [cite: 9]
    timeout /t 90 >nul

    :: 导入数据库 [cite: 13, 14, 19]
    if exist "%DEPLOY_DIR%x1.sql" (
        echo Importing x1.sql... [cite: 19]
        docker cp "%DEPLOY_DIR%x1.sql" mysql:/tmp/x1.sql
        docker exec -i mysql bash -c "mysql -u root -proot@123456 x1 < /tmp/x1.sql"
        echo Import finished. [cite: 20]
    )
    
    :: 启动应用程序容器
    echo Starting application containers...
    docker-compose -f docker-compose_window.yml up -d x1-admin-api x1-mobile-api
) else (
    echo Error: docker-compose_window.yml not found!
)

echo ===== Finished =====
pause