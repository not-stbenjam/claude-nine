from __future__ import annotations

import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


SCRIPT = Path(__file__).parents[1] / "hooks" / "keepgoing.py"
SPEC = importlib.util.spec_from_file_location("keepgoing", SCRIPT)
assert SPEC and SPEC.loader
KEEPGOING = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(KEEPGOING)


class KeepGoingTests(unittest.TestCase):
    def test_first_stop_requests_one_completion_pass(self) -> None:
        result = KEEPGOING.response(
            {"hook_event_name": "Stop", "stop_hook_active": False}, {}
        )
        self.assertEqual(result["decision"], "block")
        self.assertTrue(result["reason"])
        self.assertIn("all booked events", result["reason"])
        self.assertIn("Did you do...?", result["reason"])

    def test_default_mode_does_not_recurse(self) -> None:
        result = KEEPGOING.response(
            {"hook_event_name": "Stop", "stop_hook_active": True}, {}
        )
        self.assertEqual(result, {})

    def test_infinite_mode_repeats(self) -> None:
        for value in ("1", "true", "YES", "on"):
            result = KEEPGOING.response(
                {"hook_event_name": "Stop", "stop_hook_active": True},
                {"KEEPGOING_INFINITE": value},
            )
            self.assertEqual(result["decision"], "block")

    def test_malformed_events_fail_open(self) -> None:
        for event in (
            None,
            {},
            {"hook_event_name": "Interrupt", "stop_hook_active": False},
            {"hook_event_name": "Stop"},
            {"hook_event_name": "Stop", "stop_hook_active": "false"},
        ):
            self.assertEqual(KEEPGOING.response(event, {}), {})

    def test_custom_messages_ignore_comments_and_blank_lines(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "messages.txt"
            path.write_text("# comment\n\nFinish the requested follow-through.\n", encoding="utf-8")
            result = KEEPGOING.response(
                {"hook_event_name": "Stop", "stop_hook_active": False},
                {"KEEPGOING_MESSAGES_FILE": str(path)},
            )
        self.assertEqual(result["reason"], "Finish the requested follow-through.")

    def test_cli_returns_json_and_fails_open_on_invalid_input(self) -> None:
        for payload in ("garbage", "null"):
            completed = subprocess.run(
                [sys.executable, str(SCRIPT)],
                input=payload,
                text=True,
                capture_output=True,
                check=True,
            )
            self.assertEqual(json.loads(completed.stdout), {})


if __name__ == "__main__":
    unittest.main()
