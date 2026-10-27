#!/usr/bin/env bash
# ============================================================
#  agentic-report 部署器
#  在装了 Hermes Agent 的机器上,把本仓库的4个定时任务重建 + 挂上 ingest
#
#  前置:
#   - 已 git clone 本仓库到 /root/agentic-report(或任意路径)
#   - 目标机装了 `hermes` CLI (Hermes Agent 已运行过至少一次)
#
#  行为:
#   1. 检测 hermes CLI
#   2. 安装/更新 skills(robotics-ai-digest)到 ~/.hermes/skills/
#   3. 从 jobs/jobs.json 读取4个任务定义,若同名任务不存在则 hermes cron add 新建
#   4. 把新 job id 写回 jobs/local_map.json (供 ingest 用)
#   5. 若 jobs/local_map.json 已存在且4个任务齐全,不重建
#
#  幂等:第二次跑只做 diff 提示,不重复建任务。
# ============================================================
set -u  # -e 会导致 hermes 输出非零被误杀

REPO="$(cd "$(dirname "$0")/.." && pwd)"
JOBS="$REPO/jobs/jobs.json"
MAP="$REPO/jobs/local_map.json"
SKILLS_SRC="$REPO/skills"
SKILLS_DST="$HOME/.hermes/skills"

ok=0; bad=0; skip=0
say(){ printf "\033[1;36m$*\033[0m\n"; }
info(){ printf "\033[1m$*\033[0m\n"; }
warn(){ printf "\033[33m$*\033[0m\n"; }
err(){ printf "\033[31m$*\033[0m\n"; }

# ---------- 0. check hermes ----------
if ! command -v hermes >/dev/null 2>&1; then
  err "❌ 未找到 hermes CLI。目标机需先装 Hermes Agent 并跑一次 hermes。"
  exit 2
fi
say "✅ hermes CLI: $(command -v hermes)"

# ---------- 1. install skills ----------
if [ -d "$SKILLS_SRC" ]; then
  for d in "$SKILLS_SRC"/*/; do
    [ -f "$d/SKILL.md" ] || continue
    name=$(basename "$d")
    mkdir -p "$SKILLS_DST/$name"
    cp -r "$d"/. "$SKILLS_DST/$name"/
    ok=$((ok+1)); say "✅ skill: $name"
  done
else
  warn "没有 skills/ 目录,跳过"
fi

# ---------- 2. load map (existing) ----------
declare -A LOCAL_MAP
if [ -f "$MAP" ]; then
  while IFS=$'\t' read -r uuid slug; do
    [ -n "$uuid" ] && LOCAL_MAP["$slug"]="$uuid"
  done < <(python3 - "$MAP" <<'PY'
import json,sys
d=json.load(open(sys.argv[1]))
for k,v in d.items():
    s=v.get('slug') if isinstance(v,dict) else v
    print(f"{k}\t{s}")
PY
)
fi

# ---------- 3. create / verify jobs ----------
# 用 python 提取 jobs 列表,便于 bash 循环
while IFS=$'\t' read -r slug name schedule_utc deliver skills; do
  if [ -n "${LOCAL_MAP[$slug]:-}" ]; then
    skip=$((skip+1)); say "↷  已存在: $slug (${LOCAL_MAP[$slug]})"; continue
  fi
  # 名字唯一,避免"同名任务"重复
  exists=$(python3 -c "
import json
try:
  d=json.load(open('$HOME/.hermes/cron/jobs.json'))
  for j in d.get('jobs',[]):
    if j.get('name')=='$name':
      print(j.get('id')); break
except Exception: pass
")
  if [ -n "$exists" ]; then
    python3 -c "
import json
m=json.load(open('$MAP')) if __import__('os').path.exists('$MAP') else {}
m['$exists']={'slug':'$slug'}
json.dump(m, open('$MAP','w'), ensure_ascii=False, indent=2)
"
    LOCAL_MAP["$slug"]=$exists
    info "↷  同名任务已存在,挂到 map: $slug → $exists"
    continue
  fi

  prompt=$("$REPO"/scripts/_job_prompt.py "$slug")
  [ -z "$prompt" ] && { err "no prompt for $slug"; bad=$((bad+1)); continue; }

  say "➕ 新建 cron: $name"
  skillargs=()
  [ -n "$skills" ] && skillargs=(--skill "$skills")
  set +e
  out=$(hermes cron create "$schedule_utc" "$prompt" \
        --name "$name" \
        "${skillargs[@]}" \
        --deliver "${deliver:-origin}" 2>&1)
  set -u
  newid=$(grep -oE '\b[0-9a-f]{8,16}\b' <<<"$out" | head -1)
  if [ -z "$newid" ]; then
    err "  未能解析 job id, hermes 输出: $out"
    bad=$((bad+1)); continue
  fi
  python3 - "$MAP" "$newid" "$slug" <<'PY'
import json,sys,os
m, path, uid, slug = {}, sys.argv[1], sys.argv[2], sys.argv[3]
if os.path.exists(path): m=json.load(open(path))
m[uid]={'slug':slug}
json.dump(m, open(path,'w'), ensure_ascii=False, indent=2)
PY
  LOCAL_MAP["$slug"]="$newid"
  ok=$((ok+1))
  say "     job_id=$newid"
done < <(python3 - "$JOBS" <<'PY'
import json,sys
d=json.load(open(sys.argv[1]))
jobs=d.get('jobs') or d.get('local_job_map') or {}
order=['physical-ai-daily','physical-ai-weekly','amd-daily','amd-weekly']
for slug in order:
    j=jobs.get(slug)
    if not j: continue
    name=j.get('name',slug)
    sched=j.get('schedule_utc','')
    if isinstance(sched,dict): sched=sched.get('expr','')
    deliver=j.get('deliver','origin')
    skills=(j.get('skills') or [None])[0] or ''
    print(f"{slug}\t{name}\t{sched}\t{deliver}\t{skills}")
PY
)

# ---------- 4. verify map has all 4 ----------
python3 - "$MAP" <<'PY'
import json,sys,os
if not os.path.exists(sys.argv[1]): sys.exit(0)
m=json.load(open(sys.argv[1]))
need={'physical-ai-daily','physical-ai-weekly','amd-daily','amd-weekly'}
have={ (v.get('slug') if isinstance(v,dict) else v) for v in m.values() }
missing=need-have
if missing:
    print(f"⚠ 缺: {missing}", file=sys.stderr)
PY

# ---------- 5. summary ----------
echo
info "==== 部署完成 ===="
info "   已挂载 / 新建: $ok   已存在(跳过): $skip   失败: $bad"
if [ -f "$MAP" ]; then
  echo "   jobs/local_map.json:"
  python3 - "$MAP" <<'PY'
import json,sys
d=json.load(open(sys.argv[1]))
for uid,v in d.items():
    print(f"     {uid:20s} -> {v.get('slug') if isinstance(v,dict) else v}")
PY
fi
echo
info "下一步:"
info "   1) 手动跑一次 ingest 验证:  python3 $REPO/scripts/ingest.py"
info "   2) 触发一次任务验证 cron:   hermes cron run <job_id> ; 或等下一次调度"
info "   3) 本机预览站点:            cd $REPO && python3 -m http.server 8731"
info "   4) 推 GitHub(可选):        git -C $REPO push origin main"
echo
