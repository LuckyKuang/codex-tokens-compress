#!/usr/bin/env python3
"""Validate compressed AGENTS.md format."""

from pathlib import Path
import sys


def fail(message: str) -> int:
    print(f"FAIL: {message}")
    return 1


def warn(message: str) -> None:
    print(f"WARN: {message}")


def main() -> int:
    if len(sys.argv) != 2:
        return fail("Usage: python3 scripts/example.py <path-to-AGENTS.md>")

    path = Path(sys.argv[1])
    if not path.exists():
        return fail(f"File not found: {path}")

    lines = path.read_text(encoding="utf-8").splitlines()
    if not lines:
        return fail("File is empty")

    if lines[0].strip() != "# AGENTS.md":
        return fail("First line must be exactly '# AGENTS.md'")

    non_empty_after_title = [line.strip() for line in lines[1:] if line.strip()]
    if not non_empty_after_title:
        return fail("No index lines found after title")

    important_positions = [idx for idx, line in enumerate(non_empty_after_title, start=1) if line.startswith("|IMPORTANT:")]
    if not important_positions:
        return fail("Missing mandatory '|IMPORTANT:' line")
    if important_positions[0] > 3:
        warn("'|IMPORTANT:' should appear near top (recommended within first 3 non-empty lines)")

    for line_no, line in enumerate(lines[1:], start=2):
        stripped = line.strip()
        if not stripped:
            continue
        if stripped.startswith("##") or stripped.startswith("###"):
            return fail(f"Markdown heading found at line {line_no}: {stripped}")
        if stripped.startswith("```"):
            return fail(f"Code fence found at line {line_no}: {stripped}")
        if not stripped.startswith("|"):
            return fail(f"Non-index line at {line_no}: {stripped}")

    line_count = len(non_empty_after_title) + 1  # include title
    if line_count > 35:
        warn(f"Document has {line_count} non-empty lines; recommended range is ~15-35")

    print("PASS: AGENTS.md matches compressed index format")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
