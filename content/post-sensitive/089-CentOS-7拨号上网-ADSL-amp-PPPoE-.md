---
title: "CentOS 7拨号上网（ADSL &amp; PPPoE）"
date: 2021-08-18T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




步骤概述：

1、搜寻PPPoE相关软件，本人使用的是rp-pppoe

　　yum search pppoe

2、使用yum安装rp-pppoe

　　yum install rp-pppoe -y

3、开始配置PPPoE连接

　　pppoe-setup

4、输入ISP提供的账户

5、输入以太网卡代号，默认是eth0（注：CentOS 7已不是默认eth0，自行使用ifconfig命令即可找到）

6、配置：若长时间连线，连线会被自动中断（我不干，选no）

7、配置主DNS服务器

8、配置次DNS服务器

9、两次输入账户密码以确认

10、配置普通账户是否有网络连接权限

11、配置防火墙（没有特殊需求选0就OK）

12、配置是否开机自动拨号连接

13、确认刚填写的配置信息

14、连接网络尽情享受吧！

相关命令@ 连接网络：/sbin/ifup ppp0，断开连接：/sbin/ifdown ppp0，查看网络状态：/sbin/pppoe-status

....................................... 这是华丽丽的分割线 .......................................
获取以太网卡代号

复制代码
 1 [dsp@dsp Desktop]$ ifconfig
 2 enp9s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500                # 有线网卡
 3         ether 20:1b:06:3d:22:05  txqueuelen 1000  (Ethernet)
 4         RX packets 0  bytes 0 (0.0 B)
 5         RX errors 0  dropped 2297  overruns 0  frame 0
 6         TX packets 0  bytes 0 (0.0 B)
 7         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
 8         device interrupt 18  
 9 
10 lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
11         inet 127.0.0.1  netmask 255.0.0.0
12         inet6 ::1  prefixlen 128  scopeid 0x10<host>
13         loop  txqueuelen 0  (Local Loopback)
14         RX packets 2  bytes 110 (110.0 B)
15         RX errors 0  dropped 0  overruns 0  frame 0
16         TX packets 2  bytes 110 (110.0 B)
17         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
18 
19 virbr0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
20         inet 192.168.122.1  netmask 255.255.255.0  broadcast 192.168.122.255
21         ether 52:54:00:36:45:23  txqueuelen 0  (Ethernet)
22         RX packets 0  bytes 0 (0.0 B)
23         RX errors 0  dropped 0  overruns 0  frame 0
24         TX packets 0  bytes 0 (0.0 B)
25         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
26 
27 wlp8s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500                 # 无线网卡
28         inet 192.168.0.151  netmask 255.255.255.0  broadcast 192.168.0.255
29         inet6 fe80::4ad2:24ff:fee8:f962  prefixlen 64  scopeid 0x20<link>
30         ether 48:d2:24:e8:f9:62  txqueuelen 1000  (Ethernet)
31         RX packets 20017  bytes 16100210 (15.3 MiB)
32         RX errors 0  dropped 0  overruns 0  frame 0
33         TX packets 18263  bytes 2641746 (2.5 MiB)
34         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
复制代码
配置rp-pppoe客户端

      1 [root@dsp Desktop]# pppoe-setup
      2 Welcome to the PPPoE client setup.  First, I will run some checks on
      3 your system to make sure the PPPoE client is installed properly...
      4 
      5 LOGIN NAME
      6 
      7 Enter your Login Name (default dsp): 12345      　　# 网络服务提供商提供的账户
      8 
      9 INTERFACE
     10 
     11 Enter the Ethernet interface connected to the PPPoE modem
     12 For Solaris, this is likely to be something like /dev/hme0.
     13 For Linux, it will be ethX, where 'X' is a number.
     14 (default eth0): enp9s0                          　　# 选择以太网卡，有线网卡
     15 
     16 Do you want the link to come up on demand, or stay up continuously?
     17 If you want it to come up on demand, enter the idle time in seconds
     18 after which the link should be dropped.  If you want the link to
     19 stay up permanently, enter 'no' (two letters, lower-case.)
     20 NOTE: Demand-activated links do not interact well with dynamic IP
     21 addresses.  You may have some problems with demand-activated links.
     22 Enter the demand value (default no): no         　　# 输入no，否则若长时间连线，连线会被自动中断
     23 
     24 DNS
     25 
     26 Please enter the IP address of your ISP's primary DNS server.
     27 If your ISP claims that 'the server will provide dynamic DNS addresses',
     28 enter 'server' (all lower-case) here.
     29 If you just press enter, I will assume you know what you are
     30 doing and not modify your DNS setup.
     31 Enter the DNS information here: 8.8.8.8         　　# 主DNS服务器IP，本人使用Google Public DNS
     32 Please enter the IP address of your ISP's secondary DNS server.
     33 If you just press enter, I will assume there is only one DNS server.
     34 Enter the secondary DNS server address here: 8.8.4.4      　　# 二级DNS服务器IP
     35 
     36 PASSWORD　　　　　　　　　　　　　　　　　　　　　　　　　# 账户对应的密码，需两次输入以确认无误
     37 
     38 Please enter your Password: 
     39 Please re-enter your Password: 
     40 
     41 USERCTRL
     42 
     43 Please enter 'yes' (three letters, lower-case.) if you want to allow
     44 normal user to start or stop DSL connection (default yes): yes  # 普通用户是否可以启动停止网络连接
     45 
     46 FIREWALLING
     47 
     48 Please choose the firewall rules to use.  Note that these rules are
     49 very basic.  You are strongly encouraged to use a more sophisticated
     50 firewall setup; however, these will provide basic security.  If you
     51 are running any servers on your machine, you must choose 'NONE' and
     52 set up firewalling yourself.  Otherwise, the firewall rules will deny
     53 access to all standard servers like Web, e-mail, ftp, etc.  If you
     54 are using SSH, the rules will block outgoing SSH connections which
     55 allocate a privileged source port.
     56 
     57 The firewall choices are:
     58 0 - NONE: This script will not set any firewall rules.  You are responsible
     59           for ensuring the security of your machine.  You are STRONGLY
     60           recommended to use some kind of firewall rules.
     61 1 - STANDALONE: Appropriate for a basic stand-alone web-surfing workstation
     62 2 - MASQUERADE: Appropriate for a machine acting as an Internet gateway
     63                 for a LAN
     64 Choose a type of firewall (0-2): 0　　　　　　　　　　　　　　　# 选 0 吧
     65 
     66 Start this connection at boot time
     67 
     68 Do you want to start this connection at boot time?
     69 Please enter no or yes (default no):yes　　　　　　　　　　　　# 是否系统启动是就连接网络
     70 
     71 ** Summary of what you entered **　　　　　　　　　　　　　　　
     72 
     73 Ethernet Interface: enp9s0
     74 User name:          12345
     75 Activate-on-demand: No
     76 Primary DNS:        8.8.8.8
     77 Secondary DNS:      8.8.4.4
     78 Firewalling:        NONE
     79 User Control:       yes
     80 Accept these settings and adjust configuration files (y/n)? y　　　　# 确认刚才输入的网络配置信息
     81 Adjusting /etc/sysconfig/network-scripts/ifcfg-ppp0
     82 Adjusting /etc/resolv.conf
     83   (But first backing it up to /etc/resolv.conf.bak)
     84 Adjusting /etc/ppp/chap-secrets and /etc/ppp/pap-secrets
     85   (But first backing it up to /etc/ppp/chap-secrets.bak)
     86   (But first backing it up to /etc/ppp/pap-secrets.bak)
     87 
     88 
     89 Congratulations, it should be all set up!
     90 
     91 Type '/sbin/ifup ppp0' to bring up your xDSL link and '/sbin/ifdown ppp0'　# rp-pppoe的操作命令
     92 to bring it down.
     93 Type '/sbin/pppoe-status /etc/sysconfig/network-scripts/ifcfg-ppp0'
     94 to see the link status.
     95 
     96 [root@dsp Desktop]# /sbin/ifup ppp0　　　　　　# 启动网络连接
     97 [root@dsp Desktop]# /sbin/pppoe-status　　　　# 查看网络连接状态
     98 pppoe-status: Link is up and running on interface ppp0
     99 6: ppp0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1492 qdisc pfifo_fast state UNKNOWN qlen 3
    100     link/ppp 
    101     inet 10.198.0.17 peer 10.198.1.1/32 scope global ppp0
    102        valid_lft forever preferred_lft forever

配置rp-pppoe客户端
 

     1 [root@dsp Desktop]# pppoe-setup
      2 Welcome to the PPPoE client setup.  First, I will run some checks on
      3 your system to make sure the PPPoE client is installed properly...
      4 
      5 LOGIN NAME
      6 
      7 Enter your Login Name (default dsp): 12345      　　# 网络服务提供商提供的账户
      8 
      9 INTERFACE
     10 
     11 Enter the Ethernet interface connected to the PPPoE modem
     12 For Solaris, this is likely to be something like /dev/hme0.
     13 For Linux, it will be ethX, where 'X' is a number.
     14 (default eth0): enp9s0                          　　# 选择以太网卡，有线网卡
     15 
     16 Do you want the link to come up on demand, or stay up continuously?
     17 If you want it to come up on demand, enter the idle time in seconds
     18 after which the link should be dropped.  If you want the link to
     19 stay up permanently, enter 'no' (two letters, lower-case.)
     20 NOTE: Demand-activated links do not interact well with dynamic IP
     21 addresses.  You may have some problems with demand-activated links.
     22 Enter the demand value (default no): no         　　# 输入no，否则若长时间连线，连线会被自动中断
     23 
     24 DNS
     25 
     26 Please enter the IP address of your ISP's primary DNS server.
     27 If your ISP claims that 'the server will provide dynamic DNS addresses',
     28 enter 'server' (all lower-case) here.
     29 If you just press enter, I will assume you know what you are
     30 doing and not modify your DNS setup.
     31 Enter the DNS information here: 8.8.8.8         　　# 主DNS服务器IP，本人使用Google Public DNS
     32 Please enter the IP address of your ISP's secondary DNS server.
     33 If you just press enter, I will assume there is only one DNS server.
     34 Enter the secondary DNS server address here: 8.8.4.4      　　# 二级DNS服务器IP
     35 
     36 PASSWORD　　　　　　　　　　　　　　　　　　　　　　　　　# 账户对应的密码，需两次输入以确认无误
     37 
     38 Please enter your Password: 
     39 Please re-enter your Password: 
     40 
     41 USERCTRL
     42 
     43 Please enter 'yes' (three letters, lower-case.) if you want to allow
     44 normal user to start or stop DSL connection (default yes): yes  # 普通用户是否可以启动停止网络连接
     45 
     46 FIREWALLING
     47 
     48 Please choose the firewall rules to use.  Note that these rules are
     49 very basic.  You are strongly encouraged to use a more sophisticated
     50 firewall setup; however, these will provide basic security.  If you
     51 are running any servers on your machine, you must choose 'NONE' and
     52 set up firewalling yourself.  Otherwise, the firewall rules will deny
     53 access to all standard servers like Web, e-mail, ftp, etc.  If you
     54 are using SSH, the rules will block outgoing SSH connections which
     55 allocate a privileged source port.
     56 
     57 The firewall choices are:
     58 0 - NONE: This script will not set any firewall rules.  You are responsible
     59           for ensuring the security of your machine.  You are STRONGLY
     60           recommended to use some kind of firewall rules.
     61 1 - STANDALONE: Appropriate for a basic stand-alone web-surfing workstation
     62 2 - MASQUERADE: Appropriate for a machine acting as an Internet gateway
     63                 for a LAN
     64 Choose a type of firewall (0-2): 0　　　　　　　　　　　　　　　# 选 0 吧
     65 
     66 Start this connection at boot time
     67 
     68 Do you want to start this connection at boot time?
     69 Please enter no or yes (default no):yes　　　　　　　　　　　　# 是否系统启动是就连接网络
     70 
     71 ** Summary of what you entered **　　　　　　　　　　　　　　　
     72 
     73 Ethernet Interface: enp9s0
     74 User name:          12345
     75 Activate-on-demand: No
     76 Primary DNS:        8.8.8.8
     77 Secondary DNS:      8.8.4.4
     78 Firewalling:        NONE
     79 User Control:       yes
     80 Accept these settings and adjust configuration files (y/n)? y　　　　# 确认刚才输入的网络配置信息
     81 Adjusting /etc/sysconfig/network-scripts/ifcfg-ppp0
     82 Adjusting /etc/resolv.conf
     83   (But first backing it up to /etc/resolv.conf.bak)
     84 Adjusting /etc/ppp/chap-secrets and /etc/ppp/pap-secrets
     85   (But first backing it up to /etc/ppp/chap-secrets.bak)
     86   (But first backing it up to /etc/ppp/pap-secrets.bak)
     87 
     88 
     89 Congratulations, it should be all set up!
     90 
     91 Type '/sbin/ifup ppp0' to bring up your xDSL link and '/sbin/ifdown ppp0'　# rp-pppoe的操作命令
     92 to bring it down.
     93 Type '/sbin/pppoe-status /etc/sysconfig/network-scripts/ifcfg-ppp0'
     94 to see the link status.
     95 
     96 [root@dsp Desktop]# /sbin/ifup ppp0　　　　　　# 启动网络连接
     97 [root@dsp Desktop]# /sbin/pppoe-status　　　　# 查看网络连接状态
     98 pppoe-status: Link is up and running on interface ppp0
     99 6: ppp0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1492 qdisc pfifo_fast state UNKNOWN qlen 3
    100     link/ppp 
    101     inet 10.198.0.17 peer 10.198.1.1/32 scope global ppp0
    102        valid_lft forever preferred_lft forever


