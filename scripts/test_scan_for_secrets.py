#!/usr/bin/env python3
"""Unit tests for the value-safe secret scanner."""

from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parent))

import scan_for_secrets  # noqa: E402
from scan_for_secrets import Finding, scan_bytes  # noqa: E402


class SecretScannerTests(unittest.TestCase):
    def test_detects_google_api_key_without_exposing_value(self) -> None:
        value = "AIza" + ("A" * 35)
        findings = scan_bytes("config/example.txt", value.encode())

        self.assertEqual([finding.rule for finding in findings], ["google-api-key"])
        self.assertNotIn(value, findings[0].render())

    def test_detects_private_key(self) -> None:
        fixture = b"-----BEGIN " + b"PRIVATE KEY-----\nnot-a-real-key\n"
        findings = scan_bytes("config/example.txt", fixture)
        self.assertIn("private-key", {finding.rule for finding in findings})

    def test_ignores_documented_placeholders(self) -> None:
        content = b"API_KEY=YOUR_API_KEY\nTOKEN=example-token\n"
        self.assertEqual(scan_bytes(".env.example", content), [])

    def test_ignores_example_email(self) -> None:
        self.assertEqual(scan_bytes("README.md", b"admin@example.com"), [])

    def test_detects_literal_non_example_email(self) -> None:
        fixture = b"admin@" + b"personal.invalid"
        findings = scan_bytes("config/allowlist.txt", fixture)
        self.assertIn("literal-email", {finding.rule for finding in findings})

    def test_detects_sensitive_filename_without_scanning_binary_content(self) -> None:
        findings = scan_bytes("signing/upload.p12", b"\x00binary")
        self.assertEqual([finding.rule for finding in findings], ["sensitive-filename"])

    def test_detects_real_firebase_config_filename(self) -> None:
        findings = scan_bytes("android/app/google-services.json", b"{}")
        self.assertIn("sensitive-filename", {finding.rule for finding in findings})

    def test_allows_sensitive_filename_templates(self) -> None:
        for path in (
            ".env.example",
            "android/app/google-services.json.example",
            "android/key.properties.example",
        ):
            self.assertEqual(scan_bytes(path, b"{}"), [])

    def test_history_scan_remains_aligned_after_large_blob(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            subprocess.run(["git", "init", "-q"], cwd=root, check=True)
            subprocess.run(
                ["git", "config", "user.email", "test@example.com"], cwd=root, check=True
            )
            subprocess.run(["git", "config", "user.name", "Test"], cwd=root, check=True)
            (root / "large.txt").write_bytes(b"x" * (5 * 1024 * 1024 + 1))
            (root / "secret.txt").write_text(
                "AIza" + ("A" * 35) + "\n", encoding="utf-8"
            )
            subprocess.run(["git", "add", "."], cwd=root, check=True)
            subprocess.run(["git", "commit", "-qm", "fixture"], cwd=root, check=True)

            original_root = scan_for_secrets.ROOT
            scan_for_secrets.ROOT = root
            try:
                findings: list[Finding] = []
                for path, content in scan_for_secrets.history_blobs():
                    findings.extend(scan_for_secrets.scan_bytes(path, content))
            finally:
                scan_for_secrets.ROOT = original_root

            self.assertIn("google-api-key", {finding.rule for finding in findings})
            self.assertTrue(any(finding.path.endswith("secret.txt") for finding in findings))

    def test_finding_rendering_contains_no_value(self) -> None:
        finding = Finding("secret.txt", 7, "google-api-key")
        self.assertEqual(finding.render(), "secret.txt:7: google-api-key")


if __name__ == "__main__":
    unittest.main()
