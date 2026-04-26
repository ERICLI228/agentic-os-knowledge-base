---
title: "weekly-health-report-2026-04-20"
created: 2026-04-24
updated: 2026-04-24
tags: [架构/业务]
status: draft
---
# 📊 OpenClaw 系统周度健康报告

**报告周期:** 2026-04-14 至 2026-04-20  
**生成时间:** 2026-04-20 03:02 UTC (周一 09:02 中国时间)  
**系统版本:** OpenClaw 2026.4.14 (323493f)

---

## 🚨 关键告警 (Critical Issues)

### 1. 阿里云 API 网络连接问题 ⚠️ 严重

**状态:** 持续失败  
**影响范围:** 所有阿里云模型 (qwen3.5-plus, qwen3-max, glm-5)  
**错误类型:** `LLM request failed: network connection error (timeout)`

**最近失败记录:**
- `tk-sea-3c-monitor` Cron 任务 (08:00 中国时间) - 连续 3 个模型超时
- `daily-report-8groups` Cron 任务 - 仅 1/8 群组发送成功
- `auto-backup-and-sync` Cron 任务 - 执行超时 (300s)

**建议操作:**
1. 检查阿里云 API Key 是否有效: `rotL1VtYWRQ33sm5cIrEtF0U4vZnSO`
2. 验证本地网络到阿里云 API 端点的连通性
3. 考虑切换到 SiliconFlow 备用通道 (MiniMax-M2.5)

---

### 2. 飞书群组权限配置不完整 ⚠️ 中等

**问题:** 每日日报仅能发送到 1/8 目标群组

**可访问群组:**
- ✅ 运营指挥部

**无法访问群组 (7 个):**
- ❌ 选品作战室
- ❌ 数据看板
- ❌ 达人运营
- ❌ 订单中心
- ❌ 广告指挥室
- ❌ 内容工坊
- ❌ 客服中心
- ❌ 技术研发 ← **本周报告目标群组**

**解决方案:**
1. 将飞书应用机器人邀请入所有 8 个群组
2. 确认应用具有 `im:message:send_as_bot` 权限
3. 更新 cron/jobs.json 中的群组 ID 配置

---

### 3. Gateway 安全警告 ⚠️ 低

**警告内容:** `gateway.controlUi.allowInsecureAuth=true`

**建议:** 运行 `openclaw security audit` 审查安全配置

---

## 📈 系统资源状态

### 磁盘使用
| 分区 | 已用 | 总量 | 使用率 |
|------|------|------|--------|
| 系统盘 (/) | 12Gi | 926Gi | 3% ✅ |

### 工作区目录 (Top 10 by Size)
| 目录 | 大小 |
|------|------|
| workspace-daily | 132K |
| workspace-vision | 116K |
| workspace-complex | 116K |
| workspace-coder | 116K |
| workspace-agent | 116K |
| workspace-product_scout | 80K |
| workspace-qwen-main | 44K |
| workspace-qwen-coder | 44K |
| workspace-code_developer | 40K |
| workspace-strategy_director | 36K |

**总计:** 69 个独立工作区目录

---

## 📝 内存系统状态

### 每日日志文件 (memory/*.md)
- **文件总数:** 16 个 (2026-03-28 至 2026-04-19)
- **最早文件:** 2026-03-28 (23 天前)
- **最近文件:** 2026-04-19 (昨日)
- **过期文件 (>14 天):** 0 个 ✅

### 会话快照 (memory/snapshots/)
- **快照总数:** 48 个
- **会话备份:** 11 个
- **上下文备份:** 11 个
- **MEMORY 备份:** 11 个
- **Task 备份:** 11 个
- **过期快照 (>30 天):** 0 个 ✅

### 待办事项
- TODO-PENDING.md: 存在
- TODO-2026-04-19.md: 存在

---

## ⏰ Cron 任务状态

| 任务名称 | 调度 | 状态 | 最后运行 | 错误 |
|----------|------|------|----------|------|
| tk-sea-3c-monitor | 每 8 小时 | ❌ 失败 | 08:04 中国时间 | 网络超时 |
| daily-report-8groups | 每日 09:00 | ⚠️ 部分成功 | 01:00 中国时间 | 飞书权限 |
| auto-backup-and-sync | 每日 03:00 | ❌ 超时 | 03:00 中国时间 | 执行超时 |
| weekly-token-cleanup | 每周一 09:00 | 🔄 运行中 | - | - |

---

## 📊 日志文件状态

| 日志文件 | 大小 | 最后修改 |
|----------|------|----------|
| gateway.log | 938K | 20:03 |
| gateway.err.log | 232K | 20:03 |
| sync.log | 23K | 17:45 |
| health.log | 5.3K | 17:40 |
| userscript-server.log | 0B | 06:01 |

**错误日志摘要:**
- 主要错误: 阿里云 API 连接超时 (反复出现)
- 次要错误: 飞书消息发送失败
- 安全警告: Gateway 不安全配置标志

---

## 🔑 API Key 状态

### 已配置服务
| 服务 | 状态 | 备注 |
|------|------|------|
| 阿里云 (Aliyun) | ⚠️ 网络问题 | API Key 已配置 |
| SiliconFlow | ✅ 备用 | MiniMax-M2.5 可用 |
| Ollama (本地) | ✅ 正常 | GEMMA4:26b, qwen3:8b |
| EverOS MemorySpace | ✅ 已配置 | L0 云端存储 |
| Paperclip | ✅ 已声明 | pcp_a47b4032... |

### 用量追踪
⚠️ **注意:** 本周无法获取阿里云 API 用量数据 (网络连接失败)

---

## 🧹 清理建议

### 本周执行清理
1. ✅ 检查过期会话数据 - 无过期文件
2. ✅ 检查快照文件 - 无过期文件 (均 <30 天)
3. ✅ 磁盘空间充足 - 无需清理

### 建议保留策略
- 每日日志: 保留 30 天
- 会话快照: 保留 60 天
- 备份文件: 保留 90 天

---

## 📋 待办事项 (Action Items)

### 高优先级 🔴
1. **修复阿里云 API 连接问题**
   - 检查 API Key 有效性
   - 测试网络连通性
   - 考虑切换到 SiliconFlow

2. **修复飞书群组权限**
   - 邀请机器人到 7 个缺失群组
   - 验证应用权限配置
   - 更新群组 ID 映射

### 中优先级 🟡
3. **优化 Cron 任务超时设置**
   - auto-backup-and-sync 任务超时 (300s 不足)
   - 考虑增加到 600s 或优化备份逻辑

4. **审查 Gateway 安全配置**
   - 运行 `openclaw security audit`
   - 禁用 `allowInsecureAuth` 标志

### 低优先级 🟢
5. **归档旧日志文件**
   - gateway.log 接近 1MB 可考虑轮转
   - 配置日志轮转策略

---

## 📞 技术支持

**系统管理员:** Hokeli  
**文档位置:** `~/.openclaw/workspace/`  
**备份位置:** `~/Backups/OpenClaw/`  
**最新备份:** 2026-04-09 (11 天前)

---

*报告由 OpenClaw 周度 Token 优化检查自动生成*
