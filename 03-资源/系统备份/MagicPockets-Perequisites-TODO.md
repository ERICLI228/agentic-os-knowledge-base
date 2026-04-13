# MagicPockets 恢复重建 - 前提条件待办清单

## 创建日期：2026-03-28

---

## ✅ 已创建的数据文件（模板）

### 数据源文件（已创建模板，待填充真实数据）
- [x] `data/product_db.csv` — 产品数据库 ✅ 模板已创建
- [x] `data/competitors.csv` — 竞品白名单 ✅ 模板已创建（15个账号）
- [x] `data/suppliers.csv` — 供应商信息 ✅ 模板已创建（9家）
- [x] `data/faq.json` — FAQ知识库 ✅ 模板已创建
- [x] `data/localization/` — 语料库 ✅ 模板已创建

> 📝 **下一步**：请填充真实业务数据到这些模板文件中

---

## ❌ 缺失的API配置

### 必需API
- [ ] **TikTok API** — 数据采集、商品上架、订单同步
- [ ] **TikTok Ads API** — 广告投放优化
- [ ] **TikTok Creator Marketplace API** — 达人对接
- [x] ⭐ **阿里云翻译API** — AccessKeyID: LTAI5tMdjCnuzABdpWwe35Rf（已获取ID，待获取Secret）
- [ ] **Flow AI API** — 广告数据（当前使用）

> ⚠️ 请提供阿里翻译API的配置信息（API Key 或具体服务名称）

### 紫鸟浏览器（已确认使用）
- ⏳ ⭐ **API Key**: 已获取，待配置

### 店小秘ERP（已确认使用）
- [ ] ⭐ 店小秘 API Key/Secret — **请提供**

> ⚠️ 需确认：紫鸟API Key 的具体值是什么？

---

## ❌ 缺失的数据库连接

- [ ] MySQL 数据库（存储竞品帖子、广告数据、订单、达人信息）
- [ ] ChromaDB（如需要向量相似商品检索）

---

## 📋 已恢复的功能

- [x] 9个专属Agent绑定到飞书群
- [x] 双向通信（@机器人对话）
- [x] 每日定时日报（9个角色，09:00 中国时间）

---

## 🔧 待完善的Skills（需要API和数据源）

| Skill | 功能 | 需要的前提条件 |
|-------|------|---------------|
| tiktok-monitor | 竞品监控、达人筛选、趋势雷达 | data/competitors.csv, TikTok API |
| tiktok-content | 脚本生成、多语言本地化、标签策略 | data/localization/, 翻译API |
| tiktok-ads | 广告ROI分析、素材排行、自动调价 | TikTok Ads API, Flow AI API |
| price-tracker | 价格追踪、利润测算、汇率监控 | data/product_db.csv, suppliers.csv |
| sea5-localization | 5国翻译、禁忌词过滤、语料库管理 | DeepL API, data/localization/ |
| daily-report-gen | 日报/周报生成、飞书推送 | 已完成（cron定时任务） |

---

## 📝 备注

1. **数据文件格式**：请参考原始规划文档中的数据格式说明
2. **API获取**：TikTok官方API需要申请企业资质
3. **优先顺序**：建议先补充数据文件，再配置API

---

## ❌ 缺失项目规范文件 (2026-03-28 补充)

根据用户提供的模板，以下四个核心项目文件**尚未创建**：

### 缺失文件清单
| 文件 | 说明 | 状态 |
|------|------|------|
| `task.json` | 项目任务清单 (24个任务，4个阶段) | ✅ 已创建 |
| `progress.txt` | 工作日志 (时间戳+任务ID+操作描述) | ✅ 已创建 |
| `cloud.md` | 系统规范与流程文档 (技术栈、架构、代码规范) | ✅ 已创建 |
| `init.sh` | 环境初始化脚本 (Ubuntu/macOS) | ✅ 已创建 |
| `TK-AutoPilot-2026/` | 完整基础设施副本 | ✅ 已复制 |
| `gstack` 集成 | Claude Code 命令格式 (6个角色) | ✅ 已完成 |

### 核对要点（用户要求验证）

**1. 完整性**：需涵盖核心模块（ERP对接、紫鸟集成、选品、内容、广告、自进化、飞书集成）

**2. 一致性**：`task.json`中的任务需与分阶段计划一致，依赖关系正确

**3. 合规性**：需包含2026年TikTok Shop合规要求（ERP强制认证、AI视频标注、IP隔离）

**4. 可操作性**：`init.sh`需能在Ubuntu/macOS执行，包含错误处理

**5. 规范性**：`cloud.md`技术栈、代码规范、安全规范需清晰可行

**6. 日志格式**：`progress.txt`示例需符合关键操作、错误、时间戳记录要求

### 建议存储位置
```
~/.openclaw/workspace/
├── task.json      # 项目任务清单
├── progress.txt   # 工作日志
├── cloud.md       # 系统规范
├── init.sh        # 初始化脚本
```
或参考 cloud.md 中的路径结构：`~/projects/`

---

## 🎯 98%场景覆盖 - 完整自动化体系 (待实现)

基于20年行业经验的7大模块，当前实现程度：

### ✅ 已实现模块
| 模块 | 实现程度 | 说明 |
|------|----------|------|
| 选品洞察 | 60% | 竞品监控、利润测算已有基础 |
| 内容创作 | 30% | 脚本生成+翻译，缺视频生成 |
| 发布管理 | 20% | 定时发布，缺紫鸟隔离 |
| 数据分析 | 40% | 基础利润测算，缺跨平台归因 |

### ❌ 完全缺失模块（待开发）

| 序号 | 模块/节点 | 工具/技能 | 优先级 |
|------|----------|----------|--------|
| 1 | **视频自动生成** | Hilight AI / Seedance 2.0 | P0 |
| 2 | **多模态本地化翻译** | AVidTrans | P0 |
| 3 | **紫鸟多店铺隔离** | 紫鸟浏览器API | P0 |
| 4 | **TikTok自动发布** | tiktok-publisher | P0 |
| 5 | **Smart+广告创建** | TikTok Ads API | P1 |
| 6 | **XMP广告管理** | XMP跨平台工具 | P1 |
| 7 | **ERP订单同步** | 妙手ERP / 易仓API | P1 |
| 8 | **物流追踪回填** | ERP对接 | P1 |
| 9 | **客服FAQ智能应答** | ecommerce-cs-assistant | P1 |
| 10 | **情绪识别升级** | sentiment-analyzer | P2 |
| 11 | **跨平台数据整合** | KRossBus | P2 |
| 12 | **LTV精准核算** | 数据分析增强 | P2 |

### 📋 实现顺序建议

**Phase 1 (1-2周)**：
- [ ] 视频生成 (Hilight AI集成)
- [ ] 脚本→视频完整链路

**Phase 2 (2-3周)**：
- [ ] 紫鸟环境创建+自动发布
- [ ] 广告Smart+创建

**Phase 3 (2周)**：
- [ ] ERP订单同步
- [ ] 物流追踪回填

**Phase 4 (1周)**：
- [ ] 客服自动化
- [ ] 数据归因闭环

---

*这个文件记录了恢复MagicPockets完整功能所需的前提条件。每获取一项就划掉一项。*