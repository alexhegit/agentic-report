# 📋 Agentic Report

Hermes Agent 周期性信息收集 → 网页展示 + 知识图谱。所有报告与实体都来自 4 个 GitHub 仓库的定时任务,数据可溯源。

## 🛣 定时任务

| 任务 | 周期 (北京时间) | 说明 |
|---|---|---|
| 🤖 Physical AI 日报 | 周一~五 08:00 | VLA / 世界模型 / 具身智能 / 触觉 |
| 🤖 Physical AI 周报 | 周日 08:00 | 周度趋势 + 融资/合同/论文 |
| 📈 AMD 美股日报 | 周一~五 19:00 | 总结最近一个已收盘交易日;美股休市日自动跳过 |
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
│   ├── install.sh             ← 新机器一键部署(装 skill + 重建 cron 任务)
│   ├── ingest.py              ← 定时任务产出 → data/ + logs/ + git push
│   └── state.json             ← 幂等标记
├── jobs/
│   ├── jobs.json              ← 4 个任务的权威定义(slug 为键:周期/prompt/skills)
│   └── local_map.json         ← 本机 job UUID → slug 映射(install.sh 生成)
├── skills/robotics-ai-digest/ ← Physical AI 日报/周报所用 skill
├── vendor/                    ← cytoscape + fcose 本地副本(图谱页零 CDN 依赖)
├── site.json                  ← 站点域名(迁移改站点时唯一需改的常量)
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
4. 写日志 logs/{date}_{timestamp}_{job6}.md(文件名稳定带时间戳,避免同日多份覆盖)
5. git commit && push origin main → GitHub Pages 自动刷新

## 📦 迁移 / 部署到新机器

本仓库即完整系统:前端 + 数据 + 4 个任务的权威定义(prompt 逐字) + skill + 部署器,全部在仓库内,不依赖任何单一机器。

**前置**:目标机装了 Hermes Agent(`hermes` CLI 可用),且配置了本仓库的 push 凭据(仓库 remote 是 SSH 时:一个已加到 GitHub 账号的 SSH key;或把 remote 换成 HTTPS + token)。`ingest.py` 推送时尊重环境变量 `GIT_SSH_COMMAND`,默认尝试 `~/.ssh/id_ed25519`。

```bash
git clone git@github.com:alexhegit/agentic-report.git
cd agentic-report
bash scripts/install.sh        # ① 装 skill ② 按 jobs/jobs.json 重建 4 个定时任务 ③ 生成 jobs/local_map.json
python3 scripts/ingest.py     # ③ 验证数据链路(无新报告时打印 no new reports 即正常)
```

**install.sh 的行为(幂等)**:
- 把 `skills/` 下的 skill 安装到 `~/.hermes/skills/`
- 从 `jobs/jobs.json`(slug 为键:physical-ai-daily / physical-ai-weekly / amd-daily / amd-weekly)读取周期 + prompt + skills,`hermes cron create` 逐个建任务
- 把本机新分配的 job UUID 写回 `jobs/local_map.json`(uuid → slug 映射,ingest.py 靠它找产出目录)
- 再跑一次不会重复建任务:同名任务已存在则只挂映射

**跨机约定**:定时任务产出统一落到 Hermes 的 cron output 目录(默认 `~/.hermes/cron/output/<uuid>/latest.md`,可用环境变量 `HERMES_CRON_DIR` 覆盖),`ingest.py` 按 slug 找目录、抽报告与实体、写 `data/*.json` + `logs/*.md`,然后 `git commit && push` → Pages 自动刷新。

**改站点域名**:若换仓库/账号部署,需改两处:`site.json` 的 `site_base`(站点自引用),以及 4 个任务 prompt 末尾的 📎 深链 URL——在新机器上用 `hermes cron update --prompt` 逐条改,并回写 `jobs/jobs.json` 保持权威定义一致。

## 🌐 GitHub Pages

仓库设置 → Pages → Source: `Deploy from a branch` → 分支 `main` / 根目录 `/`。Pages 仅 Free 版 public 仓库支持。

启用后访问: [https://alexhegit.github.io/agentic-report/](https://alexhegit.github.io/agentic-report/)

## 🐞 FAQ

- **本机预览**: `cd /root/agentic-report && python3 -m http.server 8731`
- **图谱加载失败?** JS 已内置于 `vendor/`(优先本地,CDN 兜底),应可离线打开;仍失败时检查 vendor 两个文件是否齐全。
- **页面显示 file:// 错误?** 直接用 HTTP,浏览器禁止 file:// 域 fetch。

## 许可

CC BY-SA 4.0 (报告内容) · MIT (页面 / 脚本)。
