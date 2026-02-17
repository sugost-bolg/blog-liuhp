---
title: "gost一对多端口转发"
date: 2022-05-06T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




落地服务器

    nohup ./gost -L relay+tls://:50505/:9050 >> /dev/null 2>&1 &

windows客户端

    gost >nul 2>nul -L tcp://:10000 -F relay+tls://192.168.100.100:50505
    gost >nul 2>nul -L tcp://:20000 -F relay+tls://192.168.100.200:50505

windows负载均衡客户端

    gost >nul 2>nul -L=:9050 -F=socks5://:10000,:20000&strategy=round&max_fails=1&fail_timeout=30s
