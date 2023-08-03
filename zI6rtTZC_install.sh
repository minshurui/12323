#!/bin/bash

# 图形化界面安装，请根据你使用的GUI工具或方式进行安装步骤
# 这里以Xfce4桌面环境为例进行安装
sudo apt update
sudo apt install -y xfce4
sudo apt install -y dialog

# 安装certbot
sudo apt update
sudo apt install -y certbot

# 获取用户输入的域名
domain=$$(dialog --inputbox "请输入你的域名:" 10 30 --output-fd 1)

# 申请证书
sudo certbot certonly --standalone -d $$domain

# 复制证书到指定路径
cert_path="/path/to/certificate.pem"
sudo cp /etc/letsencrypt/live/$$domain/fullchain.pem $$cert_path
sudo cp /etc/letsencrypt/live/$$domain/privkey.pem /path/to/privatekey.pem

# 设置域名证书路径和Nginx反代配置
nginx_conf="/etc/nginx/sites-available/default"
nginx_cert_conf="    ssl_certificate $$cert_path;\n    ssl_certificate_key /path/to/privatekey.pem;"

# 更新Nginx配置文件
sudo sed -i "s|^\(\s*\)listen\s.*$$|\1listen 443 ssl;|g" $$nginx_conf
sudo sed -i "s|^\(\s*\)server_name\s.*$$|\1server_name $$domain;|g" $$nginx_conf
sudo sed -i "s|^\(\s*\)location\s/\s{$$|\1location / {\n\1    proxy_pass http://localhost:5212;\n\1}\n\n\1location /aring/ {\n\1    proxy_pass http://localhost:8080/;\n\1}\n\n\1$$nginx_cert_conf|g" $$nginx_conf

# 重启Nginx服务
sudo service nginx restart
