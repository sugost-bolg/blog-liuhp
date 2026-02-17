---
title: " gost3-relay+tls-负载均衡"
date: 2022-04-27T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




linux服务端

    cd /home/gost && nohup ./gost -L relay+tls://user:password@:端口 >> /dev/null 2>&1 &

window客户端

    gost -L :本地监听端口 -F relay+tls://user:password@ip:端口,ip:端口,ip:端口?nodelay=false&strategy=rand&maxFails=3&failTimeout=60s
