---
title: "hermes-status-2026-04-19"
created: 2026-04-24
updated: 2026-04-24
tags: [架构/业务]
status: draft
---
# Hermes Web UI 状态报告

**时间**: 2026-04-19 11:54 PDT

---

## ✅ Hermes 已找回并启动

### 运行状态

| 组件 | 端口 | 状态 |
|------|------|------|
| Hermes Gateway | 8642 | ✅ 运行中 (PID: 1283) |
| Hermes Dashboard | 8643 | ✅ 运行中 (PID: 86528) |

### 访问地址

- **Dashboard**: http://localhost:8643/
- **API Server**: http://localhost:8642/

### 配置信息

**位置**: `~/.hermes/`

**API Providers**:
- NVIDIA (免费): ✅ 已配置
- SiliconFlow: ⚠️ Key 已失效
- 阿里云百炼: ⚠️ Key 已失效

**有效 API Keys**:
```bash
NVIDIA_API_KEY=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
DASHSCOPE_API_KEY=sk-sp-5fe74c4a774b4404958a4d4677de4d9c
```

### 可用命令

```bash
# 查看状态
hermes status

# 查看日志
hermes logs

# 重启 Gateway
hermes gateway restart

# 聊天
hermes chat

# 查看技能
hermes skills
```

### 目录结构

```
~/.hermes/
├── hermes-agent/        # 主程序
├── skills/              # 技能目录 (28 个)
├── sessions/            # 会话记录
├── memory/              # 内存
├── logs/                # 日志
├── config.yaml          # 配置
└── .env                 # 环境变量
```

---

## 🎯 下一步

1. **访问 Dashboard**: http://localhost:8643/
2. **更新 API Keys**: SiliconFlow 和阿里云 Key 已失效
3. **检查技能**: 28 个技能已加载

---

*Hermes Web UI 已成功启动！*
