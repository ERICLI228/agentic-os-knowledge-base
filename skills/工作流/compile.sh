#!/bin/bash
# TK运营知识库 - LLM编译脚本
# 读取raw/目录，编译成结构化wiki

set -e

BASE=~/knowledge-base
RAW_DIR="$BASE/raw"
WIKI_DIR="$BASE/wiki"

echo "=== TK运营知识库编译器 ==="
echo "📂 原始数据: $RAW_DIR"
echo "📚 输出Wiki: $WIKI_DIR"
echo ""

# 检查是否有新数据
NEW_FILES=$(find $RAW_DIR -type f -name "*.md" -newer $WIKI_DIR/index.md 2>/dev/null | wc -l)
if [ "$NEW_FILES" -eq 0 ]; then
    echo "✅ 无新数据需要编译"
    exit 0
fi

echo "📊 发现 $NEW_FILES 个新文件"

# 读取所有raw文件
echo ""
echo "🤖 调用LLM编译知识..."

# 使用LLM编译的prompt
LLM_PROMPT="你是TK运营知识库编译器。请读取以下原始数据，提取关键信息，生成结构化维基条目。

原始数据目录: $RAW_DIR

请为每个文件生成结构化内容，分类到:
- products/ : 选品知识（品类分析、价格区间、利润率）
- videos/ : 爆款视频（脚本结构、时长、BGM、点赞率）
- ops/ : 运营SOP（发布流程、投放策略、数据复盘）
- competitors/ : 竞品分析（对手策略、定价、销量）

输出格式: 每个条目生成一个.md文件到对应目录，包含:
1. 标题
2. 关键数据/指标
3. 核心洞察
4. 相关链接

开始编译。"

# 调用LLM处理
echo "$LLM_PROMPT" | claude -p --dangerously-skip-permission-check 2>/dev/null || \
echo "⚠️ LLM调用失败，将手动整理"

echo ""
echo "✅ 编译完成！"
echo "📁 Wiki位置: $WIKI_DIR"