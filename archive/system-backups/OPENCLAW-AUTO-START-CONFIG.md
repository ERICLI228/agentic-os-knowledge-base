# OpenClaw 全服务开机自启动配置

> 配置时间: 2026-04-13 05:34 AM | 确保3300%服务开机正常运行

---

## ✅ 已修复问题

### 问题1: TK子页面无法打开 (404错误)

**根因**: HTTP server启动在`tk-workflow-editor`目录，而不是`public`目录

**修复**:
```bash
# 原命令 (错误)
cd ~/tk-workflow-editor && python3 -m http.server 3000

# 修正命令
cd ~/tk-workflow-editor/public && python3 -m http.server 3000
```

**验证结果**:
```
dashboard.html: HTTP/1.0 200 OK ✅
status.html: HTTP/1.0 200 OK ✅
southeast-asia-3c-report.html: HTTP/1.0 200 OK ✅
editor.html: HTTP/1.0 200 OK ✅
v3-workflow.html: HTTP/1.0 200 OK ✅
```

---

## 🚀 开机自启动配置

### 1. LaunchAgent配置文件

**位置**: `~/Library/LaunchAgents/com.openclaw.all-services.plist`

**内容**:
- 服务名称: `com.openclaw.all-services`
- 启动脚本: `~/.openclaw/scripts/start-all-services.sh`
- 触发时机: **开机自动启动** (RunAtLoad=true)
- 失败重试: KeepAlive=true

---

### 2. 全服务启动脚本

**位置**: `~/.openclaw/scripts/start-all-services.sh`

**启动服务清单**:

| 服务 | 端口 | 启动方式 | 状态 |
|------|------|----------|------|
| Dashboard API | 5001 | Python后台进程 | ✅ 开机自启动 |
| 指挥中心静态服务器 | 5002 | Python HTTP Server | ✅ 开机自启动 |
| TK编辑器静态服务器 | 3000 | Python HTTP Server | ✅ 开机自启动 (public目录) |
| 数据面板Vue服务器 | 5173 | npm run dev | ✅ 开机自启动 |
| Clawith | 3008 | bash restart.sh | ⏸️ 可选 (需PostgreSQL) |

---

### 3. 健康检查Cron任务

**任务名称**: `openclaw-health-check`

**检查频率**: 每10分钟

**检查项**:
- Dashboard API健康检查 (自动重启)
- 指挥中心服务检查 (自动重启)
- TK编辑器服务检查 (自动重启)
- 数据面板Vue检查 (需手动重启)

---

## 📋 使用方法

### 方法1: 自动启动 (推荐)

**已配置开机自启动**，无需手动操作。

验证配置:
```bash
# 查看LaunchAgent配置
cat ~/Library/LaunchAgents/com.openclaw.all-services.plist

# 查看启动脚本
cat ~/.openclaw/scripts/start-all-services.sh

# 查看健康检查脚本
cat ~/.openclaw/scripts/health-check.sh
```

---

### 方法2: 手动启动所有服务

如果服务意外停止，可手动启动:
```bash
bash ~/.openclaw/scripts/start-all-services.sh
```

输出示例:
```
═══════════════════════════════════════
  OpenClaw 全服务启动脚本
═══════════════════════════════════════

🚀 启动 Dashboard API (5001)...
  ✅ Dashboard API 启动成功 (3s)

🚀 启动 指挥中心静态服务器 (5002)...
  ✅ 指挥中心启动成功 (2s)

🚀 启动 TK编辑器静态服务器 (3000)...
  ✅ TK编辑器启动成功 (2s)

🚀 启动 数据面板Vue服务器 (5173)...
  ✅ 数据面板启动成功 (8s)
```

---

### 方法3: 健康检查

验证所有服务状态:
```bash
bash ~/.openclaw/scripts/health-check.sh
```

输出示例:
```
[健康检查] 2026-04-13 05:34:03
  ✅ Dashboard API (5001) 正常
  ✅ 指挥中心 (5002) 正常
  ✅ TK编辑器 (3000) 正常
  ✅ 数据面板Vue (5173) 正常
```

---

## 🌐 访问地址汇总

| 服务 | URL | 状态 |
|------|-----|------|
| **Dashboard API健康检查** | http://localhost:5001/api/health | ✅ 正常 |
| **指挥中心** | http://localhost:5002/ | ✅ 正常 |
| **TK运营中心** | http://localhost:5002/tk-center.html | ✅ 正常 |
| **TK编辑器首页** | http://localhost:3000/ | ✅ 正常 |
| **TK数据看板** | http://localhost:3000/dashboard.html | ✅ 正常 (已修复) |
| **TK状态页面** | http://localhost:3000/status.html | ✅ 正常 (已修复) |
| **TK东南亚报告** | http://localhost:3000/southeast-asia-3c-report.html | ✅ 正常 (已修复) |
| **数据面板Vue** | http://localhost:5173/ | ✅ 正常 |

---

## 🔧 故障排查

### 问题: TK子页面返回404

**检查**:
```bash
# 查看HTTP server工作目录
lsof -p $(pgrep -f "http.server 3000") | grep cwd
```

**预期输出**:
```
Python  PID  cwd  DIR  /Users/hokeli/tk-workflow-editor/public
```

**修复**:
```bash
# 重启TK编辑器到正确目录
pkill -f "http.server 3000"
cd ~/tk-workflow-editor/public
python3 -m http.server 3000 &
```

---

### 问题: Dashboard API未响应

**检查**:
```bash
curl http://localhost:5001/api/health
```

**修复**:
```bash
pkill -f dashboard_api_v2.py
cd ~/.openclaw/core
python3 dashboard_api_v2.py &
```

---

### 问题: Vue数据面板无法访问

**检查**:
```bash
lsof -i :5173
```

**修复**:
```bash
cd ~/agentic-os-collective/web
npm run dev -- --host 0.0.0.0 --port 5173 &
```

---

## 📂 配置文件位置

| 文件 | 位置 |
|------|------|
| **LaunchAgent配置** | `~/Library/LaunchAgents/com.openclaw.all-services.plist` |
| **启动脚本** | `~/.openclaw/scripts/start-all-services.sh` |
| **健康检查脚本** | `~/.openclaw/scripts/health-check.sh` |
| **健康检查Cron任务** | `openclaw-health-check` (每10分钟) |

---

## ✅ 配置完成清单

- ✅ TK子页面404问题已修复
- ✅ LaunchAgent开机自启动配置完成
- ✅ 全服务启动脚本已创建
- ✅ 健康检查脚本已创建
- ✅ Cron健康检查任务已配置 (每10分钟)
- ✅ 所有服务验证通过

---

**配置完成时间**: 2026-04-13 05:34 AM

**下次开机后，所有服务将自动启动运行！**

---

*文档位置: `memory/OPENCLAW-AUTO-START-CONFIG.md`*