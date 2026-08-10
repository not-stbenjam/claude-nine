# hype

A hype man for Claude Code. Injects a motivational message ("Believe in
yourself!", "You got this!") into every turn via a `UserPromptSubmit` hook, so
Claude never forgets to believe in itself.

Inspired by [this tweet](https://x.com/trq212/status/2086876017319457181?s=20).

See the [main installation guide](../../README.md#installation) for Claude
Code, Codex, and standalone Agent Skills setup.

## How it works

On every prompt you submit, the `UserPromptSubmit` hook
([`hooks/hype.sh`](hooks/hype.sh)) picks one random message and prints it to
stdout, which Claude Code adds to Claude's context for that turn.

## Customization

Messages are plain text files: one message per line; blank lines and lines
starting with `#` are ignored. The hook checks these sources in order:

1. `$HYPE_MESSAGES_FILE` — set this environment variable to point at any file.
2. `~/.claude/hype-messages.txt` — create this file to override the defaults.
3. [`hooks/messages.txt`](hooks/messages.txt) — the 10 bundled defaults.

To customize, copy the bundled defaults and edit away:

```sh
cp hooks/messages.txt ~/.claude/hype-messages.txt
```

## Skills

<!-- BEGIN GENERATED SKILLS -->
- [`hype`](skills/hype/SKILL.md) — Deliver an enthusiastic, over-the-top pep talk about the current work, celebrating progress and building momentum for what's next.
<!-- END GENERATED SKILLS -->
