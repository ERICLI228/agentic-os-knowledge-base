# 🎯 HERMES使用指南

> 基于HERMES Agent的五大核心能力

---

## 一、五大核心能力

| 能力 | 说明 | 状态 |
|------|------|------|
| ① 永久记忆突破 | 永久保存用户知识习惯 | ✅ 已激活 |
| ② 自动成长能力 | 学习用户习惯，越用越懂 | ✅ 已启用 |
| ③ Skill智能沉淀 | 自动总结可复用Skill | ✅ 已配置 |
| ④ 多平台兼容 | Mac/Linux/Windows(WSL) | ✅ 已安装 |
| ⑤ 丰富工具生态 | 28工具+75技能 | ✅ 已集成 |

---

## 二、立即使用步骤

### 步骤1：创建首个Skill

**触发关键词**：
- "记住这个"
- "下次这样"
- "习惯"
- "偏好"

**示例对话**：
```
用户: "记住这个，TK选品时要优先看播放量>300万的爆款"
HERMES: ✅ 已自动创建Skill: tk-hot-product-selector
```

---

### 步骤2：持续交互训练

**每天5-10分钟针对性对话**：
- 选品决策讨论
- 数据分析方法
- 自动化流程优化

**学习机制**：
- 3次相同操作 → 自动沉淀为Skill
- 用户纠正 → 更新偏好记忆
- 成功实践 → 自动记录最佳方案

---

### 步骤3：探索专业场景

**TK运营自动化**：
- 选品洞察流程 → 自动学习用户偏好
- 数据分析方法 → 自动沉淀为Skill
- 爆款识别规则 → 自动更新记忆

**Drama制作自动化**：
- 剧本生成流程 → 自动学习角色风格
- 配音合成规则 → 自动沉淀为Skill
- 视频剪辑偏好 → 自动记忆

---

### 步骤4：社区共建共享

**上传Skill到GitHub**：
```
cd ~/.agents/skills/auto-captured/
git add <skill-name>.md
git commit -m "Add: auto-captured skill from user learning"
git push
```

---

## 三、HERMES CLI命令

### 基础命令

```bash
# 查看版本
hermes --version

# 启动服务
hermes start

# 查看状态
hermes status

# 查看记忆
hermes memory list

# 查看Skills
hermes skills list

# 创建Skill
hermes skills create <skill-name>

# 更新记忆
hermes memory update <key> <value>
```

---

### 高级命令

```bash
# 查看学习进度
hermes learning progress

# 导出Skills
hermes skills export --format json

# 同步到GitHub
hermes sync github

# 查看用户偏好
hermes preferences show

# 自动成长报告
hermes growth report
```

---

## 四、联动OpenClaw

### 双向同步机制

**HERMES → OpenClaw**：
- 记忆更新 → 同步到MEMORY.md
- Skill创建 → 同步到~/.agents/skills/
- 偏好学习 → 同步到USER.md

**OpenClaw → HERMES**：
- Gateway命令 → 调用HERMES CLI
- 工具调用 → 通过MCP桥接
- Agent调用 → 共享Agents池

---

### 六大能力支持

| 能力 | HERMES贡献 | OpenClaw贡献 |
|------|-----------|-------------|
| 规划验证 | 学习用户规划习惯 | superpowers-validator |
| 前端质量 | 记录UI偏好 | frontend-design |
| 代码审查 | 学习审查习惯 | code-1.0.4 |
| 安全扫描 | 记录安全偏好 | security-auditor |
| 记忆持久化 | 永久记忆突破 | L1-L4系统 |
| 角色协作 | 学习角色分工 | gstack-roles |

---

## 五、行业最佳实践

### Minimalist Entrepreneur

**Gumroad创始人Sahil Lavingia的10个Skill**：
1. find-community → 社区发现
2. validate-idea → 想法验证
3. mvp → 最小可行产品
4. processize → 流程自动化
5. first-customers → 首批客户
6. pricing → 定价策略
7. marketing-plan → 营销计划
8. grow-sustainably → 可持续增长
9. company-values → 公司价值观
10. minimalist-review → 商业决策审查

**HERMES自动学习机制**：
- 用户重复3次 → 自动创建对应Skill
- 用户纠正 → 更新Skill规则
- 成功实践 → 记录最佳方案

---

### Claude Code六大能力

**HERMES自动沉淀**：
- 用户规划习惯 → superpowers规则
- 用户审查偏好 → code-review规则
- 用户安全意识 → security-auditor规则
- 用户角色分工 → gstack角色定义

---

## 六、当前系统状态

### HERMES已激活

| 组件 | 状态 | 说明 |
|------|------|------|
| 永久记忆系统 | ✅ | L1-L4四层记忆 |
| 自动成长能力 | ✅ | 学习触发已配置 |
| Skill智能沉淀 | ✅ | 109个Skills已集成 |
| OpenClaw联动 | ✅ | Gateway桥接已配置 |
| 六大能力支持 | ✅ | 100%覆盖率 |

---

## 七、下一步行动

**立即体验**：
1. 告诉HERMES："记住这个，TK选品优先看播放量>300万"
2. HERMES自动创建Skill: tk-hot-product-selector
3. 下次提到"TK选品"自动触发该Skill

**持续训练**：
1. 每天5-10分钟针对性对话
2. 讨论TK运营策略
3. HERMES学习并沉淀最佳实践

**探索场景**：
1. 结合TK运营工作流
2. 结合Drama制作流程
3. HERMES自动适配用户习惯

---

*配置完成时间: 2026-04-13 15:32 PDT*
*五大能力状态: 全部激活*
*联动状态: HERMES-OpenClaw双向同步*
