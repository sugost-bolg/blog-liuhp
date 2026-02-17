---
title: "AdGuardHome+Passwall配合使用配置"
date: 2025-08-05T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

[{"source":{"position":0,"lines":["<h1 style=\"\" id=\"passwall-%E9%85%8D%E7%BD%AE\">Passwall 配置</h1><p style=\"\">DNS 分流=DnsmasqChinaDNS-NG (推荐)<a href=\"http://10.10.10.254/cgi-bin/luci/admin/services/passwall/settings#\" class=\"log-link\">日志</a></p><p style=\"\">直连 DNS 请求协议=自动</p><p style=\"\">过滤代理域名 IPv6=☑️</p><p style=\"\">实验性功能。</p><p style=\"\">过滤模式=通过 TCP 请求 DNS</p><p style=\"\">远程 DNS=8.8.8.8 (Google)</p><p style=\"\">默认 DNS=智能，不接受直连 DNS 空响应</p><p style=\"\">停用 HTTPS 记录解析=☑️</p><p style=\"\">DNS 重定向=☑️</p><h1 style=\"\" id=\"adguardhome-%E9%85%8D%E7%BD%AE\">AdGuardHome 配置</h1><p style=\"\">在iStoreOS的 服务 AdGuardHome</p><p style=\"\">基础设置，53 重定向=作为dnsmasq的上游服务器，设置完网页访问端口和服务端口。</p><p style=\"\">手动设置，输入以下配置代码保存后重启AdGuardHome服务。</p><pre collapsed=\"true\"><code>http:"]},"target":{"position":0,"lines":["<h2 style=\"\" id=\"passwall-%E9%85%8D%E7%BD%AE\">Passwall 配置</h2><p style=\"\">DNS 分流=DnsmasqChinaDNS-NG (推荐)<a href=\"http://10.10.10.254/cgi-bin/luci/admin/services/passwall/settings#\" class=\"log-link\">日志</a></p><p style=\"\">直连 DNS 请求协议=自动</p><p style=\"\">过滤代理域名 IPv6=☑️</p><p style=\"\">过滤模式=通过 TCP 请求 DNS</p><p style=\"\">远程 DNS=8.8.8.8 (Google)</p><p style=\"\">默认 DNS=智能，不接受直连 DNS 空响应</p><p style=\"\">停用 HTTPS 记录解析=☑️</p><p style=\"\">DNS 重定向=☑️</p><h2 style=\"\" id=\"adguardhome-%E9%85%8D%E7%BD%AE\">AdGuardHome 配置</h2><p style=\"\">在iStoreOS的 服务 AdGuardHome</p><p style=\"\">基础设置，53 重定向=作为dnsmasq的上游服务器，设置完网页访问端口和服务端口。</p><p style=\"\">手动设置，输入以下配置代码保存后重启AdGuardHome服务。</p><pre><code>http:"]},"type":"CHANGE"}]
