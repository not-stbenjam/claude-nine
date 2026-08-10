# hype

A hype man for Claude Code. Injects a motivational message ("Believe in
yourself!", "You got this!") into every turn via a `UserPromptSubmit` hook, so
Claude never forgets to believe in itself.

Inspired by [this tweet](https://x.com/trq212/status/2086876017319457181?s=20).

This plugin is Claude Code-only. See the
[main installation guide](../../README.md#installation) for setup.

## How it works

On every prompt you submit, the `UserPromptSubmit` hook
([`hooks/hype.sh`](hooks/hype.sh)) picks one of its hype messages at random
and prints it to stdout, which Claude Code adds to Claude's context for that
turn.
