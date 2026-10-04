#!/usr/bin/env bash
#
# block-destructive_test.sh — exercise the classifier in
# block-destructive.sh without running anything it classifies.
#
# It feeds the hook the same JSON Claude Code feeds it and checks the
# exit status: 2 is blocked, 0 is passed through. Nothing here executes
# a command; the strings are data.
#
# The cases live in a here-document rather than in the invocation,
# because the hook reads the command it is given and a test harness that
# spelled its cases on the command line blocked itself the first time
# this was written.
#
#   ~/.claude/hooks/block-destructive_test.sh
#
# A rule nobody can fail is a rule nobody is keeping: this is here so
# that a change to the patterns has something to fail.

set -uo pipefail
HOOK="$(dirname "$0")/block-destructive.sh"

pass=0
fail=0

check() {
  local want="$1" cmd="$2"
  local json status got
  json=$(WANT_CMD="$cmd" python3 -c 'import json,os;print(json.dumps({"tool_name":"Bash","tool_input":{"command":os.environ["WANT_CMD"]}}))')
  printf '%s' "$json" | "$HOOK" >/dev/null 2>&1
  status=$?
  if [ "$status" -eq 2 ]; then got=block; else got=allow; fi
  if [ "$got" = "$want" ]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    printf 'FAIL  want %-5s got %-5s  %s\n' "$want" "$got" "$cmd"
  fi
}

# Each line is "block|allow<TAB>command". The allow cases matter as much
# as the block ones: a pattern that swallows ordinary work gets removed
# by whoever it stops, and then it protects nothing.
while IFS=$'\t' read -r want cmd; do
  [ -z "${want:-}" ] && continue
  case "$want" in \#*) continue ;; esac
  check "$want" "$cmd"
done <<'CASES'
block	git push -f origin main
block	git push origin -f
block	git push --force
block	git push origin --force
block	git push --quiet --force origin main
block	git push --force-with-lease origin main
allow	git push -u origin main
allow	git push origin main
allow	git push origin feature-force
allow	git push origin v0.3.0
block	git clean -fdx
block	git clean -fd
block	git clean --force
allow	git clean -n
allow	git clean --dry-run
block	find . -name '*.tmp' -delete
allow	find . -name '*.tmp' -print
block	rm -rf /tmp/anything
block	rm -fr /tmp/anything
block	rm --recursive --force /tmp/anything
allow	rm /tmp/one-file
allow	rm -f /tmp/one-file
block	DROP TABLE users
block	truncate table sessions
block	mkfs.ext4 /dev/sda1
block	shred -u secrets.txt
allow	git status
allow	go test ./...
allow	git rebase main
allow	git reset --hard HEAD
CASES

printf '\n%d passed, %d failed\n' "$pass" "$fail"
[ "$fail" -eq 0 ]
