#!/bin/bash

# 检查是否传入了足够的参数
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <image-name> <backup-file-path>"
    exit 1
fi

# 图像名称，同时也是容器名称
IMAGE_NAME="$1"
# 备份文件路径
BACKUP_FILE_PATH="$2"

# 构建命名卷名称
VOLUME_NAME="${IMAGE_NAME}-volume"

# 检查备份文件是否存在
if [ ! -f "$BACKUP_FILE_PATH" ]; then
    echo "Backup file $BACKUP_FILE_PATH does not exist."
    exit 1
fi

# 创建新的命名卷
docker volume create "$VOLUME_NAME"

# 检查命名卷是否创建成功
if [ $? -ne 0 ]; then
    echo "Failed to create volume $VOLUME_NAME"
    exit 1
fi

# 使用 Docker 运行一个临时容器来解压 tar 归档文件
docker run --rm -v "$VOLUME_NAME":/data -v "$(dirname "$BACKUP_FILE_PATH")":/backup alpine:latest /bin/sh -c '
    echo "Restoring backup from /backup/'"${BACKUP_FILE_PATH}"' to volume /data..."
    tar -xzf /backup/'"${BACKUP_FILE_PATH}"' -C /data
    echo "Restore complete."
'

if [ $? -eq 0 ]; then
    echo "Backup of volume $VOLUME_NAME has been restored from $BACKUP_FILE_PATH"
else
    echo "Error restoring backup of volume $VOLUME_NAME from $BACKUP_FILE_PATH"
    exit 1
fi