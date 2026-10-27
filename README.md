# 📋 Agentic Report

Hermes Agent 周期性信息收集 → 网页展示 + 知识图谱。所有报告与实体都来自 4 个 GitHub 仓库的定时任务,数据可溯源。

## 🛣 定时任务

| 任务 | 周期 (北京时间) | 说明 |
|---|---|---|
| 🤖 Physical AI 日报 | 工作日 09:00 | VLA / 世界模型 / 具身智能 / 触觉 |
| 🤖 Physical AI 周报 | 周六 09:00 | 周度趋势 + 融资/合同/论文 |
| 📈 AMD 美股日报 | 周一至周五 20:00(美股收盘后) | 当日收盘/成交量/重要市场消息;美股休市日自动跳过 |
| 📈 AMD 股市周报 | 周日 08:00 | 上一完整交易周综述 |

## 🧭 三页结构

- **index.html** — 106+ 份报告时间线 · 按日期分组 · 域名筛选 + 全文搜索
- **graph.html** — 知识图谱 (Cytoscape.js fcose 力导向) · 节点大小 = 被提及次数 · 实线 = 明确关系 / 淡虚线 = 同周期共现 · 悬停看简介 · 点击看关系列表
- **entities.html** — 实体卡片目录 · 按 kind/提及次数排序 · 搜索

## 🏗 设计:数据驱动静态站

页面只 `fetch` JSON,不嵌内容。定时任务只要更新 `data/*.json` 与 `logs/*.md` 并 push,页面自动刷新 — 不需要重新构建。

```
.
├── index.html                 ← 报告时间线
├── graph.html                 ← 知识图谱 (cytoscape@3 + fcose)
├── entities.html              ← 实体目录
├── data/
│   ├── reports.json           ← 106+ 报告 (含 full_text)
│   ├── entities.json          ← 372 个实体 (项目/论文/公司/概念)
│   └── edges.json             ← 2910 条边 (明确 + 隐式共现)
├── logs/                      ← 每期原文 (Markdown, 含 frontmatter)
├── scripts/
│   ├── ingest.py              ← 在定时任务后自动 ingest + git push
│   └── state.json             ← 幂等标记
├── SCHEMA.md                  ← 实体/边 schema
└── .nojekyll                  ← GitHub Pages
```

## 🔁 自动更新

每次一个 Physical AI / AMD 定时任务跑完后:

```bash
python3 /root/agentic-report/scripts/ingest.py
```

它会:
1. 读 `~/.hermes/cron/output/{job_id}/latest.md`
2. 抽实体 (GitHub repos / arXiv / 公司) → 追加到 entities.json
3. 加共现边
4. 写日志 logs/{date}_{site}_{title}.md
5. git commit && push origin main → GitHub Pages 自动 build

## 🌐 GitHub Pages

仓库设置 → Pages → Source: `Deploy from a branch` → 分支 `main` / 根目录 `/`。

启用后访问: [https://alexhegit.github.io/agentic-report/](https://alexhegit.github.io/agentic-report/)

## 🐞 FAQ

- **本机预览**: `cd /root/agentic-report && python3 -m http.server 8731`
- **图谱加载失败?** 检查 https://unpkg.com/cytoscape@3.33.1/dist/cytoscape.min.js 可达。
- **页面显示 file:// 错误?** 直接用 HTTP,浏览器禁止 file:// 域 fetch。

## 许可

CC BY-SA 4.0 (报告内容) · MIT (页面 / 脚本)。
