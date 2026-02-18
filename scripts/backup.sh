#!/bin/bash
# blog-backup.sh - 同步博客到 GitHub

set -e

BLOG_DIR="/srv/blog-liuhp"
GITHUB_REMOTE="github"
LOG_FILE="/tmp/blog-backup.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

main() {
    log "========== 博客备份到 GitHub =========="
    cd "$BLOG_DIR"
    
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD)
    log "当前分支: $branch"
    
    log "获取最新内容..."
    git fetch origin "$branch" 2>&1 | tee -a "$LOG_FILE" || true
    
    log "推送到 GitHub..."
    if git push github "$branch:$branch" --force 2>&1 | tee -a "$LOG_FILE"; then
        log "✓ 备份成功"
    else
        log "✗ 备份失败"
        exit 1
    fi
    
    log "======================================"
}

main "$@"
