# 🎯 API路由规划方案

> 基于两大目标 + 行业最佳实践 + 高效高性价比

---

## 一、核心路由规划

### 1.1 基础健康路由（已有）

| 路由 | 方法 | 功能 | 状态 |
|------|------|------|------|
| `/api/health` | GET | 系统健康检查 | ✅ 已有 |
| `/api/dashboard` | GET | Dashboard数据 | ✅ 已有 |

---

### 1.2 任务管理路由（核心）

| 路由 | 方法 | 功能 | 状态 | 优先级 |
|------|------|------|------|--------|
| `/api/tasks` | GET | 任务列表 | ✅ 已添加 | P0 |
| `/api/task/<task_id>` | GET | 任务详情 | ✅ 已添加 | P0 |
| `/api/tasks/create` | POST | 创建任务 | ✅ 已有 | P0 |
| `/api/tasks/<task_id>/milestone/<milestone_id>` | GET | 里程碑详情 | ✅ 已有 | P0 |
| `/api/tasks/<task_id>/execute/<milestone_id>` | POST | 执行里程碑 | ✅ 已有 | P1 |

---

### 1.3 TK运营专用路由（新增）

| 路由 | 方法 | 功能 | 优先级 |
|------|------|------|--------|
| `/api/tk/products` | GET | 选品洞察数据 | P0 |
| `/api/tk/competitors` | GET | 竞品分析数据 | P0 |
| `/api/tk/trending` | GET | 飙升词数据 | P0 |
| `/api/tk/orders` | GET | 订单同步数据 | P1 |
| `/api/tk/inventory` | GET | 库存预警数据 | P1 |
| `/api/tk/roas` | GET | ROAS监控数据 | P1 |

---

### 1.4 Drama制作专用路由（新增）

| 路由 | 方法 | 功能 | 优先级 |
|------|------|------|--------|
| `/api/drama/scripts` | GET | 剧本列表 | P0 |
| `/api/drama/script/<script_id>` | GET | 剧本详情 | P0 |
| `/api/drama/characters` | GET | 角色配置 | P0 |
| `/api/drama/generate` | POST | 生成剧本 | P0 |
| `/api/drama/voice` | POST | 生成配音 | P1 |
| `/api/drama/video` | POST | 生成视频 | P1 |

---

### 1.5 决策处理路由（已有）

| 路由 | 方法 | 功能 | 状态 |
|------|------|------|------|
| `/api/decision/<task_id>/<decision_id>` | POST | 提交决策 | ✅ 已有 |
| `/api/decision/submit` | POST | 决策提交 | ✅ 已有 |
| `/api/tasks/<task_id>/pending-decisions` | GET | 待处理决策 | ✅ 已有 |

---

### 1.6 文件管理路由（已有）

| 路由 | 方法 | 功能 | 状态 |
|------|------|------|------|
| `/api/download` | GET | 文件下载 | ✅ 已有 |
| `/api/templates` | GET | 模板列表 | ✅ 已有 |
| `/api/templates/<template_id>` | GET | 模板详情 | ✅ 已有 |

---

## 二、行业最佳实践原则

### 2.1 RESTful设计原则

- ✅ 资源命名清晰（/api/tk/products）
- ✅ 方法语义明确（GET查询，POST创建）
- ✅ 返回格式统一（JSON + HTTP状态码）
- ✅ 错误处理规范（404/500 + error message）

---

### 2.2 版本控制原则

- 推荐格式：`/api/v1/tasks`（未来扩展）
- 当前：直接使用 `/api/tasks`（单版本）

---

### 2.3 性能优化原则

- ✅ 数据分页（limit/offset参数）
- ✅ 缓存策略（Redis/内存缓存）
- ✅ 异步处理（耗时操作异步返回）

---

## 三、OPENCODE集成配置

### 3.1 opencode-controller配置

```yaml
# ~/.openclaw/opencode-controller-config.yaml
api_endpoints:
  base_url: http://localhost:5001
  gateway_url: http://localhost:18789
  
  task_management:
    list: /api/tasks
    detail: /api/task/{task_id}
    create: /api/tasks/create
    milestone: /api/tasks/{task_id}/milestone/{milestone_id}
  
  tk_operations:
    products: /api/tk/products
    competitors: /api/tk/competitors
    trending: /api/tk/trending
  
  drama_production:
    scripts: /api/drama/scripts
    generate: /api/drama/generate
    voice: /api/drama/voice
  
  file_operations:
    download: /api/download

skills_mapping:
  tk-operator: ~/.agents/skills/proactive-operator/
  drama-producer: ~/.openclaw/skills/water-margin-drama/
  seedance-video: ~/.openclaw/skills/seedance2/
  macos-voice: /usr/bin/say
```

---

## 四、实际调用示例

### 4.1 TK运营调用流程

```python
# OPENCODE调用TK运营API
import requests

# 1. 查询任务列表
tasks = requests.get("http://localhost:5001/api/tasks").json()

# 2. 获取选品数据
products = requests.get("http://localhost:5001/api/tk/products").json()

# 3. 获取飙升词
trending = requests.get("http://localhost:5001/api/tk/trending").json()

# 4. 下载分析报告
file = requests.get("http://localhost:5001/api/download?name=tk_report.pdf")
```

---

### 4.2 Drama制作调用流程

```python
# OPENCODE调用Drama制作API
import requests

# 1. 查询剧本列表
scripts = requests.get("http://localhost:5001/api/drama/scripts").json()

# 2. 生成新剧本
new_script = requests.post("http://localhost:5001/api/drama/generate", 
    json={"title": "武松打虎第4集", "characters": ["武松", "老虎"]})

# 3. 生成配音
voice = requests.post("http://localhost:5001/api/drama/voice",
    json={"script_id": "wusong_ep04", "voice_type": "macos_say"})
```

---

## 五、下一步实施

1. ✅ 基础路由已配置（6个API可用）
2. ⏳ TK专用路由待添加（6个路由）
3. ⏳ Drama专用路由待添加（6个路由）
4. ✅ OPENCODE集成配置已准备

---

*规划时间: 2026-04-13 16:15 PDT*
