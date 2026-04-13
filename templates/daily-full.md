---
title: "{{date}} 日报"
created: "{{date}}"
type: daily-report
tags: [daily, report]
---

# {{date}} 日报

## 📊 今日数据

### TK 东南亚运营
- **活跃任务**: {{tk_active_tasks}}
- **热门品类**: {{tk_hot_categories}}
- **告警数量**: {{tk_alerts_count}}

### Drama 制作
- **活跃任务**: {{drama_active_tasks}}
- **完成任务**: {{drama_completed_tasks}}
- **视频产出**: {{video_outputs}}

## 🔧 系统状态

### API 健康
| 提供商 | 状态 | 余额/模型数 |
|--------|------|-------------|
| 阿里云 | {{aliyun_status}} | {{aliyun_balance}} |
| SiliconFlow | {{siliconflow_status}} | {{siliconflow_models}} |
| 火山引擎 | {{volcengine_status}} | {{volcengine_balance}} |
| Ollama | {{ollama_status}} | {{ollama_models}} |

### 服务状态
- Dashboard API: {{dashboard_status}}
- Vite Dev: {{vite_status}}
- Gateway: {{gateway_status}}

## 🎬 视频工具状态
- [[Happy-Horse]]: {{happyhorse_status}}
- [[Open-Sora]]: {{opensora_status}}
- [[CogVideo]]: {{cogvideo_status}}
- [[Seedance]]: {{seedance_status}}

## 📝 今日工作日志
- {{work_log}}

## 🔜 明日计划
- [ ] {{next_action_1}}
- [ ] {{next_action_2}}
- [ ] {{next_action_3}}

## 🔗 相关链接
- [[Tasks]] - 任务列表

---
*生成时间: {{timestamp}}*