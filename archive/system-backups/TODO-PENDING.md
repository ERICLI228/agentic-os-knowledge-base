# 📋 待提供事项清单 (需要用户提供)

> 最后更新: 2026-04-05 20:58 PDT

---

## 🔴 高优先级 - 阻断任务 (ERP闭环)

| 序号 | 待办项 | 用途 | 获取位置 | 状态 |
|------|--------|------|----------|------|
| 1 | **紫鸟浏览器 API Key** | 多店铺IP隔离、网络合规 | znms.com → API设置 | ⏳ 待提供 |
| 2 | **店小秘 API Key/Secret** | 订单同步、ERP发货 | dianxiaomi.com → API接口 | ⏳ 待提供 |
| 3 | **妙手 ERP API** | 订单同步、库存管理 | miaoshouerp.com → 开发者中心 | ⏳ 待提供 |
| 4 | **TikTok 企业号申请** | API权限、广告投放 | business.tiktok.com | ⏳ 待申请 |
| 5 | **填充真实业务数据** | product_db.csv等 | 已填充 50+ SKU ✅ | ✅ 已完成 |

---

## 🟡 中优先级 - 增强功能

| 序号 | 待办项 | 用途 | 状态 |
|------|--------|------|------|
| 6 | TikTok Ads API | 广告自动投放 | ⏳ 待申请 |
| 7 | XMP 账号 | 跨账号批量创建广告 | ⏳ 待配置 |
| 8 | Outmax AI 账号 | 实时竞价优化 | ⏳ 待配置 |
| 9 | 视频TTS方案 | 阿里Sambert无免费 | ⏳ 需替代方案 |

---

## ✅ 已实现的基础设施

| 能力 | 位置 | 触发方式 |
|------|------|----------|
| **日志自分析** | ~/.agents/skills/log-analyzer/ | "分析日志"、"检查失败"、"自愈" |
| **GSTACK 9专家** | ~/.claude/agents/gstack/ | 自动路由 + /gstack:xxx |
| **MagicPockets** | ~/.agents/skills/magic-pockets/ | "选品"、"上架"、"运营" |
| **选品监控** | ~/.agents/skills/proactive-operator/ | 每2小时自动 |
| **视频生成** | ~/openclaw-video/ | 需TTS方案 |
| **飞书集成** | 7个飞书Skills | 日报/文档/云盘/截图 |
| **自动路由** | ~/.openclaw/workspace/scripts/auto-route.sh | 智能任务分发 |
| **产品库** | ~/.openclaw/workspace-product_scout/data/ | 50+ SKU已填充 |
| **市场分析** | ~/.openclaw/workspace/reports/ | tk-sea-3c-market-analysis-2026.md |

---

## 🚀 已集成自动路由规则

| 任务关键词 | 路由目标 |
|------------|----------|
| 战略、规划、决策 | gstack-ceo |
| 管理、项目、进度 | gstack-eng-manager |
| 开发、代码、技术 | gstack-engineer |
| 测试、质量、验收 | gstack-qa |
| 审查、风控、安全 | gstack-review |
| 部署、发布、运维 | gstack-ship |
| 浏览、调试、抓取 | gstack-browse |
| 选品、上架、订单 | MagicPockets |
| 日志、分析、失败 | log-analyzer |

---

## 📝 获取方式

### 1. 紫鸟浏览器
- 登录 https://www.znms.com/
- API设置 → 获取API Key
- 位置: 账户设置 → API开发

### 2. 店小秘
- 登录 https://www.dianxiaomi.com/
- 设置 → API接口 → 获取Key/Secret

### 3. 妙手ERP
- 登录 https://www.miaoshouerp.com/
- 开发者中心 → API密钥

### 4. TikTok 企业号
- 登录 https://business.tiktok.com/
- 注册企业号 → 申请API权限

---

**获取后告诉我，我立即集成！** 🚀