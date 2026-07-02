#!/usr/bin/env bash

# Claude Code status line script

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "unknown model"')
effort=$(echo "$input" | jq -r '.output_style.name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')

week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_resets=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

parts=()

# Model
parts+=("$model")

# Effort/output style
if [ -n "$effort" ]; then
  parts+=("effort:$effort")
fi

# Context used
if [ -n "$used_pct" ]; then
  parts+=("ctx:$(printf '%.0f' "$used_pct")%")
fi

# 5-hour rate limit
if [ -n "$five_pct" ]; then
  five_str="5h:$(printf '%.0f' "$five_pct")%"
  if [ -n "$five_resets" ]; then
    now=$(date +%s)
    secs_left=$(( five_resets - now ))
    if [ "$secs_left" -gt 0 ]; then
      mins_left=$(( secs_left / 60 ))
      hrs=$(( mins_left / 60 ))
      mins=$(( mins_left % 60 ))
      if [ "$hrs" -gt 0 ]; then
        five_str="$five_str(resets ${hrs}h${mins}m)"
      else
        five_str="$five_str(resets ${mins}m)"
      fi
    fi
  fi
  parts+=("$five_str")
fi

# 7-day rate limit
if [ -n "$week_pct" ]; then
  week_str="7d:$(printf '%.0f' "$week_pct")%"
  if [ -n "$week_resets" ]; then
    now=$(date +%s)
    secs_left=$(( week_resets - now ))
    if [ "$secs_left" -gt 0 ]; then
      days_left=$(( secs_left / 86400 ))
      hrs_left=$(( (secs_left % 86400) / 3600 ))
      if [ "$days_left" -gt 0 ]; then
        week_str="$week_str(resets ${days_left}d${hrs_left}h)"
      else
        mins_left=$(( secs_left / 60 % 60 ))
        week_str="$week_str(resets ${hrs_left}h${mins_left}m)"
      fi
    fi
  fi
  parts+=("$week_str")
fi

# Join with separator
printf '%s' "${parts[0]}"
for part in "${parts[@]:1}"; do
  printf ' | %s' "$part"
done
printf '\n'
