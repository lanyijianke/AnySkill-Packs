# 📦 AnySkill-Packs

### 官方技能组合包

预制的高质量技能集合，一句话安装到你的 [AnySkill](https://github.com/lanyijianke/AnySkill) 私人技能空间。

---

## 🎯 可用组合包

| 组合包 | 目录 | 说明 |
|:---|:---|:---|
| **核心增强** | `packs/core-enhancement/` | 思维框架、代码审查、提示词工程等增强 AI 本身能力的元技能 |
| **技术开发** | `packs/tech-development/` | 前后端开发、API 集成、DevOps 等技术类技能 |
| **内容创作** | `packs/content-creation/` | 文案写作、社交媒体运营、内容编辑等创作类技能 |
| **数据采集** | `packs/data-crawling/` | 爬虫、数据抓取、信息聚合等采集类技能 |
| **通信集成** | `packs/communication/` | 飞书、钉钉、Telegram、Slack 等通信平台对接技能 |
| **办公运营** | `packs/office-operations/` | 文档处理、表格分析、会议纪要、项目管理等办公运营类技能 |

---

## 🚀 如何使用

确保你已经安装了 [AnySkill](https://github.com/lanyijianke/AnySkill) 引擎，然后对 AI 说：

> **"从 Packs 安装核心增强"**

AI 会自动从本仓库拉取对应组合包中的所有技能，下载到你的私人技能仓库。

---

## 📁 结构

```
AnySkill-Packs/
├── packs/
│   ├── core-enhancement/         # 核心增强 (8 skills)
│   │   ├── brainstorming/
│   │   ├── find-skills/
│   │   ├── project-update/
│   │   ├── prompt-engineering/
│   │   ├── skill-writer/
│   │   ├── using-superpowers/
│   │   ├── video-prompting-guide/
│   │   └── writing-plans/
│   ├── tech-development/         # 技术开发 (21 skills)
│   │   ├── agent-tools/
│   │   ├── agent-ui/
│   │   ├── chat-ui/
│   │   ├── frontend-design/
│   │   ├── javascript-sdk/
│   │   ├── python-sdk/
│   │   ├── seo-audit/
│   │   ├── test-driven-development/
│   │   ├── vercel-react-best-practices/
│   │   ├── widgets-ui/
│   │   └── ... (+ 11 design skills)
│   ├── content-creation/         # 内容创作 (21 skills)
│   │   ├── copywriting/
│   │   ├── ai-content-pipeline/
│   │   ├── linkedin-content/
│   │   ├── twitter-thread-creation/
│   │   ├── technical-blog-writing/
│   │   └── ... (+ 16 more)
│   ├── data-crawling/            # 数据采集 (1 skill)
│   │   └── agent-browser/
│   ├── office-operations/        # 办公运营 (5 skills)
│   │   ├── pdf/
│   │   ├── competitor-teardown/
│   │   ├── customer-persona/
│   │   ├── product-changelog/
│   │   └── product-hunt-launch/
│   └── communication/            # 通信集成
├── generate-index.js             # 索引生成脚本
├── index.json                    # 自动生成的索引
└── README.md
```

---

## 🤝 贡献技能

欢迎提交 PR！每个技能是一个文件夹，至少包含一个 `SKILL.md`：

```
packs/{分类}/{技能名}/
└── SKILL.md
```

`SKILL.md` 需要 YAML frontmatter：

```markdown
---
name: 技能名称
description: 简要描述
---

# 技能内容...
```

---

## 📄 License

MIT
