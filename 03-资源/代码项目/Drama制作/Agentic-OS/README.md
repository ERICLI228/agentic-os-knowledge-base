# Agentic OS v3.1 指挥中心 - 完整备份

备份时间: 2026-04-12 23:52 (美国时间)

## 目录结构

```
Agentic-OS-v3.1-Complete-20260412-235200/
├── dashboard/        # 主页面 (5002端口)
│   └── index.html    # Agentic OS v3.1 指挥中心
├── web/              # 子页面 (5173端口) - 62MB
│   └── src/          # Vue前端代码
│   └── components/   # Dashboard, TaskList等组件
├── api/              # API服务 (5001端口)
│   └── dashboard_api_v2.py
├── tasks/            # 任务JSON文件
├── launchagents/     # 开机启动配置
│   ├── com.agentic-os.dashboard.plist  # 主页面自动启动
│   └── com.agentic-os.api.plist        # API自动启动
```

## 功能

### 主页面 (5002) - 指挥中心
- KPI卡片: 短剧进行中、TK运营中、待决策、总任务
- 任务列表: 显示所有活跃任务
- 筛选功能: 按项目/状态筛选
- 点击任务: 弹出详情显示所有里程碑

### 子页面 (5173) - 数据面板
- 里程碑点击弹窗
- 决策点审核
- 产出物显示
- 执行按钮

## 启动方式

### 自动启动 (已配置)
系统重启后自动运行:
- launchctl load ~/Library/LaunchAgents/com.agentic-os.dashboard.plist
- launchctl load ~/Library/LaunchAgents/com.agentic-os.api.plist

### 手动启动
```bash
# 主页面 (5002)
cd ~/.openclaw/dashboard && python3 -m http.server 5002

# 子页面 (5173)
cd ~/agentic-os-collective/web && npm run dev

# API (5001)
cd ~/.openclaw/core && python3 dashboard_api_v2.py
```

## 访问地址

- 主页面: http://localhost:5002/ (Agentic OS v3.1 指挥中心)
- 子页面: http://localhost:5173/ (数据面板)
- API: http://localhost:5001/api/dashboard

## 三备份方案

1. **本备份**: ~/Backups/Agentic-OS-v3.1-Complete-20260412-235200/
2. **Obsidian同步**: ~/knowledge-base/03-资源/代码项目/Drama制作/Agentic-OS/
3. **Git仓库**: ~/agentic-os-collective/ (已push到GitHub)

---
备份创建者: OpenClaw Agent