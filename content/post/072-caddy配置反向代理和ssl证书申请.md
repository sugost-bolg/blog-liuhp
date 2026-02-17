---
title: "caddy配置反向代理和ssl证书申请"
date: 2025-07-30T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

[{"source":{"position":0,"lines":["caddy官网下载地址https://caddyserver.com/download。也可以直接点此下载linux amd64版本。

如果是需要申请泛域名证书则需要勾选对应dns提供商的插件，比如cloudflare

注意：cloudflare不再支持.cf, .ga, .gq, .ml,&nbsp; .tk后缀域名使用api管理dns，也就是这些后缀的域名是不能通过cloudflare申请泛域名证书。

下载之后重命名为caddy拷贝到/usr/local/bin下即可。



配置文件Caddyfile在任意目录新建一个文件Caddyfile, 推荐位置为/etc/caddy/Caddyfile

输入以下内容， 表示将www.mydomain.cf转发到localhost:16325,并且自动通过let's encrypt申请ssl证书，申请邮箱为my@qq.com.&nbsp; 开启tls则会默认把http重定向到https

www.mydomain.cf {"]},"target":{"position":0,"lines":["下载Caddycaddy官网下载地址https://caddyserver.com/download。也可以直接点此下载linux amd64版本。

如果是需要申请泛域名证书则需要勾选对应dns提供商的插件，比如cloudflare

注意：cloudflare不再支持.cf, .ga, .gq, .ml,&nbsp; .tk后缀域名使用api管理dns，也就是这些后缀的域名是不能通过cloudflare申请泛域名证书。

下载之后重命名为caddy拷贝到/usr/local/bin下即可。



配置文件Caddyfile在任意目录新建一个文件Caddyfile, 推荐位置为/etc/caddy/Caddyfile

输入以下内容， 表示将www.mydomain.cf转发到localhost:16325,并且自动通过let's encrypt申请ssl证书，申请邮箱为my@qq.com.&nbsp; 开启tls则会默认把http重定向到https

www.mydomain.cf {"]},"type":"CHANGE"},{"source":{"position":10,"lines":["}启动caddy

运行以下命令即可让caddy进入后台运行。其中/etc/caddy/Caddyfile是配置文件Caddyfile所在路径，--dapter caddyfile表示指定配置文件适配器为caddyfile格式，默认是json，caddyfile也可以翻译为json.

如caddy adapt --config /etc/caddy/caddyfile &gt; /etc/caddy/file.json就是将caddyfile翻译为json并输出，然后caddy start的config参数指定为json文件即可。

caddy start --config /etc/caddy/Caddyfile --adapter caddyfilecaddy start是后台启动，但是日志会在当前控制台输出，关闭当前控制台也会继续运行

caddy run是前台启动，当前控制台关闭进程也会关闭

二者参数一致

添加到systemd运行新建文件/usr/lib/systemd/system/caddy.service(centos)或者/etc/systemd/system/caddy.service(ubuntu)，内容如下. 记得将User=my中my修改为有权限的用户名。

[Unit]"]},"target":{"position":10,"lines":["}启动caddy

运行以下命令即可让caddy进入后台运行。其中/etc/caddy/Caddyfile是配置文件Caddyfile所在路径，--dapter caddyfile表示指定配置文件适配器为caddyfile格式，默认是json，caddyfile也可以翻译为json.

如caddy adapt --config /etc/caddy/caddyfile &gt; /etc/caddy/file.json就是将caddyfile翻译为json并输出，然后caddy start的config参数指定为json文件即可。

caddy start --config /etc/caddy/Caddyfile --adapter caddyfilecaddy start是后台启动，但是日志会在当前控制台输出，关闭当前控制台也会继续运行

caddy run是前台启动，当前控制台关闭进程也会关闭

二者参数一致

添加到systemd运行新建文件/usr/lib/systemd/system/caddy.service(centos)或者/etc/systemd/system/caddy.service(ubuntu)，内容如下. 记得将User=my中my修改为有权限的用户名。

[Unit]"]},"type":"CHANGE"},{"source":{"position":29,"lines":["systemctl status caddy.service&nbsp;



"]},"target":{"position":29,"lines":["systemctl status caddy.service&nbsp;

添加开机自启systemctl daemon-reload #激活你的systemd服务单元","systemctl enable caddy.service #启用设置好的服务","systemctl is-enabled caddy.service #测试是否设置成功

"]},"type":"CHANGE"}]
