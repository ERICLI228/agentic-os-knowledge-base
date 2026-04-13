#!/usr/bin/env python3
"""TK数据自动同步到Obsidian"""
import json
from datetime import datetime
from pathlib import Path

VAULT = Path("/Users/hokeli/knowledge-base")
TK_DATA = Path("/Users/hokeli/.agents/skills/proactive-operator/data")

def sync_tk_data():
    today = datetime.now().strftime("%Y-%m-%d")
    json_files = sorted(TK_DATA.glob("tiktok_watch_*.json"))
    if not json_files:
        print("❌ 没有TK数据")
        return
    
    latest_file = json_files[-1]
    with open(latest_file) as f:
        data = json.load(f)
    
    categories = {}
    for item in data.get("videos", []):
        cat = item.get("category", "unknown")
        if cat not in categories:
            categories[cat] = []
        categories[cat].append(item)
    
    report = f"# TK品类监控 {today}\n\n"
    for cat, videos in sorted(categories.items()):
        report += f"### {cat}\n"
        top = sorted(videos, key=lambda x: x.get("views", 0), reverse=True)[:3]
        for v in top:
            title = v.get("title", "无标题")[:50]
            views = v.get("views", 0)
            report += f"- {title}: {views:,}\n"
        report += "\n"
    
    output_file = VAULT / "02-领域/TK运营/01-数据分析/品类监控" / f"{today}.md"
    output_file.parent.mkdir(parents=True, exist_ok=True)
    with open(output_file, "w") as f:
        f.write(report)
    print(f"✅ TK数据已同步")

if __name__ == "__main__":
    sync_tk_data()
