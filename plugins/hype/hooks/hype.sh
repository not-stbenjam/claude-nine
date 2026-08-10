#!/bin/bash
# UserPromptSubmit hook: prints one hype message to stdout, which Claude Code
# injects as context for Claude on every turn.
#
# Message sources, in order of preference:
#   1. $HYPE_MESSAGES_FILE          (explicit override)
#   2. ~/.claude/hype-messages.txt  (user customization)
#   3. bundled messages.txt         (defaults)
# Message files are plain text: one message per line; blank lines and
# lines starting with # are ignored.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

MESSAGES_FILE="${HYPE_MESSAGES_FILE:-$HOME/.claude/hype-messages.txt}"
if [ ! -f "$MESSAGES_FILE" ]; then
  MESSAGES_FILE="$SCRIPT_DIR/messages.txt"
fi

# awk's srand() alone seeds from whole seconds; mix in $RANDOM so calls in
# the same second still vary.
MESSAGE="$(grep -v -e '^[[:space:]]*$' -e '^#' "$MESSAGES_FILE" 2>/dev/null |
  awk -v seed="$RANDOM" 'BEGIN { srand(seed) } { lines[NR] = $0 } END { if (NR) print lines[int(rand() * NR) + 1] }')"

if [ -n "$MESSAGE" ]; then
  printf '📣 %s\n' "$MESSAGE"
fi

exit 0
