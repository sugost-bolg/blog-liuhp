---
title: "恢复 GNOME 顶栏的托盘图标"
date: 2025-08-24T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

<h2 style="" id="%E5%AE%89%E8%A3%85gnome%E6%89%A9%E5%B1%95%E7%AE%A1%E7%90%86%E5%99%A8">安装gnome扩展管理器</h2><pre><code>sudo apt install gnome-shell-extension-manager</code></pre><h2 style="" id="%E5%90%AF%E7%94%A8-gnome-%E6%8F%92%E4%BB%B6%E7%9A%84%E6%B5%8F%E8%A7%88%E5%99%A8%E6%89%A9%E5%B1%95">启用 GNOME 插件的浏览器扩展</h2><p style="">现在，有一些可以向顶栏增加托盘图标的 GNOME 插件。在撰写本篇教程的时候，AppIndicator and KStatusNotifierItem Support 这款插件在 GNOME 的较新版本中已经有良好的开发优化与支持。</p><p style="">前往插件的页面：</p><p style=""><a href="https://extensions.gnome.org/extension/615/appindicator-support/" target="_blank" rel="">AppIndicator</a> 插件</p><p style="">在这个页面中，你应该能看到一个开关按钮。点击这个按钮即可安装该插件。</p><p style="">接下来会有一个弹窗，弹出后请点击“安装”。</p><p style="">安装插件</p><p style="">也许安装插件后，插件不会立即生效。此时，你必须重启 GNOME。在 Xorg会话中，你只需要按下 Alt + F2 并输入 r 即可重启 GNOME，但这个操作不支持 Wayland会话。</p><p style="">注销当前会话，并且重新登录，此后托盘图标应该就能成功启用了。如果你安装了任何一款带托盘图标的软件，那么你应该可以在顶栏上看见这些图标的身影了。</p>
