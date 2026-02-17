---
title: "如何在 debian 上安装使用 tor"
date: 2025-08-30T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

[{"source":{"position":0,"lines":["tor的全称是the onion router,是用来保护互联网隐私的一个开源软件。

这篇文章是在debian上安装使用tor代理的过程。

安装在 debian 上安装 tor 只需要执行一条命令



sudo apt-get install tor","配置编辑torrc文件



sudo vi /etc/torrc","找到并注释下面这行



#ControlPort 9051","再找到下面这行 注释并把 1 改成 0



#CookieAuthentication 1","重启 tor



sudo /etc/init.d/tor restart","





"]},"target":{"position":0,"lines":["tor的全称是the onion router,是用来保护互联网隐私的一个开源软件。

这篇文章是在debian上安装使用tor代理的过程。

安装在 debian 上安装 tor 只需要执行一条命令

sudo apt-get install tor配置编辑torrc文件

sudo vi /etc/torrc找到这行，去掉前面#号

#ControlPort 9051找到这行，去掉前面#号，再把 1 改成 0

#CookieAuthentication 1重启 tor

sudo /etc/init.d/tor restart下面是跨机共享代理流量给其他设备，去掉前面#号即可开启

#SocksPort 0.0.0.0:9050卸载tor

sudo apt remove tor &amp;&amp; sudo apt purge tor &amp;&amp; sudo apt autoremove

"]},"type":"CHANGE"}]
