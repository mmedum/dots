#!/bin/bash
# Claude Code statusline — Gruvbox Material Dark theme
set -f

input=$(cat)
if [ -z "$input" ]; then
    printf "Claude"
    exit 0
fi

command -v jq >/dev/null 2>&1 || { printf "Claude (jq required)"; exit 0; }

# ── Gruvbox Material Dark palette ──
fg='\033[38;2;212;190;152m'       # #d4be98
red='\033[38;2;234;105;98m'       # #ea6962
green='\033[38;2;169;182;101m'    # #a9b665
yellow='\033[38;2;216;166;87m'    # #d8a657
blue='\033[38;2;125;174;163m'     # #7daea3
purple='\033[38;2;211;134;155m'   # #d3869b
aqua='\033[38;2;137;180;130m'     # #89b482
orange='\033[38;2;231;138;78m'    # #e78a4e
grey='\033[38;2;146;131;116m'     # #928374
bold='\033[1m'
reset='\033[0m'
sep=" ${grey}|${reset} "

# ── Helpers ──
format_tokens() {
    local n=$1
    if [ "$n" -ge 1000000 ] 2>/dev/null; then
        awk "BEGIN {printf \"%.1fm\", $n / 1000000}"
    elif [ "$n" -ge 1000 ] 2>/dev/null; then
        awk "BEGIN {printf \"%.0fk\", $n / 1000}"
    else
        printf "%d" "$n"
    fi
}

usage_color() {
    local pct=$1
    if [ "$pct" -ge 90 ] 2>/dev/null; then printf '%b' "$red"
    elif [ "$pct" -ge 70 ] 2>/dev/null; then printf '%b' "$orange"
    elif [ "$pct" -ge 50 ] 2>/dev/null; then printf '%b' "$yellow"
    else printf '%b' "$green"
    fi
}

# ── Extract all fields in a single jq call ──
# Record separator (\x1e) avoids POSIX read collapsing empty tab fields
IFS=$'\x1e' read -r model_name cwd ctx_size used_pct \
    input_tokens cache_create cache_read \
    cost_usd duration_ms \
    five_hour_pct five_hour_reset \
    seven_day_pct seven_day_reset \
    session_id vim_mode \
    < <(echo "$input" | jq -r '[
        (.model.display_name // "Claude"),
        (.cwd // .workspace.current_dir // ""),
        (.context_window.context_window_size // 200000),
        (.context_window.used_percentage // 0 | floor),
        (.context_window.current_usage.input_tokens // 0),
        (.context_window.current_usage.cache_creation_input_tokens // 0),
        (.context_window.current_usage.cache_read_input_tokens // 0),
        (.cost.total_cost_usd // 0),
        (.cost.total_duration_ms // 0),
        (.rate_limits.five_hour.used_percentage // -1 | floor),
        (.rate_limits.five_hour.resets_at // 0),
        (.rate_limits.seven_day.used_percentage // -1 | floor),
        (.rate_limits.seven_day.resets_at // 0),
        (.session_id // ""),
        (.vim.mode // "")
    ] | join("\u001e")')

# ── Effort level: env var → settings file → default ──
effort_level="${CLAUDE_CODE_EFFORT_LEVEL:-}"
if [ -z "$effort_level" ]; then
    settings_path="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/settings.json"
    [ -f "$settings_path" ] && effort_level=$(jq -r '.effortLevel // empty' "$settings_path" 2>/dev/null)
fi
effort_level="${effort_level:-medium}"

# ── Git info with caching ──
git_branch="" git_adds=0 git_dels=0 git_ahead=0 git_behind=0
if [ -n "$cwd" ] && [ -d "$cwd" ]; then
    git_cache_key=$(printf '%s:%s' "$session_id" "$cwd" | shasum 2>/dev/null | cut -c1-12)
    git_cache="/tmp/claude-sl-git-${git_cache_key:-fallback}"

    use_cache=false
    if [ -f "$git_cache" ]; then
        cache_age=$(( $(date +%s) - $(stat -f %m "$git_cache" 2>/dev/null || stat -c %Y "$git_cache" 2>/dev/null || echo 0) ))
        [ "$cache_age" -lt 10 ] && use_cache=true
    fi

    if $use_cache; then
        IFS='|' read -r git_branch git_adds git_dels git_ahead git_behind < "$git_cache"
    else
        git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
        if [ -n "$git_branch" ]; then
            read -r git_adds git_dels < <(git -C "$cwd" --no-optional-locks diff --numstat 2>/dev/null | awk '{a+=$1; d+=$2} END {printf "%d\t%d", a+0, d+0}')
            read -r git_ahead git_behind < <(git -C "$cwd" --no-optional-locks rev-list --left-right --count HEAD...@{upstream} 2>/dev/null || echo "0	0")
            printf '%s|%s|%s|%s|%s' "$git_branch" "${git_adds:-0}" "${git_dels:-0}" "${git_ahead:-0}" "${git_behind:-0}" > "$git_cache" 2>/dev/null
        else
            rm -f "$git_cache" 2>/dev/null
        fi
    fi
fi

# ── Build output ──
out=""

# Model
out+="${blue}${model_name}${reset}"

# Vim mode
if [ -n "$vim_mode" ]; then
    case "$vim_mode" in
        NORMAL) out+=" ${blue}NOR${reset}" ;;
        INSERT) out+=" ${green}INS${reset}" ;;
        *)      out+=" ${fg}${vim_mode}${reset}" ;;
    esac
fi

# Directory + git
if [ -n "$cwd" ]; then
    out+="${sep}${aqua}${cwd##*/}${reset}"
    if [ -n "$git_branch" ]; then
        out+="${grey}@${reset}${green}${git_branch}${reset}"
        [ "${git_ahead:-0}" -gt 0 ] && out+=" ${green}↑${git_ahead}${reset}"
        [ "${git_behind:-0}" -gt 0 ] && out+=" ${orange}↓${git_behind}${reset}"
        if [ "${git_adds:-0}" -gt 0 ] || [ "${git_dels:-0}" -gt 0 ]; then
            out+=" ${grey}(${reset}"
            [ "${git_adds:-0}" -gt 0 ] && out+="${green}+${git_adds}${reset}"
            [ "${git_adds:-0}" -gt 0 ] && [ "${git_dels:-0}" -gt 0 ] && out+=" "
            [ "${git_dels:-0}" -gt 0 ] && out+="${red}-${git_dels}${reset}"
            out+="${grey})${reset}"
        fi
    fi
fi

# Context window (bold + red warning when >= 80%)
current=$(( input_tokens + cache_create + cache_read ))
if [ "$used_pct" -ge 80 ] 2>/dev/null; then
    out+="${sep}${bold}${orange}$(format_tokens "$current")/${reset}${bold}${orange}$(format_tokens "$ctx_size")${reset}"
    out+=" ${grey}(${reset}${bold}${red}${used_pct}%${reset}${grey})${reset}"
else
    out+="${sep}${orange}$(format_tokens "$current")/${reset}${orange}$(format_tokens "$ctx_size")${reset}"
    pct_color=$(usage_color "$used_pct")
    out+=" ${grey}(${reset}${pct_color}${used_pct}%${reset}${grey})${reset}"
fi

# Effort
out+="${sep}${fg}effort:${reset} "
case "$effort_level" in
    low)    out+="${grey}low${reset}" ;;
    medium) out+="${yellow}med${reset}" ;;
    high)   out+="${orange}high${reset}" ;;
    max)    out+="${red}max${reset}" ;;
    *)      out+="${fg}${effort_level}${reset}" ;;
esac

# Rate limits (sentinel -1 = absent)
if [ "$five_hour_pct" -ge 0 ] 2>/dev/null; then
    fh_color=$(usage_color "$five_hour_pct")
    out+="${sep}${fg}5h${reset} ${fh_color}${five_hour_pct}%${reset}"
    if [ "$five_hour_reset" -gt 0 ] 2>/dev/null; then
        fh_time=$(date -j -r "$five_hour_reset" +"%H:%M" 2>/dev/null || date -d "@$five_hour_reset" +"%H:%M" 2>/dev/null)
        [ -n "$fh_time" ] && out+=" ${grey}@${fh_time}${reset}"
    fi
fi

if [ "$seven_day_pct" -ge 0 ] 2>/dev/null; then
    sd_color=$(usage_color "$seven_day_pct")
    out+="${sep}${fg}7d${reset} ${sd_color}${seven_day_pct}%${reset}"
    if [ "$seven_day_reset" -gt 0 ] 2>/dev/null; then
        sd_time=$(date -j -r "$seven_day_reset" +"%b %-d" 2>/dev/null || date -d "@$seven_day_reset" +"%b %-d" 2>/dev/null)
        [ -n "$sd_time" ] && out+=" ${grey}@${sd_time}${reset}"
    fi
fi

# Session cost
if [ -n "$cost_usd" ] && [ "$cost_usd" != "0" ]; then
    cost_fmt=$(printf '$%.2f' "$cost_usd")
    out+="${sep}${purple}${cost_fmt}${reset}"
fi

# Session duration
if [ "$duration_ms" -gt 0 ] 2>/dev/null; then
    total_secs=$(( duration_ms / 1000 ))
    hrs=$(( total_secs / 3600 ))
    mins=$(( (total_secs % 3600) / 60 ))
    secs=$(( total_secs % 60 ))
    if [ "$hrs" -gt 0 ]; then
        out+="${sep}${grey}${hrs}h $(printf '%02d' $mins)m${reset}"
    else
        out+="${sep}${grey}${mins}m $(printf '%02d' $secs)s${reset}"
    fi
fi

printf '%b' "$out"
exit 0
