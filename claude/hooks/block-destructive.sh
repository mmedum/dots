#!/usr/bin/env bash
#
# block-destructive.sh
# PreToolUse hook for Claude Code's Bash tool.
#
# Reads the hook JSON from stdin, inspects the command Claude wants to run,
# and blocks (exit 2) if it matches a destructive pattern. Anything else
# passes through (exit 0) and falls under normal permission rules.
#
# This is the SAFETY NET. The primary defense is the permissions block in
# ~/.claude/settings.json. Use both together.
#
# Install:
#   1. Place at ~/.claude/hooks/block-destructive.sh
#   2. chmod +x ~/.claude/hooks/block-destructive.sh
#   3. Wire it up in ~/.claude/settings.json under hooks.PreToolUse
#
# Extend the DESTRUCTIVE_PATTERNS array below for your own rules.

set -uo pipefail

# --- Dependency check ---------------------------------------------------------
if ! command -v jq >/dev/null 2>&1; then
  echo "block-destructive.sh: jq is required (brew install jq / apt install jq)" >&2
  exit 2
fi

# --- Parse the hook input -----------------------------------------------------
INPUT="$(cat)"
TOOL_NAME="$(jq -r '.tool_name // empty' <<<"$INPUT")"
COMMAND="$(jq -r '.tool_input.command // empty' <<<"$INPUT")"

# Only act on Bash. Pass everything else through unchanged.
[[ "$TOOL_NAME" == "Bash" ]] || exit 0
[[ -n "$COMMAND" ]] || exit 0

# --- Destructive patterns -----------------------------------------------------
# Extended regex, matched case-insensitively. Keep each pattern commented so
# future-you knows why it's here.
DESTRUCTIVE_PATTERNS=(
  # rm -rf / rm -fr in any flag combination
  'rm[[:space:]]+(-[a-z]*r[a-z]*f|-[a-z]*f[a-z]*r)'
  'rm[[:space:]]+--recursive[[:space:]]+--force'

  # Force-push in either long or short form
  'git[[:space:]]+push[[:space:]]+.*(--force|[[:space:]]-f([[:space:]]|$))'

  # Destructive SQL
  '(drop|truncate)[[:space:]]+(table|database|schema)'

  # Filesystem-level destruction
  'mkfs(\.|[[:space:]])'
  'dd[[:space:]]+if=.*[[:space:]]of=/dev/'
  '>[[:space:]]*/dev/sd[a-z]'
  'shred[[:space:]]+'
  'wipefs[[:space:]]+'

  # Classic fork bomb
  ':\(\)\{.*:\|:&.*\};:'

  # Recursive chmod/chown against /
  'chmod[[:space:]]+-R[[:space:]]+[0-7]+[[:space:]]+/($|[[:space:]])'
  'chown[[:space:]]+-R[[:space:]]+.+[[:space:]]+/($|[[:space:]])'
)

# --- Match & block ------------------------------------------------------------
for pattern in "${DESTRUCTIVE_PATTERNS[@]}"; do
  if printf '%s' "$COMMAND" | grep -qiE "$pattern"; then
    cat >&2 <<EOF
Blocked by ~/.claude/hooks/block-destructive.sh

The command matched a destructive pattern and was not executed:
  $COMMAND

Matched rule: $pattern

If this was intentional, either:
  - run the command yourself outside Claude Code, or
  - edit the hook script and remove the matching pattern.
EOF
    exit 2
  fi
done

exit 0
