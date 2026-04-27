---
title: "Agent Skill — Incremental Implementation"
date_created: 2026-04-27
date_modified: 2026-04-27
summary: "以垂直切片增量实现——每次实现一个完整部分，测试、验证、提交"
tags: [开发工具, 增量实现, build]
type: concept
status: final
---

# Agent Skill — Incremental Implementation (`/build`)

## 触发词

`/build`、"开始实现"、"写代码"、"编码"、"开发这个功能"、"按计划执行"

## 核心原则

**每次增量都让系统保持可工作、可测试的状态。**

## 实现循环

```
实现 ──→ 测试 ──→ 验证 ──→ 提交
  ▲                             │
  └─────────────────────────────┘
         下一个切片
```

## 实现规则

| 规则 | 说明 |
|------|------|
| Rule 0: 简单优先 | 什么是最简单的可行方案？相似代码 > 抽象 |
| Rule 0.5: 范围纪律 | 只触碰任务需要的内容，不"顺便清理" |
| Rule 1: 一次只做一件事 | 每个增量只改一个逻辑内容 |
| Rule 2: 保持可编译 | 每次增量后必须能构建、测试通过 |
| Rule 3: 未完成用 Feature Flag | 新功能默认隐藏 |
| Rule 4: 安全默认值 | 新代码默认安全、保守 |
| Rule 5: 可回滚 | 每个增量独立可回退 |

## 反借口

| 借口 | 反驳 |
|------|------|
| "最后一起测" | bug 会复合，切片1 的 bug 让切片2-5 都错 |
| "一起做更快" | 大提交隐藏 bug，回滚痛苦 |
| "这个改动太小不值得单独提交" | 小提交是免费的 |

## 相关

- 上游：[[plan]] ← 按任务清单逐个实现
- 相关：[[test]] ← TDD 是 build 的核心循环
- 来源：`~/.agents/skills/agent-skills-build/SKILL.md`
- 工作流索引：[[README]]
