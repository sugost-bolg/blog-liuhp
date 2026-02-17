#!/bin/bash

# 下载并安装正确版本的 Hugo
HUGO_VERSION=0.155.3
curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_darwin-universal.tar.gz" -o /tmp/hugo.tar.gz 2>/dev/null
tar -xzf /tmp/hugo.tar.gz -C /tmp 2>/dev/null
chmod +x /tmp/hugo 2>/dev/null

# 使用下载的 Hugo 构建
/tmp/hugo --gc --minify
