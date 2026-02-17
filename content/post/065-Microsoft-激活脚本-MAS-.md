---
title: "Microsoft 激活脚本 (MAS)"
date: 2025-09-01T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

<p style="">开源 Windows 和 Office 激活器，具有 HWID、Ohook、TSforge、KMS38 和在线 KMS 激活方法以及高级故障排除功能。</p><p style="">如何激活 Windows/Office/扩展更新 (ESU) </p><p style="">方法 1 - PowerShell </p><p style="">信息</p><p style="">打开 PowerShell</p><p style="">单击开始菜单，输入PowerShell，然后打开它。</p><p style="">复制并粘贴以下代码，然后按回车键。</p><p style="">对于Windows 8、10、11：</p><pre><code>irm https://get.activated.win | iex</code></pre><p style="">对于Windows 7及更高版本：</p><pre><code>iex ((New-Object Net.WebClient).DownloadString('https://get.activated.win'))</code></pre><p style="">脚本未启动单击此处获取信息。</p><ul><li><p style="">如果上述操作被阻止（被 ISP/DNS），请尝试以下操作（需要<strong>更新 Windows 10 或 11</strong>）：</p><pre><code>iex (curl.exe -s --doh-url https://1.1.1.1/dns-query https://get.activated.win | Out-String)
</code></pre></li><li><p style="">如果失败或者您使用的是旧版 Windows，请使用<a href="https://massgrave.dev/#method-2---traditional-windows-vista-and-later"><strong><u>方法 2</u></strong></a>。</p></li></ul><p style="">激活菜单将会出现。选择绿色突出显示的选项来激活 Windows 或 Office。</p><p style="">完毕！</p>
