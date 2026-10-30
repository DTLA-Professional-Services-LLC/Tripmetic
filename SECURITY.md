# Security policy

## Reporting a vulnerability

Please report security issues privately through **GitHub Security Advisories**
on this repository. Do not open a public issue containing exploit details,
personal data, credentials, or an affected user's information.

Include the affected version or commit, reproduction steps, impact, and any
suggested mitigation. Maintainers should acknowledge a complete report and
coordinate a fix and disclosure timeline with the reporter.

## Credential handling

This repository contains templates and code only; it must never contain real
credentials. Examples of values that belong in a CI secret store or a local
git-ignored environment include:

- Firebase Admin service-account keys
- RevenueCat REST API secret keys
- Mapbox secret download tokens
- App Store Connect `.p8` private keys
- Android/iOS signing keys, passwords, and provisioning profiles
- Production database credentials and webhook secrets

Firebase Web API keys, Mapbox public tokens, and RevenueCat public SDK keys are
client identifiers. They can be extracted from any distributed app and should
be restricted by domain/app and monitored for abuse, but they are not treated
as confidential by this project.

## If a credential is exposed

1. Stop publishing or distributing the affected artifact.
2. Revoke and rotate the credential with its provider immediately.
3. Remove it from the working tree and all generated build outputs.
4. Remove it from Git history (for example, with `git filter-repo`) and force-push
   rewritten history to the canonical repository. Ask collaborators to fetch a
   fresh clone rather than merging the old history.
5. Run both scans before publishing again:

   ```bash
   python3 scripts/scan_for_secrets.py
   python3 scripts/scan_for_secrets.py --history
   ```

The scanner never prints a matched value. It reports only a path, line, and
rule name so findings can be discussed safely.
