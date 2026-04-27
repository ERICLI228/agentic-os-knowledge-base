---
title: "Agent Skill — Spec-Driven Development"
date_created: 2026-04-27
date_modified: 2026-04-27
summary: "写任何代码之前先写结构化 spec，定义做什么、为什么做、怎样算完成"
tags: [开发工具, spec, 需求分析]
type: concept
status: final
---

# Agent Skill — Spec-Driven Development (`/spec`)

## 触发词

`/spec`、"写个 spec"、"写个规范"、"写个 PRD"、"spec 驱动"、"开始前先写个 spec"、"需求不明确，先理一理"

## 核心原则

**没有 spec 就写代码等于盲人摸象。** Spec 是你和用户之间的共识——定义了要做什么、为什么做、以及怎样算完成。

## 何时使用

- ✅ 开始新项目或新功能
- ✅ 需求模糊或不完整
- ✅ 改动涉及多个文件或模块
- ✅ 需要做架构决策
- ✅ 任务预计耗时超过 30 分钟
- ❌ 单行修复、拼写纠正、需求明确且自包含的改动

## 执行流程

### Step 1: 提问澄清（Surface Assumptions）

列出所做的假设，不要静默填补模糊需求。

```
ASSUMPTIONS I'M MAKING:
1. [假设1]
2. [假设2]
→ 请纠正我，或者确认没问题后我再继续。
```

### Step 2: 撰写 Spec 文档（六大核心区域）

| # | 区域 | 说明 |
|---|------|------|
| 1 | **Objective（目标）** | 要做什么？为什么做？谁是用户？怎样算成功？ |
| 2 | **Commands（命令）** | 完整的可执行命令，包括 flag |
| 3 | **Project Structure（项目结构）** | 源码目录、测试目录、文档目录 |
| 4 | **Code Style（代码风格）** | 用真实代码片段展示风格 |
| 5 | **Testing Strategy（测试策略）** | 测试框架、测试位置、覆盖率期望 |
| 6 | **Boundaries（边界）** | Always do / Ask first / Never do |

### Step 3: 将模糊需求转化为可验证的成功标准

示例：
- 用户需求："让仪表盘更快"
- 成功标准：LCP < 2.5s、初始加载 < 500ms、CLS < 0.1

### Step 4: 保存并请求用户审核

只有用户确认后，才能进入下一步（如 `/plan`）。

## 反借口表

| 借口 | 反驳 |
|------|------|
| "这个很简单，不需要 spec" | 至少需要验收标准 |
| "写完代码再补 spec" | 那是文档，不是规范 |
| "spec 会拖慢进度" | 15 分钟的 spec 防止数小时的返工 |

## 相关

- 下游：[[plan]] → 拆解任务
- 来源：`~/.agents/skills/agent-skills-spec/SKILL.md`
- 工作流索引：[[README]]
