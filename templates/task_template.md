# {{title}}

> 创建时间: {{created_at}}
> 任务ID: {{task_id}}
> 项目: {{project}}

## 任务描述
{{description}}

## 里程碑进展
| 里程碑 | 状态 | 产出 |
|--------|------|------|
{{#milestones}}
| {{id}} - {{name}} | {{status}} | {{output_type}} |
{{/milestones}}

## 产出内容
{{#outputs}}
### {{milestone_id}}: {{title}}
{{content}}
{{/outputs}}

## 决策记录
{{#decisions}}
- {{date}}: {{decision}} ({{comment}})
{{/decisions}}

## 下一步
- [ ] 待办事项

---
*标签: #task/{{project}} #status/{{status}}*
