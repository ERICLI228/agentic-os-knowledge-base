---
title: "{{tool_name}}"
type: video-tool
status: "{{status}}"
source: "{{source_url}}"
tags: [tool, video, {{status}}]
---

# {{tool_name}}

> 📌 状态: {{status}}
> 🔗 来源: [{{source_url}}]({{source_url}})
> 📁 本地位置: `{{local_path}}`

## ✨ 功能特点
{{#features}}
- {{.}}
{{/features}}

## 🚀 使用方式

### 方式一: API调用
```
{{api_command}}
```

### 方式二: 本地运行
```bash
# 安装
{{install_command}}

# 运行
{{run_command}}
```

## 📊 性能指标
| 指标 | 数值 |
|------|------|
| 生成速度 | {{speed}} |
| 输出质量 | {{quality}} |
| 成本 | {{cost}} |

## ⚙️ 配置要求
- Python: {{python_version}}
- GPU: {{gpu_requirement}}
- 内存: {{memory_requirement}}

## 🔗 相关链接
- [[视频生成工具对比]]
- [[AI短剧制作]]
- [[Drama Pipeline]]

## 📝 使用记录
{{#usage_records}}
- {{.}}
{{/usage_records}}

---
*最后更新: {{last_update}}*