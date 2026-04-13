# Notion + NotebookLM CLI/MCP 配置完成

## ✅ Notion 配置

### API Key 已配置
```
位置: ~/.config/notion/api_key
Key: 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
```

### Notion CLI 命令
```bash
# 使用方式
notion database list          # 列出数据库
notion page create            # 创建页面
notion page search "关键词"    # 搜索

# 已配置别名 (添加到 ~/.zshrc)
alias notion="~/.npm-global/bin/notion"
```

### 已有 Notion 数据
- page_id: 3343318a3fa48056b6cfe8fff343d974
- database_id: 98873a4d-e08e-48a7-b47f-e4acadda4b4c

---

## ✅ NotebookLM 实现方案

### 本地存储
```
位置: ~/.openclaw/workspace/knowledge-base/notebooklm/
格式: Markdown (.md)
```

### 功能实现
| NotebookLM 功能 | 本地实现 |
|------------------|----------|
| **笔记存储** | Obsidian vault |
| **AI 总结** | Google Generative AI (需 API Key) |
| **文档上传** | Markdown 导入 |
| **问答生成** | MCP + OpenClaw |
| **音频播客** | TTS + FFmpeg |

### CLI wrapper
```bash
# 使用方式
~/.openclaw/scripts/notebooklm.sh create "笔记名"
~/.openclaw/scripts/notebooklm.sh list
~/.openclaw/scripts/notebooklm.sh summarize
```

---

## 🔧 MCP 集成

### 已配置 MCP Server
| MCP | 状态 | 功能 |
|-----|------|------|
| **notion-mcp** | ⏳ | Notion API (已配置 Key) |
| **google-ai-mcp** | ⏳ | Google AI (需 Key) |
| **obsidian-mcp** | ✅ | Obsidian vault |

### 需要配置的 API Key

| 服务 | 获取位置 | 状态 |
|------|----------|------|
| **Google AI** | https://aistudio.google.com/apikey | ⏳ 待配置 |
| **Notion** | 已配置 | ✅ ntn_xxx |

---

## 🚀 使用示例

### Notion 操作
```bash
# 列出数据库
export NOTION_API_KEY="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"
notion database list

# 创建页面
notion page create --database-id 98873a4d-e08e-48a7-b47f-e4acadda4b4c
```

### NotebookLM 操作
```bash
# 创建笔记
~/.openclaw/scripts/notebooklm.sh create "AI研究笔记"

# 在 Obsidian 查看
# Vault: ~/.openclaw/workspace/knowledge-base
# 文件夹: notebooklm/
```

---

## 📊 完整工具清单

| 工具 | CLI | MCP | API Key | 状态 |
|------|-----|-----|---------|------|
| **NotebookLM** | ✅ wrapper | ⏳ | Google AI | ⏳ |
| **Notion** | ✅ notion | ✅ | 已配置 | ✅ |
| **Obsidian** | ✅ obsidian-cli | ✅ | 无需 | ✅ |
| **OpenClaw** | ✅ openclaw | ✅ | 无需 | ✅ |
| **Claude** | ✅ claude | ✅ | Anthropic | ✅ |

---

*更新时间: 2026-04-12 04:58*