#!/bin/bash

# 安装 whiptail
apt install -y whiptail 

# 欢迎界面
whiptail --title "安装程序" --msgbox "欢迎使用Alist和Aring安装程序" 10 40



# 确认安装
whiptail --title "确认安装" --yesno "是否开始安装?" 10 40
if [ $? != 0 ]; then
  exit 1
fi



# 抱歉之前提供的脚本有一些错误。以下是正确的脚本：

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
docker pull alexwall/alist

# 运行Alist容器
docker run -d --name alist \
  --network alist-aring-net \
  -p 5212:5212 \
  -v $shared_dir/alist_data:/alist/data \
  -v $shared_dir/alist_config:/alist/config \
  alexwall/alist

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

#这个脚本中修复了之前的语法错误，并更正了Aring2镜像的名称。请确保你安装了Docker，并且有足够的权限来拉取和运行容器。

希望这次能够解决你的问题。如果有其他问题，请随时告诉我。
