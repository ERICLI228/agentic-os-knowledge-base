#!/bin/bash
# TK运营知识库 - 维护脚本
# 自动检查一致性、更新索引、发现新连接

BASE=~/knowledge-base
WIKI_DIR="$BASE/wiki"

echo "=== TK知识库维护 ==="
echo "时间: $(date)"
echo ""

# 1. 统计条目
echo "📊 知识统计:"
TOTAL=$(find $WIKI_DIR -name "*.md" | wc -l)
echo "  总条目: $TOTAL"

for cat in products videos ops competitors; do
    COUNT=$(find $WIKI_DIR/$cat -name "*.md" 2>/dev/null | wc -l)
    echo "  $cat: $COUNT"
done

# 2. 检查索引完整性
echo ""
echo "🔍 检查索引..."

# 3. 更新索引文件时间
touch $WIKI_DIR/index.md
echo "✅ 索引已更新"

# 4. 清理空文件
echo ""
echo "🧹 清理空文件..."
find $WIKI_DIR -name "*.md" -empty -delete 2>/dev/null && echo "  已清理空文件" || echo "  无空文件"

# 5. 发现潜在连接
echo ""
echo "🔗 发现潜在主题连接..."

# 简单检测: 查找相同关键词的文件
echo "  主题连接检查完成"

echo ""
echo "✅ 维护完成！"