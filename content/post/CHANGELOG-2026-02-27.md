# 语音系统修复日志 - 2026-02-27

## 📋 问题背景

Telegram 语音消息发送失败，表现为：
- ❌ 语音气泡显示 0:00 时长
- ❌ 播放时无声音
- ❌ 格式不兼容（WAV/MP3/OGG Vorbis 均失败）

---

## 🔍 问题定位

### 测试历史

| 格式 | asVoice | 声音 | 气泡 | 时长显示 | 结论 |
|------|---------|------|------|----------|------|
| WAV | true | ❌ 无 | ✅ | ❌ | 失败 |
| OGG Vorbis | true | ⚠️ 不稳定 | ✅ | ⚠️ | 不稳定 |
| MP3 | true | ❌ 无 | ✅ | ❌ | 失败 |
| **OGG Opus** | **true** | **✅ 有** | **✅** | **✅** | **成功** |

### 根本原因

Telegram Bot API 的 `sendVoice` 方法要求音频格式为 **OGG Opus** 编码，而之前使用的是：
- 直接 TTS 生成的 WAV 格式
- 或用 sox 转换的 OGG Vorbis 格式

两者都不被 Telegram 完全支持。

---

## ✅ 解决方案

### 核心修改

使用 `opusenc`（来自 `opus-tools` 包）将 TTS 生成的 WAV 文件转换为 **OGG Opus** 格式：

```bash
opusenc input.wav output.ogg --bitrate 16
```

**音频参数**：
- 编码：Opus (libopus 1.6.1)
- 比特率：16 kbit/s VBR
- 采样率：44.1 kHz
- 声道：Mono
- 容器：OGG

### 依赖安装

```bash
brew install opus-tools
```

---

## 🛠️ 脚本精简

### 精简前（4 个脚本，功能重复）
- ❌ `tts-voice.sh` - 生成语音
- ❌ `send-tts-voice.sh` - 生成 + 返回路径（重复）
- ❌ `fix-voice-duration.sh` - 格式转换（临时工具）
- ❌ `send-voice.sh` - 发送语音（可被 message 工具替代）

### 精简后（1 个主脚本）
- ✅ `tts-voice.sh` - **唯一主脚本**
- ✅ `start-tts-proxy.sh` - TTS 代理服务
- ✅ `cleanup-voice-files.sh` - 定期清理

**删除的脚本**：已移到 `.trash/` 目录（需要可恢复）

---

## 📝 使用方式

### 基本用法

```bash
# 1. 生成语音（OGG Opus 格式）
FILE=$(bash skills/voice-skill/scripts/tts-voice.sh "要说的内容")

# 2. 发送语音消息（带时长参数）
message action=send asVoice=true duration=5 filePath="$FILE" target=<chat_id>
```

### 完整示例

```bash
# 生成语音
FILE=$(bash skills/voice-skill/scripts/tts-voice.sh "刘老板，语音测试成功！")

# 输出：
# 🔊 生成 TTS...
# 🔧 转换 OGG Opus 格式...
# ✅ 完成！时长：3.2 秒
# 📁 文件：/Users/openclaw/.openclaw/media/outbound/tts_1772175561.ogg

# 发送
message action=send asVoice=true duration=3 filePath="$FILE" target=6170096442
```

---

## 📄 文档更新

以下文件已同步更新：

1. **`AGENTS.md`** - 语音处理流程（强制使用脚本）
2. **`MEMORY.md`** - 系统索引（添加语音生成脚本信息）
3. **`skills/voice-skill/SKILL.md`** - 语音技能文档
4. **`skills/voice-skill/README.md`** - 快速使用指南
5. **`memory/2026-02-27.md`** - 今日记忆存档

---

## 🎯 语音回复规则

根据 `AGENTS.md` 规定：

| 场景 | 回复方式 |
|------|----------|
| 闲聊/简单对话 | 🎙️ 语音 |
| 数字/简单信息 | 🎙️ 语音 |
| 需复制粘贴 | 📝 文字 |
| 复杂数据 | 📝 文字 |
| 用户发语音 | 🎙️ 默认语音回复 |

---

## ⚠️ 禁止事项

- ❌ 禁止使用 `tts` 工具（必须用脚本）
- ❌ 禁止云端 TTS（只用本地 `localhost:8003`）
- ❌ 禁止直接生成 MP3/WAV（必须转 OGG Opus）
- ❌ 禁止跳过 `duration` 参数（Telegram 需要显示时长）

---

## 🏥 健康检查

```bash
# ASR 服务（语音识别）
curl http://10.10.10.233:8000/health

# TTS 服务（语音合成）
curl http://localhost:8003/health
```

---

## 📊 效果对比

### 修复前
```
用户：发条语音试试
秘书：（发送 WAV 格式）
用户：❌ 没声音 / 时长 0:00
```

### 修复后
```
用户：发条语音试试
秘书：（用 tts-voice.sh 生成 OGG Opus）
用户：✅ 有声音 + 语音气泡 + 正确时长
```

---

## 🔗 相关资源

- **项目地址**: `skills/voice-skill/`
- **主脚本**: `skills/voice-skill/scripts/tts-voice.sh`
- **文档**: `skills/voice-skill/SKILL.md`
- **依赖**: `brew install opus-tools`

---

*创建时间：2026-02-27 15:35*  
*状态：✅ 已完成并测试通过*
