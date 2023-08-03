#!/bin/bash

# 安装certbot和Nginx插件
sudo apt update
sudo apt install -y certbot python3-certbot-nginx

# 获取用户输入的域名
echo "请输入你的域名:"
read domain

# 图形化界面申请证书
sudo certbot certonly --nginx -d $$domain

# 完成后，certbot-nginx插件会自动配置Nginx使用新生成的证书
