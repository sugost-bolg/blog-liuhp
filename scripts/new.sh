#!/bin/bash
# Hugo 博客新建文章脚本 - 使用 YYYYMMDDHHMMSS 格式

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
# 使用 YYYYMMDDHHMMSS 格式（更直观）
TIMESTAMP=$(date +%Y%m%d%H%M%S)

FILENAME="${TIMESTAMP}-${SLUG}.md"
FILEPATH="$CONTENT_DIR/$FILENAME"

# 创建文章
cat > "$FILEPATH" << EOM
---
title: "$TITLE"
date: $DATE
draft: false
categories:
    - 随笔
tags:
    - 日志
---

EOM

echo "✅ 文章已创建: $FILEPATH"
echo "📅 时间: $DATE"
echo "🔗 URL: /post/$TIMESTAMP-$SLUG/"
echo ""
echo "编辑命令:"
echo "  vim $FILEPATH"
