---
title: "docker容器和镜像的操作"
date: 2025-08-01T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

<pre><code class="language-powershell">curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun # 阿里云镜像安装
docker run hello-world # 验证是否安装
systemctl start docker # 启动docker
docker ps -aq # 列出所有的容器 ID
docker stop $(docker ps -aq) # 停止所有的容器
docker rm $(docker ps -aq) # 删除所有的容器
docker rmi $(docker images -q) # 删除所有的镜像
docker cp mycontainer:/opt/file.txt /opt/local/ # 复制文件 容器到主机
docker cp /opt/local/file.txt mycontainer:/opt/ # 复制文件 主机到容器
docker image prune --force --all或者docker image prune -f -a # 删除所有不使用的镜像
docker container prune # 删除所有停止的容器
</code></pre><p style=""></p>
