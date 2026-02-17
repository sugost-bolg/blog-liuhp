---
title: "Cloudflare搭建DDNS(docker)"
date: 2021-08-18T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

本文所使用的项目地址https://github.com/oznu/docker-cloudflare-ddns

安装 docker

    yum install -y yum-utils device-mapper-persistent-data lvm2 && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && yum install docker-ce && systemctl start docker && systemctl enable docker && docker version

快速设置：

    docker run -d \
      -e EMAIL=hello@example.com \
      -e API_KEY=xxxxxxx \
      -e ZONE=example.com \
      -e SUBDOMAIN=subdomain \
      --restart=always oznu/cloudflare-ddns
