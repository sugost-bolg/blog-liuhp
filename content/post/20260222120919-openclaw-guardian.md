---
title: "OpenClaw Guardian：一个自愈网关守护系统"
date: 2026-02-22T12:09:19+0800
draft: false
categories:
    - 技术
tags:
    - OpenClaw
    - 运维
    - Node.js
---

OpenClaw 网关偶尔会因为各种原因崩溃——内存溢出、网络异常、配置错误。每次崩溃后需要手动重启很麻烦，所以今天写了一套自愈网关守护系统。

## 设计目标

- **自动重启**：检测到崩溃后自动恢复
- **配置保护**：错误的配置不会导致服务不可用
- **分级恢复**：软重启 → 硬重启 → 告警通知
- **原子更新**：配置修改失败可自动回滚

## 系统架构

Guardian 由三个核心组件组成：

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  config-guard   │────▶│    watchdog     │────▶│  safe-update    │
│   配置验证器    │     │    守护进程     │     │   安全更新工具  │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### 1. watchdog — 守护进程

核心功能：心跳检测 → 软重启 → 硬重启 → 告警

```javascript
const CONFIG = {
  gatewayUrl: ws://127.0.0.1:18789,
  checkInterval: 30000,      // 30秒检测一次
  failThreshold: 3,          // 连续3次失败才重启
  restartDelay: [0, 5000, 30000], // 分级延迟
  maxRestarts: 5,            // 5次后放弃
};
```

**分级恢复策略**：
1. 第一次崩溃：立即软重启（`openclaw gateway restart`）
2. 第二次崩溃：延迟5秒后强制重启
3. 第三次崩溃：延迟30秒后强制重启并发送告警
4. 超过5次：停止自动恢复，等待人工介入

### 2. config-guard — 配置验证

在网关启动前验证配置，防止因配置错误导致反复崩溃。

检查项：
- JSON 语法有效性
- 网关绑定地址格式
- 模型名称有效性
- 端口范围（1024-65535）
- 定时任务 cron 表达式格式

验证失败时会阻止启动并发送通知。

### 3. safe-update — 安全更新

配置修改的安全封装：

```javascript
async function safeUpdate(configPath, newContent) {
  // 1. 备份当前配置
  await backup(configPath);
  
  // 2. 写入新配置
  await writeFile(configPath, newContent);
  
  // 3. 验证配置
  if (!await validate()) {
    await rollback();  // 验证失败，回滚
    throw new Error(配置验证失败);
  }
  
  // 4. 健康检查（30秒）
  if (!await checkHealth(30000)) {
    await rollback();  // 启动失败，回滚
    throw new Error(健康检查失败);
  }
  
  // 5. 清理旧备份
  await cleanupOldBackups();
}
```

## 部署方式

### LaunchAgent 托管（macOS）

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" 
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.openclaw.guardian</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/local/bin/node</string>
    <string>/Users/openclaw/.openclaw/guardian/watchdog.mjs</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <true/>
</dict>
</plist>
```

开机自启，崩溃后自动重启守护进程本身。

### 常用命令

```bash
# 查看运行状态
guardian-status

# 查看实时日志
guardian-logs

# 安全编辑配置
openclaw-safe edit

# 查看配置备份
openclaw-safe list

# 回滚到上一版本
openclaw-safe rollback
```

## 崩溃原因追踪

在 watchdog 中加入崩溃分析：

```javascript
async function analyzeCrash() {
  const logs = await exec(openclaw logs --tail 100);
  
  if (logs.includes(out of memory)) return 内存不足;
  if (logs.includes(ECONNRESET)) return 网络连接重置;
  if (logs.includes(SyntaxError)) return 配置/代码错误;
  return 未知原因;
}
```

这样每次重启时都能知道大概是什么原因。

## 效果

上线半天已经自动处理了一次网关异常退出，日志显示从检测到崩溃到完全恢复大约用了12秒。

对于个人使用的场景，这个方案够用了。如果要更高可用，可以考虑双网关热备，但那就复杂多了。

---

**代码位置**：`~/.openclaw/guardian/`  
**日志位置**：`~/.openclaw/logs/guardian/`  
