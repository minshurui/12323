#!/bin/bash

# 更新系统
apt update
apt install -y curl unzip

# 安装Docker
curl -fsSL https://get.docker.com | bash

# 下载Alist和Aring的Docker镜像
docker pull alexwall/alist:latest
docker pull eilinge/aring:latest

# 创建网络
docker network create alist-aring-net

# 运行Alist
docker run -d --name alist \
--network alist-aring-net \
-p 5212:5212 \
-v /alist/data:/alist/data \
-v /alist/config:/alist/config \
alexwall/alist

# 运行Aring  
docker run -d --name aring \
--network alist-aring-net \ 
-p 8082:8083 \
-v /aring/data:/data \
eilinge/aring

# 进入Alist容器,安装Aring插件
docker exec -it alist bash
/alist/alist.sh plugin install aring
/alist/alist.sh restart

echo "Alist and Aring installed successfully!"
