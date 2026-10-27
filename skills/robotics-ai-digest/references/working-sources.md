# Working Data Sources for Robotics News (cron-compatible)

## ✅ Confirmed Working (2026-07-02)

### RSS Feeds
| Source | URL | Notes |
|--------|-----|-------|
| The Robot Report | `https://www.therobotreport.com/feed/` | Robotics industry news, updated daily. Parse with `grep -E "<title>|<link>|pubDate"` |
| Hacker News | `https://news.ycombinator.com/` | HTML page, robots/AI startup news. Parse with `grep -i "robot\|humanoid\|VLA"` |

### APIs
| Source | URL | Auth | Notes |
|--------|-----|------|-------|
| arXiv API | `https://export.arxiv.org/api/query?search_query=...` | None | Returns Atom XML, parse with grep |
| GitHub API | `https://api.github.com/search/repositories?q=...` | None (60/hr) | Returns JSON, parse with sed/grep |

## ❌ Blocked/Unavailable

| Source | Reason |
|--------|--------|
| browser_navigate | `agent-browser` binary missing in cron |
| Reddit r/robotics | Blocked by "network policy" |
| Reddit JSON API | Returns block page |
| Twitter API v1 | Deprecated |
| TechCrunch robotics feed | 404 |
| Google Search | JS-rendered, blocks crawlers |

## Example: Fetching The Robot Report RSS

```bash
curl -sL "https://www.therobotreport.com/feed/" | grep -E "<title>|<link>|pubDate" | head -40
```

Output:
```
<title>The Robot Report</title>
<title>Apptronik unveils Apollo 2...</title>
<link>https://www.therobotreport.com/apptronik-unveils-apollo-2-...</link>
<pubDate>Wed, 01 Jul 2026 12:30:31 +0000</pubDate>
```

## ⚠️ arXiv page API `show` parameter
arXiv HTML list `?show=N` only accepts: **25, 50, 100, 250, 500, 1000, 2000**. Values like 200 will get "Invalid show value" error. Use the Atom API (`?max_results=N`) to avoid this restriction.

## Example: Fetching Hacker News Robotics Posts

```bash
curl -s "https://news.ycombinator.com/" | grep -i "robot\|humanoid\|VLA" | head -30
```