#!/bin/bash
# auto-publish.sh - 每周自动生成并发布博客

set -e

BLOG_DIR="/srv/blog-liuhp"
TOPICS_FILE="/srv/blog-liuhp/.auto-topics.txt"
PUBLISHED_FILE="/srv/blog-liuhp/.auto-published.txt"

# 如果主题文件不存在，创建默认主题
init_topics() {
    if [[ ! -f "$TOPICS_FILE" ]]; then
        cat > "$TOPICS_FILE" << 'EOF'
本周技术观察
本周工作总结
学习笔记
工具分享
折腾记录
代码片段
生活随想
EOF
    fi
}

# 获取本周主题（循环使用）
get_weekly_topic() {
    local topics=()
    while IFS= read -r line; do
        [[ -n "$line" ]] && topics+=("$line")
    done < "$TOPICS_FILE"
    
    local week_num=$(date +%U)
    local index=$((week_num % ${#topics[@]}))
    echo "${topics[$index]}"
}

# 生成文章内容
generate_post() {
    local topic="$1"
    local date_str=$(date +%Y-%m-%d)
    local slug="weekly-$(date +%s)"
    
    cd "$BLOG_DIR"
    
    # 创建文章
    bash scripts/new.sh "$slug" "$topic - $date_str"
    
    # 获取生成的文件路径
    local file=$(ls -t content/post/*-${slug}.md | head -1)
    
    # 添加模板内容
    cat >> "$file" << EOF

## $topic

本周的一些思考和记录。

### 技术动态

- 待补充...

### 工作总结

- 待补充...

### 下周计划

- 待补充...

---
*本文由定时任务自动生成，于 $(date '+%Y-%m-%d %H:%M') 创建*
EOF
    
    echo "$file"
}

# 发布文章
publish_post() {
    cd "$BLOG_DIR"
    
    # 提交并推送
    git add -A
    git commit -m "auto: weekly post $(date +%Y-%m-%d)" > /dev/null
    git push origin main
    
    echo "✅ 已发布"
}

# 主函数
main() {
    echo "========== 每周自动博客发布 =========="
    
    init_topics
    
    local topic=$(get_weekly_topic)
    echo "本周主题: $topic"
    
    local file=$(generate_post "$topic")
    echo "创建文章: $file"
    
    publish_post
    
    # 记录已发布
    echo "$(date +%Y-%m-%d): $topic" >> "$PUBLISHED_FILE"
    
    echo "======================================"
}

main "$@"
