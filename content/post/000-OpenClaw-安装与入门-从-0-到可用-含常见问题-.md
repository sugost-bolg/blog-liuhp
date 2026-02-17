---
title: "OpenClaw 安装与入门：从 0 到可用（含常见问题）"
date: 2026-02-08T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

OpenClaw 是一个你可以部署在自己设备上的个人 AI 助理：它通过你常用的聊天软件（如 Telegram/WhatsApp/Slack/Discord 等）和你对话，也能运行工具（浏览器、文件、定时任务、节点设备等），核心由一个常驻后台的 Gateway 负责调度。

本文以“最快跑起来 + 最少踩坑”为目标，把官方文档与社区教程的关键步骤整理成一篇可直接照做的安装指南。

1. 安装前准备1.1 系统与运行时Node.js：建议 Node &gt;= 22（官方文档以此为前提）

macOS / Linux：直接按本文步骤即可

Windows：建议使用 WSL2 (Ubuntu)，原生 Windows 环境兼容性与工具链较麻烦

验证 Node 版本：

“`bash

node -v

“`

2. 安装 OpenClaw CLI官方推荐一键脚本（macOS / Linux）：

“`bash

curl -fsSL https://openclaw.ai/install.sh | bash

“`

Windows PowerShell：

“`powershell

iwr -useb https://openclaw.ai/install.ps1 | iex

“`

也可以选择全局安装：

“`bash

npm install -g openclaw@latest

或pnpm add -g openclaw@latest

“`

3. 运行引导向导（onboard）安装完成后，建议直接跑向导，它会把“模型、网关、工作区、渠道、技能、后台服务”等一次性配好：

“`bash

openclaw onboard –install-daemon

“`

向导会让你选择：

Gateway 运行在本机还是远程

选择模型与鉴权方式（OAuth / API Key 等）

是否配置渠道（Telegram/WhatsApp/Discord…）

是否安装为后台服务（systemd/launchd；WSL2 可用 systemd）

提示：如果你要用 Telegram/WhatsApp，官方不建议用 Bun 作为运行时，优先用 Node（兼容性更稳）。

4. 启动与访问 Gateway（最关键）如果你在向导里选择安装后台服务，通常 Gateway 已经在跑了：

“`bash

openclaw gateway status

“`

如果你要手动前台启动（便于看日志排障）：

“`bash

openclaw gateway –port 18789 –verbose

“`

然后打开 Dashboard / Control UI：

默认地址http://127.0.0.1:18789/

或直接用命令：

“`bash

openclaw dashboard

“`

5. 2 分钟自检（推荐）当你不确定“到底哪里坏了”，先跑这些：

“`bash

openclaw status

openclaw health

openclaw security audit –deep

“`

status：运行状态与基础信息

health：健康检查（常见提示：未配置模型鉴权等）

security audit：安全审计（尤其是 DM 策略、允许列表等）

6. 连接 Telegram（最常用）两件事：

1) 在 Telegram 找到 BotFather 创建机器人，拿到 bot token

2) 在 OpenClaw 里配置 Telegram channel（向导能做；你也可以手动配置）

重要的默认安全策略：

陌生人私聊默认是 pairing 模式：对方发来第一条消息时会收到一个配对码，但消息不会被处理

你需要批准配对，机器人才会开始正常回复

查看与批准配对示例：

“`bash

openclaw pairing list telegram

openclaw pairing approve telegram

```

如果你“发消息机器人不回”，十有八九是：

Gateway 没启动

Telegram bot token 配错

还没 approve pairing

7. 常见问题（踩坑速查）7.1 openclaw: command not found通常是 npm 全局 bin 路径没加入 PATH：

```bash

npm prefix -g

```

把 $(npm prefix -g)/bin 加到 PATH（例如写入 ~/.zshrc / ~/.bashrc），然后重开终端。

7.2 Node 版本太低 / 环境混乱用 node -v 确认 &gt;= 22

Windows 请优先 WSL2

7.3 Dashboard 打不开先确认 openclaw gateway status 显示 running

确认端口未冲突（默认 18789）

本机访问用 127.0.0.1，远程访问需要做安全加固（token / tunnel / VPN）

8. 下一步怎么玩（建议路线）先在 Dashboard 里直接聊天，验证模型与工具可用

再接 Telegram/WhatsApp，让它真正“住进你的聊天软件”

最后再玩技能（Skills）、定时任务（Cron）、节点设备（Nodes：手机/平板/摄像头/屏幕等）

参考资料（原文链接）官方 Getting Started：https://docs.openclaw.ai/start/getting-started

官方仓库（安装/命令/更新）：https://github.com/openclaw/openclaw

社区图文教程（中文整理）：https://apifox.com/apiskills/openclaw-installation-and-usage-guide/
