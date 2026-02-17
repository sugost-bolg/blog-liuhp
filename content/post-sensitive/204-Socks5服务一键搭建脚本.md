---
title: "Socks5服务一键搭建脚本"
date: 2019-12-21T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




稳定版V1.1.8
介绍
一个Shell脚本，集成socks5搭建，管理，启动，添加账号等基本操作。基于socks5官方的辅助脚本，方便用户操作，并且支持快速构建socks5服务环境。

脚本只提供学习交流，请在法律允许范围内使用！！！！
系统支持
CentOS 6.x
CentOS 7.x
谷歌云部分系统问题请看更新日志
功能
全自动无人值守安装，服务端部署只需一条命令）

一键开启、关闭ss5服务
添加账户，删除用户，开启账户验证，关闭账户验证，一键修改端口
支持傻瓜式用户添加，小白也可以用
自动修改防火墙规则
输入 s5 即可启动控制面板
一键安装或更新到最新

    wget -q -N --no-check-certificate https://raw.githubusercontent.com/wyx176/Socks5/master/install.sh && bash install.sh
