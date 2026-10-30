# Tripmetic operator scripts

These scripts use Google Application Default Credentials and require an
explicit Firebase project id. Never commit a service-account JSON file.

## Secret scanning

Before committing or publishing, scan the repository:

```bash
python3 scripts/scan_for_secrets.py
```

The scanner reports only the affected file, line, and rule name. It never
prints a matched credential. It checks tracked and untracked, non-ignored files,
credential-bearing filenames (including signing files), and common credential
patterns in text content. Binary file contents are skipped, while suspicious
filenames are still reported. Install it as a local pre-commit hook with:

```bash
git config core.hooksPath .githooks
```

To scan staged content and all reachable Git history as well:

```bash
python3 scripts/scan_for_secrets.py --staged
python3 scripts/scan_for_secrets.py --history
```

If the scanner reports a real credential, remove it from the working tree,
revoke/rotate it at the provider, and remove it from Git history before the
repository is made public.

## `create_admin_users.js`

Creates Firebase Auth users and grants the `admin: true` custom claim. The
Cloud Functions, Firestore rules, and web admin all authorize from that claim;
there is no public email allowlist in the source code.

```bash
export FIREBASE_PROJECT_ID="your-firebase-project-id"
export ADMIN_EMAILS="admin@example.com,other-admin@example.com"
export GOOGLE_APPLICATION_CREDENTIALS="/absolute/path/to/your-firebase-adminsdk.json"

node scripts/create_admin_users.js
```

Optional environment variables:

- `ADMIN_TEMP_PASSWORD` — shared temporary password. If omitted, a strong
  temporary password is generated and printed once.
- `--reset-password` — resets the password of accounts that already exist.

Administrators must sign in again after the claim is issued so Firebase
refreshes their ID token.

## `generate_codes.js`

Generate lifetime promo codes into Firestore `appsumo_codes` and export
`appsumo_codes.csv`.

### 1. Service account

1. Open [Firebase Console](https://console.firebase.google.com/) and select
   your own Firebase project.
2. Project settings → **Service accounts** → **Generate new private key**.
3. Save the JSON somewhere local (do **not** commit it).
4. Export the path and project id:

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/absolute/path/to/your-firebase-adminsdk.json"
export FIREBASE_PROJECT_ID="your-firebase-project-id"
```

### 2. Install & run

```bash
cd scripts
npm install
node generate_codes.js 500
node generate_codes.js 1000 --campaign=AppSumo_Tier1
node generate_codes.js 2000 --campaign=Dealify
```

Allowed counts: `500`, `1000`, `2000`.

CSV is written to the current working directory as `appsumo_codes.csv` (one code per line).
