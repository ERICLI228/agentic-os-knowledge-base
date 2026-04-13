# 🎯 OPENCODE立即可用方案

> 无需CLI安装，通过opencode-controller Skill直接调用

---

## 问题解决

**用户反馈**: "API用不了"

**根本原因**: OPENCODE CLI未找到npm包

**解决方案**: 通过opencode-controller Skill + Gateway API调用

---

## 立即可用方法

**无需安装CLI，直接通过对话调用**：

```
用户: "用opencode编辑TK运营脚本"
我: ✅ 调用opencode-controller Skill
    ✅ 执行Plan→Build流程
    ✅ 通过Gateway API返回结果
```

---

## API端点（已验证可用）

| 端点 | URL | 状态 |
|------|-----|------|
| 健康检查 | http://localhost:5001/api/health | ✅ OK |
| 任务列表 | http://localhost:5001/api/tasks | ✅ OK |
| 任务详情 | http://localhost:5001/api/task/<task_id> | ✅ OK |
| 里程碑 | http://localhost:5001/api/tasks/<task_id>/milestone/<milestone_id> | ✅ OK |
| 文件下载 | http://localhost:5001/api/download?name=<filename>&path=<path> | ✅ OK |

---

## opencode-controller工作方式

**核心规则**:
```
Clawdbot does not write code.
All planning and coding happens inside Opencode.
```

**执行流程**:
1. `/sessions` - 选择会话
2. `/agents` - 切换Plan/Build
3. `/models` - 选择模型
4. Plan分析 → Build实现 → 自动审查

---

## 与六大能力联动

| 能力 | 触发时机 |
|------|---------|
| superpowers-validator | Plan阶段规划验证 |
| frontend-design | UI代码自动检查 |
| code-1.0.4 | Build完成代码审查 |
| security-auditor | API密钥检测 |
| claude-mem | 编辑习惯记忆 |
| gstack-roles | Plan→Build角色分工 |

---

## 当前系统状态

| 组件 | 状态 | 说明 |
|------|------|------|
| Gateway | ✅ live | 端口18789 |
| Dashboard API | ✅ OK | 端口5001 |
| opencode-controller Skill | ✅ 已配置 | 无需CLI |
| 六大能力 | ✅ 100% | 自动触发 |

---

## 下一步

**立即可用**：
- 说："用opencode编辑XX代码"
- 我调用Skill执行，无需CLI安装

---

*更新时间: 2026-04-13 15:38 PDT*
