#!/usr/bin/env bash
#
# notify-on-stop.sh
# Stop hook: pings you with a desktop notification when Claude Code finishes
# a turn / session. Uses the best notifier available on the current OS, and
# always falls back to a terminal bell so you hear something.
#
# Install: ~/.claude/hooks/notify-on-stop.sh (chmod +x), wired under hooks.Stop
# in ~/.claude/settings.json.

set -uo pipefail

# Best-effort JSON parse for directory context. Don't fail if jq is missing.
INPUT=""
if ! [[ -t 0 ]]; then
  INPUT="$(cat || true)"
fi

CWD=""
if command -v jq >/dev/null 2>&1 && [[ -n "$INPUT" ]]; then
  CWD="$(jq -r '.cwd // empty' <<<"$INPUT" 2>/dev/null || true)"
fi
[[ -z "$CWD" ]] && CWD="$(pwd)"
DIR_NAME="$(basename "$CWD")"

TITLE="Claude Code"
MESSAGE="Finished: $DIR_NAME"

# Try notifiers in order; stop at first success.
sent=false
if ! $sent && command -v notify-send >/dev/null 2>&1; then
  notify-send -u normal -a "Claude Code" "$TITLE" "$MESSAGE" >/dev/null 2>&1 && sent=true
fi
if ! $sent && command -v terminal-notifier >/dev/null 2>&1; then
  terminal-notifier -title "$TITLE" -message "$MESSAGE" >/dev/null 2>&1 && sent=true
fi
if ! $sent && command -v osascript >/dev/null 2>&1; then
  osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\"" >/dev/null 2>&1 && sent=true
fi

# Terminal bell (always safe, works in tmux/iTerm/Windows Terminal/VS Code)
printf '\a' >&2

exit 0
