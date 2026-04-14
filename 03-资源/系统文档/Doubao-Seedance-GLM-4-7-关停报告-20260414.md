# 🚨 Doubao-Seedance 和 GLM-4.7 模型关停报告

> **2026-04-14 01:21 PDT | 用户紧急请求**

---

## ✅ 已完成关停操作

### 1. Gateway配置禁用

**文件**: `~/.openclaw/openclaw.json`

**修改**:
```json
"volcengine/glm-4-7": {
  "alias": "🔥 GLM-4.7 (火山引擎免费) - 已禁用",
  "disabled": true
}
```

---

### 2. Seedance 2.0 禁用

**文件**: `~/.openclaw/skills/seedance2/seedance.py`

**修改**:
```python
DEFAULT_MODEL = "disabled-doubao-seedance"  # 已禁用
# 原配置: doubao-seedance-2-0-260128（已关停）
```

**模型**: `doubao-seedance-2-0-260128` ✅ 已禁用

---

### 3. GLM-4.7 禁用（5个文件）

| 文件 | 原模型 | 状态 |
|------|-------|------|
| `drama_script.py` | `glm-4-7-251222` | ✅ 已禁用 |
| `controversy_rewriter.py` | `glm-4-7-251222` | ✅ 已禁用 |
| `script_selector.py` | `glm-4-7-251222` | ✅ 已禁用 |
| `water_margin_drama.py` | `glm-4-7-251222` | ✅ 已禁用 |
| `drama_script_optimized.py` | `glm-4-7-251222` | ✅ 已禁用 |

**修改内容**:
```python
GLM_MODEL = "disabled-glm-4-7"  # 已禁用
# 原配置: glm-4-7-251222（已关停）
```

---

### 4. 进程检查

**正在运行的进程**: ✅ 无相关进程

```
seedance.py → 已检查，无进程运行
drama_script → 已检查，无进程运行
```

---

## 📊 API端点禁用状态

| API端点 | 模型 | 状态 |
|--------|------|------|
| `https://ark.cn-beijing.volces.com/api/v3/responses` | GLM-4.7 | ✅ 已禁用 |
| `https://ark.cn-beijing.volces.com/api/v3/chat/completions` | GLM-4.7 | ✅ 已禁用 |
| 火山引擎视频生成API | Doubao-Seedance | ✅ 已禁用 |

---

## ⚠️ 影响范围

**已禁用的功能**:

| 功能 | 原模型 | 状态 |
|------|-------|------|
| **剧本生成** | GLM-4.7 | ⏸ 已暂停 |
| **争议剧情改写** | GLM-4.7 | ⏸ 已暂停 |
| **剧本选择** | GLM-4.7 | ⏸ 已暂停 |
| **视频生成** | Doubao-Seedance | ⏸ 已暂停 |

---

## 🔧 替代方案

### GLM-4.7 替代模型

**推荐替代**:
| 替代模型 | 来源 | 状态 |
|---------|------|------|
| `aliyun/glm-5` | 阿里云 | ✅ 可用 |
| `aliyun/kimi-k2.5` | 阿里云 | ✅ 可用 |
| `ollama/qwen3.5:35b-a3b` | 本地 | ✅ 可用 |

---

### Seedance 替代方案

**推荐替代**:
| 替代方案 | 来源 | 状态 |
|---------|------|------|
| MiniMax Hailuo | 免费(每日5条) | ⏳ 待申请 |
| Google Veo | 免费(每24h9次) | ✅ 可用 |
| Wan 2.2 | 自托管 | ⏳ 待部署 |

---

## 💡 下一步操作

**如需恢复使用**:
1. 移除 `"disabled": true` 标记
2. 修改 GLM_MODEL 为原模型ID
3. 重启相关服务

**如需使用替代模型**:
1. 修改 `GLM_MODEL` 为替代模型ID
2. 配置对应API Key
3. 测试调用成功

---

*关停时间: 2026-04-14 01:21 PDT*
*用户请求: 立即关停 Doubao-Seedance 和 GLM-4.7 模型接口调用*