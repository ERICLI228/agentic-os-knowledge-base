---
title: "{{project_name}}"
type: project
status: "{{status}}"
created: "{{date}}"
tags: [project, {{category}}]
---

# {{project_name}}

> 📅 创建时间: {{date}}
> 📁 项目类型: {{category}}
> 🎯 目标: {{goal}}

## 📋 项目概述
{{description}}

## 🎯 核心目标
{{#goals}}
- {{.}}
{{/goals}}

## 📊 进度追踪

### 当前阶段
- **阶段**: {{current_stage}}
- **进度**: {{progress}}%

### 里程碑
| 里程碑 | 计划日期 | 实际日期 | 状态 |
|--------|----------|----------|------|
{{#milestones}}
| {{name}} | {{planned}} | {{actual}} | {{status}} |
{{/milestones}}

## 🔗 相关任务
{{#tasks}}
- [[{{task_id}}]] - {{task_name}}
{{/tasks}}

## 📝 关键决策
{{#decisions}}
- **{{date}}**: {{decision}}
{{/decisions}}

## 🔧 技术栈
{{#tech_stack}}
- {{.}}
{{/tech_stack}}

## 📚 相关文档
- [[Dashboard]]
- [[Daily Reports]]
- [[Knowledge Base]]

---
*最后更新: {{last_update}}*