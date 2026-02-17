---
title: "一键pptp安装脚本"
date: 2021-08-16T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




centos7 一键pptp安装脚本
    yum install -y wget
    wget https://z-v.winecoo.com:5678/linux/pptp/CentOS7-pptp-host1plus.sh
    chmod +x ./CentOS7-pptp-host1plus.sh
    ./CentOS7-pptp-host1plus.sh -u wine -p hp198521
