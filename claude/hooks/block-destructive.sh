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
# Extend the DESTRUCTIVE_PATTERNS array below for your own rules, and
# add a case to block-destructive_test.sh beside it: three of these
# patterns were believed to cover things they did not, and reading them
# is how that belief survived. The test feeds this script the same JSON
# Claude Code does and checks the exit status, so it exercises the
# classifier without running anything it classifies.

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
  # Any recursive rm, whatever the flag spelling and wherever the flag
  # sits in the run. Two changes from the pair of rules this replaces.
  #
  # Scope: recursion alone is enough, force is not required. The old
  # rules encoded "recursive AND force", but the force flag only
  # suppresses prompts for write-protected files and errors for missing
  # ones, and GNU rm prompts at all only when stdin is a terminal --
  # which it is not when a tool runs the command. So recursion without
  # force deletes exactly as thoroughly and as quietly. A block costs
  # one round trip; a deleted tree has no undo.
  #
  # Shape: matched over the whole flag run rather than one spelling,
  # because the old rules wanted both letters inside a single cluster
  # and let every other arrangement through. A rule per arrangement is
  # a hand-written list, and it goes stale the same way.
  #
  # The first rule reads a cluster after a single dash, so a long option
  # that merely contains the letter (--verbose, --preserve-root) does
  # not trip it. The long form is therefore named on its own line.
  'rm([[:space:]]+-[^[:space:]]+)*[[:space:]]+-[a-zA-Z]*[rR]'
  'rm([[:space:]]+-[^[:space:]]+)*[[:space:]]+--recursive'

  # Force-push, in any flag position and either form. The earlier
  # pattern required a space before -f, which the mandatory space after
  # "push" had already consumed, so `git push -f origin main` passed
  # while `git push origin -f` was caught. The optional token run below
  # is what lets the flag sit anywhere, and backtracking is what lets it
  # sit first. --force-with-lease is listed before --force because the
  # trailing boundary would otherwise reject it.
  'git[[:space:]]+push([[:space:]]+[^[:space:]]+)*[[:space:]]+(--force-with-lease|--force|-f)([[:space:]]|=|$)'

  # git clean with force: it deletes untracked files and there is no
  # undo. -n and --dry-run pass, which is how you find out what it would
  # have taken.
  'git[[:space:]]+clean([[:space:]]+[^[:space:]]+)*[[:space:]]+(-[a-z]*f[a-z]*|--force)([[:space:]]|$)'

  # find that deletes, in either idiom
  'find[[:space:]].*[[:space:]]-delete([[:space:]]|$)'
  'find[[:space:]].*-exec[[:space:]]+rm([[:space:]]|$)'

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
