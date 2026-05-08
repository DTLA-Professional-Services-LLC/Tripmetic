# Tripmetic

**Tripmetic** is a Flutter travel companion: currency tools, offline maps, multi-country budgets, packing lists, a global time scheduler, and more. **All product features are offered through Tripmetic Pro** — an auto-renewing monthly subscription with a **3-day free trial** for eligible subscribers. There is no separate permanent free tier beyond the trial; access is defined in the app and store listings.

**Support & legal (public site)**  
- https://tripmetic.app/support.html  
- https://tripmetic.app/privacy.html  
- https://tripmetic.app/terms.html  

## Features

- **Currency** — Default home tab: exchange rates and travel currency tools.
- **Itinerary** — Trip events and planning (backed by Hive + Firestore where configured).
- **Offline map** — Mapbox map, search, routes, steps, optional navigation, offline region downloads, and saved locations (Hive).
- **More tools** — Budget, packing, global scheduler, units, crypto, tips, size converter, mind map, document vault, settings, etc.

Navigation uses **go_router** with a bottom shell; some tools open full-screen routes. **Pro access** is enforced in the app shell and router via **RevenueCat** customer info / entitlements.

## Tech stack

| Area | Packages / notes |
|------|------------------|
| UI & state | Flutter 3, **Riverpod**, Material 3 |
| Routing | **go_router** |
| Maps | **mapbox_maps_flutter** (public access token + Android downloads token) |
| Subscriptions | **RevenueCat** (`purchases_flutter`, `purchases_ui_flutter`). Public SDK keys and product/entitlement ids are wired in app bootstrap and `lib/core/subscription/`. **Android** uses a release build with Play Billing. |
| Local storage | **Hive** / **hive_flutter** (itinerary, packing, currency/crypto caches, mind map, scheduler prefs, saved map locations) |
| Backend | **Firebase** (e.g. Firestore) where enabled |
| Location | **geolocator** (map centering, navigation) |

## Prerequisites

- Flutter SDK **^3.11.4** (see `pubspec.yaml` for the current `version:` line).
- **Mapbox**
  - Public token: configured where the map initializes (`MapboxOptions`).
  - Android: add `MAPBOX_DOWNLOADS_TOKEN` to `local.properties` so Gradle can resolve Mapbox Maven artifacts (see `android/build.gradle.kts`).
- **RevenueCat** — Create the **Tripmetic Pro** product, entitlement, and current offering in the [RevenueCat dashboard](https://app.revenuecat.com). Link **Google Play** and **App Store** apps; use the **public** API keys in the app (not secret keys). Service account / store credentials are configured in RevenueCat for server-side product sync.
- **Firebase** — `google-services` (Android) / `GoogleService-Info.plist` (iOS) for your Firebase project.
- **iOS** — Sign with your Apple team; for subscriptions, complete App Store Connect metadata (privacy policy URL, terms/EULA, subscription group, review notes as required by Apple).

## Run the app

```bash
flutter pub get
flutter run
```

## Build

**Android (Play Store — App Bundle):**

```bash
flutter clean
flutter pub get
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`  
Increment the `+` build number in `pubspec.yaml` before each new Play upload (version code must always increase).

**iOS (App Store):**

```bash
flutter build ipa --release
```

Or open `ios/Runner.xcworkspace` in Xcode and archive. CI: `codemagic.yaml` at repo root can drive signed iOS/Android builds; ensure **App Store**-eligible export options for store submission (not internal-only TestFlight flags).

**APK (side load / local test):**

```bash
flutter build apk --release
```

## Project layout (high level)

- `lib/core/` — Theme, router, subscription (RevenueCat) state and guards.
- `lib/features/` — Feature modules (map, trip, currency, paywall, more, etc.).
- `lib/shared/` — Shared widgets (shell, app bar, etc.).
- `lib/app_bootstrap.dart` — Firebase, Hive, timezone, scheduler prefs, RevenueCat `Purchases.configure`, then `TripmeticApp`.

## Development notes

- Map-related secrets belong in **local.properties** or CI secrets — do not commit real Mapbox download tokens, RevenueCat secret keys, or keystores.
- After changing native permissions (location, billing, etc.), do a full restart on device/emulator.
- **Subscription debugging:** Use RevenueCat dashboard **Customers** and device logs; bootstrap prints a short **RevenueCat** line when offerings load successfully (filter logcat / Xcode console).

## License

Private / unpublished (`publish_to: 'none'` in `pubspec.yaml`).
