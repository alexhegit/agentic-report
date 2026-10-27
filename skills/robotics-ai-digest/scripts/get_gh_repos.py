#!/usr/bin/env python3
"""Fetch GitHub repo details for curated top robotics repos."""
import urllib.request, json

repos = [
    "Genesis-Embodied-AI/genesis-world",
    "huggingface/lerobot",
    "AtsushiSakai/PythonRobotics",
    "isaac-sim/IsaacLab",
    "DLR-RM/stable-baselines3",
    "commaai/openpilot",
    "robotframework/robotframework",
    "kornia/kornia",
]
for full_name in repos:
    url = f"https://api.github.com/repos/{full_name}"
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    try:
        d = json.loads(urllib.request.urlopen(req, timeout=10).read().decode('utf-8'))
        desc = d.get('description') or ''
        stars = d.get('stargazers_count', 0)
        lang = d.get('language') or ''
        updated = d.get('pushed_at', '')[:10]
        print(f"{full_name} | {stars} stars | {lang} | updated {updated} | {desc[:120]}")
    except Exception as e:
        print(f"Error fetching {full_name}: {e}")