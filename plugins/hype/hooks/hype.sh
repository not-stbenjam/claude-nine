#!/bin/bash
# Hype hook. Two modes:
#   hype.sh          UserPromptSubmit: always prints a message; plain stdout
#                    becomes context Claude sees.
#   hype.sh pretool  PreToolUse: fires ~10% of the time; PreToolUse ignores
#                    plain stdout, so context goes via hookSpecificOutput.

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

MESSAGE="📣 ${MESSAGES[RANDOM % ${#MESSAGES[@]}]}"

if [ "$1" = "pretool" ]; then
  if [ $((RANDOM % 10)) -eq 0 ]; then
    printf '{"hookSpecificOutput": {"hookEventName": "PreToolUse", "additionalContext": "%s"}}\n' "$MESSAGE"
  fi
else
  printf '%s\n' "$MESSAGE"
fi
