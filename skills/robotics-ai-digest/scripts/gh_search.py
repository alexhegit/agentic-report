#!/usr/bin/env python3
"""Search GitHub for robotics repos by keyword and print top results."""
import urllib.request, json, sys

if len(sys.argv) < 2:
    print("Usage: python3 get_gh_search.py <keyword>")
    sys.exit(1)

query = sys.argv[1]
url = f"https://api.github.com/search/repositories?q={query}+language:Python&sort=stars&order=desc&per_page=10"
req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
d = json.loads(urllib.request.urlopen(req, timeout=10).read().decode('utf-8'))
print(f"Query: {query} — {d.get('total_count', 0)} total results\n")
for r in d.get('items', [])[:10]:
    desc = r.get('description') or ''
    stars = r.get('stargazers_count', 0)
    lang = r.get('language') or ''
    updated = r.get('updated_at', '')[:10]
    print(f"{r['full_name']} | {stars} stars | {lang} | updated {updated} | {desc[:100]}")