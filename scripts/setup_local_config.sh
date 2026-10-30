#!/usr/bin/env bash
#
# Creates the local (git-ignored) config files from the committed templates.
#
# Run once after cloning, then fill in your own values:
#
#   ./scripts/setup_local_config.sh
#
# Everything this script creates is ignored by .gitignore, so your real
# credentials never reach the repository.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

created=0
skipped=0

# copy_template <template> <target>
copy_template() {
    local template="$1"
    local target="$2"

    if [ ! -f "$template" ]; then
        echo "  ! template missing: $template" >&2
        return 1
    fi

    if [ -f "$target" ]; then
        echo "  - $target (already exists, left untouched)"
        skipped=$((skipped + 1))
        return 0
    fi

    cp "$template" "$target"
    echo "  + $target"
    created=$((created + 1))
}

echo "Setting up local config files in $ROOT"

copy_template "android/app/google-services.json.example" \
              "android/app/google-services.json" || true

copy_template "ios/Runner/GoogleService-Info.plist.example" \
              "ios/Runner/GoogleService-Info.plist" || true

copy_template "webapp/.env.example" "webapp/.env.local" || true

copy_template ".env.example" ".env" || true

echo
echo "Created $created file(s), skipped $skipped."
echo
echo "Next steps:"
echo "  1. Fill in your own values in:"
echo "       android/app/google-services.json"
echo "       ios/Runner/GoogleService-Info.plist"
echo "       webapp/.env.local"
echo "  2. (Optional) Fill in .env for reference — the Flutter app reads"
echo "     secrets from --dart-define, not from .env."
echo "  3. Run the app with your keys, e.g.:"
echo "       flutter run \\"
echo "         --dart-define=MAPBOX_ACCESS_TOKEN=pk.xxxxx \\"
echo "         --dart-define=REVENUECAT_APPLE_KEY=appl.xxxxx \\"
echo "         --dart-define=REVENUECAT_GOOGLE_KEY=goog.xxxxx"
echo "  4. Select your own Firebase project when deploying:"
echo "       firebase deploy --only hosting --project \"\$FIREBASE_PROJECT_ID\""
echo
echo "These files are git-ignored — never commit them."
