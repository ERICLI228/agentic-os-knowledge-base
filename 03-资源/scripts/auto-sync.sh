#!/bin/bash
# TK知识库自动同步 - 零Token消耗
# 每小时自动运行，检查并整理知识

BASE=~/knowledge-base
RAW_DIR="$BASE/raw"
WIKI_DIR="$BASE/wiki"

LOG_FILE="$BASE/.sync.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== 知识库自动同步开始 ==="

# 1. 检查raw目录新文件
log "📂 检查原始数据..."
NEW_COUNT=$(find $RAW_DIR -type f -name "*.md" -mmin -60 2>/dev/null | wc -l)
if [ "$NEW_COUNT" -gt 0 ]; then
    log "  发现 $NEW_COUNT 个新文件(1小时内)"
    
    # 2. 简单整理：移动到对应分类
    for f in $(find $RAW_DIR -type f -name "*.md" -mmin -60 2>/dev/null); do
        BASENAME=$(basename "$f")
        
        # 根据文件名关键词自动分类
        if echo "$BASENAME" | grep -qi "选品\|产品\|product"; then
            mv "$f" "$WIKI_DIR/products/" 2>/dev/null && log "  → 移至 products/: $BASENAME"
        elif echo "$BASENAME" | grep -qi "视频\|脚本\|video"; then
            mv "$f" "$WIKI_DIR/videos/" 2>/dev/null && log "  → 移至 videos/: $BASENAME"
        elif echo "$BASENAME" | grep -qi "运营\|sop\|ops"; then
            mv "$f" "$WIKI_DIR/ops/" 2>/dev/null && log "  → 移至 ops/: $BASENAME"
        elif echo "$BASENAME" | grep -qi "竞品\|对手\|competitor"; then
            mv "$f" "$WIKI_DIR/competitors/" 2>/dev/null && log "  → 移至 competitors/: $BASENAME"
        else
            log "  ⚠️ 未分类: $BASENAME (请手动分类)"
        fi
    done
else
    log "  无新文件"
fi

# 3. 统计更新
log "📊 知识统计:"
TOTAL=$(find $WIKI_DIR -name "*.md" | wc -l)
for cat in products videos ops competitors; do
    COUNT=$(find $WIKI_DIR/$cat -name "*.md" 2>/dev/null | wc -l)
    log "  $cat: $COUNT 条"
done

# 4. 更新索引时间戳
touch "$WIKI_DIR/index.md"

log "✅ 同步完成 ==="
log ""