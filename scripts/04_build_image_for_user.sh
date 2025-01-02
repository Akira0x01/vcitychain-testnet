#!/bin/bash

# 节点名称，用于配置文件和测试链目录的命名
NODE_NAME="node"
IMAGE_NAME="vcitychain-testnet-${NODE_NAME}"

# 删除当前存在的同名镜像
echo "Checking for existing image: $IMAGE_NAME"
docker image rm "$IMAGE_NAME" 2>/dev/null

# 创建Dockerfile内容
cat <<EOF > Dockerfile
FROM alpine:3.14

RUN set -x \
    && apk add --update --no-cache \
       ca-certificates \
    && rm -rf /var/cache/apk/*
COPY polygon-edge /usr/local/bin/

EXPOSE 8545 9632 1478 5001

RUN addgroup -S edge \
    && adduser -S edge -G edge

USER edge

COPY --chown=edge:edge genesis.json /home/edge/genesis.json
COPY --chown=edge:edge normal-node-config.yaml /home/edge/node-config.yaml
RUN mkdir -p /home/edge/test-chain

WORKDIR /home/edge

ENTRYPOINT ["polygon-edge", "server", "--config", "node-config.yaml"]
EOF

# 构建Docker镜像
docker build -t "vcitychain-testnet-${NODE_NAME}" .

# 删除Dockerfile
rm Dockerfile

# 输出构建结果
echo "Docker image 'vcitychain-testnet-${NODE_NAME}' has been built and Dockerfile has been removed."