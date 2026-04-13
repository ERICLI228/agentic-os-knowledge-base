# MEMORY.md - 长期记忆

> 每次会话开始时自动加载
> 记录所有重要事项、待办、历史事件

---

## 📡 飞书 Webhook 配置（重要！不要重复创建）

已有 8 个飞书 Webhook，位置：
```
~/.openclaw/workspace/scripts/send-feishu-v3.py
~/.openclaw/workspace/scripts/send-feishu-cards.py
```

| 群组 | Webhook ID | 用途 |
|------|------------|------|
| 选品作战室 | `74a5a7e3-d88f-44a0-a012-07b56dc5cd4c` | 🔍 选品日报 |
| 数据看板 | `8f3fde4b-ce19-41c7-b37d-e09a992d1473` | 📊 数据日报 |
| 达人运营 | `32c6f1d0-af10-4340-876b-9cd54a589289` | 🤝 达人日报 |
| 订单中心 | `cc17bf78-7112-4c38-84ea-f5be40afb9a5` | 🛡️ 订单日报 |
| 广告指挥室 | `fd52600b-b626-4cf3-898c-dac2ecd77d58` | 📈 广告日报 |
| 内容工坊 | `c851d4b8-5a63-47c7-bb71-5c474f6c99ad` | 🎬 内容日报 |
| 客服中心 | `fcf21b55-8b43-4719-a2b2-51854fdf9aef` | 💬 客服日报 |
| 技术研发 | `148cb666-4573-4ef6-a03e-a9008b0c972c` | 💻 技术日报 |

**新增功能时必须复用这些 webhook，不要创建新的！**

---

## 📌 用户：Hokeli (ERIC)

- TikTok/TK 跨境电商运营
- OpenClaw 全能终极版
- 多个飞书群绑定Agent
- 位于美国洛杉矶

---

## 🚀 核心目标

**TK东南亚5国 3C类目 全自动运营**
- 平台: TikTok
- 市场: 印尼/越南/泰国/菲律宾/马来西亚
- 品类: 3C电子产品
- 参考: PROJECT_ROADMAP.md

---

## 🎯 TK东南亚5国3C运营 - 主动运营Agent (2026-04-04)

### ⭐ 自动化闭环 (无需提醒，自动化执行)

**日常运营自动化流程:**
| 时间 | 任务 | 状态 |
|------|------|------|
| 每2小时 | TK东南亚3C运营检查 | ✅ 自动 |
| 每天1点(北京) | 批量生成日报+整合TK数据 | ✅ 自动 |
| 每天3点(美国) | 三备份+Notion同步 | ✅ 自动 |
| 每周 | Token节省优化检查 | ✅ 自动 |

**自动化原则:**
- [x] TK数据自动进入日报 (选品/数据部门)
- [x] 备份状态自动记录
- [x] 爆款自动告警
- [x] 不需要用户提醒，自动执行

---

### ⭐ 核心基础设施 (从Claude Code源码泄漏学习)

**主动运营 Agent 系统:**
| 组件 | 位置 | 状态 |
|------|------|------|
| 监控脚本 | ~/.agents/skills/proactive-operator/ | ✅ 基础设施 |
| 3C品类配置 | 16个品类 | ✅ 已配置 |
| 定时任务 | tk-sea-3c-operator | ✅ 每2小时运行 |
| 爆款阈值 | 300万播放 | ✅ 自动告警 |

**架构设计参考Claude Code:**
- ✅ 三层记忆 (L1-L4) - 同 Claude Code Memory Layers
- ✅ Agent工作流 - 监控→分析→执行
- ✅ 定时任务 - Cron调度
- ✅ 工具编排 - OpenCLI + Skills

---

### 已搭建系统
| 组件 | 位置 | 说明 |
|------|------|------|
| 监控脚本 | ~/.agents/skills/proactive-operator/ | 定时抓取TK热门 |
| Cron任务 | tk-sea-3c-operator | 每2小时自动运行 |
| 监控品类 | 3C全品类 | laptop/earbuds/charger/smart watch等16个 |
| 爆款阈值 | 300万播放 | 超过自动记录 |

### 目标
- 平台: TikTok
- 地区: 东南亚5国 (印尼/越南/泰国/菲律宾/马来西亚)
- 品类: 3C电子产品
- 频率: 每2小时检查

---

## 🎯 当前待办事项 (2026-04-04 07:53更新)

### 🔴 高优先级
| 待办 | 说明 | 状态 |
|------|------|------|
| 店小秘 ERP API | 订单同步必需 | ⏳ 已开通账户，待获取Key |
| 妙手 ERP API | 订单同步 | ⏳ 已开通账户，待获取Key |
| 紫鸟浏览器 API | 多店铺IP隔离 | ⏳ 已购买套餐，待获取API |
| TikTok API | 企业资质申请 | ⏳ 待申请 |
| TikTok Ads API | 广告投放自动化 | ⏳ 待申请 |
| 填充真实业务数据 | product_db.csv等 | ⏳ 待填充 |
| 视频语音TTS | 视频生成必需 | ⏳ 阿里Sambert无免费，可尝试MiniMax |

### 🟡 中优先级
| 待办 | 说明 | 状态 |
|------|------|------|
| MySQL 数据库 | 数据存储 | ✅ 已搭建 (Docker本地) |
| 向量数据库 | 语义检索 | ✅ 已搭建 (SQLite FTS5) |
| 店小秘 Skill | 订单同步Skill | ⏳ 待创建 |
| 紫鸟浏览器 Skill | 店铺环境管理 | ⏳ 待创建 |

### ✅ 2026-04-03 已完成
| 完成项 | 说明 | 状态 |
|--------|------|------|
| Paperclip集成 | Gateway适配器集成完成 | ✅ |
| MagicPockets公司 | Gateway公司创建成功 | ✅ |
| 4月2日记录 | 补充缺失的日志 | ✅ |
| 备份恢复 | pre-compact-hook 正常工作 | ✅ |
| Coding Plan Pro配置 | 火山引擎6模型已配置，主力切到kimi-k2.5 | ✅ |
| 模型切换 | MiniMax→火山引擎Kimi-K2.5 | ✅ |
| OpenClaw升级 | v2026.3.24 → v2026.4.2 | ✅ |

### ✅ 2026-03-30 已修复
| 问题 | 方案 | 状态 |
|------|------|------|
| Cron: auto-send-reports 执行失败 | 添加 python3/bash/sh 到 exec allowlist | ✅ 已修复并验证 |
| SiliconFlow API Key 更新 | 替换为新 key (sk-kyuvwsx...) | ✅ 已更新 |

### 🟢 已完成 (备份)
- ✅ OpenClaw 160+ Skills 集成
- ✅ 17 Agents 配置
- ✅ 8群飞书日报
- ✅ Python 3.12.0 升级
- ✅ Clawith 数字员工平台
- ✅ openclaw-video 视频生成 (等待TTS)
- ✅ 阿里云 API Keys 配置

---

## 💾 重要数据位置

### 微信备份
| 内容 | 路径 |
|------|------|
| **完整备份** | `/Users/hokeli/证据备份/微信/Mac本地备份/` (40GB) |
| 聊天记录DB | `.../Message/msg_*.db` |
| 联系人DB | `.../Contact/wccontact_new2.db` |
| 群聊DB | `.../Group/group_new.db` |

### OpenClaw 备份
| 内容 | 路径 |
|------|------|
| 自动备份 | `~/Backups/OpenClaw/` |
| 工作区备份 | `~/Backups/workspace-backup/` |
| TK编辑器备份 | `~/Backups/tk-editor-auto/` |

---

## 🧠 已整合 Skills/Agents (2026-04-01 更新)

### 统计
| 类型 | 数量 |
|------|------|
| **Skills** | **200+** |
| **Agents** | **17+** |
| **Commands** | **12** |
| **Agency Agents** | **162** (多领域专家) |

### 📦 2026-04-01 新增插件
| 插件 | 目录 | 功能 |
|------|------|------|
| **claude-mem** | `~/.agents/skills/claude-mem/` | 记忆持久化压缩 (5 skills) |
| **get-shit-done (GSD)** | `~/.agents/skills/gsd/` | 任务管理框架 (19 skills) |
| **planning-with-files** | `~/.agents/skills/planning-with-files/` | Manus风格文件规划 (3 skills) |
| **everything-claude-code (ECC)** | Claude Code原生 | 25 agents + 110 skills |

---

### 📚 Skills 详细列表

#### 1. 核心功能 Skills
| Skill | 位置 | 功能 |
|-------|------|------|
| content-review-system | ecc-integration/skills/ | 对抗式内容审核 (笔杆子→参谋→三万) |
| video-generator | ecc-integration/skills/ | 文字→TTS→视频渲染 |
| open-space | ecc-integration/skills/ | HKUDS 自进化技能引擎 |
| firecrawl | ecc-integration/skills/ | 网页抓取 |
| quickui | ecc-integration/skills/ | HTML/CSS模板生成 |

#### 2. Minimalist Entrepreneur (Gumroad创始人)
| Skill | 功能 |
|-------|------|
| find-community | 创业社区发现 |
| validate-idea | 创业想法验证 |
| mvp | 最小可行产品 |
| processize | 流程自动化 |
| first-customers | 首批客户获取 |
| pricing | 定价策略 |
| marketing-plan | 营销计划 |
| grow-sustainably | 可持续增长 |
| company-values | 公司价值观 |
| minimalist-review | 商业决策审核 |

#### 3. Everything Claude Code (150+ Skills)
- 前端开发、PPT生成、Excel处理、PDF生成、视频语音生成等

---

### 🤖 Agents 列表
| Agent | 用途 |
|-------|------|
| review-bot | 代码审查 |
| python-reviewer | Python审查 |
| typescript-reviewer | JS/TS审查 |
| go-reviewer | Go审查 |
| build-error-resolver | 编译错误修复 |
| security-reviewer | 安全审查 |
| flutter-dart-code-review | Flutter审查 |

---

## 🔧 系统配置

### blockStreamingDefault
- 位置: `~/.openclaw/openclaw.json`
- 状态: ✅ 已添加 (禁止AI过渡话术)

### Python
- 版本: **3.12.0** (原3.9.6)
- 方式: pyenv
- 状态: ✅ 已升级

---

## 🎬 视频生成问题 (2026-03-29)

### 问题
- 阿里云 Sambert TTS **无免费试用**
- API 返回: `model Access denied`

### 替代方案
1. **MiniMax TTS** - 通过 MiniMax Skill 调用
2. **手动合成** - 我生成脚本，你用其他TTS工具
3. **付费开通** - 阿里云付费使用 Sambert

---

## 🔑 API Keys (2026-03-31 更新)

### SiliconFlow (主)
- **Key**: `sk-kyuvwsxkxhrqkdonjikzxncbdlnvlncrfwhquassakektoin`
- **来源**: 硅基流动 (https://cloud.siliconflow.cn)
- **状态**: ✅ 正常

### 阿里云百炼 (通义千问)
| Key | 用途 | 状态 |
|-----|------|------|
| `sk-b2122500f74347f4ae209ebf7df8d504` | 通用模型 | ✅ 有效 |
| `sk-3e7ed92bda1c49e59019aa1479a8b744` | TTS 语音 | ✅ 有效 |

### Google Gemini
- **状态**: ❌ 已失效，需重新生成

---

## 🤖 Claude Code / Cursor 配置

### 模型优先级
1. **主模型**: MiniMax-M2.5 (SiliconFlow)
2. **备用**: Gemini 2.5 Pro (Google)

### 配置位置
- OpenClaw: `~/.openclaw/openclaw.json` ✅ 已更新
- 说明文档: `~/CLAUDE-CODE-config.md`

### 推荐模型
| 场景 | 模型 |
|------|------|
| 品牌定制 | cosyvoice-v3.5-plus |
| 客服/助手 | cosyvoice-v3-flash |
| 教育公式 | cosyvoice-v2 |

---

## 📡 服务端口 (2026-03-29)

| 服务 | 地址 | 状态 |
|------|------|------|
| OpenClaw Bot Dashboard | http://localhost:3000 | ✅ 运行中 |
| OpenClaw 控制面板 | http://localhost:18789 | ✅ 运行中 |
| Clawith 数字员工 | http://localhost:3008 | ✅ 运行中 |
| TK Workflow Editor | http://localhost:3005 | ✅ 运行中 |

---

## 📁 重要项目位置

| 项目 | 位置 |
|------|------|
| OpenClaw-bot-review | ~/projects/OpenClaw-bot-review |
| openclaw-video | ~/openclaw-video |
| Clawith | ~/Clawith |
| TK Workflow Editor | ~/tk-workflow-editor |
| 飞书日报 | ~/daily-reports/ |

---

## 🚀 飞书日报系统

| 项目 | 状态 |
|------|------|
| 8群Webhook | ✅ 已配置 |
| 自动发送脚本 | ✅ ~/daily-reports/send-daily.sh |
| 定时任务 | ✅ 每天 8:00 AM (美国) |
| 标准模板 | ✅ ~/daily-reports/templates/ |

---

## 📜 历史事件

### 2026-03-29 (今天)
**已完成**:
- ✅ Python 3.9.6 → 3.12.0 升级
- ✅ OpenClaw-bot-review 安装并在 3000 端口运行
- ✅ Clawith 数字员工平台安装并启动
- ✅ openclaw-video 视频生成系统安装
- ✅ 160+ Skills 集成
- ✅ 10个 Minimalist Entrepreneur Skills
- ✅ 阿里云语音合成 API Keys 配置
- ✅ 飞书日报系统完善
- ✅ blockStreamingDefault 配置

**待跟进**:
- Docker Hub 登录问题
- TikTok API 申请
- 店小秘/紫鸟浏览器 API

---

### 2026-03-28 (昨天)
**已完成**:
- 飞书双向通信恢复
- 定时日报任务恢复
- 整合 ECC + MiniMax Skills
- 微信完整备份确认

---

## 🧠 持续学习 - 已记录的模式

### 行为模式
| 模式 | 说明 | 来源 |
|------|------|------|
| Connect/Disconnect | 会话连接/断开管理 | 2026-04-06 提取 |
| Resources 浏览/搜索 | 资源发现与检索 | 2026-04-06 提取 |
| Tools 发现/调用 | 工具自动发现与执行 | 2026-04-06 提取 |

### 原则
| 规则 | 说明 | 来源 |
|------|------|------|
| "Memory is limited" | 想记住什么就写文件，脑记不持久 | AGENTS.md |
| "Text > Brain" | 文本优先于记忆 | AGENTS.md |

---

## 🔧 快速调用指令

| 你说 | 我做什么 |
|------|----------|
| "技能" / "skills" | 列出所有可用技能 |
| "记忆" / "查看待办" | 列出待办事项 |
| "备份" | 找到微信/OpenClaw备份位置 |

---

*更新于 2026-04-05 20:12 | 每次会话自动加载*

### 2026-04-05 更新
- ✅ 待办页面自动更新 (cron任务)

### 2026-04-06 更新
- ✅ 模型偏好：优先使用阿里云 (200 元套餐)
  - 主模型：`aliyun/qwen3.5-plus`
  - 备用：`aliyun/kimi-k2.5`, `aliyun/glm-4.7`
  - 不使用：SiliconFlow (等阿里云额度用完再说)
