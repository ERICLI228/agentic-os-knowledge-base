#!/usr/bin/env python3
"""每日自动生成日报"""
from datetime import datetime
from pathlib import Path

VAULT = Path("/Users/hokeli/knowledge-base")
today = datetime.now()
date_str = today.strftime("%Y-%m-%d")
month = today.strftime("%Y-%m")

report = f"""# 每日运营日报 {date_str}

## 📊 今日数据
- TK运营: 待更新
- Drama制作: 待更新

## 📝 今日工作
- 

## 🔜 明日计划
- [ ] 

---
*自动生成于 {today.strftime('%Y-%m-%d %H:%M:%S')}*
"""

output = VAULT / "05-每日日志" / month / f"{date_str}.md"
output.parent.mkdir(parents=True, exist_ok=True)
if output.exists():
    print(f"ℹ️ 日报已存在")
else:
    with open(output, "w") as f:
        f.write(report)
    print(f"✅ 日报已创建: {output}")
