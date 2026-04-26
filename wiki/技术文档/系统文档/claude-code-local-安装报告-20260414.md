---
title: "claude-code-local-安装报告-20260414"
created: 2026-04-24
updated: 2026-04-24
tags: [技术]
status: draft
---
# 🧠 claude-code-local 安装报告

> **2026-04-14 02:50 PDT | 中国网络环境**

---

## ✅ 已完成安装

| 组件 | 状态 | 说明 |
|------|------|------|
| **项目克隆** | ✅ | `/Users/hokeli/projects/claude-code-local/` |
| **MLX虚拟环境** | ✅ | `~/.local/mlx-server/` |
| **Python 3.12** | ✅ | Python 3.12.4 |
| **mlx-lm 0.31.2** | ✅ | Apple MLX框架 |
| **mlx-metal 0.31.1** | ✅ | Metal GPU加速 |

---

## ⏳ 待完成（网络问题）

| 任务 | 状态 | 解决方案 |
|------|------|---------|
| **模型下载** | ⏳ 失败 | HuggingFace连接问题 |
| **服务器启动** | ⏳ 待测试 | 需先下载模型 |

---

## 🔧 解决方案

### 方案A：使用HuggingFace镜像

```bash
# 设置HF镜像
export HF_ENDPOINT=https://hf-mirror.com

# 下载模型
~/.local/mlx-server/bin/python3 -c "from mlx_lm.utils import load; load('mlx-community/Qwen3.5-4B-4bit')"
```

### 方案B：手动下载模型

**步骤**:
1. 浏览器打开: https://hf-mirror.com/mlx-community/Qwen3.5-4B-4bit
2. 下载所有文件到: `~/.cache/huggingface/hub/models--mlx-community--Qwen3.5-4B-4bit/`
3. 重启安装脚本

### 方案C：使用已有Ollama模型

如果已有本地模型（如Ollama），可以跳过下载，直接测试MLX服务器。

---

## 📋 项目结构

```
/Users/hokeli/projects/claude-code-local/
├── launchers/         # 启动脚本
├── scripts/           # 核心脚本
├── proxy/server.py    # MLX服务器
├── setup.sh           # 安装脚本
├── start-cn-mirror.sh # 中国镜像启动脚本 ✅ 已创建
└── README.md          # 说明文档
```

---

## 🚀 MLX环境信息

```
虚拟环境: ~/.local/mlx-server/
Python: 3.12.4
mlx: 0.31.1
mlx-lm: 0.31.2
mlx-metal: 0.31.1
```

---

## 📊 系统检测

```
芯片: Apple M2 Max
内存: 32 GB
推荐模型: Qwen 3.5 4B（小型版本）
```

---

## 🎯 下一步操作

**优先级P1**: 下载模型（HF镜像或手动）

**优先级P2**: 启动MLX服务器测试

**优先级P3**: 配置Claude Code连接

---

*安装时间: 2026-04-14 02:50 PDT*
*状态: MLX环境已就绪，模型下载因网络问题暂停*