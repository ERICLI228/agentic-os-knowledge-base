---
title: "{{meeting_title}}"
date: "{{date}}"
type: meeting
attendees: {{attendees}}
tags: [meeting, {{category}}]
---

# {{meeting_title}}

> 📅 时间: {{date}} {{time}}
> 👥 参会人员: {{attendees}}
> 📁 类型: {{category}}

## 📋 会议议程
{{#agenda}}
1. {{.}}
{{/agenda}}

## 💬 会议记录

### 讨论要点
{{#discussion_points}}
- **{{topic}}**: {{summary}}
{{/discussion_points}}

### 决议事项
{{#decisions}}
- [ ] **{{decision}}** - 负责人: {{owner}} - 截止: {{deadline}}
{{/decisions}}

### 待办事项
| 任务 | 负责人 | 截止日期 | 状态 |
|------|--------|----------|------|
{{#action_items}}
| {{task}} | {{owner}} | {{deadline}} | {{status}} |
{{/action_items}}

## 🔗 相关链接
- [[Project/{{project}}]]
- [[Tasks]]

---
*记录人: {{recorder}}*