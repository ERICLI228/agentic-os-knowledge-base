---
title: "Open CoDesign - 本地AI设计工具"
created: 2026-04-25
updated: 2026-04-25
tags: [设计, AI工具, 开源, Ollama]
status: ✅ 已安装可运行
---

# Open CoDesign

> 开源的 Claude Design 替代品，本地 AI 设计工具
> 状态：**已安装，可在 Ollama 本地模型下运行**

---

## 📋 基本信息

| 项目 | 值 |
|------|-----|
| GitHub | `OpenCoworkAI/open-codesign` |
| 协议 | MIT |
| Stars | ~2,408 |
| 语言 | TypeScript 91% |
| 创建时间 | 2026-04-18（项目非常新） |
| 当前版本 | v0.1.4 |

## 🔗 关键路径

| 路径 | 说明 |
|------|------|
| 应用安装 | `/Applications/Open CoDesign.app` |
| Homebrew cask | `opencoworkai/tap/open-codesign` |
| 配置目录 | `~/Library/Application Support/@open-codesign/desktop/` |
| Preferences | `.../Preferences` (JSON) |
| 设计数据库 | `.../designs.db` (SQLite) |

## 🛠️ 功能

- **Prompt → 原型**：输入描述生成 UI 设计
- **多模型支持**：Claude / GPT / Gemini / DeepSeek / Kimi / GLM / Ollama
- **本地优先**：API Key 存本地 `~/.config/open-codesign/config.toml`，权限 0600
- **输出格式**：原型 / slides / PDF

## 📦 安装状态

| 步骤 | 状态 |
|------|------|
| Homebrew 安装 | ✅ `brew install --cask` |
| 绕过 Gatekeeper | ✅ `xattr -d com.apple.quarantine` |
| 应用运行 | ✅ PID 75495 |
| Ollama 模型 | ✅ `qwen2.5:7b` 等可用 |

## ⚙️ 配置 Ollama 本地模型

1. 打开 Open CoDesign → **Settings** → **Models**
2. Provider 选择 **Ollama**
3. Base URL: `http://localhost:11434`
4. Model 选择：
   - `qwen2.5:7b`（轻量，速度快，效果一般）
   - `qwen3.5:35b-a3b`（推荐，效果好）

## ⚠️ 已知限制

1. **项目非常新**：才 7 天，最高版本 v0.1.3，稳定性待观察
2. **macOS 安装器未签名**：每次更新可能需要重新绕过 Gatekeeper
3. **无本地 API/CLI**：纯 GUI 应用，无法通过终端自动化操作
4. **无法远程截图**：Electron 桌面应用，canvas/screenshot 工具无法直接捕获
5. **小模型效果有限**：`qwen2.5:7b` 生成的设计质量不如云端大模型

## 🔬 已验证（2026-04-25）

- Ollama 本地模型代码生成能力测试：
  - `qwen2.5:7b` 可生成 HTML Hero Section 代码 ✅
  - 输出包含基本 CSS 样式（flexbox、背景图、按钮）

## 📝 待办

- [ ] 手动在 GUI 中配置 Ollama 连接
- [ ] 测试内置 Demo 生成效果
- [ ] 评估本地模型生成设计的质量

---

*记录时间: 2026-04-25 | 标签: #设计 #AI工具 #开源 #Ollama*
