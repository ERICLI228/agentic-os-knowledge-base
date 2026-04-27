---
title: "video-use - AI视频编辑Skill"
created: 2026-04-25
updated: 2026-04-25
tags: [视频, AI工具, ClaudeCode, 待启用]
status: ⏳ 等待Claude Code CLI
---

# video-use

> 用 coding agent 驱动的对话式视频编辑器
> 状态：**已安装，等待 Claude Code CLI Key 到位**

---

## 📋 基本信息

| 项目 | 值 |
|------|-----|
| GitHub | `browser-use/video-use` |
| 作者 | gregpr07 |
| 协议 | MIT |
| Stars | ~4,640 |
| 语言 | Python 76% + HTML 23% |
| 创建时间 | 2026-04-12 |

## 🔗 关键路径

| 路径 | 说明 |
|------|------|
| 代码仓库 | `~/Developer/video-use` |
| Skill 注册 | `~/.openclaw/skills/video-use` (symlink) |
| SKILL.md | `~/Developer/video-use/SKILL.md` |
| helpers 脚本 | `~/Developer/video-use/helpers/` |
| .env 配置 | `~/Developer/video-use/.env` |
| Python venv | `~/Developer/video-use/.venv` |

## 🛠️ 核心功能

1. **转录** - ElevenLabs Scribe 语音转文字，带说话人区分 + 时间戳
2. **去填充词** - 自动识别并裁剪 umm/uh/false starts
3. **字幕** - ffmpeg 字幕渲染
4. **调色** - ffmpeg 调色链

## 📦 依赖状态

| 依赖 | 状态 |
|------|------|
| ffmpeg | ✅ v8.1 |
| Python 依赖 (uv) | ✅ 已安装 |
| ElevenLabs API Key | ✅ 已配置 (免费 10,000 字符/月) |
| Claude Code CLI | ❌ **待安装** |

## ⚠️ 重要限制

**不能直接运行！** 必须配合 Claude Code CLI 使用：
1. 放视频到一个文件夹
2. 在终端启动 `claude`
3. 说 "edit this video"
4. Claude Code 自动调用 helpers 脚本编排全流程

### Claude App vs Claude Code
| | Claude App | Claude Code CLI |
|---|---|---|
| 形态 | 网页版/App | 终端 CLI |
| Skill 支持 | ❌ 不支持 | ✅ 支持 |
| 价格 | 免费/付费 | 需要付费订阅 |

## 🧪 已验证的流程（2026-04-25）

### 测试1：人工合成视频转录
- 创建 15s 440Hz 正弦波测试视频
- ElevenLabs Scribe 转录 ✅ (2.2s)
- 识别结果："(4000 Hz tone)" 音频事件

### 测试2：真人语音视频转录 + 字幕
- 视频：`TK_product_keyboard.mp4` (10.9s, 3.3MB)
- Whisper 本地转录 ✅ (替代 ElevenLabs，免费)
- 识别内容：4条英文字幕，准确率 100%
- MoviePy 烧录字幕 ✅ (输出 1.9MB)

## 🔄 替代方案（不需要 Claude Code）

如果暂时不用 Claude Code，可以用以下组合替代：

```
Whisper (本地转录) + ffmpeg (剪辑/调色) + MoviePy (字幕烧录)
```

**优势**：免费、本地运行、无字符限制
**劣势**：不能自动去填充词（需要手动脚本）

## 📝 待办

- [ ] 安装 Claude Code CLI
- [ ] 获取 Claude Code API Key
- [ ] 用真实视频测试完整流程（转录→EDL→裁剪→字幕→输出）

---

*记录时间: 2026-04-25 | 标签: #视频 #AI工具 #ClaudeCode #待启用*
