#!/bin/bash
# TK知识库 - 守护进程管理

BASE=~/knowledge-base
PID_FILE="$BASE/.daemon.pid"
DAEMON="$BASE/scripts/daemon.sh"
LOG_FILE="$BASE/.daemon.log"

case "$1" in
    start)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            if kill -0 "$PID" 2>/dev/null; then
                echo "⚠️ 守护进程已在运行 (PID: $PID)"
                exit 0
            fi
        fi
        
        echo "🧠 启动知识库守护进程..."
        nohup "$DAEMON" >> "$LOG_FILE" 2>&1 &
        sleep 1
        if [ -f "$PID_FILE" ]; then
            echo "✅ 已启动 (PID: $(cat $PID_FILE))"
            echo "📝 日志: $LOG_FILE"
        else
            echo "❌ 启动失败"
        fi
        ;;
    
    stop)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            kill "$PID" 2>/dev/null && echo "🛑 已停止" || echo "❌ 无法停止"
            rm -f "$PID_FILE"
        else
            echo "⚠️ 未运行"
        fi
        ;;
    
    status)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            if kill -0 "$PID" 2>/dev/null; then
                echo "🟢 运行中 (PID: $PID)"
                echo "📝 日志尾部:"
                tail -5 "$LOG_FILE" 2>/dev/null
            else
                echo "🔴 进程已停止 ( stale PID file)"
                rm -f "$PID_FILE"
            fi
        else
            echo "⚪ 未运行"
        fi
        ;;
    
    restart)
        $0 stop
        sleep 1
        $0 start
        ;;
    
    log)
        tail -20 "$LOG_FILE"
        ;;
    
    *)
        echo "TK知识库守护进程管理"
        echo ""
        echo "用法: $0 <command>"
        echo ""
        echo "命令:"
        echo "  start   启动守护进程"
        echo "  stop    停止守护进程"
        echo "  status  查看状态"
        echo "  restart 重启"
        echo "  log     查看日志"
        ;;
esac