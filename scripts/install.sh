#!/usr/bin/env bash
# ============================================================
#  agentic-report 部署器
#  在装了 Hermes Agent 的机器上,把本仓库的5个定时任务重建 + 挂上 ingest
#
#  前置:
#   - 已 git clone 本仓库到 /root/agentic-report(或任意路径)
#   - 目标机装了 `hermes` CLI (Hermes Agent 已运行过至少一次)
#
#  行为:
#   1. 检测 hermes CLI
#   2. 安装/更新 skills(robotics-ai-digest)到 ~/.hermes/skills/
#   3. 安装 NVIDIA 监控合同（已有状态文件绝不覆盖）
#   4. 从 jobs/jobs.json 读取5个任务定义,若同名任务不存在则 hermes cron add 新建
#   5. 把新 job id 写回 jobs/local_map.json (供 ingest 用)
#   6. 若 jobs/local_map.json 已存在且5个任务齐全,不重建
#
#  幂等:第二次跑只做 diff 提示,不重复建任务。
# ============================================================
set -u  # -e 会导致 hermes 输出非零被误杀

REPO="$(cd "$(dirname "$0")/.." && pwd)"
JOBS="$REPO/jobs/jobs.json"
MAP="$REPO/jobs/local_map.json"
SKILLS_SRC="$REPO/skills"
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
SKILLS_DST="$HERMES_HOME/skills"
WATCH_SRC="$REPO/jobs/watch-contracts/nvidia-physical-ai-labs-weekly.json"
WATCH_DST="$HERMES_HOME/competitor-watches/nvidia-physical-ai-labs-weekly.json"

ok=0; bad=0; skip=0
say(){ printf "\033[1;36m$*\033[0m\n"; }
info(){ printf "\033[1m$*\033[0m\n"; }
warn(){ printf "\033[33m$*\033[0m\n"; }
err(){ printf "\033[31m$*\033[0m\n"; }

if [ -e "$MAP" ] && ! python3 - "$MAP" <<'PY'
import json, sys
json.load(open(sys.argv[1], encoding='utf-8'))
PY
then
  err "❌ jobs/local_map.json 不是有效 JSON；拒绝继续以免丢失任务映射"
  exit 1
fi

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

# ---------- 2. install watch contract without overwriting runtime state ----------
if [ -f "$WATCH_SRC" ]; then
  mkdir -p "$(dirname "$WATCH_DST")"
  if [ -e "$WATCH_DST" ]; then
    if python3 - "$WATCH_SRC" "$WATCH_DST" <<'PY'
import json, os, sys
src, dst = sys.argv[1:]
template = json.load(open(src, encoding='utf-8'))
current = json.load(open(dst, encoding='utf-8'))
template['monitoring_state'] = current.get('monitoring_state', {})
tmp = dst + '.tmp'
with open(tmp, 'w', encoding='utf-8') as f:
    json.dump(template, f, ensure_ascii=False, indent=2)
    f.write('\n')
os.replace(tmp, dst)
PY
    then
      say "↷  更新监控合同并保留已有运行状态: $WATCH_DST"
    else
      err "❌ 更新监控合同失败: $WATCH_DST"
      bad=$((bad+1))
    fi
  else
    if cp "$WATCH_SRC" "$WATCH_DST"; then
      ok=$((ok+1)); say "✅ watch contract: nvidia-physical-ai-labs-weekly"
    else
      err "❌ 安装监控合同失败: $WATCH_DST"
      bad=$((bad+1))
    fi
  fi
fi

# ---------- 3. discard stale/profile-foreign mappings, then load map ----------
if ! python3 - "$MAP" "$JOBS" "$HERMES_HOME/cron/jobs.json" <<'PY'
import json, os, sys
path, defs_path, active_path = sys.argv[1:]
old = json.load(open(path)) if os.path.exists(path) else {}
defs = json.load(open(defs_path)).get('jobs', {})
active = ({j.get('id'): j for j in json.load(open(active_path)).get('jobs', [])}
          if os.path.exists(active_path) else {})
valid = {}
for uid, value in old.items():
    slug = value.get('slug') if isinstance(value, dict) else value
    expected = defs.get(slug, {}).get('name')
    actual = active.get(uid, {}).get('name')
    if expected and actual == expected:
        valid[uid] = {'slug': slug}
if valid or old:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    tmp = path + '.tmp'
    with open(tmp, 'w', encoding='utf-8') as f:
        json.dump(valid, f, ensure_ascii=False, indent=2)
        f.write('\n')
    os.replace(tmp, path)
PY
then
  err "❌ 无法校验或更新 jobs/local_map.json"
  exit 1
fi

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

# ---------- 4. create / verify jobs ----------
# 用 python 提取 jobs 列表,便于 bash 循环
while IFS=$'\t' read -r slug name schedule_utc deliver skills; do
  if [ -n "${LOCAL_MAP[$slug]:-}" ]; then
    skip=$((skip+1)); say "↷  已存在: $slug (${LOCAL_MAP[$slug]})"; continue
  fi
  # 名字唯一,避免"同名任务"重复
  exists=$(python3 -c "
import json
try:
  d=json.load(open('$HERMES_HOME/cron/jobs.json'))
  for j in d.get('jobs',[]):
    if j.get('name')=='$name':
      print(j.get('id')); break
except Exception: pass
")
  if [ -n "$exists" ]; then
    if ! python3 - "$MAP" "$exists" "$slug" <<'PY'
import json, os, sys
path, uid, slug = sys.argv[1:]
m = json.load(open(path)) if os.path.exists(path) else {}
m[uid] = {'slug': slug}
tmp = path + '.tmp'
with open(tmp, 'w', encoding='utf-8') as f:
    json.dump(m, f, ensure_ascii=False, indent=2)
    f.write('\n')
os.replace(tmp, path)
PY
    then
      err "❌ 无法写入任务映射: $slug"
      bad=$((bad+1)); continue
    fi
    LOCAL_MAP["$slug"]=$exists
    info "↷  同名任务已存在,挂到 map: $slug → $exists"
    continue
  fi

  prompt=$("$REPO"/scripts/_job_prompt.py "$slug")
  [ -z "$prompt" ] && { err "no prompt for $slug"; bad=$((bad+1)); continue; }
  # 从 jobs.json 读取锁定模型(若定义里有),防止新机器默认模型漂移
  model=$(python3 -c "import json; d=json.load(open('$REPO/jobs/jobs.json'))['jobs'].get('$slug',{});print(d.get('model',''))")
  mprov=$(python3 -c "import json; d=json.load(open('$REPO/jobs/jobs.json'))['jobs'].get('$slug',{});print(d.get('provider',''))")
  modelargs=()
  [ -n "$model" ] && modelargs=(--model "$model")
  [ -n "$mprov" ] && modelargs+=(--provider "$mprov")

  say "➕ 新建 cron: $name"
  skillargs=()
  if [ -n "$skills" ]; then
    IFS=',' read -r -a skill_list <<< "$skills"
    for skill in "${skill_list[@]}"; do
      [ -n "$skill" ] && skillargs+=(--skill "$skill")
    done
  fi
  out=$(hermes cron create "$schedule_utc" "$prompt" \
        --name "$name" \
        "${skillargs[@]}" \
        "${modelargs[@]}" \
        --deliver "${deliver:-origin}" 2>&1)
  create_rc=$?
  if [ "$create_rc" -ne 0 ]; then
    err "  hermes cron create 失败(exit=$create_rc): $name"
    bad=$((bad+1)); continue
  fi
  newid=$(grep -oE '\b[0-9a-f]{8,16}\b' <<<"$out" | head -1)
  if [ -z "$newid" ]; then
    err "  未能解析 job id: $name"
    bad=$((bad+1)); continue
  fi
  if ! python3 - "$HERMES_HOME/cron/jobs.json" "$newid" "$name" <<'PY'
import json, sys
path, uid, expected_name = sys.argv[1:]
try:
    jobs = json.load(open(path)).get('jobs', [])
except Exception:
    sys.exit(1)
match = next((j for j in jobs if j.get('id') == uid), None)
sys.exit(0 if match and match.get('name') == expected_name else 1)
PY
  then
    err "  新任务未出现在当前 profile 注册表: $name ($newid)"
    bad=$((bad+1)); continue
  fi
  if ! python3 - "$MAP" "$newid" "$slug" <<'PY'
import json, sys, os
path, uid, slug = sys.argv[1:]
m = json.load(open(path)) if os.path.exists(path) else {}
m[uid] = {'slug': slug}
tmp = path + '.tmp'
with open(tmp, 'w', encoding='utf-8') as f:
    json.dump(m, f, ensure_ascii=False, indent=2)
    f.write('\n')
os.replace(tmp, path)
PY
  then
    err "  无法写入任务映射: $slug"
    bad=$((bad+1)); continue
  fi
  LOCAL_MAP["$slug"]="$newid"
  ok=$((ok+1))
  say "     job_id=$newid"
done < <(python3 - "$JOBS" <<'PY'
import json,sys
d=json.load(open(sys.argv[1]))
jobs=d.get('jobs') or d.get('local_job_map') or {}
order=['physical-ai-daily','physical-ai-weekly','nvidia-physical-ai-labs-weekly','amd-daily','amd-weekly']
for slug in order:
    j=jobs.get(slug)
    if not j: continue
    name=j.get('name',slug)
    sched=j.get('schedule_utc','')
    if isinstance(sched,dict): sched=sched.get('expr','')
    deliver=j.get('deliver','origin')
    skills=','.join(j.get('skills') or [])
    print(f"{slug}\t{name}\t{sched}\t{deliver}\t{skills}")
PY
)

# ---------- 5. verify map has all 5 ----------
missing=$(python3 - "$MAP" "$JOBS" "$HERMES_HOME/cron/jobs.json" <<'PY'
import json,sys,os
map_path, defs_path, active_path = sys.argv[1:]
m=json.load(open(map_path)) if os.path.exists(map_path) else {}
defs=json.load(open(defs_path)).get('jobs', {})
active=({j.get('id'):j for j in json.load(open(active_path)).get('jobs', [])}
        if os.path.exists(active_path) else {})
valid=set()
for uid, value in m.items():
    slug=value.get('slug') if isinstance(value,dict) else value
    if slug in defs and active.get(uid,{}).get('name') == defs[slug].get('name'):
        valid.add(slug)
need={'physical-ai-daily','physical-ai-weekly','nvidia-physical-ai-labs-weekly','amd-daily','amd-weekly'}
print(','.join(sorted(need-valid)))
PY
)
verify_rc=$?
if [ "$verify_rc" -ne 0 ]; then
  err "❌ 无法验证最终任务映射"
  bad=$((bad+1))
elif [ -n "$missing" ]; then
  err "❌ 缺少任务映射: $missing"
  bad=$((bad+1))
fi

# ---------- 6. summary ----------
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

if [ "$bad" -ne 0 ]; then
  exit 1
fi
