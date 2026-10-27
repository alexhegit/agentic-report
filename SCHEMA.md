# Data Schema

版本:v1(2026-10)。字段语义详见 [design.md §3](design.md)。

## reports.json

```jsonc
{
  "id": "17abfd_2026-10-27_090226",  // {job6}_{YYYY-MM-DD}[_{HHMMSS}]
  "date": "2026-10-27",              // 生成日(以 cron 输出文件名时间戳为准,北京时间)
  "site": "physical-ai",             // physical-ai | amd
  "kind": "日报",                     // 日报 | 周报
  "title": "Physical AI 日报",
  "summary": "240 字以内纯文本摘要",
  "full_text": "…报告全文(Markdown)…",
  "source": "{job_uuid}/{filename}", // cron 产出相对路径
  "log": "2026-10-27_090226_17abfd.md" // logs/ 下对应文件名
}
```

## entities.json

```jsonc
{
  "id": "owner/repo",                // arXiv 用纯 ID;GitHub 用 owner/repo;公司用全名;长度 ≤ 80
  "label": "SuperMimic",
  "kind": "project",                 // paper|project|company|trend|reference|concept|product
  "url": "https://github.com/…",
  "first_seen": "2026-08-19",
  "last_seen": "2026-10-27",
  "mentions": 3,
  "extra": "可选的一句话描述(人工/任务补充,合并时保留)"
}
```

## edges.json

```jsonc
{
  "source": "UniSuperMimic",
  "target": "SuperMimic",
  "relation": "独立复现 (independent reimplementation)",
  "implicit": false                  // true = 同报告共现(淡虚线);false = 显式关系(实线)
}
```

去重:按 (`source`,`target`) 无序对唯一。

## 约束

- `id` / `date` / `log` 由稳定输入推导,禁止手工改写(破坏幂等)
- `full_text` 只存于 reports.json;logs/*.md 的正文应与其一致
- 实体 id 出现 404/HTML 误抓特征且长度 > 80 时应丢弃
