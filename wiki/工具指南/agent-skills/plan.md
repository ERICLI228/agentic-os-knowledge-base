---
title: "Agent Skill — Planning and Task Breakdown"
date_created: 2026-04-27
date_modified: 2026-04-27
summary: "将 spec 拆分为小的可验证任务，每个任务有验收标准和依赖顺序"
tags: [开发工具, 任务拆解, planning]
type: concept
status: final
---

# Agent Skill — Planning and Task Breakdown (`/plan`)

## 触发词

`/plan`、"拆解任务"、"拆分任务"、"规划一下"、"制定实现计划"、"列个 todo"

## 核心原则

**好的任务拆解是可靠交付和混乱代码之间的区别。**

## 关键方法

### 垂直切分（正确）✅

```
任务1: 用户可以创建账户（schema + API + 注册 UI）
任务2: 用户可以登录（auth schema + API + 登录 UI）
任务3: 用户可以创建任务（task schema + API + 创建 UI）
```

每个垂直切片都交付**可测试的功能**。

### 水平切分（错误）❌

```
任务1: 构建整个数据库 schema
任务2: 构建所有 API 端点
任务3: 构建所有 UI 组件
任务4: 连接一切
```

## 任务结构模板

```markdown
## Task [N]: [简短描述性标题]

**描述：** 一段话说明此任务完成什么

**验收标准：**
- [ ] [具体、可测试的条件]

**验证方式：**
- [ ] 测试通过：`npm test -- --grep "feature"`

**依赖：** [依赖的任务编号，或"无"]

**预计范围：** Small(1-2文件) / Medium(3-5文件) / Large(5+文件)
```

## 任务大小指南

| 大小 | 文件数 | 说明 |
|------|--------|------|
| XS | 1 | 单个函数或配置变更 |
| S | 1-2 | 一个组件或端点 |
| M | 3-5 | 一个功能切片 |
| L | 5-8 | **太大，需要继续拆分** |
| XL | 8+ | **必须拆分** |

## 相关

- 上游：[[spec]] ← 需要先有 spec
- 下游：[[build]] ← 按计划逐个实现
- 来源：`~/.agents/skills/agent-skills-plan/SKILL.md`
- 工作流索引：[[README]]
