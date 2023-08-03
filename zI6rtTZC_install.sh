```bash
#!/bin/bash

# 创建网络
docker network create alist-aring-net

# 设置共享路径
shared_dir=/alist-aring/shared

# 创建共享目录
mkdir -p $shared_dir/alist_data
mkdir -p $shared_dir/alist_config
mkdir -p $shared_dir/aring_data

# 拉取Alist镜像
docker pull xhofe/alist:latest

# 运行Alist容器
docker run -d --name alist \
  --network alist-aring-net \
  -p 5212:5212 \
  -v $shared_dir/alist_data:/alist/data \
  -v $shared_dir/alist_config:/alist/config \
  xhofe/alist:latest

# 拉取Aring镜像
docker pull eilinge/aring2:latest

# 运行Aring容器
docker run -d --name aring \
  --network alist-aring-net \
  -p 8888:8080 \
  -v $shared_dir/aring_data:/data \
  eilinge/aring2:latest

echo "Alist and Aring containers are running successfully!"
```
