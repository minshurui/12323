#!/bin/bash

# 安装certbot和Nginx插件
sudo apt update
sudo apt install -y certbot python3-certbot-nginx dialog

# 获取用户输入的域名
domain_encoded=$$(dialog --inputbox "请输入你的域名（使用ASCII编码）:" 10 30 --output-fd 1)
domain=$$(echo $$domain_encoded | iconv -t ascii//TRANSLIT)

# 图形化界面申请证书
sudo certbot certonly --nginx -d $$domain
