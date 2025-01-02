#!/bin/bash

# 检查是否传入了镜像名称作为参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <image-name>"
    exit 1
fi

IMAGE_NAME="$1"
CONTAINER_NAME="$IMAGE_NAME"
DATA_DIR="./$IMAGE_NAME"

# 检查是否存在同名容器
existing_container=$(docker ps -aq -f name=^${CONTAINER_NAME}$)

# 如果容器存在，则停止并删除
if [ -n "$existing_container" ]; then
    echo "Stopping and removing existing container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

VOLUME_NAME="$CONTAINER_NAME-volume"

# 运行新容器
docker run -d \
    --restart=always \
    -p 9545:8545 \
    -p 9632:9632 \
    -p 1478:1478 \
    -p 5001:5001 \
    -v $VOLUME_NAME:/home/edge/test-chain \
    --name $CONTAINER_NAME \
    $IMAGE_NAME

echo "Container $CONTAINER_NAME has been started."