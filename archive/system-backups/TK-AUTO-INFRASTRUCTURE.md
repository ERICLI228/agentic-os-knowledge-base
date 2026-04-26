# TK 东南亚 3C 电商自动化 - 持久基础设施能力

> 创建时间: 2026-04-07
> 目标: 东南亚5国 (印尼/越南/泰国/菲律宾/马来西亚) 3C类目全自动运营

---

## 📊 能力总览

| 能力模块 | 状态 | 自动化 | 位置 |
|----------|------|--------|------|
| 01 ERP对接 | ⏳ | 待API | 店小秘/妙手 |
| 02 选品数据 | ✅ | 自动 | proactive-operator |
| 03 视频内容 | ✅ | 手动/自动 | heygen_batch.sh |
| 04 广告投放 | ⏳ | 待API | TikTok Ads |
| 05 日志分析 | ⏳ | 基础 | 日志收集 |
| 06 飞书日报 | ✅ | 自动 | send-daily.sh |
| 07 定时监控 | ✅ | 自动 | cron tk-sea-3c-operator |

---

## 🏗️ 已构建的持久能力

### 1. 选品数据监控系统

**功能**: 每2小时自动检查 TikTok 东南亚热门3C产品

| 组件 | 位置 | 说明 |
|------|------|------|
| 监控脚本 | `~/.agents/skills/proactive-operator/` | 16个3C品类监控 |
| Cron任务 | `tk-sea-3c-operator` | 每2小时运行 |
| 爆款阈值 | 300万播放 | 超过自动记录 |

**调用**:
```bash
# 手动运行
python3 ~/.agents/skills/proactive-operator/run.py check

# 查看最近数据
cat ~/.openclaw/workspace/memory/tk-trending-latest.json
```

---

### 2. 视频生成系统

**功能**: 马来语虚拟人产品视频批量生成

| 组件 | 位置 | 说明 |
|------|------|------|
| 主脚本 | `scripts/heygen_batch.sh` | 批量生成10个产品 |
| 单品脚本 | `scripts/heygen_video_v2.sh` | 生成单个视频 |
| 工具 | `scripts/heygen_tool.py` | API封装 |

**HeyGen 配置**:
- API Key: `sk_V2_hgu_kagwwRl9fSH_S45hK3boFxpZYjNCg3h0ADp7vUyCtrKd`
- 端点: `https://api.heygen.com/v1/video_agent/generate`
- 视频翻译: `https://api.heygen.com/v2/video_translate`

**使用**:
```bash
# 批量生成 (10个产品)
~/.openclaw/workspace/scripts/heygen_batch.sh

# 单品生成
~/.openclaw/workspace/scripts/heygen_video_v2.sh "产品文案" [语音ID]

# 示例
~/.openclaw/workspace/scripts/heygen_video_v2.sh "Power bank 20000mAh! RM79 saja!"
```

**输出**: `~/Desktop/TK_product_*.mp4`

---

### 3. TTS 语音合成

**功能**: 马来语/英语/中文语音生成

| 方案 | 状态 | 成本 | 路径 |
|------|------|------|------|
| macOS say (Amira) | ✅ 可用 | $0 | 内置 |
| HeyGen Voice | ✅ 可用 | 测试中 | API |
| CosyVoice2 | ⏳ 需配置 | $0.003/千字符 | SiliconFlow |

**马来语生成**:
```bash
# 使用 macOS Amira 语音
say -v Amira -o ~/Desktop/audio.m4a "Bajet fon yang ni confirm lagi terbaik!"
```

---

### 4. 飞书日报系统

**功能**: 8群自动日报推送

| 群组 | Webhook ID | 用途 |
|------|------------|------|
| 选品作战室 | `74a5a7e3-d88f-44a0-a012-07b56dc5cd4c` | 选品日报 |
| 数据看板 | `8f3fde4b-ce19-41c7-b37d-e09a992d1473` | 数据日报 |
| 达人运营 | `32c6f1d0-af10-4340-876b-9cd54a589289` | 达人日报 |
| 订单中心 | `cc17bf78-7112-4c38-84ea-f5be40afb9a5` | 订单日报 |
| 广告指挥室 | `fd52600b-b626-4cf3-898c-dac2ecd77d58` | 广告日报 |
| 内容工坊 | `c851d4b8-5a63-47c7-bb71-5c474f6c99ad` | 内容日报 |
| 客服中心 | `fcf21b55-8b43-4719-a2b2-51854fdf9aef` | 客服日报 |
| 技术研发 | `148cb666-4573-4ef6-a03e-a9008b0c972c` | 技术日报 |

**调用**:
```bash
# 手动发送
python3 ~/daily-reports/send-daily.sh

# 定时任务 (自动)
# 每天 8:00 AM America/Los_Angeles
```

---

### 5. 短剧/内容工作流 (drama-studio)

**功能**: 爆款分析 → 剧本生成 → 视频生成 → 分发

| Skill | 位置 | 功能 |
|-------|------|------|
| drama-studio | `skills/drama-studio/` | 主工作流编排 |
| drama-learner | `skills/drama-learner/` | 自学习系统 |
| tiktok-distributor | `skills/tiktok-distributor/` | TK分发 |

**调用**:
```bash
# 完整工作流
python3 ~/.openclaw/workspace/skills/drama-studio/run.py --full
```

---

### 6. 数据存储

| 数据 | 位置 | 说明 |
|------|------|------|
| 产品库 | `data/product_db.csv` | 37个SKU, 16个品类 |
| 热门数据 | `memory/tk-trending-latest.json` | 实时热门 |
| 选品记录 | `memory/todo-2026-04-07.md` | 待处理清单 |

---

### 7. 定时任务

| 任务 | 调度 | 功能 |
|------|------|------|
| tk-sea-3c-operator | 每2小时 | TK热门监控 |
| auto-send-reports | 每天8:00AM | 飞书日报 |
| drama-studio | 每天9:00AM | 短剧工作流 |

**查看任务**:
```bash
openclaw cron list
```

---

### 8. 成本控制规则

> 添加于 2026-04-07

| 规则 | 说明 |
|------|------|
| 免费优先 | 能用免费的就不用付费 |
| 一次机会 | 新方案只试一次，效果OK就继续 |
| 验证质量 | 结果必须满足要求 |
| 记录成本 | 付费方案都要记录 |

---

## 🔑 API Keys 配置

### 已配置

| 服务 | Key | 状态 |
|------|-----|------|
| HeyGen | `sk_V2_hgu_kagwwRl9fSH_S45hK3boFxpZYjNCg3h0ADp7vUyCtrKd` | ✅ 测试通过 |
| 阿里云通用 | `sk-b2122500f74347f4ae209ebf7df8d504` | ✅ 有效 |
| 阿里云TTS | `sk-3e7ed92bda1c49e59019aa1479a8b744` | ✅ 有效 |
| SiliconFlow | `sk-kyuvwsxkxhrqkdonjikzxncbdlnvlncrfwhquassakektoin` | ✅ 正常 |

### 待配置

| 服务 | 说明 | 状态 |
|------|------|------|
| 店小秘 ERP | 订单同步 | ⏳ 待Key |
| 妙手 ERP | 库存同步 | ⏳ 待Key |
| 紫鸟浏览器 | 店铺IP隔离 | ⏳ 待API |
| TikTok API | 企业资质 | ⏳ 待申请 |
| TikTok Ads | 广告投放 | ⏳ 待申请 |

---

## 📁 关键文件位置

```
~/.openclaw/workspace/
├── scripts/
│   ├── heygen_batch.sh          # 批量视频生成
│   ├── heygen_video_v2.sh       # 单品视频生成
│   ├── heygen_tool.py           # HeyGen API封装
│   ├── send-feishu-v3.py        # 飞书发送
│   └── send-daily.sh            # 日报发送
├── skills/
│   ├── proactive-operator/      # TK热门监控
│   ├── drama-studio/            # 短剧工作流
│   ├── drama-learner/           # 自学习
│   ├── tiktok-distributor/      # TK分发
│   └── video-generation/         # 视频生成
├── data/
│   └── product_db.csv           # 产品数据库
├── memory/
│   ├── tk-trending-latest.json  # 热门数据
│   └── 2026-04-07.md            # 今日日志
└── AGENTS.md                    # 成本控制规则
```

---

## 🚀 快速使用指南

### 生成产品视频
```bash
# 1. 单品生成
~/.openclaw/workspace/scripts/heygen_video_v2.sh "产品文案"

# 2. 批量生成
~/.openclaw/workspace/scripts/heygen_batch.sh
```

### 查看热门数据
```bash
# 手动检查
python3 ~/.agents/skills/proactive-operator/run.py check
```

### 发送日报
```bash
python3 ~/daily-reports/send-daily.sh
```

---

## 📈 能力扩展路线

### Phase 1 ✅ 已完成
- [x] 选品监控系统
- [x] 视频生成系统
- [x] TTS语音
- [x] 飞书日报
- [x] 定时任务

### Phase 2 ⏳ 待API
- [ ] ERP对接 (店小秘/妙手)
- [ ] TikTok API 申请
- [ ] 广告投放自动化

### Phase 3 🎯 规划中
- [ ] 批量视频工厂
- [ ] AI智能选品推荐
- [ ] 自动广告投放优化

---

## 🧠 AI 开发者生态增强 (Phase 4)

> 基于 Hermes Agent / Graphify 等前沿能力分析
> 详细分析: `memory/AI-ECOSYSTEM-ANALYSIS.md`

### 目标能力

| 能力 | 描述 | 优先级 |
|------|------|--------|
| **obsidian-sync** | 代码→Obsidian文档自动生成 | 🔴 高 |
| **token-compressor** | 上下文自动压缩 (目标71.5x) | 🔴 高 |
| **codebase-graph** | 代码关系图谱生成 | 🟡 中 |
| **tool-validator** | 工具参数自纠错层 | 🟡 中 |

### 已有可复用
- `chat-export` - 文档导出
- `drama-learner` - 模式提取
- `FTS5` - 基础搜索
- `cron` - 定时任务

---

## 🆕 Phase 4 Skills (2026-04-07)

| Skill | 位置 | 功能 | 状态 |
|-------|------|------|------|
| **obsidian-sync** | `skills/obsidian-sync/` | 代码→Obsidian文档自动生成 | ✅ |
| **token-compressor** | `skills/token-compressor/` | 上下文压缩 (8.6x测试) | ✅ |
| **codebase-graph** | `skills/codebase-graph/` | 代码关系图谱生成 | ✅ |
| **tool-validator** | `skills/tool-validator/` | 工具参数自纠错 | ✅ |

### 使用示例

```bash
# Obsidian 同步
python3 skills/obsidian-sync/sync.py ./src ./Obsidian/Vault

# Token 压缩
python3 skills/token-compressor/compress.py --input memory/2026-04-07.md

# 代码图谱
python3 skills/codebase-graph/graph.py ./src --format mermaid

# 工具校验
python3 skills/tool-validator/validate.py --tool read_file --params '{"path":"/test"}' --fix
```

---

*更新于 2026-04-07 23:15*