#!/usr/bin/env python3
"""
Convert PNG/JPEG images under assets/ to WebP for smaller Flutter bundles.

Requirements:
  pip install pillow

Usage (from repo root):
  python tool/convert_assets_to_webp.py
  python tool/convert_assets_to_webp.py --quality 82 --delete-originals
  python tool/convert_assets_to_webp.py --dry-run

Notes:
  - Only scans the Flutter assets/ directory (not android/res or ios AppIcon sets).
  - assets/brand/app_icon*.png are used by flutter_launcher_icons in pubspec.yaml;
    keep those as PNG unless you regenerate launcher assets separately.
  - After conversion, add paths under flutter: assets: in pubspec.yaml and update
    Dart references (Image.asset, AssetImage) from .png/.jpg to .webp.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

try:
    from PIL import Image
except ImportError:
    print("Install Pillow: pip install pillow", file=sys.stderr)
    sys.exit(1)

RASTER_SUFFIXES = {".png", ".jpg", ".jpeg", ".PNG", ".JPG", ".JPEG"}
SKIP_NAMES = {"app_icon.png", "app_icon_foreground.png"}


def convert_file(src: Path, quality: int, delete_original: bool, dry_run: bool) -> Path | None:
    dst = src.with_suffix(".webp")
    if dry_run:
        print(f"[dry-run] {src} -> {dst}")
        return dst

    with Image.open(src) as im:
        im.save(dst, "WEBP", quality=quality, method=6)

    src_kb = src.stat().st_size / 1024
    dst_kb = dst.stat().st_size / 1024
    saved = 100 * (1 - dst_kb / src_kb) if src_kb else 0
    print(f"OK  {src.relative_to(repo_root)}  {src_kb:.1f}KB -> {dst_kb:.1f}KB  ({saved:.0f}% smaller)")

    if delete_original:
        src.unlink()
        print(f"    removed {src.name}")

    return dst


def scan_assets(assets_dir: Path) -> list[Path]:
    files: list[Path] = []
    for path in sorted(assets_dir.rglob("*")):
        if not path.is_file():
            continue
        if path.suffix not in RASTER_SUFFIXES:
            continue
        if path.name in SKIP_NAMES:
            print(f"SKIP (launcher_icons source): {path.relative_to(repo_root)}")
            continue
        files.append(path)
    return files


def main() -> int:
    parser = argparse.ArgumentParser(description="Convert assets/ raster images to WebP.")
    parser.add_argument(
        "--assets-dir",
        default="assets",
        help="Assets root relative to repo (default: assets)",
    )
    parser.add_argument("--quality", type=int, default=80, help="WebP quality 1-100")
    parser.add_argument(
        "--delete-originals",
        action="store_true",
        help="Delete PNG/JPEG after successful conversion",
    )
    parser.add_argument("--dry-run", action="store_true", help="List conversions only")
    args = parser.parse_args()

    global repo_root
    repo_root = Path(__file__).resolve().parent.parent
    assets_dir = (repo_root / args.assets_dir).resolve()

    if not assets_dir.is_dir():
        print(f"No assets directory at {assets_dir}", file=sys.stderr)
        return 1

    targets = scan_assets(assets_dir)
    if not targets:
        print(f"No convertible raster files under {assets_dir} (excluding launcher icon sources).")
        return 0

    converted: list[Path] = []
    for src in targets:
        out = convert_file(src, args.quality, args.delete_originals, args.dry_run)
        if out:
            converted.append(out)

    if converted and not args.dry_run:
        print("\n--- Next steps ---")
        print("1. Add under pubspec.yaml flutter: assets: (if not already):")
        for p in converted:
            rel = p.relative_to(repo_root).as_posix()
            print(f"   - {rel}")
        print("2. Grep lib/ for old paths and switch to .webp:")
        print("   rg \"\\.png|\\.jpg|assets/\" lib/")
        print("3. Do NOT delete assets/brand/app_icon*.png while using flutter_launcher_icons.")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
