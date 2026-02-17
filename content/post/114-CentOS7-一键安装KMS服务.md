---
title: "CentOS7 一键安装KMS服务"
date: 2019-09-10T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




关于本脚本
1、本脚本适用于三大 Linux 发行版，其他版本则不支持。
2、KMS 服务安装完成后会加入开机自启动。
3、默认记录日志，其日志位于 /var/log/vlmcsd.log。

使用方法
使用root用户登录，运行以下命令：

    wget --no-check-certificate https://github.com/teddysun/across/raw/master/kms.sh && chmod +x kms.sh && ./kms.sh

安装完成后，输入以下命令查看端口号 1688 的监听情况：

    netstat -nxtlp | grep 1688

返回值类似于如下这样就表示 OK 了：

    tcp        0      0 0.0.0.0:1688                0.0.0.0:*                   LISTEN      3200/vlmcsd         
    tcp        0      0 :::1688                     :::*                        LISTEN      3200/vlmcsd 

本脚本安装完成后，会将 KMS 服务加入开机自启动。

使用命令：
启动：`/etc/init.d/kms start`
停止：`/etc/init.d/kms stop`
重启：`/etc/init.d/kms restart`
状态：`/etc/init.d/kms status`

卸载方法：
使用 root 用户登录，运行以下命令： `./kms.sh uninstall` 

管理员身份运行命令 `slmgr /skms hp.liuhp.net:1688 && slmgr /ato`
