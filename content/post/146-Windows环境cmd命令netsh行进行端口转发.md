---
title: "Windows环境cmd命令netsh行进行端口转发"
date: 2021-04-28T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




查询所有存在的转发

> netsh interface portproxy show all

将本地上的8443映射到192.168.191.2的443端口：

> netsh interface portproxy add v4tov4 8443 192.168.191.2 443

删除端口映射

> netsh interface portproxy del v4tov4 listenport=8443

进行了端口映射后的两机器，本地机器防火墙开启8443端口即可通过监听的端口互相进行访问。
