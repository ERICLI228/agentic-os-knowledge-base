#!/usr/bin/env python3
"""Drama产出自动归档"""
import json
from datetime import datetime
from pathlib import Path

VAULT = Path("/Users/hokeli/knowledge-base")
TASKS_DIR = Path("/Users/hokeli/.openclaw/workspace/tasks/active")

def sync_drama():
    today = datetime.now().strftime("%Y-%m-%d")
    records = []
    for f in TASKS_DIR.glob("DRAMA-*.json"):
        with open(f) as fp:
            task = json.load(fp)
        for ms in task.get("milestones", []):
            if ms.get("status") == "completed":
                records.append(f"### {task['id']} - {ms.get('id')}\n- 类型: {ms.get('output_type')}\n- 名称: {ms.get('name')}\n")
    
    if not records:
        print("ℹ️ 没有新产出")
        return
    
    report = f"# Drama产出记录 {today}\n\n" + "\n".join(records)
    output = VAULT / "02-领域/Drama制作/03-产出库" / f"{today}.md"
    output.parent.mkdir(parents=True, exist_ok=True)
    with open(output, "w") as f:
        f.write(report)
    print(f"✅ Drama产出已同步 {len(records)}条")

if __name__ == "__main__":
    sync_drama()
