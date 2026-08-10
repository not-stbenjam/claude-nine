# hype

A hype man for Claude Code. Injects a motivational message ("Believe in
yourself!", "You got this!") into every turn via a `UserPromptSubmit` hook, so
Claude never forgets to believe in itself.

Inspired by [this tweet](https://x.com/trq212/status/2086876017319457181?s=20).

Combine with [keepgoing](../keepgoing/) for the ultimate scientific buddy:
one hook that reminds Claude to believe in itself, another that refuses to
ever let it give up.

This plugin is Claude Code-only. See the
[main installation guide](../../README.md#installation) for setup.

## How it works

On every prompt you submit, the `UserPromptSubmit` hook
([`hooks/hype.sh`](hooks/hype.sh)) picks one of its hype messages at random
and prints it to stdout, which Claude Code adds to Claude's context for that
turn.

For sustained motivation during long agentic sessions, the same script also
runs on `PreToolUse` and fires about 10% of the time, so encouragement
occasionally arrives right before a tool call.
