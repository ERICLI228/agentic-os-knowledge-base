#!/bin/bash
# 孤儿笔记检测脚本
# 扫描仓库中未被任何其他笔记引用的笔记

VAULT="/Users/hokeli/knowledge-base"
echo "🔍 孤儿笔记检测报告"
echo "===================="
echo ""

while IFS= read -r note; do
    rel_path="${note#$VAULT/}"
    basename=$(basename "$note" .md)
    
    # 跳过系统目录和归档
    [[ "$rel_path" == archive/* ]] && continue
    [[ "$rel_path" == templates/* ]] && continue
    [[ "$rel_path" == skills/* ]] && continue
    [[ "$rel_path" == daily/* ]] && continue
    
    # 检查是否有其他笔记引用它（[[basename]] 或 [[basename|...]]）
    count=$(grep -rl "\[\[$basename" "$VAULT" --include="*.md" 2>/dev/null | grep -v "$note" | wc -l)
    
    if [ "$count" -eq 0 ]; then
        size=$(wc -c < "$note")
        echo "  🚫 $rel_path (${size}B) - 无引用"
    fi
done < <(find "$VAULT" -name "*.md" -not -path "*/.obsidian/*" -not -path "*/.git/*" | sort)

echo ""
echo "===================="
echo "💡 提示: 孤儿笔记建议移入 raw/ 或直接删除"
