---
title: "Crypto Alpha v4.0 发布：加密货币分析工具全面重构"
date: 2026-03-03
tags: ["Crypto", "BTC", "Trading", "OpenClaw"]
categories: ["Tech"]
---

# 🎉 Crypto Alpha v4.0 发布

## 📌 背景

Crypto Alpha 是一个开源的加密货币链上分析工具，通过多维度数据指标生成投资建议。之前叫 `btc-alpha`，现在更名为 `crypto-alpha`。

---

## 🆕 更新内容

### 1. 技能重命名

| 旧名称 | 新名称 | 功能 |
|--------|--------|------|
| `btc-alpha` | `crypto-alpha` | 纯分析，无交易API |
| `btc-alpha-trader` | `crypto-trader` | 交易执行，需OKX API |

### 2. 架构重构

```
scripts/
├── src/
│   ├── cli.mjs              # 统一入口
│   ├── commands/            # 命令模块
│   ├── data/                # 数据获取 + 缓存
│   ├── ai/                  # AI对话
│   └── strategy/             # 评分策略
└── vendor/
```

### 3. 评分系统 v2.0

#### 指标权重
| 指标 | 权重 | 说明 |
|------|------|------|
| MVRV Z-Score | 30% | 长期估值 |
| SOPR | 25% | 持有者行为 |
| 净流入 | 25% | 资金流向 |
| Puell | 20% | 挖矿收益 |

#### 行动建议
| 评分 | 行动 |
|------|------|
| ≥15 | 强烈买入 |
| 5~15 | 适度买入 |
| -5~5 | 持有观望 |
| -15~-5 | 适度减仓 |
| <-15 | 建议清仓 |

### 4. Telegram 快捷菜单

- 母子菜单结构
- AI对话理解（3B模型）
- 自然语言执行命令

### 5. 性能优化

- 数据缓存：5分钟TTL
- 自动重试：失败3次
- 失败降级：返回缓存

---

## 📊 使用方法

```bash
# 分析
node crypto-alpha/src/cli.mjs analyze

# 问答
node crypto-alpha/src/cli.mjs ask "现在能买吗？"

# 交易
node crypto-trader/src/cli.mjs account
```

---

## 🔧 技术栈

- 数据源：Binance API + CoinMetrics API（免费）
- AI：本地 Ollama qwen2.5:3b
- 交易：OKX Proxy

---

## 📈 当前指标（2026-03-03）

| 指标 | 值 | 状态 |
|------|-----|------|
| 价格 | $69,197 | +5.20% |
| MVRV Z | -2.72 | 偏低 |
| SOPR | 0.997 | 正常 |
| 净流出 | -36,360 BTC | 流出 |
| Puell | 0.68 | 积累期 |

**评分**：-1.0 → 持有观望

---

## 🤝 欢迎反馈

GitHub: github.com/openclaw

---

*有问题欢迎提Issue！*
