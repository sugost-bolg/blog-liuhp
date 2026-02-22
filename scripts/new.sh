#!/bin/bash
# Hugo 博客新建文章脚本 - 使用当前时间

set -e

BLOG_DIR="/srv/blog-liuhp"
CONTENT_DIR="$BLOG_DIR/content/post"

# 参数检查
if [ $# -lt 1 ]; then
    echo "用法: $0 <slug> [标题]"
    echo "示例: $0 hello-world \"Hello World\""
    exit 1
fi

SLUG=$1
TITLE=${2:-$SLUG}

# 使用当前时间（避免 future post 问题）
DATE=$(date +%Y-%m-%dT%H:%M:%S%z)
DATE_STR=$(date +%Y-%m-%d)
TIMESTAMP=$(date +%s)

FILENAME="${TIMESTAMP}-${SLUG}.md"
FILEPATH="$CONTENT_DIR/$FILENAME"

# 创建文章
cat > "$FILEPATH" << EOF
---
title: "$TITLE"
date: $DATE
draft: false
categories:
    - 随笔
tags:
    - 日志
---

EOF

echo "✅ 文章已创建: $FILEPATH"
echo "📅 时间: $DATE"
echo ""
echo "编辑命令:"
echo "  vim $FILEPATH"
echo ""
echo "发布后执行:"
echo "  cd $BLOG_DIR && bash scripts/publish.sh"
