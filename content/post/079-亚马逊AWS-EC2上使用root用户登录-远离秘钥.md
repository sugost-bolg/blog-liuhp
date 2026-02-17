---
title: "亚马逊AWS EC2上使用root用户登录-远离秘钥"
date: 2022-10-09T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




aws ec2默认是使用ec2-user账号登陆的，对很多文件夹是没有权限的。如何使用root账号执行命令就是一个问题了。解决办法如下：

1.根据官网提供的方法登录连接到EC2服务器（官网推荐windows用户使用PUTTY连接）

主机：是服务器的Public DNS

端口：22

2.创建root的密码，输入如下命令：

sudo passwd root

3.然后会提示你输入new password。输入一个你要设置的root的密码，需要你再输入一遍进行验证。

4.接下来，切换到root身份，输入如下命令：

su root

5.使用root身份编辑亚马逊云主机的ssh登录方式，找到 PasswordAuthentication no，把no改成yes。输入：

vim /etc/ssh/sshd_config

6.接下来，要重新启动下sshd，如下命令：

sudo /sbin/service sshd restart

7.然后再切换到root身份

su root

8.再为原来的”ec2-user”添加登录密码。如下命令：

passwd ec2-user

按提示，两次输入密码。

9.修改sshd配置文件

vi /etc/ssh/sshd_config

PermitRootLogin这行改为

PermitRootLogin yes

PasswordAuthentication no改为

PasswordAuthentication yes

UsePAM yes改为

UsePAM no
