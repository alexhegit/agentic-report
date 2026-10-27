#!/usr/bin/env python3
"""Print the prompt of a job by slug, from jobs/jobs.json. (helper for install.sh)"""
import json, os, sys
repo = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
p = sys.argv[1] if len(sys.argv) > 1 else ''
d = json.load(open(os.path.join(repo, 'jobs', 'jobs.json')))
j = d['local_job_map'].get(p) or d.get('local_job_map', {}).get(p)
if not j:
    # try top-level
    j = d.get(p)
if not j:
    sys.exit(1)
sys.stdout.write(j.get('prompt', ''))
