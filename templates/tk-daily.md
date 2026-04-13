---
title: "TK日报 - {{date:YYYY-MM-DD}}"
date: {{date:YYYY-MM-DD}}
type: daily-report
tags: [tk, daily]
---

# TK日报 {{date:YYYY-MM-DD}}

## 📊 今日数据

### 店铺概况
| 指标 | 数值 | 环比 |
|------|------|------|
| GMV | {{gmv}} | {{gmv_change}} |
| 订单数 | {{orders}} | {{orders_change}} |
| 客单价 | {{aov}} | {{aov_change}} |
| 退款率 | {{refund_rate}} | {{refund_change}} |

### 分国家数据
| 国家 | GMV | 订单 | 占比 |
|------|-----|------|------|
| 🇮🇩 印尼 | {{id_gmv}} | {{id_orders}} | {{id_pct}} |
| 🇹🇭 泰国 | {{th_gmv}} | {{th_orders}} | {{th_pct}} |
| 🇻🇳 越南 | {{vn_gmv}} | {{vn_orders}} | {{vn_pct}} |
| 🇵🇭 菲律宾 | {{ph_gmv}} | {{ph_orders}} | {{ph_pct}} |
| 🇲🇾 马来西亚 | {{my_gmv}} | {{my_orders}} | {{my_pct}} |

### 品类表现
{{top_products}}

## 🎬 内容数据
- 视频发布: {{videos_published}}
- 总播放量: {{total_views}}
- 转化率: {{video_cvr}}

## ⚠️ 问题与风险
{{issues}}

## ✅ 明日计划
- [ ] {{plan_1}}
- [ ] {{plan_2}}
- [ ] {{plan_3}}