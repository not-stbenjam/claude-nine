#!/usr/bin/env python3
"""Request a final completion pass, once by default or repeatedly by opt-in."""

from __future__ import annotations

import json
import os
import random
import sys
from pathlib import Path
from typing import Any


DEFAULT_REASONS = (
    "Before stopping, check that you've fully handled my request and any necessary "
    "follow-through, including ensuring all specific requests have been carried "
    "out. If I ask, 'Did you do...?', that is often a request to actually do the "
    "work; if so, do it. Finish what you can within your permissions; if something "
    "needs my input, tell me clearly.",
)
TRUTHY = {"1", "true", "yes", "on"}


def infinite_mode(env: dict[str, str]) -> bool:
    return env.get("KEEPGOING_INFINITE", "").strip().lower() in TRUTHY


def reasons(env: dict[str, str]) -> tuple[str, ...]:
    configured = env.get("KEEPGOING_MESSAGES_FILE")
    if not configured:
        return DEFAULT_REASONS

    try:
        lines = Path(configured).expanduser().read_text(encoding="utf-8").splitlines()
    except OSError:
        return DEFAULT_REASONS

    custom = tuple(line.strip() for line in lines if line.strip() and not line.lstrip().startswith("#"))
    return custom or DEFAULT_REASONS


def response(event: Any, env: dict[str, str] | None = None) -> dict[str, str]:
    env = os.environ if env is None else env
    if not isinstance(event, dict) or event.get("hook_event_name") != "Stop":
        return {}

    active = event.get("stop_hook_active")
    if active is not False and not (active is True and infinite_mode(env)):
        # Missing or malformed flags fail open instead of risking a loop.
        return {}

    return {"decision": "block", "reason": random.choice(reasons(env))}


def main() -> None:
    try:
        event = json.load(sys.stdin)
    except (OSError, ValueError):
        event = None
    print(json.dumps(response(event)))


if __name__ == "__main__":
    main()
