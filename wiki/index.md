---
title: "知识库总索引"
date_created: 2026-04-13
date_modified: 2026-04-27
total_pages: 17
---

# 知识库总索引

## 总览

本项目知识库覆盖：AI 数字短剧自动化、TK 东南亚运营、LLM Wiki 方法论、会话归档机制、知识库自动化运维、Agent 开发工作流。

## 概念（2 篇）

- [[llm-wiki-methodology]] — 基于 Karpathy 模式的 raw + wiki + CLAUDE.md 知识库架构
- [[session-archiving]] — 基于 Clicky/CPR 设计理念的会话归档机制

## 工具指南（9 篇）

### Agent Skills 开发工作流（7 篇）
- [[spec]] — Spec 驱动开发：写代码前先写结构化规格文档
- [[plan]] — 任务拆解：将 spec 拆分为可验证任务，排依赖顺序
- [[build]] — 增量实现：垂直切片构建，每次增量保持可工作
- [[test]] — TDD 工作流：先写失败测试，Bug 用 Prove-It 模式
- [[review]] — 五轴代码审查：正确性、可读性、架构、安全、性能
- [[code-simplify]] — 代码简化：降低复杂度，保持行为不变
- [[ship]] — 发布检查：扇出审查 + GO/NO-GO 决策 + 回滚计划
- [[agent-skills/README]] — Agent Skills 工作流总索引

### 其他（2 篇）
- `open-codesign.md` — OpenClaw 代码签名指南
- `video-use.md` — 视频使用指南

## 脚本（3 篇）

- `shared/scripts/wiki-ingest.py` — raw→wiki 自动编译
- `shared/scripts/wiki-query.py` — 回答归档到 output
- `shared/scripts/wiki-lint.py` — 每周健康检查

## 模板（4 篇）

- `shared/knowledge/templates/concept.md`
- `shared/knowledge/templates/entity.md`
- `shared/knowledge/templates/source.md`
- `shared/knowledge/templates/output.md`

## 实体（0 篇）

## 综合分析（0 篇）

## 最近新增

1. [2026-04-27] [[spec]] — Agent Skill: Spec-Driven Development
2. [2026-04-27] [[plan]] — Agent Skill: Task Breakdown
3. [2026-04-27] [[build]] — Agent Skill: Incremental Implementation
4. [2026-04-27] [[test]] — Agent Skill: TDD Workflow
5. [2026-04-27] [[review]] — Agent Skill: Code Review
6. [2026-04-27] [[code-simplify]] — Agent Skill: Code Simplification
7. [2026-04-27] [[ship]] — Agent Skill: Shipping and Launch
8. [2026-04-27] [[agent-skills/README]] — Agent Skills 工作流索引
9. [2026-04-27] wiki-ingest.py（脚本）
10. [2026-04-27] wiki-query.py（脚本）
11. [2026-04-27] wiki-lint.py（脚本）

## 概念

- [[test-raw-note]] — Ingested from test-raw-note.md
