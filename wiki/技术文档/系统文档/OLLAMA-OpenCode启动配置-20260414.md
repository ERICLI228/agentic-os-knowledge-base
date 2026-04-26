---
title: "OLLAMA-OpenCode启动配置-20260414"
created: 2026-04-24
updated: 2026-04-24
tags: [技术]
status: draft
---
# 🔧 OLLAMA + OpenCode 启动配置

> **使用本地OLLAMA模型替代HuggingFace下载**

---

## ✅ 启动OLLAMA服务

```bash
# 启动OLLAMA服务
ollama serve

# 查看可用模型
ollama list

# 推荐模型（已安装）
ollama pull qwen3.5:35b-a3b    # 35B，适合代码生成
ollama pull gemma4:26b         # 26B，本地大杯
```

---

## ✅ OpenCode APP启动

```bash
# 启动OpenCode桌面应用
open -a OpenCode

# 检查端口
lsof -i :58480

# 健康检查
curl http://localhost:58480/health
```

---

## 📊 配置OLLAMA模型用于VoiceClone

**修改setup.sh使用本地模型**:

```bash
# 不下载HuggingFace模型，使用本地OLLAMA
MODEL_ID="ollama/qwen3.5:35b-a3b"

# MLX服务器配置
MLX_MODEL="local"  # 使用本地模型
```

---

## 🎯 使用OLLAMA的优势

| 对比项 | HuggingFace | OLLAMA本地 |
|-------|------------|-----------|
| **下载速度** | 慢（需网络） | ✅ 已安装 |
| **网络依赖** | 需要网络 | ✅ 本地运行 |
| **隐私安全** | 下载到本地 | ✅ 完全本地 |
| **模型数量** | 有限 | ✅ 可拉取任意模型 |

---

## 🔧 配置文件

**位置**: `~/.openclaw/opencode-bridge.yaml`

```yaml
bridge:
  mode: skill_controller
  endpoint: http://localhost:18789

shared_capabilities:
  - skills_pool: ~/.agents/skills/
  - memory_system: L1-L4
```

---

## 📋 服务状态

| 服务 | 状态 | 端口 |
|------|------|------|
| **OLLAMA** | ✅ 已启动 | 11434 |
| **OpenCode** | ✅ 已启动 | 58480 |
| **Gateway** | ✅ 运行中 | 18789 |

---

*配置时间: 2026-04-14 02:55 PDT*