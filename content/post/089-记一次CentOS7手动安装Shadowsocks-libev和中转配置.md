---
title: "记一次CentOS7手动安装Shadowsocks-libev和中转配置"
date: 2021-08-30T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

今天先手动装一波SS-libev，外加配置下中转，正好自己不是很了解这些，做个记录~
准备两台机器，这里我们就称两台机器名为“被中转服务器”和“中转服务器”，系统选择CentOS7X64。
我们先在“被中转服务器”上安装SS-libev。
这次是装国内机器，不能翻墙于是就先到这里 https://github.com/shadowsocks/shadowsocks-libev/releases/
把安装包 shadowsocks-libev-3.3.5.tar.gz 下载到本地然后上传到被中转机器root目录下。

    cd /root
    yum install epel-release -y
    yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium-devel mbedtls-devel -y
    tar xf shadowsocks-libev-3.3.5.tar.gz
    cd shadowsocks-libev-3.3.5
    ./configure
    make
    make install

2、通过加载配置文件来运行：
我们可以先在root目录下生成一个ssconfig.json：

    cd /root
    vi ssconfig.json

在这个文件内填入如下配置信息：

    {
        "server":["0.0.0.0"],
        "server_port":21313,
        "local_address":"127.0.0.1",
        "local_port":1080,
        "password":"lala.im-TEST",
        "timeout":600,
        "method":"chacha20-ietf-poly1305"
    }

注：server_port即SS连接端口，password即SS连接密码，method即SS加密方式，同理使用客户端连接这台服务器填写这台机器的公网IP即可。

填写完毕后，退出并保存，接着使用如下命令启动服务端：

   nohup ss-server -c /root/ssconfig.json -u > /dev/null 2>&1 &

结束进程：

    kill -9 $(ps aux | grep "ss-server" | sed '/grep/d' | awk '{print $2}')

假设你测试连接不成功，一般都是防火墙的问题，首先查看防火墙的状态：

    systemctl status firewalld

不想麻烦的话，可以直接将这台“被中转服务器”的防火墙关闭：

    systemctl stop firewalld

如果不想关闭的话，可以添加相应的规则来放行我们的SS端口，这里我以21313端口为例：

    firewall-cmd --permanent --zone=public --add-port=21313/tcp
    firewall-cmd --permanent --zone=public --add-port=21313/udp
    firewall-cmd --reload

这样操作后，再次尝试连接，应该就可以了，如果还是还是不行，那只能说你的人品有问题。。。
至此，“被中转服务器”的SS服务端就搭建好了，如果你不需要中转服务的话，那么你现在就可以用这台机器开始科学上网了。如果你需要中转服务，请接着往下阅读。

我们现在登录“中转服务器”来配置相应的防火墙规则。
请注意，本文所使用的系统是CentOS7，7系统默认是不启用iptables的，7是默认启用新版firewall防火墙的。所以我文章这里的规则是适用于firewall的，不适用iptables，如果你的系统是CentOS6请不要模仿本文操作。。。
另外“中转服务器”不需要安装任何额外的东西，连SS服务端都不需要安装，你只需要保证这台机器启动了firewall即可，启动命令：

    systemctl start firewalld

接着开启CentOS7的ipv4转发功能：

    echo 1 > /proc/sys/net/ipv4/ip_forward

这里假设，我们拿“中转服务器”的52888端口做转发，“被中转服务器”的SS服务端口是21313，那么可以使用如下规则：

    firewall-cmd --permanent --add-port=52888/tcp
    firewall-cmd --permanent --add-port=52888/udp
    firewall-cmd --permanent --add-masquerade
    firewall-cmd --permanent --add-forward-port=port=52888:proto=tcp:toport=21313:toaddr=被中转服务器的公网IP
    firewall-cmd --permanent --add-forward-port=port=52888:proto=udp:toport=21313:toaddr=被中转服务器的公网IP
    firewall-cmd --reload

注：你的SS端口号和服务器的公网IP以及这台用来做转发的端口号，都可以根据你的实际需要来修改。

这样配置好了后，我们就可以使用SS客户端来进行连接测试了，SS客户端配置信息的填写，你只需要更改两个地方：
1、将“被中转服务器”的公网IP改成现在这台“中转服务器”的公网IP。

2、将“被中转服务器”的SS端口号改成现在这台“中转服务器”的转发端口号。
其他配置，比如：连接密码、加密方式等等都不需要做更改，保存原先的即可。
至此，整个过程就大功告成了~
