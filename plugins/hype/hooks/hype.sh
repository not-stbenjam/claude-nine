#!/bin/bash
# UserPromptSubmit hook: prints one hype message to stdout, which Claude Code
# injects as context for Claude on every turn.

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

printf '📣 %s\n' "${MESSAGES[RANDOM % ${#MESSAGES[@]}]}"
