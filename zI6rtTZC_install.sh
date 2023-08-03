#!/bin/bash

# 安装certbot和Nginx插件
sudo apt update
sudo apt install -y certbot python3-certbot-nginx dialog

# 获取用户输入的域名
domain=$$(dialog --inputbox "请输入你的域名（使用ASCII编码）:" 10 30 --output-fd 1)

# 图形化界面申请证书
sudo certbot certonly --authenticator standalone --installer nginx -d $$domain

# 完成后，certbot会自动配置Nginx使用新生成的证书
