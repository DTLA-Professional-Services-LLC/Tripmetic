# Tripmetic

**Tripmetic** is a Flutter travel companion: live currency tools, offline maps, multi-country budgets, packing lists, a global time scheduler, document vault, group planner, and more.

**Tripmetic Pro** is an auto-renewing monthly subscription (3-day free trial where eligible) that unlocks premium tools. A small set of features stays free without a subscription — see [Free vs Pro](#free-vs-pro) below.

## Open source

Tripmetic is an **open-source project provided by [DTLA Professional Services, LLC](https://dtlaprofessionalservices.com/)**. You are welcome to read the source, build it, self-host it, and contribute.

If you fork this project, please keep the attribution in place and note that the upstream project and its trademark are not granted by the license — see [License](#license).

### Security and credentials

No real credential is stored in this repository. Secrets such as the RevenueCat REST API key, Firebase Admin service-account key, Mapbox secret downloads token, App Store Connect `.p8` key, and Android signing keystore must be supplied through your CI secret store or local environment.

Firebase Web API keys, Mapbox **public** tokens, and RevenueCat **public** SDK keys are client identifiers rather than confidential credentials. They are intentionally absent from source control and injected at build time; anyone can extract them from a shipped app binary, so restrict them to your own domains/apps and rotate them if abused.

Before publishing or committing changes, run the repository scanner:

```bash
python3 scripts/scan_for_secrets.py
```

It reports only a file, line, and rule name—never the matched value. See
[SECURITY.md](SECURITY.md) for rotation and vulnerability-reporting guidance.

## Features

| Area | Description |
|------|-------------|
| **Dashboard** | Trip hub — pinned tools and quick access from the bottom bar or More menu. |
| **Currency** | In-app converter with live fiat rates (Firestore + Frankfurter fallback). **Pro** in the main app; the **Android home-screen widget** is free. |
| **Itinerary** | Trip events and planning (Hive + Firestore where configured). |
| **Offline map** | Mapbox map, search, routes, offline region downloads, saved locations. |
| **Budget** | Multi-destination trip budget with per-day estimates. |
| **Packing** | Categorized packing lists with hide-completed. |
| **Scheduler** | Global time / availability across time zones. |
| **Vault** | Travel documents for offline access. |
| **Bucket list** | World travel map and destination tracking. |
| **Group planner** | Shared trips with real-time sync. |
| **More tools** | Units, crypto, tip calculator, size converter, mind map, settings. |
| **Home-screen widgets (Android)** | **Currency converter** (live rates, refresh in background) and **Dual Clock** (two cities). |

Navigation uses **go_router** with a bottom shell; many tools open full-screen routes. Pro-gated screens use a soft glass overlay (`ProGlassOverlay`) with an in-app upgrade sheet.

## Free vs Pro

**Free (no subscription)**

- Dashboard, Settings, Units converter, Dual Clock (in-app + widget setup)
- **Currency home-screen widget** on Android — change currencies and refresh rates via `/currency-widget/*` deep links (does not require opening the Pro in-app Currency tool)

**Tripmetic Pro**

- Currency converter (in-app), itinerary, offline map, budget, packing, scheduler, vault, bucket list, group planner, crypto, tip calculator, size converter, mind map, and related Pro routes

Access is enforced via **RevenueCat** entitlements and `ProGlassOverlay` on individual features. Subscriptions require a **Google Play** or **App Store** install for billing; sideloaded APKs may show purchases as unavailable.

## Languages

The app supports **10 locales** (Settings → Language, or system default):

| Code | Language |
|------|----------|
| `en` | English |
| `es` | Español |
| `zh` | 简体中文 |
| `de` | Deutsch |
| `fr` | Français |
| `ja` | 日本語 |
| `pt` | Português |
| `ko` | 한국어 |
| `hi` | हिन्दी |
| `ar` | العربية |

Strings live in `lib/l10n/app_*.arb`. Generated code is in `lib/l10n/generated/`. See [Localization](#localization) for adding or updating translations.

## Tech stack

| Area | Packages / notes |
|------|------------------|
| UI & state | Flutter 3, **Riverpod**, Material 3 |
| Routing | **go_router** |
| i18n | **flutter_localizations**, ARB files, `l10n.yaml` |
| Maps | **mapbox_maps_flutter** (public access token injected at build time) |
| Subscriptions | **RevenueCat** (`purchases_flutter`, `purchases_ui_flutter`). Public SDK keys injected at build time — see [Configuration](#configuration). |
| Widgets | **home_widget** (Android currency + dual-clock widgets; background refresh entry point) |
| Local storage | **Hive** / **hive_flutter** |
| Backend | **Firebase** (Auth, Firestore) where enabled |
| Exchange rates | Firestore `fiat_rates/latest` with **Frankfurter** API fallback |
| Location | **geolocator** |

## Prerequisites

- Flutter SDK **^3.11.4** (see `version:` in `pubspec.yaml`).
- **Mapbox** — an account with a **public** access token (`pk.…`) for the map
  and geocoding, plus a **secret** downloads token (`sk.…`) for the Android
  Maven artifacts. Both come from [Mapbox → Account → Access tokens](https://account.mapbox.com/access-tokens/).
- **RevenueCat** — a Tripmetic Pro product, entitlement and current offering
  in the [RevenueCat dashboard](https://app.revenuecat.com). Link Google Play
  and the App Store, then copy the **public** SDK keys (`goog.…` / `appl.…`).
  Use public keys in the app only — the secret key stays in Cloud Functions.
- **Firebase** — a project with an Android app and an iOS app, so you can
  download `google-services.json` and `GoogleService-Info.plist`.
- **iOS** — an Apple developer team for signing, and App Store Connect
  metadata for the subscriptions.
- **Android widgets** — after changing widget `PendingIntent` handlers or
  providers, users may need to remove and re-add the widget on the home
  screen.

### 1. Create your local config files

No credential is committed to this repository. Every config file ships as a
`*.example` template, and the real file is git-ignored. Generate the local
copies with:

```bash
./scripts/setup_local_config.sh
```

That creates (skipping any that already exist):

| File | Fill it with |
|------|---------------|
| `android/app/google-services.json` | Firebase Console → Project settings → Your apps → **Android** → `google-services.json` |
| `ios/Runner/GoogleService-Info.plist` | Firebase Console → Project settings → Your apps → **iOS** → `GoogleService-Info.plist` |
| `webapp/.env.local` | Firebase Console → Project settings → Your apps → **Web** → SDK setup → config values |
| `.env` | Reference copy of `.env.example` (see [Configuration](#configuration)) |

Prefer to paste the files by hand? Equivalent commands:

```bash
cp android/app/google-services.json.example android/app/google-services.json
cp ios/Runner/GoogleService-Info.plist.example ios/Runner/GoogleService-Info.plist
cp webapp/.env.example webapp/.env.local
```

If you would rather not create the native files at all, pass the Firebase
values as `--dart-define` instead — see [Configuration](#configuration).

### 2. Pass your keys at compile time

The Flutter app reads every credential from `--dart-define`. Put your keys on
the command line:

```bash
flutter run \
  --dart-define=MAPBOX_ACCESS_TOKEN=pk.xxxxx \
  --dart-define=REVENUECAT_APPLE_KEY=appl.xxxxx \
  --dart-define=REVENUECAT_GOOGLE_KEY=goog.xxxxx
```

| Variable | Where it comes from | If it is missing |
|----------|--------------------|------------------|
| `MAPBOX_ACCESS_TOKEN` | Mapbox → Access tokens → **Public** token | Map views render a neutral surface; geocoding and directions stay off. |
| `REVENUECAT_APPLE_KEY` | RevenueCat → API keys → **App Store** (`appl.…`) | Subscriptions unavailable; the app stays usable. |
| `REVENUECAT_GOOGLE_KEY` | RevenueCat → API keys → **Google Play** (`goog.…`) | Same as above. |
| `FIREBASE_API_KEY` | Firebase Console → Project settings → General | Falls back to the native platform config files. |
| `FIREBASE_APP_ID` | Firebase Console → Project settings → General | Falls back to the native platform config files. |
| `FIREBASE_MESSAGING_SENDER_ID` | Firebase Console → Project settings → General | Falls back to the native platform config files. |
| `FIREBASE_PROJECT_ID` | Firebase Console → Project settings → General | Falls back to the native platform config files. |
| `FIREBASE_STORAGE_BUCKET` | Firebase Console → Project settings → General | Falls back to the native platform config files. |
| `FIREBASE_AUTH_DOMAIN` | Firebase Console → Project settings → General | Falls back to the native platform config files. |

Placeholders are compiled in as defaults, so the app **compiles and boots with
no configuration at all** — the affected feature degrades gracefully instead
of crashing. See `lib/core/config/app_secrets.dart` and
`lib/core/config/firebase_config.dart`.

To keep the command line short, use a JSON file (git-ignored):

```bash
flutter run --dart-define-from-file=config/local.json
```

```json
{
  "MAPBOX_ACCESS_TOKEN": "pk.xxxxx",
  "REVENUECAT_APPLE_KEY": "appl.xxxxx",
  "REVENUECAT_GOOGLE_KEY": "goog.xxxxx"
}
```

`.env.example` lists the same variable names for reference and for CI.

## Configuration

### Android signing

Release signing credentials are never in the repository. Supply them as
Gradle properties or environment variables (this is what CI should do):

```bash
export ORG_GRADLE_PROJECT_storeFile=/path/to/upload-keystore.jks
export ORG_GRADLE_PROJECT_storePassword=…
export ORG_GRADLE_PROJECT_keyAlias=upload
export ORG_GRADLE_PROJECT_keyPassword=…
```

or via the git-ignored `android/key.properties` (see
`android/key.properties.example`). With neither, release builds fall back to
the **debug keystore** — fine locally, never valid for store uploads.

### Android Mapbox downloads token

The secret Mapbox token used to fetch the Mapbox Maven artifacts is supplied
out-of-band:

```bash
export MAPBOX_DOWNLOADS_TOKEN=sk.xxxxx
# or: -PMAPBOX_DOWNLOADS_TOKEN=sk.xxxxx
# or: ~/.gradle/gradle.properties
```

### Web app

```bash
cp webapp/.env.example webapp/.env.local
```

`NEXT_PUBLIC_*` values are inlined into the client bundle at build time. They
are public identifiers rather than secrets — restrict the Firebase API key by
authorized domain and API in Google Cloud Console.

### Firebase project and administrators

Select the Firebase project explicitly instead of relying on a project alias in
source control:

```bash
export FIREBASE_PROJECT_ID="your-firebase-project-id"
firebase deploy --only hosting --project "$FIREBASE_PROJECT_ID"
```

Create admin accounts and grant the server-enforced `admin: true` Firebase Auth
custom claim:

```bash
export ADMIN_EMAILS="admin@example.com"
export GOOGLE_APPLICATION_CREDENTIALS="/absolute/path/to/your-firebase-adminsdk.json"
node scripts/create_admin_users.js
```

Admin email addresses are intentionally not stored in the repository. See
[`scripts/README.md`](scripts/README.md).

### Secret scanning and commit hook

The dependency-free scanner checks tracked files for common credential formats:

```bash
python3 scripts/scan_for_secrets.py
```

To enforce the same check before each local commit:

```bash
git config core.hooksPath .githooks
```

GitHub Actions runs the scanner on every push and pull request.

## Run the app

```bash
flutter pub get
flutter gen-l10n   # after editing .arb files

# With your own keys:
flutter run \
  --dart-define=MAPBOX_ACCESS_TOKEN=pk.xxxxx \
  --dart-define=REVENUECAT_APPLE_KEY=appl.xxxxx \
  --dart-define=REVENUECAT_GOOGLE_KEY=goog.xxxxx
```

Without any `--dart-define` the app still runs — maps and subscriptions are
simply disabled.

## Build

**Android (Play Store — App Bundle):**

```bash
flutter clean
flutter pub get
flutter build appbundle --release \
  --dart-define=MAPBOX_ACCESS_TOKEN=pk.xxxxx \
  --dart-define=REVENUECAT_APPLE_KEY=appl.xxxxx \
  --dart-define=REVENUECAT_GOOGLE_KEY=goog.xxxxx
```

Output: `build/app/outputs/bundle/release/app-release.aab`  
Increment the `+` build number in `pubspec.yaml` before each Play upload.

**iOS (App Store):**

```bash
flutter build ipa --release \
  --dart-define=MAPBOX_ACCESS_TOKEN=pk.xxxxx \
  --dart-define=REVENUECAT_APPLE_KEY=appl.xxxxx \
  --dart-define=REVENUECAT_GOOGLE_KEY=goog.xxxxx
```

Or open `ios/Runner.xcworkspace` in Xcode and archive. CI: `codemagic.yaml` at
repo root — it reads the same variables from the CI environment.

**APK (sideload / local test):**

```bash
flutter build apk --release
```


## Project layout

```
lib/
  app_bootstrap.dart       # Firebase, Hive, RevenueCat, home_widget callback
  tripmetic_app.dart       # MaterialApp, locale override, theme
  core/
    locale/                # supported_app_locales.dart, app_locale_provider.dart
    router/                # go_router, deep links (incl. currency-widget)
    subscription/          # RevenueCat state, Pro guards, paywall actions
    data/sync/             # Fiat rates (Firestore + Frankfurter composite)
  features/                # Feature modules (currency, map, trip, paywall, …)
  l10n/
    app_en.arb             # Template strings (edit here first)
    app_*.arb              # Per-locale translations
    generated/             # flutter gen-l10n output (do not edit by hand)
  services/
    widget_service.dart    # Android currency widget prefs + sync
    currency_widget_background_callback.dart
android/.../CurrencyWidgetProvider.kt   # Currency home-screen widget
tools/
  generate_arb_translations.py          # Machine-translate from English
  apply_arb_polish.py                   # Apply human-reviewed overrides
  arb_polish_overrides.json
```

## Localization

1. Add or change strings in **`lib/l10n/app_en.arb`** (template). Keep `{placeholders}` and brand names (`Tripmetic`, `RevenueCat`, `Android`, etc.) as documented in `@@context`.
2. Regenerate other locales (optional, uses Google Translate + cache):

   ```bash
   python3 -m venv .venv-l10n && .venv-l10n/bin/pip install deep-translator
   .venv-l10n/bin/python tools/generate_arb_translations.py
   ```

3. Apply curated fixes: edit `tools/arb_polish_overrides.json`, then:

   ```bash
   python3 tools/apply_arb_polish.py
   ```

4. Regenerate Dart bindings:

   ```bash
   flutter gen-l10n
   ```

Language names in Settings use native script labels from `lib/core/locale/supported_app_locales.dart`.

## Development notes

- Never commit credentials: Mapbox tokens, RevenueCat **secret** keys, Firebase Admin service-account files, keystores, `.p8` files, or `.env` values. Everything is injected at build time — see [Configuration](#configuration).
- Run `python3 scripts/scan_for_secrets.py` before committing. If it finds a real value, remove it from the file, **rotate/revoke it with the provider**, and purge it from Git history before publishing.
- After native permission or widget manifest changes, do a full restart on device.
- **RevenueCat:** Dashboard → Customers; bootstrap logs offering id when configure succeeds.
- **Currency widget:** Keys in `WidgetService` must match `CurrencyWidgetProvider.kt`. Free routes: `/currency-widget/select`, `/currency-widget/refresh`, `/currency-widget` (instructions).
- **Debug Pro locally:** Non-release builds can enable “Test as Tripmetic Pro” in Settings (ignored in release).

## License

Released under the **MIT License** — see [LICENSE](LICENSE).

```
MIT License

Copyright (c) 2026 DTLA Professional Services, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

Third-party dependencies remain under their own licenses (Flutter and the
Dart SDK — BSD-3-Clause; Mapbox SDK — Mapbox Terms of Service; Firebase,
RevenueCat, and the other pub.dev packages — their respective licenses).
