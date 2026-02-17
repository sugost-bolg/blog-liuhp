---
title: "auto_trade_js_7 相关命令"
date: 2025-10-21T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

[{"source":{"position":0,"lines":["<p style=\"\">安装环境</p><pre><code>cd /home/auto_trade &amp;&amp; chmod +x install_numpy_ccxt.sh &amp;&amp; ./install_numpy_ccxt.sh</code></pre><p style=\"\">测试交易</p><pre><code>cd /home/auto_trade &amp;&amp; python3 okx_multi_account.py</code></pre><p style=\"\">开机自启</p><pre><code>cd /home/auto_trade &amp;&amp;  chmod +x /create_okx_service.sh &amp;&amp; ./create_okx_service.sh</code></pre><p style=\"\">启动交易</p><pre><code>systemctl start okx_multi_account.service</code></pre><p style=\"\">暂停交易</p><pre><code>sudo systemctl stop okx_multi_account.service</code></pre><p style=\"\">重启交易</p><pre><code>systemctl restart okx_multi_account.service</code></pre><p style=\"\">显示日志</p><pre><code>cd /home/auto_trade &amp;&amp; chmod +x show_log.sh &amp;&amp; ./show_log.sh</code></pre><p style=\"\"></p>"]},"target":{"position":0,"lines":["<p style=\"\">安装环境</p><pre><code>cd /home/auto_trade &amp;&amp; chmod +x install_numpy_ccxt.sh &amp;&amp; ./install_numpy_ccxt.sh</code></pre><p style=\"\">测试交易</p><pre><code>cd /home/auto_trade &amp;&amp; python3 okx_multi_account.py</code></pre><p style=\"\">设置开机自启交易</p><pre><code>cd /home/auto_trade &amp;&amp;  chmod +x /create_okx_service.sh &amp;&amp; ./create_okx_service.sh</code></pre><p style=\"\">启动交易</p><pre><code>systemctl start okx_multi_account.service</code></pre><p style=\"\">暂停交易</p><pre><code>sudo systemctl stop okx_multi_account.service</code></pre><p style=\"\">重启交易</p><pre><code>systemctl restart okx_multi_account.service</code></pre><p style=\"\">测试log2html</p><pre><code>cd /usr/share/caddy &amp;&amp; node log2html.js</code></pre><p style=\"\">设置开机自启log2html</p><pre><code>cd /usr/share/caddy &amp;&amp;  chmod +x install_log2html_service.sh &amp;&amp; ./install_log2html_service.sh</code></pre><p style=\"\"></p>"]},"type":"CHANGE"}]
