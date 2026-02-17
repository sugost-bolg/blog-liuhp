---
title: "虚拟机从centos7安装tor到搭建暗网"
date: 2021-06-23T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




linux系统使用 `CentOS-7-x86_64-NetInstall-2009.iso`
centos7 安装源问题
设置网络后使用网上安装源`https://mirrors.aliyun.com/centos/7/os/x86_64/`

安装 Tor
    yum install epel-release
    yum install tor
编辑配置文件
    /etc/tor/torrc
找的以下两行修改
    #HiddenServiceDir /var/lib/tor/hidden_service/
    #HiddenServicePort 80 127.0.0.1:80
改为
    HiddenServiceDir /var/lib/tor/hidden_service/
    HiddenServicePort 80 127.0.0.1:8082
末尾添加tor前置代理
    socks5proxy 192.168.1.208:11223
如果有密码则增加下面两行

    Socks5ProxyPassword 密码
    Socks5ProxyUsername 用户名

tor前置代理可以用 gost 这个开源项目来做。从 [https://github.com/ginuerzh/gost/releases][1] 下载gost二进制执行文件，上传到国外的翻墙服务器和本地虚拟机的/home/gost目录没有gost目录就新建一个。并给gost执行权限。

服务端运行代码 `cd /home/gost && nohup ./gost -L 用户名:密码@:端口 socks5://:端口 >> /dev/null 2>&1 &`
客户端运行代码 `cd /home/gost && nohup ./gost -L=:端口 -F socks5://用户名:密码@服务器ip:端口 >> /dev/null 2>&1 &`

服务器防火墙需要放行对应的端口。


----------


查看防火墙状态:

    firewall-cmd --state

安装防火墙:

    yum -y install firewalld

启动:

    systemctl start firewalld.service

重启:

    systemctl restart firewalld.service

开机启动:

    systemctl enable firewalld.service

停止:

    systemctl stop firewalld.service

禁止开机启动:

    systemctl disable firewalld.service

查看状态:

    systemctl status firewalld.service

放行一下三个端口

    firewall-cmd --zone=public --add-port=22/tcp --permanent
    firewall-cmd --zone=public --add-port=8082/tcp --permanent
    firewall-cmd --zone=public --add-port=9051/tcp --permanent

启动tor
    systemctl start tor
重启tor
    systemctl restart tor
查看tor运行状态
    systemctl status tor
打开下面文件查看域名
    /var/lib/tor/hidden_service/hostname
安装golang环境
    yum install golang
配置环境变量
通过编辑 /etc/profile 文件配置环境变量。
    # vim /etc/profile

在文件的末尾添加如下代码：
    export GOROOT=/usr/lib/golang
    export GOPATH=/var/goproject
    export PATH=$PATH:$GOROOT/bin

    # source /etc/profile
查看环境参数。
    # go env


  [1]: https://github.com/ginuerzh/gost/releases
