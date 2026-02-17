---
title: "构建GOST隧道中转"
date: 2020-08-28T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




    wget -N --no-check-certificate https://github.com/ginuerzh/gost/releases/download/v2.11.0/gost-linux-amd64-2.11.0.gz && gzip -d gost-linux-amd64-2.11.0.gz
    mv gost-linux-amd64-2.11.0 gost
    chmod +x gost

中转机安装gost
中转机的gost安装和落地机是一模一样，但是很多国内的机器无法下载或是对于github的下载很是缓慢，所以我们这边直接给它上传一个gost包。

然后改名为gost（改名的目的只是让我们等下的运行命令简单些而已，没什么鸟用。。。）

然后赋予权限

    chmod +x gost

开始中转
中转需要用到以下命令，请自行区分中转机和落地机。

落地机命令（不用修改 7443落地机监听端口，8443为服务软件端口）

    nohup ./gost -L relay+tls://:7443/127.0.0.1:8443 >> /dev/null 2>&1 &

中转机命令（7443落地机监听端口，8443为中转机监听端口）

    nohup ./gost -L udp://:8443 -L tcp://:8443 -F relay+tls://落地机ip:7443 >> /dev/null 2>&1 &

不加密转发（转发本地7443端口到远程443端口）

    nohup ./gost -L :7443/v.winecoo.com:443?ttl=60s >> /dev/null 2>&1 &

关闭gost进程

    kill -9 $(ps aux | grep "gost" | sed '/grep/d' | awk '{print $2}')
