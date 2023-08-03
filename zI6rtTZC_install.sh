#非常抱歉，似乎在复制粘贴脚本时出现了一些问题，导致了语法错误。请尝试以下修复后的脚本：

```bash
#!/bin/bash

# 安装certbot和Nginx插件
sudo apt update
sudo apt install -y certbot python3-certbot-nginx dialog

# 获取用户输入的域名
domain=$(dialog --inputbox "请输入你的域名:" 10 30 --output-fd 1)

# 图形化界面申请证书
sudo certbot certonly --nginx -d $domain

# 完成后，certbot-nginx插件会自动配置Nginx使用新生成的证书
```

#请注意，我已经修复了 `dialog` 命令中的空格问题，并且加入了对 `dialog` 工具的安装。

#请尝试使用修改后的脚本再次运行，并输入你的域名进行测试。如果还是遇到问题，请提供更多的相关信息，以便我能帮助你更好地解决问题。
