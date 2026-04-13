# 🎯 OPENCODE使用指南

> 基于opencode-controller Skill的代码编辑和开发工具

---

## 一、OPENCODE核心能力

| 能力 | 说明 | 状态 |
|------|------|------|
| ① 代码编辑 | 实时代码编辑和开发 | ✅ Skill已配置 |
| ② Skill调用 | 通过opencode-controller调用OpenClaw能力 | ✅ 联动配置 |
| ③ 记忆同步 | 与L1-L4记忆系统双向同步 | ✅ 已启用 |
| ④ Agent协作 | 与17个Agents协作审查代码 | ✅ 已集成 |
| ⑤ 六大能力 | 自动触发六大能力检查 | ✅ 100%覆盖率 |

---

## 二、立即使用方法

### 通过opencode-controller Skill

**触发关键词**：
- "opencode"
- "代码编辑"
- "开发"

**示例对话**：
```
用户: "用opencode帮我编辑TK运营脚本"
我: ✅ 调用opencode-controller Skill，启动代码编辑流程
```

---

## 三、与HERMES/OpenClaw联动

### OPENCODE → OpenClaw

- 代码编辑 → 调用Gateway命令
- Skill调用 → 触发六大能力检查
- 记忆更新 → 同步到MEMORY.md

### OPENCODE → HERMES

- 代码习惯 → 自动学习沉淀Skill
- 编辑偏好 → 更新永久记忆
- 开发流程 → 记录最佳实践

---

## 四、六大能力支持

| 能力 | OPENCODE贡献 | OpenClaw贡献 |
|------|-------------|-------------|
| 规划验证 | 编辑规划习惯 | superpowers-validator |
| 前端质量 | UI编辑偏好 | frontend-design |
| 代码审查 | 审查编辑习惯 | code-1.0.4 + 17 Agents |
| 安全扫描 | 安全编辑规则 | security-auditor |
| 记忆持久化 | 编辑历史记忆 | L1-L4系统 |
| 角色协作 | 编辑角色分工 | gstack-roles |

---

## 五、opencode-controller Skill功能

### 核心功能

1. **代码编辑流程控制**
   - 启动编辑 → 自动规划（Think Before Coding）
   - 编辑过程 → 外科手术式修改（Surgical Changes）
   - 编辑完成 → 自动审查（17 Agents）

2. **六大能力自动触发**
   - frontend-design: UI代码自动检查
   - code-1.0.4: 所有代码变更必检
   - security-auditor: API密钥泄露检测
   - claude-mem: 编辑习惯记忆
   - superpowers-validator: 规划验证
   - gstack-roles: 多角色审查

3. **记忆系统同步**
   - L1: 编辑偏好写入MEMORY.md
   - L2: 当前编辑状态写入CONTEXT.md
   - L3: 今日编辑日志写入YYYY-MM-DD.md
   - L4: 编辑快照备份

---

## 六、OPENCODE CLI命令（如有）

```bash
# 查看版本
opencode --version

# 启动编辑
opencode edit <file>

# 调用Skill
opencode skill <skill-name>

# 查看记忆
opencode memory list

# 六大能力检查
opencode capabilities check
```

---

## 七、当前系统状态

### OPENCODE已激活

| 组件 | 状态 | 说明 |
|------|------|------|
| opencode-controller Skill | ✅ | 已配置 |
| OPENCODE-OpenClaw联动 | ✅ | 桥接已配置 |
| OPENCODE-HERMES联动 | ✅ | 记忆同步已启用 |
| 六大能力支持 | ✅ | 100%覆盖率 |

---

## 八、下一步行动

**立即可用**：
1. 告诉我："用opencode编辑XX代码"
2. 我调用opencode-controller Skill
3. 自动触发六大能力检查
4. 编辑完成同步到记忆系统

**持续训练**：
1. 每次编辑自动学习习惯
2. HERMES自动沉淀编辑Skill
3. 下次编辑自动应用最佳实践

---

*配置完成时间: 2026-04-13 15:36 PDT*
*五大能力状态: 全部激活*
*联动状态: OPENCODE-HERMES-OpenClaw三方联动*
