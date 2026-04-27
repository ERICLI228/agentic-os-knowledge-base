---
title: "Agent Skills 开发工作流 — 总索引"
date_created: 2026-04-27
date_modified: 2026-04-27
summary: "7 个 AI 辅助开发 Skill 的索引，覆盖 spec→plan→build→test→review→simplify→ship 全链路"
tags: [开发工具, AI工作流, agent-skills]
type: index
status: final
---

# Agent Skills 开发工作流 — 总索引

## 概述

7 个 OpenClaw Skill，组成完整的 **spec 驱动开发工作流**。每个 Skill 都是一个独立的开发阶段，可按顺序使用，也可单独触发。

## 工作流顺序

```
/spec → /plan → /build → /test → /review → /code-simplify → /ship
```

| Skill | 触发词 | 用途 | 文件 |
|-------|--------|------|------|
| [[agent-skills-spec]] | `/spec` | 写结构化规格文档 | [[spec]] |
| [[agent-skills-plan]] | `/plan` | 拆解任务、排依赖 | [[plan]] |
| [[agent-skills-build]] | `/build` | 增量实现、垂直切片 | [[build]] |
| [[agent-skills-test]] | `/test` | TDD + Bug Prove-It | [[test]] |
| [[agent-skills-review]] | `/review` | 五轴代码审查 | [[review]] |
| [[agent-skills-code-simplify]] | `/code-simplify` | 降低复杂度、保持行为 | [[simplify]] |
| [[agent-skills-ship]] | `/ship` | 扇出审查 + GO/NO-GO | [[ship]] |

## 何时使用

| 场景 | 推荐流程 |
|------|---------|
| 新功能开发 | `/spec` → `/plan` → `/build` → `/test` → `/review` → `/ship` |
| Bug 修复 | 直接 `/test`（Prove-It）→ 修复 → `/review` |
| 代码重构 | `/code-simplify` → `/test` → `/review` |
| 紧急修复 | `/build` → `/test` → `/ship`（跳过 spec/plan） |

## 来源

- 原始项目：`~/.agents/skills/agent-skills-1.0.0/`
- 来源：Karpathy spec 驱动开发理念
- 转换日期：2026-04-27
