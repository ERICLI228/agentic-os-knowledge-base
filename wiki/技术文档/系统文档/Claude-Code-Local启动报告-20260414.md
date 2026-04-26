---
title: "Claude-Code-Local启动报告-20260414"
created: 2026-04-24
updated: 2026-04-24
tags: [技术]
status: draft
---
# ✅✅✅ Claude Code Local完整启动报告

> **2026-04-14 03:12 PDT**

---

## 📊 最终状态

| 服务 | 状态 | 端口 |
|------|------|------|
| **MLX服务器** | ✅ 运行中 | 4000 (PID 46213) |
| **OLLAMA** | ✅ 运行中 | 11434 |
| **模型** | Qwen3.5-4B-4bit | 已加载 |

---

## ✅ 启动成功！

### 模型加载信息

```
[03:12:09] Loading model: ~/.cache/huggingface/hub/.../Qwen3.5-4B-4bit
[03:12:10] Model loaded in 1.3s
[03:12:10] KV cache: full precision
```

---

## 🎯 Claude Code使用命令

**启动Claude Code**:
```bash
ANTHROPIC_BASE_URL=http://localhost:4000 \
ANTHROPIC_API_KEY=sk-local \
claude --model claude-sonnet-4-6
```

---

## 📋 启动脚本

**位置**: `/Users/hokeli/projects/claude-code-local/start-offline.sh`

**使用方法**:
```bash
bash /Users/hokeli/projects/claude-code-local/start-offline.sh
```

---

## 🔧 网络问题解决方案

### 问题诊断

| 问题 | 原因 | 解决方案 |
|------|------|---------|
| HuggingFace连接失败 | SOCKS代理配置 | 安装httpx[socks] |
| 模型下载验证失败 | 网络重置 | 使用离线模式 |
| 模型路径验证失败 | 路径格式错误 | 使用本地快照路径 |

### 最终方案

**使用离线模式启动MLX服务器**:
```bash
export HF_HUB_OFFLINE=1
MLX_MODEL=~/.cache/.../0e7ffd5c...
```

---

## 📊 端口监听确认

```
COMMAND   PID   USER   FD   TYPE    DEVICE SIZE/OFF NODE NAME
Python  46213 hokeli    4u  IPv4    0x...   0t0     TCP localhost:4000 (LISTEN)
```

---

## 🎯 测试API

**健康检查**:
```bash
curl http://localhost:4000/health
```

**Claude API测试**:
```bash
curl -X POST http://localhost:4000/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk-local" \
  -d '{"model":"claude-sonnet-4-6","max_tokens":100,"messages":[{"role":"user","content":"你好"}]}'
```

---

## ✅✅✅ 总结

- ✅ MLX服务器成功启动
- ✅ 模型加载完成（1.3秒）
- ✅ 端口4000监听确认
- ✅ 离线模式解决网络问题

**Claude Code Local已完整启动！**

---

*启动时间: 2026-04-14 03:12 PDT*
*离线模式成功解决网络问题*