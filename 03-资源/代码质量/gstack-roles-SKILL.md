---
name: gstack-roles
version: 1.0.0
description: 23专家角色协作机制，基于garrytan/gstack (2万+stars)。YC CEO开发，60天600,000+行代码。
triggers:
  - 角色切换
  - CEO决策
  - 审查
  - QA
  - 发布
---

# Gstack Roles

23专家角色协作机制，基于YC CEO Garry Tan开发。

## 23专家角色清单

| 角色 | 职责 | Slash命令 |
|------|------|-----------|
| CEO | 重新思考产品 | /plan-ceo-review |
| Eng Manager | 锁定架构 | /plan-eng-review |
| Designer | 抓AI slop | /design-review |
| Reviewer | 找生产bug | /review |
| QA Lead | 打开真实浏览器 | /qa |
| Security Officer | OWASP + STRIDE审计 | /security-auditor |
| Release Engineer | 发布PR | /ship |
| Design Consultant | 设计咨询 | /design-consultation |
| Devex Reviewer | 开发体验审查 | /devex-review |
| ... | 23 specialists | /office-hours |

## 8个核心工具

| 工具 | 功能 | 使用场景 |
|------|------|---------|
| /office-hours | 描述构建内容 | 项目启动 |
| /plan-ceo-review | CEO视角审查 | 商业决策 |
| /review | 变更审查 | 代码审查 |
| /qa | staging QA测试 | 上线前测试 |
| /ship | 发布PR | 发布流程 |
| /browse | 浏览器浏览 | Web测试 |
| /retro | 回顾总结 | 项目复盘 |
| /investigate | 问题调查 | Bug调查 |

## 角色协作流程

```
需求启动
    ↓
/office-hours → 描述构建内容
    ↓
/plan-ceo-review → CEO视角商业决策
    ↓
/plan-eng-review → Eng Manager技术决策
    ↓
/design-review → Designer UI审查
    ↓
/review → Reviewer代码审查
    ↓
/qa → QA Lead浏览器测试
    ↓
/security-auditor → Security Officer安全审计
    ↓
/ship → Release Engineer发布PR
    ↓
/retro → 回顾总结
```

## 强制执行清单

| 检查项 | 角色 | 标准 |
|--------|------|------|
| 商业可行性 | CEO | ROI > 20% |
| 技术可行性 | Eng Manager | 架构清晰 |
| UI质量 | Designer | 无AI slop |
| 代码质量 | Reviewer | 无生产bug |
| 功能测试 | QA Lead | 浏览器测试通过 |
| 安全合规 | Security Officer | OWASP + STRIDE |
| 发布流程 | Release Engineer | PR发布 |

## 支持两大目标

### TK运营

- 选品决策 → /plan-ceo-review（CEO视角）
- 技术方案 → /plan-eng-review（Eng Manager视角）
- Dashboard质量 → /design-review（Designer视角）
- 代码审查 → /review（Reviewer视角）
- 功能测试 → /qa（QA Lead视角）
- API安全 → /security-auditor（Security Officer视角）
- 发布上线 → /ship（Release Engineer视角）

### Drama制作

- 剧本商业价值 → /plan-ceo-review（CEO视角）
- 技术架构 → /plan-eng-review（Eng Manager视角）
- 界面设计 → /design-review（Designer视角）
- 剧本审查 → /review（Reviewer视角）
- 功能测试 → /qa（QA Lead视角）
- 合规扫描 → /security-auditor（Security Officer视角）
- 批量发布 → /ship（Release Engineer视角）

---

*来源: garrytan/gstack (2万+stars)*
*开发: Garry Tan（YC CEO）*
*集成时间: 2026-04-13 10:35 PDT*
