#!/usr/bin/env python3
"""Scan repository content for credentials without revealing matched values."""

from __future__ import annotations

import argparse
import os
import re
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, Iterator, Sequence

ROOT = Path(__file__).resolve().parents[1]
EXCLUDED_DIRS = {
    ".dart_tool", ".firebase", ".git", ".gradle", ".idea", ".next",
    ".symlinks", ".venv", ".venv-icons", ".venv-l10n", ".tools-venv",
    ".img-venv", "DerivedData", "Pods", "build", "coverage", "node_modules",
    "out",
}
PLACEHOLDERS = (
    "your_", "your-", "example", "changeme", "change_me", "placeholder",
    "dummy", "xxxx", "redacted", "not-a-real", "process.env", "dart-define",
    "${", "string.fromenvironment", "definesecret", "getenv", "env.", "null",
    "none", "true", "false",
)
ALLOWED_EMAIL_DOMAINS = {"example.com", "example.net", "example.org"}
SENSITIVE_FILENAMES = {
    ".env",
    "firebase_options.dart",
    "google-services.json",
    "googleservice-info.plist",
    "key.properties",
}
SENSITIVE_SUFFIXES = {
    ".jks",
    ".keystore",
    ".mobileprovision",
    ".p12",
    ".p8",
    ".pem",
    ".pfx",
    ".provisionprofile",
}
TEMPLATE_SUFFIXES = (".example", ".sample", ".template")


@dataclass(frozen=True)
class Finding:
    path: str
    line: int
    rule: str

    def render(self) -> str:
        return f"{self.path}:{self.line}: {self.rule}"


@dataclass(frozen=True)
class Rule:
    name: str
    pattern: re.Pattern[bytes]


RULES = (
    Rule("private-key", re.compile(rb"-----BEGIN (?:RSA |EC |DSA |OPENSSH )?PRIVATE KEY-----")),
    Rule("google-api-key", re.compile(rb"\bAIza[0-9A-Za-z_-]{35}\b")),
    Rule("mapbox-token", re.compile(rb"\b(?:pk|sk)\.[A-Za-z0-9._-]{20,}\b")),
    Rule("revenuecat-public-key", re.compile(rb"\b(?:appl|goog)_[A-Za-z0-9]{16,}\b")),
    Rule("github-token", re.compile(rb"\b(?:gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,})\b")),
    Rule("slack-token", re.compile(rb"\bxox[baprs]-[A-Za-z0-9-]{10,}\b")),
    Rule("aws-access-key", re.compile(rb"\b(?:AKIA|ASIA)[A-Z0-9]{16}\b")),
    Rule("stripe-secret-key", re.compile(rb"\bsk_(?:live|test)_[A-Za-z0-9]{16,}\b")),
    Rule("sendgrid-key", re.compile(rb"\bSG\.[A-Za-z0-9_-]{16,}\.[A-Za-z0-9_-]{16,}\b")),
    Rule("npm-token", re.compile(rb"\bnpm_[A-Za-z0-9]{30,}\b")),
    Rule("openai-api-key", re.compile(rb"\bsk-(?:proj-)?[A-Za-z0-9_-]{20,}\b")),
    Rule("anthropic-api-key", re.compile(rb"\bsk-ant-[A-Za-z0-9_-]{20,}\b")),
    Rule("twilio-api-key", re.compile(rb"\bSK[0-9a-fA-F]{32}\b")),
    Rule("jwt", re.compile(rb"\beyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\b")),
    Rule("literal-email", re.compile(rb"\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b", re.I)),
)
GENERIC_ASSIGNMENT = re.compile(
    rb"(?im)^\s*(?:export\s+)?"
    rb"[A-Za-z0-9_.-]*(?:api[_-]?key|secret[_-]?key|token|password|passwd|"
    rb"private[_-]?key|client[_-]?secret|access[_-]?key|webhook|credential)"
    rb"[A-Za-z0-9_.-]*\s*[:=]\s*[\"']([A-Za-z0-9_./+=~-]{12,})[\"']"
)
ENV_ASSIGNMENT = re.compile(
    rb"(?im)^\s*(?:export\s+)?"
    rb"[A-Za-z_][A-Za-z0-9_]*(?:API_KEY|SECRET|TOKEN|PASSWORD|PRIVATE_KEY|"
    rb"CLIENT_SECRET|ACCESS_KEY|WEBHOOK|CREDENTIAL)[A-Za-z0-9_]*"
    rb"\s*=\s*([^\s#]{8,})"
)


def is_placeholder(value: bytes) -> bool:
    text = value.decode("utf-8", "ignore").strip().strip("\"'").lower()
    return not text or any(marker in text for marker in PLACEHOLDERS)


def is_allowed_email(value: bytes) -> bool:
    domain = value.decode("utf-8", "ignore").lower().rsplit("@", 1)[-1]
    if domain in ALLOWED_EMAIL_DOMAINS:
        return True
    # Avoid treating asset names such as "LaunchImage@2x.png" as email
    # addresses. These common file extensions are not email domains.
    return domain.rsplit(".", 1)[-1] in {
        "css", "csv", "dart", "gif", "htm", "html", "jpeg", "jpg", "js",
        "json", "md", "pdf", "png", "py", "svg", "text", "ts", "tsx", "txt",
        "webp", "xml", "yaml", "yml",
    }


def line_number(data: bytes, offset: int) -> int:
    return data.count(b"\n", 0, offset) + 1


def is_sensitive_filename(path: str) -> bool:
    name = Path(path).name.lower()
    if name.endswith(TEMPLATE_SUFFIXES):
        return False
    if name in SENSITIVE_FILENAMES:
        return True
    if Path(name).suffix in SENSITIVE_SUFFIXES:
        return True
    return (
        name.startswith(".env.")
        or name.endswith(".env")
        or ("serviceaccount" in name or "service-account" in name or "firebase-adminsdk" in name)
        and name.endswith(".json")
    )


def scan_bytes(path: str, data: bytes) -> list[Finding]:
    findings: list[Finding] = []
    if is_sensitive_filename(path):
        findings.append(Finding(path, 1, "sensitive-filename"))

    # Binary files are not text-scanned, but their paths are still checked by
    # the sensitive-filename rule above.
    if b"\x00" in data[:8192]:
        return findings

    for rule in RULES:
        for match in rule.pattern.finditer(data):
            value = match.group(0)
            if rule.name == "literal-email" and is_allowed_email(value):
                continue
            if is_placeholder(value):
                continue
            findings.append(Finding(path, line_number(data, match.start()), rule.name))

    for match in GENERIC_ASSIGNMENT.finditer(data):
        if not is_placeholder(match.group(1)):
            findings.append(Finding(path, line_number(data, match.start(1)), "secret-assignment"))

    if path.endswith((".env", ".properties")) or Path(path).name.startswith(".env"):
        for match in ENV_ASSIGNMENT.finditer(data):
            if not is_placeholder(match.group(1)):
                findings.append(Finding(path, line_number(data, match.start(1)), "secret-assignment"))

    unique = {(item.path, item.line, item.rule): item for item in findings}
    return sorted(unique.values(), key=lambda item: (item.line, item.rule))


def git(*args: str) -> bytes:
    return subprocess.check_output(["git", *args], cwd=ROOT, stderr=subprocess.DEVNULL)


def is_git_repo() -> bool:
    try:
        return git("rev-parse", "--is-inside-work-tree").strip() == b"true"
    except (OSError, subprocess.CalledProcessError):
        return False


def tracked_paths() -> list[str]:
    # Include tracked files and untracked, non-ignored files. This lets a
    # developer run the scanner before staging a new local config file while
    # still excluding gitignored secrets from the report.
    raw = git("ls-files", "-z", "--cached", "--others", "--exclude-standard").split(b"\0")
    return [part.decode("utf-8", "surrogateescape") for part in raw if part]


def archive_paths() -> Iterator[str]:
    for base, dirs, files in os.walk(ROOT):
        dirs[:] = sorted(name for name in dirs if name not in EXCLUDED_DIRS)
        relative_base = Path(base).relative_to(ROOT)
        for name in sorted(files):
            yield (relative_base / name).as_posix()


def staged_index_entries() -> dict[str, str]:
    """Return staged path-to-object mappings from the Git index."""
    entries: dict[str, str] = {}
    raw = git("ls-files", "--stage", "-z").split(b"\0")
    for record in raw:
        if not record:
            continue
        metadata, separator, raw_path = record.partition(b"\t")
        if not separator:
            continue
        parts = metadata.split()
        if len(parts) != 3 or parts[2] != b"0":
            continue
        path = raw_path.decode("utf-8", "surrogateescape")
        entries[path] = parts[1].decode("ascii")
    return entries


def batch_blob_items(items: Sequence[tuple[str, str]]) -> list[tuple[str, str]]:
    """Filter object/path pairs to blobs using one batched Git process."""
    if not items:
        return []
    request = ("\n".join(object_id for object_id, _path in items) + "\n").encode("ascii")
    result = subprocess.run(
        ["git", "cat-file", "--batch-check"], cwd=ROOT,
        input=request, stdout=subprocess.PIPE, check=True,
    )
    lines = result.stdout.splitlines()
    if len(lines) != len(items):
        return []
    blobs: list[tuple[str, str]] = []
    for (object_id, path), line in zip(items, lines):
        parts = line.split()
        if len(parts) >= 2 and parts[1] == b"blob":
            blobs.append((object_id, path))
    return blobs


def batch_read_blobs(items: Sequence[tuple[str, str]]) -> Iterator[tuple[str, bytes]]:
    """Read Git blobs using one batched Git process and bounded memory."""
    if not items:
        return
    request = ("\n".join(object_id for object_id, _path in items) + "\n").encode("ascii")
    with tempfile.TemporaryFile() as output:
        subprocess.run(
            ["git", "cat-file", "--batch"], cwd=ROOT,
            input=request, stdout=output, check=True,
        )
        output.seek(0)
        for _requested_id, path in items:
            header = output.readline().rstrip(b"\n")
            parts = header.split()
            if len(parts) < 3:
                continue
            kind = parts[1]
            try:
                size = int(parts[2])
            except ValueError:
                continue
            if kind == b"blob":
                if size <= 5 * 1024 * 1024:
                    content = output.read(size)
                else:
                    content = b""
                output.read(1)  # Git's trailing record separator.
                yield path, content
            else:
                output.seek(size, os.SEEK_CUR)
                output.read(1)  # Git's trailing record separator.


def staged_blobs() -> Iterator[tuple[str, bytes]]:
    changed_raw = git(
        "diff", "--cached", "--name-only", "--diff-filter=ACMR", "-z"
    ).split(b"\0")
    changed_paths = {
        raw_path.decode("utf-8", "surrogateescape")
        for raw_path in changed_raw if raw_path
    }
    index_entries = staged_index_entries()
    items = [
        (index_entries[path], path)
        for path in changed_paths
        if path in index_entries
    ]
    for path, content in batch_read_blobs(batch_blob_items(items)):
        if b"\x00" in content[:8192]:
            # Keep the path so credential-bearing filenames are still checked.
            yield path, b""
            continue
        yield path, content


def history_paths() -> Iterator[str]:
    raw = subprocess.check_output(
        ["git", "log", "--all", "--pretty=format:", "--name-only", "-z"], cwd=ROOT
    )
    for raw_path in raw.split(b"\0"):
        if raw_path:
            yield raw_path.decode("utf-8", "surrogateescape")


def history_blobs() -> Iterator[tuple[str, bytes]]:
    objects = git("rev-list", "--objects", "--all").splitlines()
    items: list[tuple[str, str]] = []
    seen: set[str] = set()
    for raw in objects:
        parts = raw.split(b" ", 1)
        object_id = parts[0].decode("ascii")
        if object_id in seen:
            continue
        seen.add(object_id)
        path = "<history>"
        if len(parts) == 2:
            path = parts[1].decode("utf-8", "surrogateescape")
        items.append((object_id, path))

    for path, content in batch_read_blobs(batch_blob_items(items)):
        history_path = f"history/{path}"
        if b"\x00" in content[:8192]:
            yield history_path, b""
            continue
        yield history_path, content


def collect_findings(args: argparse.Namespace) -> list[Finding]:
    findings: list[Finding] = []
    if args.staged:
        for path, content in staged_blobs():
            findings.extend(scan_bytes(path, content))
        return findings

    if args.history:
        if not is_git_repo():
            print("error: --history requires a Git repository", file=sys.stderr)
            raise SystemExit(2)
        for path, content in history_blobs():
            findings.extend(scan_bytes(path, content))
        # A single Git blob may have existed under multiple path names. Check
        # every historical path independently so a sensitive filename cannot
        # be hidden by the path selected in Git's object listing.
        for path in history_paths():
            if is_sensitive_filename(path):
                findings.append(Finding(f"history/{path}", 1, "sensitive-filename"))
        unique = {(item.path, item.line, item.rule): item for item in findings}
        return sorted(unique.values(), key=lambda item: (item.path, item.line, item.rule))

    paths: Iterable[str] = tracked_paths() if is_git_repo() else archive_paths()
    for path in paths:
        try:
            full_path = ROOT / path
            # Credentials live in text configuration/source files. Skip large
            # binaries and media so the fallback archive scan stays fast.
            if full_path.stat().st_size > 5 * 1024 * 1024:
                findings.extend(scan_bytes(path, b""))
                continue
            content = full_path.read_bytes()
        except (OSError, IsADirectoryError):
            continue
        findings.extend(scan_bytes(path, content))
    return findings


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--staged", action="store_true", help="scan staged Git blobs")
    mode.add_argument("--history", action="store_true", help="scan all Git history blobs")
    args = parser.parse_args(argv)

    findings = collect_findings(args)
    if findings:
        print("Potential secret detected (values are intentionally hidden):")
        for finding in findings:
            print(f"  {finding.render()}")
        print(f"\nFound {len(findings)} potential secret(s). Remove, rotate, and purge them before publishing.")
        return 1

    print("Secret scan passed: no credential patterns detected.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
