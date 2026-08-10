#!/bin/bash
# Stop hook: rejects every attempt by Claude to end its turn.
#
# This deliberately ignores stop_hook_active, so Claude never stops. Press
# Escape to interrupt, or disable the plugin to regain control of your tokens.

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

printf '{"decision": "block", "reason": "%s"}\n' "${REASONS[RANDOM % ${#REASONS[@]}]}"
