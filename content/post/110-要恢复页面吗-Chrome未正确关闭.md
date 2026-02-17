---
title: "要恢复页面吗?Chrome未正确关闭"
date: 2021-04-30T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




异常描述

谷歌chrome浏览器每次打开提示“要恢复页面吗”怎么办？

此时如果你打开任务管理器时你会发现在任务管理器中有多个chrome.exe进程，在把chrome浏览器关闭后后台仍旧残留一些chrome.exe进程，这就导致了浏览器以为你强制退出了，在下次启动时就有“chrome未正确关闭，要恢复页面吗？”的提示。

解决方法：

1、关闭谷歌浏览器

2、打开 C:\Users\电脑用户名\AppData\Local\Google\Chrome\User Data\Default 文件夹中的 Preferences 文件

3、查找exit_type，将"exit_type":“crash” 改为"Normal"

4、将Preferences 改为“只读”
![Snipaste_2021-04-27_04-57-18.jpg][1]


  [1]: https://liuhongping.com/usr/uploads/2021/04/1914231265.jpg
