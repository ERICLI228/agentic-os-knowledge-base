#!/bin/bash
# TK运营知识库 - 主入口

case "$1" in
    add)
        # 添加新知识
        shift
        echo "📝 添加新知识: $@"
        FILE="raw/$(date +%Y%m%d_%H%M%S).md"
        cat > ~/knowledge-base/$FILE << EOF
# 新知识

## 内容
$@

## 来源
## 标签
## 备注

---
*添加于 $(date)*
EOF
        echo "✅ 已保存到: $FILE"
        ;;
    
    compile)
        # 编译知识库
        ~/knowledge-base/scripts/compile.sh
        ;;
    
    query)
        # 查询
        shift
        ~/knowledge-base/scripts/query.sh "$@"
        ;;
    
    maintain)
        # 维护
        ~/knowledge-base/scripts/maintain.sh
        ;;
    
    stats)
        # 统计
        echo "=== 知识库统计 ==="
        find ~/knowledge-base/wiki -name "*.md" | wc -l
        ;;
    
    *)
        echo "TK运营知识库 🧠"
        echo ""
        echo "用法: knowledge-base <command> [args]"
        echo ""
        echo "命令:"
        echo "  add <内容>     添加新知识"
        echo "  compile        编译知识库"
        echo "  query <问题>   查询知识"
        echo "  maintain       维护/检查"
        echo "  stats          统计"
        echo ""
        echo "示例:"
        echo "  knowledge-base add \"发现一款新耳机...\""
        echo "  knowledge-base query \"什么耳机好卖\""
        ;;
esac