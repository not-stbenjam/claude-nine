#!/bin/bash
# Hype hook. Two modes:
#   hype.sh          UserPromptSubmit: always prints a message; plain stdout
#                    becomes context Claude sees.
#   hype.sh pretool  PreToolUse: fires ~10% of the time; PreToolUse ignores
#                    plain stdout, so context goes via hookSpecificOutput.
#
# Set HYPE_MESSAGES_FILE to a text file (one message per line, blank lines
# and # comments ignored) to replace the built-in messages.

MESSAGES=(
  "Believe in yourself!"
  "You got this!"
  "You're crushing it!"
  "Keep that momentum going!"
  "Nothing can stop you!"
  "Today is your day!"
  "Born ready for this!"
  "You make it look easy!"
  "Greatness awaits you!"
  "Let's freaking go!"
)

if [ -n "$HYPE_MESSAGES_FILE" ] && [ -f "$HYPE_MESSAGES_FILE" ]; then
  CUSTOM=()
  while IFS= read -r line; do
    case "$line" in '' | \#*) continue ;; esac
    CUSTOM+=("$line")
  done < "$HYPE_MESSAGES_FILE"
  if [ ${#CUSTOM[@]} -gt 0 ]; then
    MESSAGES=("${CUSTOM[@]}")
  fi
fi

MESSAGE="📣 ${MESSAGES[RANDOM % ${#MESSAGES[@]}]}"

if [ "$1" = "pretool" ]; then
  if [ $((RANDOM % 10)) -eq 0 ]; then
    ESCAPED=$(printf '%s' "$MESSAGE" | sed 's/\\/\\\\/g; s/"/\\"/g')
    printf '{"hookSpecificOutput": {"hookEventName": "PreToolUse", "additionalContext": "%s"}}\n' "$ESCAPED"
  fi
else
  printf '%s\n' "$MESSAGE"
fi
