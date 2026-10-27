#!/usr/bin/env python3
"""Fetch recent arXiv cs.RO papers and print titles."""
import urllib.request, re

url = "https://arxiv.org/list/cs.RO/recent?show=50"
req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
html = urllib.request.urlopen(req, timeout=10).read().decode('utf-8')

# Extract titles
titles = re.findall(r"<div class='list-title mathjax'>(.*?)</div>", html, re.DOTALL)
for i, t in enumerate(titles[:20]):
    t = re.sub(r'<[^>]+>', '', t).strip()
    t = t.replace('\n', ' ').replace('  ', ' ')
    print(f'{i+1}. {t}')

# Extract IDs too (for reference)
ids = re.findall(r'arXiv:(\d+\.\d+)', html)
print(f"\nTotal papers on page: {len(ids)}")