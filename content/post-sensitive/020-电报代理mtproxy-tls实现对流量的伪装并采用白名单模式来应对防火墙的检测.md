---
title: "电报代理mtproxy+tls实现对流量的伪装并采用白名单模式来应对防火墙的检测"
date: 2021-07-02T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




该镜像集成了nginx、mtproxy+tls 实现对流量的伪装，并采用白名单模式来应对防火墙的检测。
Installation
Centos7上安装docker

Docker从1.13版本之后采用时间线的方式作为版本号，分为社区版CE和企业版EE。

社区版是免费提供给个人开发者和小型团体使用的，企业版会提供额外的收费服务，比如经过官方测试认证过的基础设施、容器、插件等。

社区版按照stable和edge两种方式发布，每个季度更新stable版本，如17.06，17.09；每个月份更新edge版本，如17.09，17.10。

 一、安装docker
1、Docker 要求 CentOS 系统的内核版本高于 3.10 ，查看本页面的前提条件来验证你的CentOS 版本是否支持 Docker 。

通过 uname -r 命令查看你当前的内核版本

 $ uname -r
2、使用 root 权限登录 Centos。确保 yum 包更新到最新。

$ sudo yum update
3、卸载旧版本(如果安装过旧版本的话)

$ sudo yum remove docker  docker-common docker-selinux docker-engine
4、安装需要的软件包， yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的

$ sudo yum install -y yum-utils device-mapper-persistent-data lvm2
5、设置yum源

$ sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
 
6、可以查看所有仓库中所有docker版本，并选择特定版本安装

$ yum list docker-ce --showduplicates | sort -r


7、安装docker

$ sudo yum install docker-ce  #由于repo中默认只开启stable仓库，故这里安装的是最新稳定版17.12.0
$ sudo yum install <FQPN>  # 例如：sudo yum install docker-ce-17.12.0.ce
 

8、启动并加入开机启动

$ sudo systemctl start docker
$ sudo systemctl enable docker
9、验证安装是否成功(有client和service两部分表示docker安装启动都成功了)

$ docker version

 二、问题
1、因为之前已经安装过旧版本的docker，在安装的时候报错如下：

Transaction check error:
  file /usr/bin/docker from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64
  file /usr/bin/docker-containerd from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64
  file /usr/bin/docker-containerd-shim from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64
  file /usr/bin/dockerd from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64

2、卸载旧版本的包

$ sudo yum erase docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64

3、再次安装docker

$ sudo yum install docker-ce

卸载 docker
删除安装包：
yum remove docker-ce

删除镜像、容器、配置文件等内容：
rm -rf /var/lib/docker

----------


Pull images

docker pull ellermister/nginx-mtproxy:latest

Quickly create MTProxy

可通过 -p 指定端口映射，连接均为外部端口。

docker run --name nginx-mtproxy -d  -p 80:80 -p 443:443 ellermister/nginx-mtproxy:latest

Custom parameters

你可以在创建时指定 secret、tag、 domain：

secret=$(head -c 16 /dev/urandom | xxd -ps)
tag="12345678901234567890121231231231"
domain="cloudflare.com"
docker run --name nginx-mtproxy -d -e tag="$tag" -e secret="$secret" -e domain="$domain" -p 80:80 -p 443:443 ellermister/nginx-mtproxy:latest

创建完毕后，查看访问链接：

docker logs nginx-mtproxy

注意：请注意修改端口为你的 docker 映射的端口。

Usage
The image uses a whitelist mode to fight crawling and firewall detection.

该镜像采用白名单模式，来应对爬虫和防火墙探测。

whitelist
By default, all visitors are not allowed to connect. Only when the visitor tries to access the address below, the guest IP will be added to the whitelist.

The IP and port depend on your docker configuration:

默认所有访客都不被允许连接，只有当访客尝试访问了下面的地址，才会将访客IP加入到白名单中。

IP 和端口取决于你 docker 的配置：

http://ip/add.php

service Stop service / 停止服务

docker stop nginx-mtproxy

Start service / 启动服务

docker start nginx-mtproxy

Restart service / 重启服务

docker restart nginx-mtproxy

Delete service / 删除服务

docker rm nginx-mtproxy

Auto Run /  开机自启 

docker update --restart=always nginx-mtproxy
