#!/bin/bash

# 检查是否传入了镜像名称作为参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <container-name>"
    exit 1
fi

IMAGE_NAME="$1"
CONTAINER_NAME="$IMAGE_NAME"

# 停止容器
docker stop $CONTAINER_NAME

# 检查容器是否停止成功
if [ $? -eq 0 ]; then
    echo "Container '$CONTAINER_NAME' has been stopped."
else
    echo "Failed to stop container '$CONTAINER_NAME'."
    exit 1
fi

# 删除容器
docker rm $CONTAINER_NAME

# 检查容器是否删除成功
if [ $? -eq 0 ]; then
    echo "Container '$CONTAINER_NAME' has been removed."
else
    echo "Failed to remove container '$CONTAINER_NAME'."
    exit 1
fi