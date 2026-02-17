---
title: "Manjaro KDE 裝機記錄"
date: 2021-03-17T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




先到國內鏡像網站下載安裝鏡像然後用rufus-3.0或者一下的版本選擇 DD模式 燒錄進u盤，如果以後系統版本更新或者不要DD模式，具體看燒錄的效果，不行再換其他的燒錄。

Manjaro KDE 切换国内源及软件安装

1.配置镜像源:

sudo pacman-mirrors -i -c China -m rank

3.更新源列表

sudo pacman-mirrors -g

4.更新pacman数据库并全面更新系统

sudo pacman -Syyu
----------

**更新完後開始裝軟件和配置主題**

一、安装fcitx5、配置工具、rime

    sudo pacman -S fcitx5 fcitx5-qt fcitx5-gtk fcitx5-configtool fcitx5-rime

二、在fcitx5中填加RIME输入法

      打开fcitx5设置工具，然后点击填加输入法，找到RIME，然后填加

三、设置fcitx5为开机启动

1、在用户文件夹下创建.xprofile配置文件

      输入命令
 
sudo vim ~/.xprofile

      然后插入如下内容

  export GTK_IM_MODULE=fcitx5

  export QT_IM_MODULE=fcitx5

  export XMODIFIERS=@im=fcitx


2、设置fcitx5为开机启动

      ①: 直接在~/.xprofile中插入下面这行

      fcitx5 &

      ②: 如果是KDE用户，可在系统设置-启动和关闭-自启动中填加fcitx5为开机自启动

四、安装RIME五笔方案

    1、五笔码表下载地址https://github.com/rime/rime-wubi

    2、将下载的文件解压并将其中的.yaml文件复到/usr/share/rime-data中

    3、编辑/usr/share/rime-data/default.yaml并在scheama_list段落下插入

    schema: wubi86
    
    schema: wubi_pinyin
    
    schema: wubi_trad

    4、重启fcitx5

    5、切换输入法为RIME，按F4,然后用上下箭头选择五笔或所要使用的输入法

----------

**主題安裝**

主題中心下載 全局主題 layan 設置完後，可能需要調整面板位置，

到軟件中心下載 latte 這個是底部的dock，設置完需要顯示的效果

----------

**裝到這裏後就可以去選擇自己想要的軟件安裝了。**

記錄下自己常用的軟件，在軟件中心可以直接安裝的有一下：

telegram  聊天軟件

vlc  音樂播放器

remmina  遠程桌面登錄

simplescreenrecorder  錄屏軟件

FileZilla  ftp客戶端

----------
軟件中心沒有谷歌裝，需要手動編譯

    git clone https://aur.archlinux.org/google-chrome.git

進入下載後的目錄一般在$home下，進入谷歌軟件的目錄執行 `makepkg -si`

編譯好後會下載一些文件，如果有看到chrome-*.tar.zst 這樣的文件就可以直接安裝，如果沒有的話就執行`sudo pacman -U google-chrome*.tar.xz` 會編譯下載來的deb的安裝包。

----------

    v2rayA下载安装及使用教程 支持VMess/VLESS/SS/SSR/Trojan

archlinux/manjaro v2raya已发布于AUR中：

    git clone https://aur.archlinux.org/v2raya.git /tmp/v2raya
    cd /tmp/v2raya
    makepkg -si

如果makepkg失败，运行以下命令再试：

    sudo pacman -S base-devel

部署完毕后，访问该机器的2017端口即可使用，如http://localhost:2017。
由於源用國內源，安裝過程需要翻牆。


