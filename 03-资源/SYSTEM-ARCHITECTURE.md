# 🎯 Agentic OS v3.1 系统架构

## 系统入口

| 入口 | 端口 | 功能 |
|------|------|------|
| **指挥中心** | 5002 | 总控制台、任务监控、KPI仪表盘 |
| **数据面板** | 5173 | 详细任务数据、里程碑详情 |
| **TK编辑器** | 3000 | TK东南亚运营工具集 |
| **API服务** | 5001 | 后端数据接口 |

## 系统导航图

```
指挥中心 (5002)
├── 📊 数据面板 (5173)
│   ├── 任务列表
│   ├── 里程碑详情
│   └── 决策审核
│
├── 🛒 TK编辑器 (3000)
│   ├── 可视化编辑器 (editor.html)
│   ├── 仪表盘 (dashboard.html)
│   ├── 状态监控 (status.html)
│   ├── 东南亚报告 (southeast-asia-3c-report.html)
│   ├── 周报 (weekly-report.html)
│   ├── V3工作流 (v3-workflow.html)
│   ├── 账号管理 (accounts.html)
│   ├── 配置中心 (config-center.html)
│   ├── 权限管理 (permissions.html)
│   └── 视频转录 (video-transcriber.html)
│
└── 🎬 Clawith (3008)
    ├── 数字员工管理
    └── 工作流编排
```

## 页面功能详情

### TK编辑器模块

| 页面 | URL | 功能 |
|------|-----|------|
| 主页 | `/` | 模块入口 |
| 可视化编辑器 | `/editor.html` | 工作流可视化编辑 |
| 仪表盘 | `/dashboard.html` | 运营数据概览 |
| 状态监控 | `/status.html` | 服务状态 |
| 东南亚报告 | `/southeast-asia-3c-report.html` | TK东南亚3C数据报告 |
| 周报 | `/weekly-report.html` | TK运营周报 |
| V3工作流 | `/v3-workflow.html` | V3版本工作流 |
| 账号管理 | `/accounts.html` | 多账号配置 |
| 配置中心 | `/config-center.html` | 全局配置 |
| 权限管理 | `/permissions.html` | 权限控制 |
| 视频转录 | `/video-transcriber.html` | AI视频转录工具 |

## 开机自动启动

所有服务已配置LaunchAgent，重启后自动运行：
- `com.agentic-os.dashboard` (5002)
- `com.agentic-os.api` (5001)
- `com.agentic-os.web` (5173)

## 数据同步

- 任务数据: `~/.openclaw/workspace/tasks/`
- TK监控: `~/.agents/skills/proactive-operator/data/`
- 报告: `~/tk-workflow-editor/data/reports/`

---
创建时间: 2026-04-13
更新时间: 2026-04-13