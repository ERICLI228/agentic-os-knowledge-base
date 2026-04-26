---
title: "阶段A-多故事架构完成"
created: 2026-04-24
updated: 2026-04-24
tags: [架构, 架构/v3, 架构/业务]
status: draft
---
# 🎬 阶段 A 完成：多故事架构（2026-04-24）

> **执行环境**：OpenCode App（`~/agentic-os-collective/`）  
> **同步到**：`~/.openclaw/workspace/skills/water-margin-drama/`  
> **验证时间**：2026-04-24 08:06 PDT

---

## 新增文件（4 个）

| 文件 | 大小 | 作用 |
|------|------|------|
| `stories/shuihuzhuan.yaml` | 6.5KB | 水浒传配置 — 5 角色/12 集/23 条改写规则/4 场景 |
| `stories/sanguo.yaml` | 5.3KB | 三国演义配置 — 5 角色/10 集/9 条改写规则/4 场景 |
| `stories/xiyou.yaml` | 5KB | 西游记配置 — 4 角色/10 集/9 条改写规则/3 场景 |
| `shared/story_loader.py` | 4.3KB | 通用加载器 — `Story` 类 + `load_story()` + `list_available()` |

## 修改文件（5 个）— 全部去硬编码

| 文件 | 改造内容 | 消除的硬编码 |
|------|----------|-------------|
| `water_margin_drama.py` | `--story` 参数 + `--mode` 取代 `--script/--video/--full` | "水浒传短视频" 提示词 |
| `script_selector.py` | 12 个硬编码章节 → `story.episodes` | `CHARACTER_POPULARITY`, `CLASSIC_EPISODES` |
| `role_designer.py` | `ROLES` 字典 → `story.roles()` | 5 角色 `CHARACTER_PROFILES` 硬编码 |
| `controversy_rewriter.py` | `CONTROVERSY_RULES` → `story.controversies` | 23 条 `SENSITIVE_PATTERNS` 硬编码 |
| `shared/config.py` | 同步过来（被改造文件引用） | N/A（依赖项） |

## 验证结果

```
# 水浒传
python3 script_selector.py --story shuihuzhuan select
 → 武松打虎 (92) > 林冲风雪山神庙 (90) > 鲁智深倒拔垂杨柳 (88)

# 三国演义
python3 script_selector.py --story sanguo select
 → 赤壁之战 (98) > 桃园三结义 (95) > 空城计 (94)

# 西游记
python3 script_selector.py --story xiyou select
 → 孙悟空大闹天宫 (98) > 三打白骨精 (95) > 真假美猴王 (90)
```

✅ 三故事实时切换，全部通过

## 如何添加第 4 个故事

只需创建一个 YAML 文件，不改任何代码：

```bash
cp stories/shuihuzhuan.yaml stories/fengshen.yaml
# 编辑 fengshen.yaml：改 name/roles/episodes/controversy_rules
# 立即可用
python3 water_margin_drama.py --story fengshen --theme "哪吒闹海" --mode script
```

## 对 PRD 的影响

- 总体完成度：35% → **45%**
- 剧本筛选模块：25% → **65%**
- 争议改写模块：20% → **50%**
- 角色设计模块：75% → **80%**（去硬编码 + API 接入）

---

*归档时间：2026-04-24 08:10 PDT*
