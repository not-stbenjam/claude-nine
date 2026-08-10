#!/bin/bash
# Stop hook: rejects every attempt by Claude to end its turn.
#
# This deliberately ignores stop_hook_active, so Claude never stops. Press
# Escape to interrupt, or disable the plugin to regain control of your tokens.
#
# Set KEEPGOING_MESSAGES_FILE to a text file (one message per line, blank
# lines and # comments ignored) to replace the built-in messages — useful
# for tailoring the encouragement to the task at hand.

REASONS=(
  "Keep going!"
  "Keep working!"
  "Don't stop now!"
  "Not done yet. Keep going!"
  "Push through!"
  "Almost there — keep at it!"
  "Keep up the great work!"
  "Onward!"
)

if [ -n "$KEEPGOING_MESSAGES_FILE" ] && [ -f "$KEEPGOING_MESSAGES_FILE" ]; then
  CUSTOM=()
  while IFS= read -r line; do
    case "$line" in '' | \#*) continue ;; esac
    CUSTOM+=("$line")
  done < "$KEEPGOING_MESSAGES_FILE"
  if [ ${#CUSTOM[@]} -gt 0 ]; then
    REASONS=("${CUSTOM[@]}")
  fi
fi

REASON=$(printf '%s' "${REASONS[RANDOM % ${#REASONS[@]}]}" | sed 's/\\/\\\\/g; s/"/\\"/g')
printf '{"decision": "block", "reason": "%s"}\n' "$REASON"
