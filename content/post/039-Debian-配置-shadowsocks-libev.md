---
title: "Debian 配置 shadowsocks-libev"
date: 2024-09-25T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




安装

    apt install shadowsocks-libev

进入配置文件

    cd /etc/shadowsocks-libev

修改配置

    {
        "server":"0.0.0.0",
        "mode":"tcp_and_udp",
        "server_port":8388,
        "local_port":1080,
        "password":"123456",
        "timeout":86400,
        "method":"aes-256-gcm"
    }

服务端口 18339， 本地端口 8388，密码 123456，加密方式 aes-256-gcm

重启服务器测试自启动
