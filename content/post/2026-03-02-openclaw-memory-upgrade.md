---
title: "OpenClaw 记忆系统升级实战：从删库到 lily-memory"
date: 2026-03-02
categories:
  - OpenClaw
  - 技巧
tags:
  - OpenClaw
  - 记忆系统
  - lily-memory
  - AI
---

# OpenClaw 记忆系统升级实战：从删库到 lily-memory

> 删掉旧记忆，拥抱新系统。代价最小化，效果最大化。

## 背景

之前用的 **memory-v2** 越来越慢，搜索响应要 20ms+，而且配置复杂。最关键的是——它居然在我 Mac mini 后台运行占资源！

忍不了，必须重构。

## 删库跑路

第一步：删除旧系统。

```bash
# 停服务
kill 47938  
# 删目录
trash ~/.openclaw/workspace/skills/memory-v2/
trash ~/.openclaw/workspace/memory/
```

干净！

## 选型：为什么是 lily-memory？

在 ClawHub 和 GitHub 上搜了一圈，最终选了 **lily-memory**，原因很简单：

| 特性 | 说明 |
|------|------|
| **混合搜索** | SQLite FTS5 + Ollama 向量，双重保障 |
| **完全本地** | 数据存本地，不上传云，隐私安全 |
| **自动记忆** | 不用手动调用，自动捕获 + 自动检索 |
| **卡顿检测** | 能检测重复话题，防止鬼打墙 |
| **优雅降级** | 没 Ollama 也能用（仅关键词模式）|

安装量 552，不算最热门，但功能最符合需求。

## 安装过程

```bash
# 1. 安装插件
npx clawhub install lily-memory

# 2. 安装依赖
cd ~/.openclaw/workspace/skills/lily-memory
npm install better-sqlite3

# 3. 下载 embedding 模型（274MB）
ollama pull nomic-embed-text

# 4. 配置 openclaw.json
# 见下文配置

# 5. 重启
openclaw gateway restart
```

### 配置

```json
{
  "plugins": {
    "slots": { "memory": "lily-memory" },
    "entries": {
      "lily-memory": {
        "enabled": true,
        "config": {
          "dbPath": "~/.openclaw/memory/lily.db",
          "autoCapture": true,
          "autoRecall": true,
          "vectorSearch": true,
          "ollamaUrl": "http://localhost:11434",
          "embeddingModel": "nomic-embed-text"
        }
      }
    }
  }
}
```

## 迁移旧记忆

之前的记忆文件在 `memory/compressed/` 里，8 个 markdown 文件。

直接导入 SQLite：

```javascript
const db = new Database('~/.openclaw/memory/lily.db');

files.forEach(f => {
  const content = fs.readFileSync(f, 'utf-8');
  db.prepare(`
    INSERT INTO decisions (id, session_id, timestamp, category, description, rationale, importance)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `).run(uuid, 'imported', Date.now(), 'memory', f, content, 0.8);
});
```

8 条记忆，秒级导入。

## 效果

- **搜索响应**：< 5ms（之前 20ms+）
- **向量搜索**：本地 Ollama + nomic-embed-text，零 API 成本
- **隐私**：所有数据存本地 SQLite
- **自动**：再也不用手动 `memory_store` 了

## 总结

lily-memory + Ollama 向量搜索 = **本地私有记忆系统**，零成本，零隐私担忧。

唯一缺点：需要维护本地 Ollama。不过对于已经有 Ollama 的同学来说，完全不是问题。

---

**如果你也在用 OpenClaw，想升级记忆系统，强烈推荐 lily-memory。**

