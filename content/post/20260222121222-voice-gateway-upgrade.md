---
title: "语音服务改造：从 CosyVoice 到双引擎架构"
date: 2026-02-22T12:12:22+0800
draft: false
categories:
    - 技术
tags:
    - 语音合成
    - TTS
    - EdgeTTS
---

今天上午对语音服务做了一次架构升级，从单一的 CosyVoice 本地模型扩展为双引擎架构，解决了响应速度和音色选择的问题。

## 背景

之前语音服务只有一个 CosyVoice 本地模型，部署在 `10.10.10.233:8000`。虽然音质不错，但有几个问题：

1. **速度慢** — 本地推理需要 3-5 秒才能生成音频
2. **音色少** — 只有 4 个预设音色
3. **不稳定** — 偶尔会因为显存不足而失败
4. **格式问题** — OpenClaw 内置 TTS 工具生成的文件是空的（MP3 转换失败）

## 方案：双引擎架构

保留 CosyVoice 作为"高品质选项"，新增 EdgeTTS 作为"快速响应选项"。

| 引擎 | 部署位置 | 端口 | 特点 |
|------|----------|------|------|
| CosyVoice | 10.10.10.233 | 8000 | 本地模型，4音色，音质好，速度慢 |
| EdgeTTS | 10.10.10.233 | 8002 | 微软API，8音色，速度快，免费 |

## EdgeTTS 部署

EdgeTTS 是基于微软 Azure 免费 TTS 的开源封装，部署很简单：

```bash
# 安装依赖
pip install edge-tts fastapi uvicorn

# 启动服务
python main.py --port 8002
```

提供 8 个中文音色：

| 音色ID | 名称 | 风格 |
|--------|------|------|
| xiaoxiao | 晓晓 | 温柔女声 |
| xiaoyi | 晓伊 | 活泼女声（默认） |
| yunxi | 云希 | 年轻男声 |
| yunjian | 云健 | 成熟男声 |
| xiaochen | 晓晨 | 知性女声 |
| xiaohan | 晓涵 | 温暖女声 |
| hsiaochen | 晓臻 | 台湾女声 |
| hiugaai | 晓佳 | 粤语女声 |

## 遇到的坑

### 1. 中文乱码

最初用 Form 编码传参数，结果中文会乱码。改用 JSON body 解决：

```python
# 错误：Form 编码
text = request.form.get("text")  # 中文乱码

# 正确：JSON body
request.json["text"]  # 正常
```

### 2. 流式响应

大段文字生成时间较长，改为流式返回：

```python
from fastapi.responses import StreamingResponse

async def generate_audio_stream(text, voice):
    communicate = edge_tts.Communicate(text, voice)
    async for chunk in communicate.stream():
        if chunk["type"] == "audio":
            yield chunk["data"]

return StreamingResponse(generate_audio_stream(text, voice))
```

### 3. OpenClaw 内置 TTS 问题

发现 OpenClaw 的 `tts` 工具生成的是空文件，原因是 MP3 转换环节失败。临时解决方案是绕过内置工具，直接调用语音服务器 API 生成 WAV。

## 使用方式

### ASR 语音识别

```bash
curl -X POST "http://10.10.10.233:8000/asr" \\
  -F "file=@audio.ogg" \\
  -F "language=zh"
```

### TTS 语音合成

```bash
curl -X POST "http://10.10.10.233:8002/tts" \\
  -H "Content-Type: application/json" \\
  -d {text: 你好世界, voice: xiaoyi} \\
  --output output.wav
```

## 效果

改造后响应速度对比：

| 引擎 | 短句（<20字） | 长句（100字） |
|------|--------------|--------------|
| CosyVoice | 3-5秒 | 8-12秒 |
| EdgeTTS | 0.5-1秒 | 1-2秒 |

现在默认用 EdgeTTS 快速响应，需要高音质场景可以切到 CosyVoice。

## 配置

SSH 免密登录：

```bash
# ~/.ssh/config
Host voice
    HostName 10.10.10.233
    User root
    IdentityFile ~/.ssh/id_ed25519
```

现在可以直接 `ssh voice` 管理语音服务器。

## 总结

双引擎架构是个不错的折中方案：
- 日常对话用 EdgeTTS，快且稳定
- 特殊场景用 CosyVoice，音质更好
- 两者互补，不会互相影响

下一步可以考虑把 ASR 也换成更快的方案，目前用的 whisper.cpp 在小机器上还是有点慢。

---

**EdgeTTS 代码**：`voice-server/`  
**服务地址**：`http://10.10.10.233:8002`  
**部署文档**：`voice-server/DEPLOY.md`
