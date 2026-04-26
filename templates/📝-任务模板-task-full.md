---
title: "{{title}}"
created: "{{date}}"
task_id: "{{task_id}}"
project: "{{project}}"
status: "{{status}}"
tags: [task, {{project}}]
---

# {{title}}

> 📅 创建时间: {{date}}
> 🆔 任务ID: `{{task_id}}`
> 📁 项目: [[{{project}}]]

## 📋 任务描述
{{description}}

## 🎯 里程碑进度
| 里程碑 | 名称 | 状态 | 产出类型 |
|--------|------|------|----------|
{{#milestones}}
| {{id}} | {{name}} | {{status}} | {{output_type}} |
{{/milestones}}

## 📦 产出内容
{{#outputs}}
### {{milestone_id}}: {{title}}
- **类型**: {{type}}
- **生成时间**: {{generated_at}}

{{content_summary}}
{{/outputs}}

## 🤔 决策记录
{{#decisions}}
- {{date}}: **{{decision}}** {{#comment}}(备注: {{comment}}){{/comment}}
{{/decisions}}

## 🔗 相关链接
- [[Dashboard]] - 实时状态
- [[{{project}}]] - 项目主页
- [[Daily/{{date}}]] - 当日日报

## ✅ 下一步行动
- [ ] 待补充

---
*最后更新: {{date}}*