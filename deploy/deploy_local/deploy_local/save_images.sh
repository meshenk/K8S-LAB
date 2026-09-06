#!/bin/bash
# 定义需要打包的镜像列表（从docker-compose.yml提取核心镜像）
IMAGES=(
  "admin1"          # x1-admin-api自定义镜像
  "mobile"          # x1-mobile-api自定义镜像
  "mysql:8.0"
  "redis:latest"
  "minio:latest"
  "nginx:stable"
  "emqx/emqx:4.4.19"
)

# 定义打包输出目录（自动创建）
OUTPUT_DIR="./docker_images"
mkdir -p ${OUTPUT_DIR}

# 批量打包镜像
for IMAGE in "${IMAGES[@]}"; do
  # 处理镜像名特殊字符（/、:），避免文件名异常
  IMAGE_FILE=$(echo ${IMAGE} | tr '/' '_' | tr ':' '_').tar
  echo "开始打包镜像: ${IMAGE} -> ${OUTPUT_DIR}/${IMAGE_FILE}"
  docker save ${IMAGE} -o ${OUTPUT_DIR}/${IMAGE_FILE}
  
  # 校验打包结果
  if [ $? -eq 0 ]; then
    echo "✅ 镜像${IMAGE}打包成功"
  else
    echo "❌ 镜像${IMAGE}打包失败"
  fi
done

echo "所有指定镜像打包完成，输出目录：${OUTPUT_DIR}"