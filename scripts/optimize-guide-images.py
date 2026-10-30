#!/usr/bin/env python3
"""Crop phone UIs from marketing banners and emit SEO-friendly WebP assets."""
from __future__ import annotations

import subprocess
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[1] / "website"
SRC_065 = ROOT / "tripmetic-app-1920x1080px-images-065"
OUT = ROOT / "screenshots" / "optimized"
OUT.mkdir(parents=True, exist_ok=True)

# Dual-phone landscape banners (text left, phones right)
PHONE_CROPS = {
    "3.png": {
        "bucket-world-explored.webp": (860, 40, 1285, 1040),
        "bucket-list-categories.webp": (1310, 40, 1735, 1040),
    },
    "4.png": {
        "bucket-want-list.webp": (860, 40, 1285, 1040),
        "bucket-popular-toggles.webp": (1310, 40, 1735, 1040),
    },
    "5.png": {
        "bucket-popular-continents.webp": (860, 40, 1285, 1040),
        "bucket-map-view.webp": (1310, 40, 1735, 1040),
    },
    "6.png": {
        "group-trip-hub-dark.webp": (860, 40, 1285, 1040),
        "group-trip-hub-light.webp": (1310, 40, 1735, 1040),
    },
    "8.png": {
        "time-date-scheduler.webp": (860, 40, 1285, 1040),
        "global-scheduler-card.webp": (1310, 40, 1735, 1040),
    },
    "9.png": {
        "meeting-scheduler-am.webp": (860, 40, 1285, 1040),
        "meeting-scheduler-pm.webp": (1310, 40, 1735, 1040),
    },
}

# Existing portrait screenshots to recompress as WebP
RECOMPRESS = {
    "tripmetic-clock-widget-1242x2688px.png": "dual-clock-ios-widget.webp",
    "global-meeting-scheduler-tripmetic-01.png": "meeting-01.webp",
    "global-meeting-scheduler-tripmetic-02.png": "meeting-02.webp",
    "global-meeting-scheduler-tripmetic-03.png": "meeting-03.webp",
    "global-meeting-scheduler-tripmetic-04.png": "meeting-04.webp",
}


def save_webp(im: Image.Image, dest: Path, max_w: int = 720) -> None:
    im = im.convert("RGB")
    w, h = im.size
    if w > max_w:
        nh = int(h * (max_w / w))
        im = im.resize((max_w, nh), Image.Resampling.LANCZOS)
    tmp = dest.with_suffix(".tmp.png")
    im.save(tmp, format="PNG", optimize=True)
    # Prefer cwebp for smaller files
    try:
        subprocess.run(
            [
                "cwebp",
                "-q",
                "78",
                "-m",
                "6",
                "-mt",
                str(tmp),
                "-o",
                str(dest),
            ],
            check=True,
            capture_output=True,
        )
    except (FileNotFoundError, subprocess.CalledProcessError):
        im.save(dest, format="WEBP", quality=78, method=6)
    finally:
        if tmp.exists():
            tmp.unlink()
    print(f"  wrote {dest.relative_to(ROOT)} ({dest.stat().st_size // 1024}KB)")


def main() -> None:
    print("Cropping marketing banners…")
    for banner, mapping in PHONE_CROPS.items():
        path = SRC_065 / banner
        if not path.exists():
            print(f"  skip missing {banner}")
            continue
        im = Image.open(path)
        for name, box in mapping.items():
            save_webp(im.crop(box), OUT / name)

    print("Recompressing existing screenshots…")
    shots = ROOT / "screenshots"
    for src_name, dest_name in RECOMPRESS.items():
        src = shots / src_name
        if not src.exists():
            print(f"  skip missing {src_name}")
            continue
        save_webp(Image.open(src), OUT / dest_name)

    # Android dual-clock placeholder: crop middle widget strip from iOS marketing composite
    clock = shots / "tripmetic-clock-widget-1242x2688px.png"
    if clock.exists():
        im = Image.open(clock)
        w, h = im.size
        # Middle third often holds the home-widget showcase
        mid = im.crop((int(w * 0.08), int(h * 0.34), int(w * 0.92), int(h * 0.62)))
        save_webp(mid, OUT / "dual-clock-home-widget.webp", max_w=900)

    print("Done.")


if __name__ == "__main__":
    main()
