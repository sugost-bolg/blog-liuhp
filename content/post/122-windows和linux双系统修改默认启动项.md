---
title: "windows和linux双系统修改默认启动项"
date: 2021-03-13T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




打开文件

    sudo gedit /etc/default/grub

修改
`GRUB_DEFAULT=0` 就是默认启动的系统，我这里是Linux Mint，然后我的Window10启动为第三个，这里将 0 改为 2 就好了（排序的位置数减一）。同时可以修改`GRUB_TIMEOUT=10`中的10，修改默认的等待时间。改完后点击”保存“然后关闭。

重新生成GRUB的启动菜单配置文件 grub.cfg

    sudo update-grub


