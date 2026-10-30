#!/usr/bin/env python3
"""Apply curated translation fixes to generated ARB files."""

from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / "lib" / "l10n"
OVERRIDES = json.loads((ROOT / "tools" / "arb_polish_overrides.json").read_text(encoding="utf-8"))


def main() -> None:
    for locale, fixes in OVERRIDES.items():
        path = L10N / f"app_{locale}.arb"
        data = json.loads(path.read_text(encoding="utf-8"))
        for key, value in fixes.items():
            data[key] = value
        path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        print(f"Polished {path.name}: {len(fixes)} strings")


if __name__ == "__main__":
    main()
