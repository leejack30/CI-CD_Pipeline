#!/bin/bash
# 停止所有運行中的 Docker 容器
docker stop $(docker ps -q) || true

# 刪除所有 Docker 容器
docker rm $(docker ps -a -q) || true

sudo yum update -y
sudo yum install httpd -y

