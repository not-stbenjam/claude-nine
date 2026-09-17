# keepgoing

<table>
<tr>
<td width="25%">
<img src="assets/believe.png" alt="Clawd wearing headphones, singing: Don't stop believin'...">
</td>
<td width="75%">

Gives Claude Code or Codex one last chance to finish required follow-through
before ending a turn. By default it runs once, then honors the
`stop_hook_active` loop breaker so the agent can stop normally.

For experiments that truly need relentless continuation, infinite mode keeps
rejecting every stop until you interrupt the agent. It is deliberately opt-in.

Combine with [hype](../hype/) for the ultimate scientific buddy: one hook
that reminds Claude to believe in itself on every prompt, another that
refuses to ever let it give up.

</td>
</tr>
</table>

See the [main installation guide](../../README.md#installation) for Claude
Code and Codex setup. Codex requires you to review and trust the plugin hook
before it will run.

## Customization

### Infinite mode

Set `KEEPGOING_INFINITE=1` in the environment where you launch Claude Code or
Codex. Infinite mode ignores the loop breaker and can keep consuming tokens
until you interrupt the agent, so it should be enabled only intentionally.

For Claude Code, it can also be set per project:

```json
{
  "env": {
    "KEEPGOING_INFINITE": "1"
  }
}
```

### Completion messages

Set `KEEPGOING_MESSAGES_FILE` to a text file of your own encouragement —
one message per line; blank lines and `#` comments are ignored. Useful for
tailoring the completion check to the task at hand. Export it in the shell
where you launch your agent, or set it per project in `.claude/settings.json`:

```json
{
  "env": {
    "KEEPGOING_MESSAGES_FILE": "./keepgoing-messages.txt"
  }
}
```

## How it works

Whenever the agent first tries to finish its turn, the `Stop` hook
([`hooks/keepgoing.py`](hooks/keepgoing.py)) returns
`{"decision": "block", "reason": ...}`. The agent receives that reason as a
continuation prompt. When it stops again, the hook sees
`stop_hook_active: true` and allows the turn to end unless infinite mode is on.

Codex supplies the same `CLAUDE_PLUGIN_ROOT` compatibility variable used by
Claude Code, so both clients run the same hook definition and Python script.
