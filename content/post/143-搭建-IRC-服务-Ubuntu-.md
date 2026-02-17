---
title: "搭建 IRC 服务（Ubuntu） "
date: 2021-03-13T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




**问题描述**

我们需要使用 IRC 的即时通知（我们使用 Linux 版本，其他即时通讯软件，要么没有 Linux 客户端，要么已经在使用（我们使用 Slack 办公），要么配置繁琐，总之我们有这样的需求）

该笔记将记录：如何搭建 IRC 服务


----------

**解决方案**

第一步、安装服务

    apt-get install inspircd

第二步、修改配置

修改 `/etc/inspircd/inspircd.conf` 配置：

    <bind address="<0.0.0.0>" port="<6667>" type="clients">

下面为非必要配置：

    <server name="irc.example.com" description="Example IRC Server" network="EXAMPLEIRC">

第三步、启动服务

    systemctl start inspircd.service
