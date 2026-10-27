# 📋 Agentic Report

Hermes Agent 驱动的**自动情报知识库**:两个定时研究任务(物理 AI 进展 + AMD 市场)每天产出报告,自动沉淀为可检索的网页站点与知识图谱。纯静态站、无后端、无数据库,部署在 GitHub Pages,电脑/手机直接访问。

🌐 **在线站点**:https://alexhegit.github.io/agentic-report/

## ✨ 功能

- 🗞 **报告时间线** — 100+ 份 AI 日报/周报,按日期分组,月历点选、全文搜索、域名筛选,支持 `?date=&site=` 深链直达
- 🗺 **知识图谱** — 370+ 项目/论文/公司实体,力导向布局,显式关系(复现/构建)与同周期共现分线型,离线可用
- 📇 **实体目录** — 卡片式浏览每个项目/论文/公司,按提及热度排序
- 📬 **飞书同步** — 每份报告推送时附站点深链,点进即见当天内容
- 🔄 **自动积累** — 每个交易日/工作日持续入库,历史只增不删,所有条目可溯源到原文
- 📦 **可迁移** — 任务定义 + skill + 部署器全部在仓库内,任何一台 Hermes 主机 `git clone` 即可接管

## 🛣 定时任务

| 任务 | 周期 (北京时间) | 内容 |
|---|---|---|
| 🤖 Physical AI 日报 | 周一~五 08:00 | VLA / 世界模型 / 具身智能 / 触觉 |
| 🤖 Physical AI 周报 | 周日 08:00 | 周度趋势 + 融资 / 合同 / 论文 |
| 📈 AMD 美股日报 | 周一~五 19:00 | 最近一个已收盘交易日总结;美股休市日跳过 |
| 📈 AMD 股市周报 | 周日 08:00 | 上一完整交易周综述 |

## 🚀 安装 / 部署

**前提**:目标机已安装 Hermes Agent(`hermes` CLI 可用),并已配置本仓库的 git push 凭据(SSH key 加到 GitHub 账号,或 remote 改 HTTPS + token)。

```bash
git clone git@github.com:alexhegit/agentic-report.git
cd agentic-report
bash scripts/install.sh    # 装 skill + 重建 4 个定时任务 + 生成本机任务映射(幂等,可重复执行)
python3 scripts/ingest.py # 验证数据链路(无新报告时打印 no new reports 即正常)
```

完成后,4 个任务按上表周期自动运行;每期报告入库后自动 commit + push,站点即刷新。无需配置数据库、无需构建步骤、无需后端服务。

> 本地预览:`python3 -m http.server 8731` → http://localhost:8731

### 仓库结构

```
├── index.html / graph.html / entities.html   ← 三个页面(纯静态)
├── data/                                      ← reports / entities / edges JSON(站点唯一数据源)
├── logs/                                      ← 每期报告原文(Markdown + frontmatter)
├── jobs/jobs.json                             ← 4 个任务的权威定义(prompt/周期)
├── jobs/local_map.json                        ← 本机 job UUID → slug(install.sh 生成)
├── skills/robotics-ai-digest/                 ← 任务所用 skill(方法论+脚本)
├── scripts/install.sh · ingest.py             ← 部署器 · 数据入库器
├── vendor/                                    ← cytoscape + fcose 本地副本(离线可开)
├── site.json                                  ← 站点 base(换部署位置时改这里)
├── design.md                                  ← 架构与原理
└── SCHEMA.md                                  ← 数据字段定义
```

### 换账号 / 换仓库名部署

1. `git remote set-url origin <新仓库>`
2. 改 `site.json` 的 `site_base` 为新 Pages 地址
3. 用 `hermes cron update` 把 4 个任务 prompt 末尾的 📎 深链同步为新地址,并回写 `jobs/jobs.json`
4. 新仓库 Settings 开启 Pages(分支 `main`,根目录;Free 版要求仓库 public)

## 📚 文档

- **[design.md](design.md)** — 架构、数据模型、更新管道、可迁移机制、安全边界、踩坑记录
- **[SCHEMA.md](SCHEMA.md)** — reports / entities / edges 字段定义
- **skills/robotics-ai-digest** — 物理 AI 报告任务的 skill(方法论 + 参考 + 脚本)

## 🐞 FAQ

- **本机预览**:`cd agentic-report && python3 -m http.server 8731`
- **图谱打不开?** JS 已内置 `vendor/`(本地优先、CDN 兜底),检查两个 vendor 文件是否齐全
- **file:// 打开报错?** 浏览器禁止本地文件 fetch JSON,请用 HTTP

## 许可

CC BY-SA 4.0(报告内容)· MIT(页面/脚本)
