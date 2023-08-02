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



# 更新系统
apt update
apt install -y curl unzip
#是的，Alist和Aring通常需要在同一个路径下配合使用，确保它们可以正确地访问共享的数据和配置文件。以下是修改后的脚本，将Alist和Aring容器的文件共享路径设置为相同的路径：

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

# 运行Alist
docker run -d --name alist \
  --network alist-aring-net \
  -p 5212:5212 \
  -v $shared_dir/alist_data:/alist/data \
  -v $shared_dir/alist_config:/alist/config \
  alexwall/alist

# 运行Aring
docker run -d --name aring \
  --network alist-aring-net \
  -p 8888:8080 \
  -v $shared_dir/aring_data:/data \
  eilinge/aring

echo "Alist and Aring containers are running successfully!"
```

# 在这个脚本中，我们设置了一个`shared_dir`变量来指定共享路径，然后创建了三个子目录来分别存放Alist的数据、Alist的配置以及Aring的数据。这样，Alist
