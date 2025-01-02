#!/bin/bash

# 检查是否传入了足够的参数
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <image-name> <backup-directory>"
    exit 1
fi

# 镜像名称，同时也是容器名称
IMAGE_NAME="$1"
# 备份目录
BACKUP_DIR="$2"

# 构建容器名称
CONTAINER_NAME="$IMAGE_NAME"

# 构建命名卷名称
VOLUME_NAME="${CONTAINER_NAME}-volume"

# 确保备份目录存在
mkdir -p "$BACKUP_DIR"

# 生成备份文件名
BACKUP_FILE="$BACKUP_DIR/${VOLUME_NAME}_backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# 检查命名卷是否存在
if docker volume ls | grep -q "$VOLUME_NAME"; then
    # 使用 Docker 运行一个临时容器来创建 tar 归档文件
    docker run --rm -v "$VOLUME_NAME":/data -v "$BACKUP_DIR":/backup alpine:latest /bin/sh -c '
        echo "Creating backup of volume $VOLUME_NAME..."
        tar -czf /backup/'"${BACKUP_FILE}"' -C /data .
        echo "Backup complete."
    '

    if [ $? -eq 0 ]; then
        echo "Backup of volume $VOLUME_NAME has been saved to $BACKUP_FILE"
    else
        echo "Error creating backup of volume $VOLUME_NAME"
        exit 1
    fi
else
    echo "Volume $VOLUME_NAME does not exist."
    exit 1
fi