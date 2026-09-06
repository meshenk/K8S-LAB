set -e
timestamp=$(date '+%Y%m%d%H%M')iotpc 

backup_path="/home/jack/bak/$timestamp"

# 检查文件夹是否存在
if [ ! -d "$backup_path" ]; then
    # 若文件夹不存在，则创建它
    sudo mkdir -p "$backup_path"
    if [ $? -ne 0 ]; then
        echo "创建文件夹 $backup_path 时出错。"
    fi
fi

# 检查文件是否存在
file_path="/home/jack/dist.zip"
if [ -f "$file_path" ]; then
	# 将线上正在运行的jar包备份到备份文件夹中 
	sudo mv /home/jack/online/x1/dist.zip "$backup_path"
	if [ $? -eq 0 ]; then
        echo "文件备份成功"
    else
        echo "文件备份失败"
    fi
    #删除原dist文件夹
    sudo rm -rf /home/jack/online/x1/dist
    if [ $? -eq 0 ]; then
        echo "删除旧包成功"
    else
        echo "删除旧包失败"
    fi
    # 如果文件存在，移动文件到上线发布文件夹
    sudo mv "$file_path" /home/jack/online/x1/
    if [ $? -eq 0 ]; then
        echo "文件 $file_path 已成功移动到 /home/jack/online/x1/下"
    else
        echo "移动文件 $file_path 到 /home/jack/online-jar/ 时出错。"
    fi
else
    echo "文件 $file_path 不存在。"
fi

# 解压文件夹
sudo unzip -o /home/jack/online/x1/dist.zip -d /home/jack/online/x1

echo "操作成功"




