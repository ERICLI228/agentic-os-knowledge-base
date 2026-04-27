---
title: "Agent Skill — Shipping and Launch"
date_created: 2026-04-27
date_modified: 2026-04-27
summary: "发布前扇出审查——并行运行三个专家角色，做出 GO/NO-GO 决策并附回滚计划"
type: concept
status: final
tags: [开发工具, 发布, launch, 安全]
---

# Agent Skill — Shipping and Launch (`/ship`)

## 触发词

`/ship`、"发布"、"上线"、"部署到生产"、"准备 launch"、"发版检查"

## 核心原则

**没有回滚计划的发布就是赌博。任何 GO 决策前必须有回滚计划。**

## 执行流程

### Phase A: 并行扇出（三个专家角色同时审查）

| 角色 | 职责 |
|------|------|
| **Code Reviewer** | 五轴审查（正确性、可读性、架构、安全、性能） |
| **Security Auditor** | OWASP Top 10、密钥处理、CVE 扫描 |
| **Test Engineer** | 正常路径、边界情况、错误路径、并发场景覆盖率 |

### Phase B: 主上下文合并

综合三个报告，检查代码质量、安全、性能、基础设施、文档。

### Phase C: 决策和回滚

输出单一决策文档：

```markdown
## Ship Decision: GO | NO-GO

### Blockers（必须修复才能发布）
- [来源角色: Critical 发现 + file:line]

### Recommended fixes（发布前应该修复）
- [来源角色: Important 发现 + file:line]

### Rollback plan
- Trigger conditions: [什么信号触发回滚]
- Rollback procedure: [确切步骤]
- Recovery time objective: [目标时间]
```

## 跳过扇出的条件（必须全部满足）

- 改动 ≤ 2 个文件
- diff ≤ 50 行
- 不涉及 auth、支付、数据访问、配置/环境变量

## 发布前检查清单

- [ ] 所有测试通过（单元、集成、E2E）
- [ ] 构建成功，无错误
- [ ] Lint 通过，无警告
- [ ] 数据库迁移已测试（含回滚迁移）
- [ ] Feature Flag 已配置
- [ ] 环境变量已设置
- [ ] 监控和告警已配置
- [ ] 文档已更新（README、Changelog、ADRs）
- [ ] 回滚计划已制定并测试

## 红旗信号 🚩

- 没有并行审查就直接 GO
- 没有回滚计划就发布
- Critical 安全发现被忽略
- 跳过可访问性检查
- 数据库迁移没有回滚方案

## 相关

- 上游：[[review]] ← 单独运行五轴审查
- 工作流终点：所有代码审查完成后
- 来源：`~/.agents/skills/agent-skills-ship/SKILL.md`
- 工作流索引：[[README]]
