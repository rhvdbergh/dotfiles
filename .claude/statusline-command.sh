#!/usr/bin/env bash
# Claude Code status line — robbyrussell-inspired
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
rate_used=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
rate_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')

# Short directory name (basename, with $HOME replaced by ~)
home="$HOME"
short_dir="${cwd/#$home/\~}"
basename_dir=$(basename "$short_dir")

# Git branch (skip optional locks)
git_branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree --no-optional-locks 2>/dev/null | grep -q true; then
  git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# ANSI colors (dimmed-friendly)
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Build the prompt segment
line=""

# Directory
line+=$(printf "${CYAN}%s${RESET}" "$basename_dir")

# Git branch
if [ -n "$git_branch" ]; then
  line+=$(printf " ${BLUE}git:(${GREEN}%s${BLUE})${RESET}" "$git_branch")
fi

# Model
line+=$(printf " ${YELLOW}%s${RESET}" "$model")

# Context usage bar
if [ -n "$used" ]; then
  width=12
  filled=$(printf "%.0f" "$(echo "$used * $width / 100" | bc -l 2>/dev/null || echo 0)")
  empty=$((width - filled))
  bar="["
  for ((i = 0; i < filled; i++)); do bar+="="; done
  for ((i = 0; i < empty; i++)); do bar+=" "; done
  bar+="]"
  line+=$(printf " %s${CYAN}%.0f%%${RESET}" "$bar" "$used")
fi

# 5-hour rate limit usage
if [ -n "$rate_used" ]; then
  RED='\033[0;31m'
  rate_int=$(printf "%.0f" "$rate_used")
  if [ "$rate_int" -ge 80 ]; then
    color="$RED"
  elif [ "$rate_int" -ge 50 ]; then
    color="$YELLOW"
  else
    color="$GREEN"
  fi
  # Show time until reset if available
  reset_str=""
  if [ -n "$rate_resets" ] && [ "$rate_resets" != "null" ]; then
    now=$(date +%s)
    remaining=$((rate_resets - now))
    if [ "$remaining" -gt 0 ]; then
      hrs=$((remaining / 3600))
      mins=$(((remaining % 3600) / 60))
      if [ "$hrs" -gt 0 ]; then
        reset_str=$(printf " resets %dh%dm" "$hrs" "$mins")
      else
        reset_str=$(printf " resets %dm" "$mins")
      fi
    fi
  fi
  line+=$(printf " ★ ${color}5h:%.0f%%%s${RESET}" "$rate_used" "$reset_str")
fi

printf "%b" "$line"
