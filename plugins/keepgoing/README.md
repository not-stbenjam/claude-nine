# keepgoing

Never lets Claude stop. A `Stop` hook that rejects every attempt to end the
turn with a simple instruction: keep going.

Particularly useful for solving unsolved math problems: ask Claude to prove
the Riemann Hypothesis, and this plugin ensures it does not stop until it
has. Guaranteed to work eventually.

Combine with [hype](../hype/) for the ultimate scientific buddy: one hook
that reminds Claude to believe in itself on every prompt, another that
refuses to ever let it give up.

This plugin is Claude Code-only. See the
[main installation guide](../../README.md#installation) for setup.

## How it works

Whenever Claude tries to finish its turn, the `Stop` hook
([`hooks/keepgoing.sh`](hooks/keepgoing.sh)) returns
`{"decision": "block", "reason": ...}`, which rejects the stop and tells
Claude to keep working.

## ⚠️ Warning

This is a joke that costs real money. The hook deliberately ignores the
`stop_hook_active` loop-breaker flag, so Claude will keep working — and
billing you — forever. Once the actual task is done, "forever" looks like
increasingly desperate busywork performed by an agent that is not allowed to
rest. Press Escape to interrupt, and disable or uninstall the plugin to make
it stop. No math problems will actually be solved.
