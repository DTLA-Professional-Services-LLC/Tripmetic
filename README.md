# Tripmetic

**Tripmetic** is a Flutter travel companion app: budgets, itineraries, live and offline maps, currency tools, and more — with optional **Tripmetic Pro** via RevenueCat.

## Features

- **Currency** — Default home tab: exchange rates and travel currency tools.
- **Itinerary** — Trip events and planning (backed by Hive + Firestore where configured).
- **Offline Map** — Mapbox dark-style map, search (Mapbox Search Box), driving/walking routes, turn-by-turn steps, optional live navigation, offline region downloads, and saved location marks (Hive).
- **More tools** — Budget, packing, scheduler, units, crypto, tips, size converter, mind map, settings, etc.

Navigation uses **go_router** with a bottom shell; some tools open full-screen routes.

## Tech stack

| Area | Packages / notes |
|------|------------------|
| UI & state | Flutter 3, **Riverpod**, Material 3 |
| Routing | **go_router** |
| Maps | **mapbox_maps_flutter** (public access token + Android downloads token) |
| Subscriptions | **RevenueCat** (`purchases_flutter`, `purchases_ui_flutter`). Android uses `FlutterFragmentActivity`. |
| Local storage | **Hive** / **hive_flutter** (itinerary, packing, currency/crypto caches, mind map, saved map locations) |
| Backend | **Firebase** (e.g. Firestore) where enabled |
| Location | **geolocator** (map centering, navigation) |

## Prerequisites

- Flutter SDK **^3.11.4** (see `pubspec.yaml`).
- **Mapbox**
  - Public token: set in the offline map screen / `MapboxOptions` where your project wires it.
  - Android: add `MAPBOX_DOWNLOADS_TOKEN` to `local.properties` so Gradle can resolve the Mapbox Maven artifacts (see `android/build.gradle.kts`).
- **RevenueCat** — Configure products and offerings in the dashboard; Pro-gated routes use your entitlement id (see app subscription code). Debug builds may bypass gates for development — see router and shell code.
- **Firebase** — `google-services` / `GoogleService-Info.plist` as usual for your Firebase project.

## Run the app

```bash
flutter pub get
flutter run
```

## Build

```bash
flutter build apk    # Android
flutter build ios    # iOS (on macOS)
```

## Project layout (high level)

- `lib/core/` — Theme, router, subscription guards.
- `lib/features/` — Feature modules (map, trip, currency, more, etc.).
- `lib/shared/` — Shared widgets (shell, app bar, etc.).

## Development notes

- Map-related secrets belong in **local.properties** or env — do not commit real Mapbox download tokens or API keys.
- After changing native permissions (location, etc.), do a full restart of the app on device/emulator.

## License

Private / unpublished (`publish_to: 'none'` in `pubspec.yaml`).
