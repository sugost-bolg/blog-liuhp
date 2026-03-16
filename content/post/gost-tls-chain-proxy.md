---
title: "Gost v3 链式 TLS 加密隧道代理配置指南"
date: 2026-03-17
tags: ["gost", "代理", "TLS", "加密", "负载均衡", "链式代理"]
category: "技术教程"
draft: false
---

# Gost v3 链式 TLS 加密隧道代理配置指南

**发布日期**: 2026-03-17  
**分类**: 技术教程  
**标签**: gost v3, 代理，TLS 加密，链式代理，负载均衡

---

## 📋 场景说明

在企业网络环境中，构建一个高可用、全加密的代理系统。本文介绍如何使用 **gost v3.2.6** 搭建一个三层链式代理 + 负载均衡的完整方案。

### 架构设计

```
客户端 → A(入口/负载均衡) → B(双链路中转) → C(SOCKS5 出口) → 互联网
     │         │                    │                    │
     └─ 10000 ─┴─ 10000/20000 ──────┴─ 30000 ───────────┘
```

**服务器角色**:
| 服务器 | IP | 角色 | 端口 | 架构 |
|--------|-----|------|------|------|
| **A** | 10.10.10.254 | 入口 + 负载均衡 | 10000 | ARM64 (OpenWRT) |
| **B** | 47.80.22.21 | 双链路中转 | 10000, 20000 | AMD64 (Debian) |
| **C** | 47.238.159.48 | SOCKS5 出口 | 30000 | AMD64 (Debian) |

---

## 🔐 加密与鉴权策略

| 链路 | 协议 | 加密 | 鉴权 |
|------|------|------|------|
| 客户端 → A | SOCKS5 | ❌ 明文 (本地可信) | ❌ 免鉴权 |
| A → B | HTTP | ✅ TLS | ✅ wine:1234 |
| B → C | SOCKS5 | ✅ TLS | ✅ wine:1234 |

**设计原则**:
1. 客户端免鉴权 - 简化使用
2. 中间链路全加密 - 公网传输安全
3. 双链路负载均衡 - 提高可用性

---

## 📦 安装 gost

### A 服务器 (ARM64)

```bash
mkdir -p /etc/gost && cd /etc/gost
curl -sL -o gost.tar.gz https://github.com/go-gost/gost/releases/download/v3.2.6/gost_3.2.6_linux_arm64.tar.gz
tar xzf gost.tar.gz && chmod +x gost && rm gost.tar.gz
./gost -V  # 验证版本
```

### B/C 服务器 (AMD64)

```bash
mkdir -p /etc/gost && cd /etc/gost
curl -sL -o gost.tar.gz https://github.com/go-gost/gost/releases/download/v3.2.6/gost_3.2.6_linux_amd64.tar.gz
tar xzf gost.tar.gz && chmod +x gost && rm gost.tar.gz
./gost -V  # 验证版本
```

---

## 🔑 生成 TLS 证书

三台服务器分别生成自签名证书：

```bash
# A 服务器
openssl req -x509 -newkey rsa:2048 -keyout /etc/gost/key.pem -out /etc/gost/cert.pem -days 365 -nodes -subj '/CN=10.10.10.254'

# B 服务器
openssl req -x509 -newkey rsa:2048 -keyout /etc/gost/key.pem -out /etc/gost/cert.pem -days 365 -nodes -subj '/CN=47.80.22.21'

# C 服务器
openssl req -x509 -newkey rsa:2048 -keyout /etc/gost/key.pem -out /etc/gost/cert.pem -days 365 -nodes -subj '/CN=47.238.159.48'
```

---

## ⚙️ 配置启动

### C 服务器 (SOCKS5 出口)

```bash
# 命令行启动
nohup /etc/gost/gost -L "socks5+tls://wine:1234@:30000?cert=/etc/gost/cert.pem&key=/etc/gost/key.pem" > /tmp/gost.log 2>&1 &

# systemd 自启
cat > /etc/systemd/system/gost.service << 'EOF'
[Unit]
Description=gost SOCKS5 Proxy (Exit Node)
After=network.target

[Service]
Type=simple
ExecStart=/etc/gost/gost -L "socks5+tls://wine:1234@:30000?cert=/etc/gost/cert.pem&key=/etc/gost/key.pem"
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload && systemctl enable gost && systemctl start gost
```

### B 服务器 (双链路中转)

```bash
# 链路 1 (10000 端口)
nohup /etc/gost/gost -L "http+tls://:10000?cert=/etc/gost/cert.pem&key=/etc/gost/key.pem" -F "socks5+tls://wine:1234@47.238.159.48:30000?insecure=true" > /tmp/gost.log 2>&1 &

# 链路 2 (20000 端口)
nohup /etc/gost/gost -L "http+tls://:20000?cert=/etc/gost/cert.pem&key=/etc/gost/key.pem" -F "socks5+tls://wine:1234@47.238.159.48:30000?insecure=true" > /tmp/gost.log 2>&1 &

# systemd 模板服务
cat > /etc/systemd/system/gost@.service << 'EOF'
[Unit]
Description=gost Proxy (Relay Node) - Port %i
After=network.target

[Service]
Type=simple
ExecStart=/etc/gost/gost -L "http+tls://:%i?cert=/etc/gost/cert.pem&key=/etc/gost/key.pem" -F "socks5+tls://wine:1234@47.238.159.48:30000?insecure=true"
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload && systemctl enable gost@10000.service gost@20000.service
systemctl start gost@10000.service gost@20000.service
```

### A 服务器 (入口 + 负载均衡)

```bash
# 命令行启动 (负载均衡到 B 的两个端口)
nohup /etc/gost/gost -L=:10000 -F "http+tls://47.80.22.21:10000?insecure=true,http+tls://47.80.22.21:20000?insecure=true" > /tmp/gost.log 2>&1 &

# OpenWRT 自启
cat > /etc/init.d/gost << 'EOF'
#!/bin/sh /etc/rc.common
USE_PROCD=1
START=95
start_service() {
  procd_open_instance
  procd_set_param command /etc/gost/gost -L=:10000 -F "http+tls://47.80.22.21:10000?insecure=true,http+tls://47.80.22.21:20000?insecure=true"
  procd_set_param respawn
  procd_set_param respawn_threshold 10
  procd_close_instance
}
EOF

chmod +x /etc/init.d/gost && /etc/init.d/gost enable && /etc/init.d/gost start
```

---

## ✅ 测试验证

### 测试链路

```bash
# 从 A 服务器测试完整链路
curl -s --socks5-hostname localhost:10000 https://api.ip.sb/ip
# 输出：47.238.159.48 (C 服务器出口 IP)
```

### 客户端配置

```
代理地址：10.10.10.254
端口：10000
协议：SOCKS5
用户名：(留空)
密码：(留空)
```

---

## 🔍 故障排查

### 检查进程

```bash
# A 服务器
ps | grep gost

# B/C 服务器
ps aux | grep gost
netstat -tlnp | grep -E '10000|20000|30000'
```

### 查看日志

```bash
# systemd 服务
journalctl -u gost.service -f
journalctl -u gost@10000.service -f

# nohup 日志
tail -f /tmp/gost.log
```

### 常见问题

| 问题 | 原因 | 解决 |
|------|------|------|
| 端口被占用 | 旧进程未清理 | `pkill -9 gost` |
| TLS 握手失败 | 证书路径错误 | 检查 `cert.pem` 和 `key.pem` |
| 连接被拒 | 防火墙阻止 | 检查安全组规则 |

---

## 📊 性能优化建议

1. **启用 BBR** - 提高 TCP 传输效率
   ```bash
   echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
   echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
   sysctl -p
   ```

2. **调整文件描述符** - 支持更多并发
   ```bash
   ulimit -n 65535
   ```

3. **监控流量** - 使用 `iftop` 或 `nethogs`

---

## 🔒 安全建议

1. **定期更新证书** - 建议每年更换
2. **限制访问 IP** - 防火墙只允许可信 IP
3. **修改默认鉴权** - 使用强密码
4. **监控异常流量** - 设置告警

---

## 总结

本方案实现了：
- ✅ 三层链式代理
- ✅ 全链路 TLS 加密
- ✅ 双链路负载均衡
- ✅ 客户端免鉴权
- ✅ 开机自启

适合需要高可用、高安全性的代理场景。

---

**参考链接**:
- [gost 官方文档](https://docs.gost.run/)
- [gost GitHub](https://github.com/go-gost/gost)
