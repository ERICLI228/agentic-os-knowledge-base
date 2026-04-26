#!/bin/bash
# TK知识库守护进程 - 零Token消耗
# 后台持续运行，定期同步知识

BASE=~/knowledge-base
INTERVAL=3600  # 1小时 = 3600秒

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "🧠 TK知识库守护进程启动"
log "📁 知识库: $BASE"
log "⏱️ 同步间隔: $INTERVAL 秒"
log ""

# 创建PID文件
PID_FILE="$BASE/.daemon.pid"
echo $$ > "$PID_FILE"

# 清理函数
cleanup() {
    log "🛑 守护进程停止"
    rm -f "$PID_FILE"
    exit 0
}
trap cleanup SIGINT SIGTERM

# 主循环
while true; do
    log "=== 开始同步 ==="
    
    # 1. 检查并自动分类
    for f in $(ls ~/knowledge-base/raw/*.md 2>/dev/null); do
        [ -f "$f" ] || continue
        BASENAME=$(basename "$f")
        
        if echo "$BASENAME" | grep -qi "选品\|产品\|product"; then
            mv "$f" "$BASE/wiki/products/" 2>/dev/null && log "  → products: $BASENAME"
        elif echo "$BASENAME" | grep -qi "视频\|脚本\|video"; then
            mv "$f" "$BASE/wiki/videos/" 2>/dev/null && log "  → videos: $BASENAME"
        elif echo "$BASENAME" | grep -qi "运营\|sop\|ops"; then
            mv "$f" "$BASE/wiki/ops/" 2>/dev/null && log "  → ops: $BASENAME"
        elif echo "$BASENAME" | grep -qi "竞品\|对手\|competitor"; then
            mv "$f" "$BASE/wiki/competitors/" 2>/dev/null && log "  → competitors: $BASENAME"
        fi
    done
    
    # 2. 统计
    TOTAL=$(find $BASE/wiki -name "*.md" 2>/dev/null | wc -l)
    log "📊 知识库: $TOTAL 条"
    
    # 3. 更新索引时间
    touch "$BASE/wiki/index.md"
    
    log "✅ 同步完成，等待下次..."
    log ""
    
    sleep $INTERVAL
done