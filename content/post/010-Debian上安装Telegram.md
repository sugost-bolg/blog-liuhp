---
title: "Debian上安装Telegram"
date: 2025-08-27T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

<p style="">在Debian上安装Telegram有几种主要方法：使用Snap（推荐，最简单）、Flatpak或从官方下载的Tarball进行手动安装。最常用的是通过snapd安装，命令为sudo snap install telegram-desktop，但需要先确保snapd已安装并启用。﻿</p><h2 style="" id="%E4%BD%BF%E7%94%A8snap-(%E6%8E%A8%E8%8D%90)"> 使用Snap (推荐)</h2><p style=""> 这是最简单的方法，适用于Debian 9及更新版本。﻿</p><p style=""><strong>安装Snapd </strong>如果你的系统没有Snapd，请先安装它。</p><p style="">代码</p><pre><code>sudo apt update
sudo apt install snapd
sudo snap install core</code></pre><p style=""><strong>安装Telegram</strong> 接着使用以下命令安装Telegram Desktop。﻿</p><p style="">代码</p><pre><code>sudo snap install telegram-desktop</code></pre><p style=""></p>
