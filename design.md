# Architecture & Design Notes

`agentic-report` 的设计原理、数据模型、更新管道与跨机可迁移机制。面向想理解/接手/魔改本系统的人;只想安装看结果的请回 [README](README.md)。

## 1. 设计目标

1. **持续积累**:每天自动把 Physical AI 与 AMD 市场情报沉淀成可检索的历史,越用越厚
2. **零后端**:站点是纯静态文件 + JSON,部署在 GitHub Pages(Free 版即可),没有服务器、没有数据库、没有构建步骤
3. **可溯源**:每一页内容都能反查到是哪期报告、哪份原文、哪天生成的
4. **可迁移**:整套系统(前端 + 数据 + 任务定义 + skill + 部署器)全部在仓库内,任何一台装了 Hermes Agent 的机器 clone 下来就能接管

## 2. 架构总览

```
┌─────────────────────────────────────────────────────────────────┐
│                        生产侧 (Agent 主机)                       │
│                                                                 │
│  Hermes Agent ──cron──┬─► Physical AI 日报  (周一~五 08:00 北京) │
│   │  skills/           ├─► Physical AI 周报  (周日 08:00)        │
│   │  (robotics-         ├─► AMD 美股日报     (周一~五 19:00)     │
│   │   ai-digest)        └─► AMD 股市周报     (周日 08:00)        │
│   │                                                             │
│   ▼ 定时触发,按 jobs/jobs.json 的权威 prompt 执行                │
│  LLM 研究 + 写作 ──► ~/.hermes/cron/output/<uuid>/latest.md      │
│                     └── 同一份内容推送飞书(📎 带站点深链)          │
│   │                                                             │
│   ▼ ingest.py (被任务收尾调用,或由人手动跑)                        │
│  解析 → 抽实体/边 → 合并 data/*.json → 写 logs/*.md               │
│       → git commit && push                                      │
└───────┼─────────────────────────────────────────────────────────┘
        ▼
┌─────────────────────────────────────────────────────────────────┐
│                     存储/分发侧 (GitHub)                          │
│   agentic-report 仓库 (main)  ──►  GitHub Pages                 │
│   ├─ index/graph/entities .html                                │
│   ├─ data/ (reports|entities|edges).json  ← 页面唯一数据来源     │
│   ├─ logs/  106+ 篇原文 (含 frontmatter)                        │
│   ├─ vendor/ cytoscape + fcose (离线可用)                       │
│   └─ jobs/ skills/ scripts/  ← 系统的可迁移"身体"                │
└─────────────────────────────────────────────────────────────────┘
        ▼
┌─────────────────────────────────────────────────────────────────┐
│  消费侧: 浏览器(电脑/手机)直接 fetch JSON,无 cookie/无登录        │
└─────────────────────────────────────────────────────────────────┘
```

关键取舍:**git 仓库既是数据库也是发布管道**。写路径只有 `ingest.py` 一个入口(幂等合并),读路径是浏览器直接 `fetch('data/*.json')`。没有 API,就没有 API 的运维;没有数据库,迁移就是 `git clone`。

## 3. 数据模型

### 3.1 reports (data/reports.json,106+)

| 字段 | 说明 |
|---|---|
| `id` | `{job6}_{YYYY-MM-DD}[_{HHMMSS}]` — job 目录名前 6 位 + 生成时间;同一天多份报告靠 HHMMSS 区分 |
| `date` | **以 cron 输出文件名时间戳为准**(北京生成日),绝不用正文中出现的日期——正文常引用前一天的行情/论文日期,用正文日期会把报告归错天(已踩过) |
| `site` | `physical-ai` \| `amd` |
| `kind` / `title` | 日报/周报 + 固定标题(来自 jobs 定义,不自由发挥) |
| `summary` | 前 N 行剥离 Markdown 符号的纯文本,时间线折叠态用 |
| `full_text` | 报告全文(仅存于 JSON;logs/*.md 存同一份 + frontmatter) |
| `source` | `~/.hermes/cron/output/<uuid>/<file>` 溯源路径 |
| `log` | 对应 `logs/{date}_{HHMMSS}_{job6}.md` 文件名,页面"GitHub 原文"链接直接用 |

### 3.2 entities (data/entities.json,372)

`{id, label, kind, url, first_seen, last_seen, mentions, extra?}`

- `kind`:paper(200)/ project(105)/ company(49)/ trend / reference / node…
- `id` 规则:arXiv 用纯 ID(如 `2608.17596`),GitHub 用 `owner/repo`(去 /docs /tests 子路径),公司用全名
- **防御规则**:实体 id 长度 ≤ 80 —— 更长的"匹配"基本是 404/HTML 误抓,不是真实体(曾因此膨胀到过 27 万条,过滤后 372)
- `extra`:人工或任务补充的一句话描述(合并时保留,重建不可覆盖)

### 3.3 edges (data/edges.json,2910)

`{source, target, relation, implicit}`

- `implicit=false`:明确关系(如 `UniSuperMimic —独立复现→ SuperMimic`),带 relation 文本,图谱实线
- `implicit=true`:**同报告共现**(co-mention)——同一期报告里同时出现的实体之间连一条淡虚线。2880 条中绝大多数。去重用**无序对** frozenset,防 A→B / B→A 重复(曾因此 double-count)
- 共现边按报告增量生成,历史不重算

### 3.4 命名与幂等

- `scripts/state.json`:`{job: {latest_date, latest_file, latest_size_mtime, done_files[3]}}` —— 同一文件只 ingest 一次;`done_files` 环形保留最近 3 个文件名
- slug 全部由稳定输入推导(date + 时间戳 + job 前缀),同输入必同输出,跨机器重建数据不漂移

## 4. 更新管道(一次日报的完整旅程)

```
cron 触发(UTC 表达式见 jobs/jobs.json)
  → Hermes 按 prompt 执行(搜索→写作→输出 latest.md + 飞书推送)
  → 收尾执行 scripts/ingest.py:
      1) 读 jobs/local_map.json 得到 uuid→slug;找不到则回退内置映射
      2) 扫 ~/.hermes/cron/output/<uuid>/(HERMES_CRON_DIR 可覆盖)
      3) 新文件 → 追加 report + 重算实体 mentions/时间窗 + 加共现边
      4) 写 logs/*.md(frontmatter 带 id/date/title/type)
      5) 落 data/*.json(UTF-8,indent=2) + state.json
      6) git add -A → commit(Hermes Agent 匿名身份)→ push
  → GitHub Pages 拾取 main 分支 → 浏览器 refresh 即见
```

- 任何一步失败(网络/磁盘)不会污染已有数据:合并是增量且先校验再写
- `ingest.py` 幂等:重跑无新文件时只打印 `no new reports to ingest`

## 5. 前端三页

| 页 | 数据源 | 要点 |
|---|---|---|
| `index.html` | reports.json | 日期分组时间线;站点 filter + 全文搜索;**月历点选**(有报告的日期带 🔴/🟢 点);**深链** `?date=YYYY-MM-DD&site=amd\|physical-ai` 直达 |
| `graph.html` | entities.json + edges.json | Cytoscape.js + fcose 力导向;显式关系实线/共现淡虚线;节点半径=mention 次数;hover 出简介、click 出邻接关系;`#focus=` 锚点 |
| `entities.html` | entities.json | kind 卡片目录,按提及次数排序,搜索 |

技术原则:
- 页面零构建、零运行时依赖;JS **vendor 优先**(vendor/cytoscape.min.js + cytoscape-fcose.js),CDN 仅兜底 —— 断网环境图谱页也可开
- `<details>` 折叠必须用 `<summary>` 自定义头,否则浏览器注入原生「详细信息」按钮(踩过的坑)
- 深链与飞书 📎 链接共用同一 URL schema;任务 prompt 末尾固定要求附上 `📎 网页版:<site_base>?date=…&site=…`,域名从 `site.json` 取

## 6. 可迁移设计(核心创新点)

**问题**:Hermes 的 cron job 以 UUID 标识,UUID 每台机器不同;skill 装在 ~/.hermes;产出目录、git 凭据、站点域名都绑机器。如何让"这个站"漂移到任意机器?

**方案**:把"机器相关的"全部抽成**运行时映射**,把"系统身份"全部收敛到仓库:

| 系统身份(仓库内,稳定) | 机器相关(运行时,可变) |
|---|---|
| `jobs/jobs.json` — 4 任务的 slug 键权威定义(周期/prompt/skills) | `jobs/local_map.json` — 本机 uuid→slug(install.sh 生成) |
| `skills/robotics-ai-digest/` — 任务所用 skill 全文 | `~/.hermes/skills/` — 实际安装位置 |
| `site.json` — 站点 base | 飞书推送渠道(每机 hermes 自带) |
| `data/` + `logs/` — 全部历史 | `~/.hermes/cron/output/<uuid>/` — 产出目录 |
| `scripts/` — ingest/install | git 凭据 — `GIT_SSH_COMMAND` 或 token,不入仓 |

`install.sh`(幂等):装 skill → 按 jobs.json 建任务(同名已存在则只挂映射,绝不重复建)→ 写 local_map.json。从此生产侧与仓库解耦:仓库知道"要哪 4 个任务、每个长什么样",机器只负责"给 UUID"。

**迁移验收标准**:clone → install.sh → 手动触发一次任务 → 飞书收到带 📎 链接的推送 → 站点出现新条目。四步都过,迁移成功。

## 7. 安全边界

- 仓库 **0 凭据**:token / 私钥 / 密码从未入库,git 历史全量扫过;commit 身份用 `users.noreply.github.com` 匿名邮箱
- repo public 是**功能需求**(Pages 在 Free 版要求 public),内容均为公开信息汇编
- LLM 任务的 prompt 含联网搜索要求,但不含任何密钥
- 敏感环境信息(本机 token)只存在于 `~/.hermes/.env` 等机器侧文件

## 8. 已知坑与防复发

| 坑 | 复发防线 |
|---|---|
| 报告归错天(正文引用旧日期) | ingest 只认文件名时间戳(§3.1) |
| 同日多份报告互相覆盖 | id 与 log slug 强制含 HHMMSS |
| 实体爆炸(270K) | id 长度过滤 + node_ids 缓存集 |
| 共现边 double-count | 无序对 frozenset 去重 |
| 原生「详细信息」按钮 | `<details>` 必须 `<summary>` |
| fcose 2.3.0 CDN 404 | 锁定 2.2.0 正确路径 + vendor 兜底 |
| cron 编辑漏传 prompt → 任务变空 | 改 schedule 必须用 `hermes cron update`(整对象替换),并对照输出 diff |

## 9. 局限与可能的演进

- **无增量摘要**:每期报告全文入库,JSON 会线性增长(当前 ~10MB,可接受);未来可拆 `data/archive-*.json` 分片
- **实体消解是启发式**:同名实体未跨报告归一(如公司简称/全称),依赖 id 规约 + 人工 extra
- **图谱规模**:372 节点 + 2910 边 fcose 布局 <1s;若到 5K 节点级别需预计算布局或改用 d3-hierarchy
- **多语言**:报告为中文,实体 id 保留原文;搜索不分词(整串匹配),中文长尾词可考虑 bigram 索引
