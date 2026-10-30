#!/usr/bin/env python3
"""Generate Flutter ARB locale files from app_en.arb using Google Translate."""

from __future__ import annotations

import json
import re
import sys
import time
from pathlib import Path

from deep_translator import GoogleTranslator

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / "lib" / "l10n"
CACHE = ROOT / "tools" / ".arb_translation_cache.json"

LOCALES: dict[str, str] = {
    "zh": "zh-CN",
    "de": "de",
    "fr": "fr",
    "ja": "ja",
    "pt": "pt",
    "ko": "ko",
    "hi": "hi",
    "ar": "ar",
}

PLACEHOLDER_RE = re.compile(r"\{[a-zA-Z0-9_]+\}")
PIPE_SPLIT_KEYS = frozenset({"proPaywallBullets", "proPaywallBenefits"})

# Tokens protected during machine translation.
PROTECTED_TERMS = (
    "Tripmetic",
    "Tripmetic.app",
    "Tripmetic Pro",
    "RevenueCat",
    "Google Play",
    "Android",
    "iOS",
    "iPhone",
    "Firebase",
    "USD",
    "EUR",
    "GBP",
    "App Store",
    "Play Store",
    "ISO",
    "GPS",
    "PDF",
    "QR",
    "Wi‑Fi",
    "Wi-Fi",
    "p1.do",
    "Travel Recap",
    "DockTxt",
    "PayXT",
    "PermitMobile",
    "Trackkr",
    "Key Forecasts",
    "Stream CRM",
    "LinkInBioPremium",
    "Premium Selling",
    "TikTok",
    "TikTok Live",
    "Stripe",
    "PayPal",
    "macOS",
    "HVAC",
    "CRM",
    "AI",
    "SMS",
    "JSON",
)

# Platform / brand-like strings that should stay identical across locales.
EXACT_KEYS = frozenset({
    "appTitle",
    "ourAppsPlatformWeb",
    "ourAppsPlatformMacos",
    "ourAppsPlatformIosAndroid",
    "ourAppsPlatformIosAndroidWeb",
})


def load_cache() -> dict[str, dict[str, str]]:
    if CACHE.exists():
        return json.loads(CACHE.read_text(encoding="utf-8"))
    return {}


def save_cache(cache: dict[str, dict[str, str]]) -> None:
    CACHE.parent.mkdir(parents=True, exist_ok=True)
    CACHE.write_text(json.dumps(cache, ensure_ascii=False, indent=2), encoding="utf-8")


def protect(text: str) -> tuple[str, dict[str, str]]:
    mapping: dict[str, str] = {}

    def ph_repl(match: re.Match[str]) -> str:
        token = f"__PH{len(mapping)}__"
        mapping[token] = match.group(0)
        return token

    out = PLACEHOLDER_RE.sub(ph_repl, text)
    for term in PROTECTED_TERMS:
        if term in out:
            token = f"__BR{len(mapping)}__"
            mapping[token] = term
            out = out.replace(term, token)
    return out, mapping


def restore(text: str, mapping: dict[str, str]) -> str:
    out = text
    for token, original in mapping.items():
        out = out.replace(token, original)
    return out


def translate_value(
    translator: GoogleTranslator,
    value: str,
    *,
    retries: int = 4,
) -> str:
    if not value.strip():
        return value
    masked, mapping = protect(value)
    for attempt in range(retries):
        try:
            translated = translator.translate(masked)
            if translated is None:
                raise RuntimeError("empty translation")
            return restore(translated, mapping)
        except Exception:
            time.sleep(0.8 * (attempt + 1))
    raise RuntimeError(f"failed to translate: {value[:80]!r}")


def translate_pipe_string(translator: GoogleTranslator, value: str) -> str:
    parts = value.split("|")
    translated = [translate_value(translator, p.strip()) for p in parts]
    return "|".join(translated)


def _cache_get(locale_cache: dict, key: str, src: str) -> str | None:
    """Return cached translation when available and English source still matches."""
    entry = locale_cache.get(key)
    if isinstance(entry, dict):
        if entry.get("en") == src and isinstance(entry.get("tr"), str):
            return entry["tr"]
        return None
    # Legacy cache stored bare strings (no EN fingerprint).
    if isinstance(entry, str):
        return entry
    return None


def _cache_set(locale_cache: dict, key: str, src: str, translated: str) -> None:
    locale_cache[key] = {"en": src, "tr": translated}


def build_locale_arb(en: dict, locale: str, target: str, cache: dict[str, dict[str, str]]) -> dict:
    translator = GoogleTranslator(source="en", target=target)
    locale_cache = cache.setdefault(locale, {})
    out: dict = {"@@locale": locale}

    if "@@context" in en:
        ctx = en["@@context"]
        cached_ctx = _cache_get(locale_cache, "@@context", ctx)
        if cached_ctx is not None:
            out["@@context"] = cached_ctx
        else:
            out["@@context"] = translate_value(translator, ctx)
            _cache_set(locale_cache, "@@context", ctx, out["@@context"])
            save_cache(cache)

    keys = [k for k in en if not k.startswith("@") and k != "@@locale" and k != "@@context"]
    total = len(keys)
    for i, key in enumerate(keys, 1):
        if key in EXACT_KEYS:
            out[key] = en[key]
            continue

        src = en[key]
        cached = _cache_get(locale_cache, key, src)
        if cached is not None:
            out[key] = cached
            continue

        if key in PIPE_SPLIT_KEYS:
            translated = translate_pipe_string(translator, src)
        else:
            translated = translate_value(translator, src)

        out[key] = translated
        _cache_set(locale_cache, key, src, translated)

        if i % 25 == 0:
            save_cache(cache)
            print(f"  [{locale}] {i}/{total}", flush=True)
        time.sleep(0.05)

    # Copy metadata blocks from English unchanged (placeholders/types for codegen).
    for key, value in en.items():
        if key.startswith("@") and not key.startswith("@@"):
            out[key] = value

    save_cache(cache)
    return out


def main(argv: list[str]) -> int:
    en_path = L10N / "app_en.arb"
    en = json.loads(en_path.read_text(encoding="utf-8"))
    cache = load_cache()

    targets = LOCALES
    if len(argv) > 1:
        targets = {k: v for k, v in LOCALES.items() if k in argv[1:]}

    for locale, target in targets.items():
        out_path = L10N / f"app_{locale}.arb"
        print(f"Generating {out_path.name} -> {target}", flush=True)
        data = build_locale_arb(en, locale, target, cache)
        out_path.write_text(
            json.dumps(data, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        print(f"Wrote {out_path}", flush=True)

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
