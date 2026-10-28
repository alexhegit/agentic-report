#!/usr/bin/env python3
"""Ingest new cron outputs into agentic-report and git-commit.
Runs after any of the 4 periodic-report cron jobs finishes.
Pure stdlib. Idempotent (skips already-ingested files by report id).
"""
import json, os, re, sys, hashlib, subprocess
from datetime import datetime, timezone

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # 仓库根目录(相对脚本位置,可迁移)
CRON = os.environ.get('HERMES_CRON_DIR', os.path.expanduser('~/.hermes/cron/output'))
ENV = os.environ.get('AGENTIC_ENV_FILE', os.path.expanduser('~/.hermes/.env'))

# slug -> 元数据(与 jobs/jobs.json 的 slug 对齐)
JOBS = {
    'physical-ai-daily':   ('physical-ai', '日报', 'Physical AI 日报'),
    'physical-ai-weekly':  ('physical-ai', '周报', 'Physical AI 周报'),
    'amd-daily':           ('amd',        '日报', 'AMD 美股日报'),
    'amd-weekly':          ('amd',        '周报', 'AMD 股市周报'),
}

# 目录名(cron job uuid) -> slug。本机默认映射(可被 jobs/local_map.json 覆盖/扩展)
DIR_TO_SLUG = {
    '17abfd193223': 'physical-ai-daily', 'e3325cc31dd3': 'physical-ai-weekly',
    '2bb7831e0820': 'amd-daily', '8245979b3f86': 'amd-weekly',
}
def load_dir_map():
    m = dict(DIR_TO_SLUG)
    p = os.path.join(REPO, 'jobs', 'local_map.json')
    if os.path.exists(p):
        for uuid, v in json.load(open(p)).items():
            m[uuid] = (v or {}).get('slug') if isinstance(v, dict) else v
    return m

STATE = os.path.join(REPO, 'scripts', 'state.json')
def load_json(path, default):
    try: return json.load(open(path, encoding='utf-8'))
    except Exception: return default
def save_json(path, obj):
    tmp = path + '.tmp'
    with open(tmp, 'w', encoding='utf-8') as f: json.dump(obj, f, ensure_ascii=False, indent=2)
    os.replace(tmp, path)

def get_token():
    if os.environ.get('GITHUB_TOKEN'): return os.environ['GITHUB_TOKEN']
    for l in open(ENV, encoding='utf-8').read().splitlines():
        if l.startswith('COPILOT_GITHUB_TOKEN='):
            return l.split('=', 1)[1].strip()
    return None

def extract_response(path):
    txt = open(path, encoding='utf-8').read()
    m = re.search(r'^## Response\s*$\n(.*?)(?=^⚠️|\Z)', txt, re.M | re.S)
    if not m: return ''
    body = re.sub(r'^⚠️.*\Z', '', m.group(1), flags=re.S).strip()
    return body

def first_date(body):
    m = re.search(r'(\d{4}-\d{2}-\d{2})', body)
    return m.group(1) if m else ''

GH   = re.compile(r'github\.com/([A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+)')
ARX  = re.compile(r'(?:arxiv\.org/(?:abs|pdf)/(\d{4}\.\d{4,5})|arXiv\s*\[?(\d{4}\.\d{4,5}))')

def main():
    os.makedirs(os.path.dirname(STATE), exist_ok=True)
    reports = load_json(f'{REPO}/data/reports.json', [])
    entities = {e['id']: e for e in load_json(f'{REPO}/data/entities.json', [])}
    edges = load_json(f'{REPO}/data/edges.json', [])
    seen_edge = {frozenset((e['source'], e['target'])) for e in edges}
    done_files = set(load_state().get('done_files', [])) if os.path.exists(STATE) else set()
    added = 0

    seen_reports = {r['id'] for r in reports}
    seen_sources = {r.get('source') for r in reports}

    dir_map = load_dir_map()  # uuid -> slug(本机默认 + jobs/local_map.json 覆盖)
    for job_dir, slug in dir_map.items():
        site, kind, title = JOBS[slug]
        d = os.path.join(CRON, job_dir)
        if not os.path.isdir(d): continue
        for fname in sorted(os.listdir(d)):
            if not fname.endswith('.md'): continue
            path = os.path.join(d, fname)
            date = fname[:10]
            body = extract_response(path)
            if not body: continue
            bd = date  # 文件名时间戳 = 生成日,避免正文引用日期导致归错天
            tstamp = fname[11:19].replace('-', '').replace(':', '') if len(fname) >= 19 else ''
            j6 = job_dir[:6]
            rid = f'{j6}_{date}_{tstamp}' if tstamp else f'{j6}_{date}'
            src = f'{job_dir}/{fname}'
            if src in seen_sources: continue
            seen_sources.add(src)
            summary = re.sub(r'\s+', ' ', re.sub(r'[#*`\[\]\-]', '', body))[:240]
            logsug = re.sub(r'[^A-Za-z0-9._\-]', '_', f'{bd}_{tstamp}_{j6}' if tstamp else f'{bd}_{j6}') + '.md'
            reports.append({
                'id': rid, 'date': bd, 'site': site, 'kind': kind,
                'title': title, 'summary': summary,
                'full_text': body, 'source': f'{job_dir}/{fname}', 'log': logsug,
            })
            seen_reports.add(rid)
            os.makedirs(f'{REPO}/logs', exist_ok=True)
            with open(f'{REPO}/logs/{logsug}', 'w', encoding='utf-8') as f:
                f.write(f"---\nid: {rid}\ndate: {bd}\ntitle: {title}\ntype: {kind}\n---\n\n{body}\n")
            added += 1
            # entities
            for owner_repo in GH.findall(body):
                if re.search(r'/(docs|tests|examples)\b', owner_repo) or 'readme' in owner_repo.lower():
                    continue
                eid = owner_repo
                if eid not in entities:
                    entities[eid] = {'id': eid, 'label': eid, 'kind': 'project', 'url': f'https://github.com/{owner_repo}', 'first_seen': bd, 'last_seen': bd, 'mentions': 0, 'extra': ''}
                e = entities[eid]
                e['mentions'] += 1
                e['last_seen'] = max(e.get('last_seen',''), bd)
            for a,b in ARX.findall(body):
                aid = a or b
                if not aid: continue
                eid = aid
                if eid not in entities:
                    entities[eid] = {'id':eid,'label':aid,'kind':'paper','url':f'https://arxiv.org/abs/{aid}','first_seen':bd,'last_seen':bd,'mentions':0,'extra':''}
                e = entities[eid]
                e['mentions'] += 1
                e['last_seen'] = max(e.get('last_seen',''), bd)

    # implicit co-mention edges between newly-seen and existing reports
    # (kept cheap: only add edges for new entities, not full n^2 recompute)
    def find_id(x):
        if x in entities: return x
        xl = x.lower()
        for nid in entities:
            if nid.lower()==xl: return nid
        return None
    node_ids = set(entities)
    new_ids = {r['id'] for r in reports if r['id'].split('_',1)[0] in {j[:6] for j in JOBS}}
    for r in reports:
        body = r['full_text']
        ment = [n for n in list(node_ids) if len(n)<=80 and n in body]
        for i in range(len(ment)):
            for j in range(i+1, len(ment)):
                a, b = ment[i], ment[j]
                fs = frozenset((a,b))
                if fs in seen_edge: continue
                seen_edge.add(fs)
                edges.append({'source':a,'target':b,'relation':'同周期共现 (co-mentioned in same report)','implicit':True})
                added += 1

    if added == 0:
        print('no new reports to ingest');
        # still refresh state
        save_state()
        return 0

    save_json(f'{REPO}/data/reports.json', reports)
    save_json(f'{REPO}/data/entities.json', list(entities.values()))
    save_json(f'{REPO}/data/edges.json', edges)
    save_state()

    print(f'ingested {added} new entries')
    # git commit and push
    env = dict(os.environ)
    # 可选:有 SSH key 时优先走 SSH(本仓库 remote 通常是 git@github.com)
    sshkey = os.path.expanduser('~/.ssh/id_ed25519')
    if os.path.exists(sshkey):
        default_ssh = f"ssh -i {sshkey} -o BatchMode=yes -o StrictHostKeyChecking=accept-new"
        env.setdefault('GIT_SSH_COMMAND', default_ssh)
    env['GIT_AUTHOR_NAME'] = 'Hermes Agent'
    env['GIT_AUTHOR_EMAIL'] = 'hermes-agent@users.noreply.github.com'
    env['GIT_COMMITTER_NAME'] = 'Hermes Agent'
    env['GIT_COMMITTER_EMAIL'] = 'hermes-agent@users.noreply.github.com'
    r0 = subprocess.run(['git','-C',REPO,'add','-A'], env=env, capture_output=True, text=True)
    if r0.returncode != 0:
        print('git add failed:', r0.stderr); return 1
    r1 = subprocess.run(['git','-C',REPO,'status', '--porcelain'], env=env, capture_output=True, text=True)
    if not r1.stdout.strip():
        print('no git changes (already up to date)'); return 0
    r2 = subprocess.run(['git','-C',REPO,'commit','-m',f'ingest: +{added} entries @ {datetime.now(timezone.utc).isoformat(timespec="seconds")}'],
                        env=env, capture_output=True, text=True)
    if r2.returncode != 0:
        print('git commit failed:', r2.stderr); return 1
    r3 = subprocess.run(['git','-C',REPO,'push','origin','HEAD:main'],
                        env=env, capture_output=True, text=True)
    if r3.returncode != 0:
        print('git push FAILED:', r3.stderr[:300])
    else:
        print('pushed ✓')
    return 0

def load_state(): return load_json(STATE, {})
def save_state():
    st = load_state()
    # refresh done_files from reports' sources
    srcs = [r['source'] for r in load_json(f'{REPO}/data/reports.json', [])]
    st['done_files'] = sorted(set(srcs))
    st['last_run'] = datetime.now(timezone.utc).isoformat(timespec='seconds')
    os.makedirs(os.path.dirname(STATE), exist_ok=True)
    save_json(STATE, st)

if __name__ == '__main__':
    sys.exit(main())
