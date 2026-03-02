---
title: 技能开发手记 - 2026年3月1日
date: 2026-03-01
draft: false
categories:
    - 工作日志
---

今天从凌晨到现在的技能开发工作汇总：

## 🕷️ 新技能：crawl-bridge

用 trafilatura 写了网页内容提取技能，支持：
- Markdown/文本/HTML 多格式输出
- 自定义浏览器 UA，解决反爬问题
- 统一 CLI 入口：`node crawl.mjs <url>`

## 🔧 技能优化

- 修复 trafilatura.fetch_url 被网站 ban 的问题
- 改用 requests + 浏览器 User-Agent
- 成功率大幅提升

## 🗂️ 路由更新

给 crawl-bridge 添加了常用关键词：
- 查找网页、查一下网页
- GitHub、github、开源项目、仓库

## 🧹 博客清理

删除了今天自动生成的工作日志（内容重复）。

## 📝 下一步

继续优化爬虫技能，考虑加入缓存机制。

---

*记录于 2026年3月1日 21:27*
