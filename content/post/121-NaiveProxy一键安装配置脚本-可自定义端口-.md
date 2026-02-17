---
title: "NaiveProxy一键安装配置脚本（可自定义端口）"
date: 2023-06-18T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




本脚本基于centos7制作，在其他系统上应该也能运行，但是我还是建议大家在使用前把vps重装成centos7来使用

项目地址

    https://github.com/imajeason/nas_tools/tree/main/NaiveProxy

执行安装前，请把要使用的域名做一个A解析到你的vps上，并等待解析生效

查看是否生效，在你的vps上执行ping命令即可，如果得到的ip是你解析得目标vps就可以继续操作了。

ping 你的域名
重装好系统后，确保你的vps有5G可用空间。

执行安装，确认你在root账号中执行以下命令安装
安装 naive命令

    curl https://raw.githubusercontent.com/imajeason/nas_tools/main/NaiveProxy/do.sh | bash

执行naive

    naive

安装完成后得到类似以下信息，就安装完成了

    ........... Naiveproxy 配置信息  ..........
    本机ip       =你的vps ip
    域名domain   =你的域名
    端口port     =443
    用户名user   =User
    密码password =这就是密码
    邮箱email    =a@bac.com
