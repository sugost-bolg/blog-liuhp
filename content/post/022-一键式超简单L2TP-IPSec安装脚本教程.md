---
title: "一键式超简单L2TP/IPSec安装脚本教程"
date: 2021-08-14T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




系统要求
首先说下系统要求吧，系统支持：CentOS6+，Debian7+，Ubuntu12+，内存小于128M的小鸡仔就不要往下看了为你好另外OpenVZL架构的也不要看了（因为需要开启TUN/TAP才能正常使用、还需要系统内核支持 IPSec 才行一般不建议在 OpenVZ 的 VPS 上安装。）

检测TUN/TAP
如果条件都符合的话，我们现在先检测是否支持TUN模块执行命令

cat /dev/net/tun
如果返回信息为：cat: /dev/net/tun: File descriptor in bad state 说明正常

检测是否支持ppp模块执行命令

cat /dev/ppp
如果返回信息为：cat: /dev/ppp: No such device or address 说明正常

如果上面的四点都全部满足的话可以接着往下看啦，基本上99％的都可以满足，要是不能满足的都是超级垃圾没人要的服务器了，建议尽早更换

安装步骤
执行命令

    wget --no-check-certificate http://shell.easion.site/shell/vpn/l2tp-ipsec-vpn/l2tp-2020.06.05.sh
    chmod +x l2tp-2020.06.05.sh
    ./l2tp-2020.06.05.sh

使用命令
如果你要想对用户进行操作，可以使用如下命令：
l2tp -a 新增用户
l2tp -d 删除用户
l2tp -m 修改现有的用户的密码
l2tp -l 列出所有用户名和密码
l2tp -h 列出帮助信息
