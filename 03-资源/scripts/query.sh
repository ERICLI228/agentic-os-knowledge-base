#!/bin/bash
# TK运营知识库 - 问答脚本

BASE=~/knowledge-base
WIKI_DIR="$BASE/wiki"
QUERY_DIR="$BASE/queries"

# 获取问题参数
QUESTION="$1"

if [ -z "$QUESTION" ]; then
    echo "=== TK运营知识库问答 ==="
    echo "用法: $0 \"你的问题\""
    echo ""
    echo "示例:"
    echo '  ./query.sh "什么样的3C产品适合在东南亚TikTok卖"'
    echo '  ./query.sh "耳机类目爆款视频有什么共同特点"'
    echo '  ./query.sh "印尼市场有哪些运营禁忌"'
    exit 0
fi

echo "🔍 问题: $QUESTION"
echo ""

# 保存查询记录
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
QUERY_FILE="$QUERY_DIR/${TIMESTAMP}.md"

cat > "$QUERY_FILE" << EOF
# 查询: $QUESTION

**时间**: $(date)
**状态**: 处理中

---

## 问题

$QUESTION

---

## 检索到的知识

EOF

# 检索相关wiki文件
echo "📚 检索相关知识..." 
RELEVANT_FILES=$(grep -rli "$QUESTION" $WIKI_DIR/*.md 2>/dev/null | head -5)

if [ -n "$RELEVANT_FILES" ]; then
    echo "$RELEVANT_FILES" >> "$QUERY_FILE"
    echo "✅ 找到相关文档"
else
    echo "⚠️ 未找到精确匹配，使用关键词检索..."
    
    # 提取关键词搜索
    KEYWORDS=$(echo "$QUESTION" | tr ' ' '\n' | head -3)
    for kw in $KEYWORDS; do
        find $WIKI_DIR -name "*.md" -exec grep -l "$kw" {} \; 2>/dev/null
    done | sort -u | head -3 >> "$QUERY_FILE"
fi

echo ""
echo "🤖 调用LLM生成答案..."

# 构建LLM prompt
LLM_PROMPT="你是TK运营专家。请根据知识库回答以下问题。

## 知识库位置
$WIKI_DIR

## 问题
$QUESTION

请给出:
1. 直接答案
2. 相关案例
3. 行动建议

如果知识库没有足够信息，请说明并提供基于你知识的建议。"

# 调用LLM（这里用简单方式）
echo "$LLM_PROMPT"

cat >> "$QUERY_FILE" << EOF

---

## LLM回答

(这里会显示LLM的回答)

---

*此查询记录保存在: $QUERY_FILE*
EOF

echo ""
echo "✅ 查询完成！"
echo "📝 记录: $QUERY_FILE"