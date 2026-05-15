# Tripmetic

Flutter travel companion app: budgets, itineraries, live/offline maps, currency tools, and more.

## Cursor Cloud specific instructions

### Overview

Tripmetic is a **single Flutter app** (not a monorepo). Primary targets are Android and iOS; web is available for development but requires Firebase web configuration (see below). See `README.md` for the full tech stack and prerequisites.

### Quick reference

| Task | Command |
|------|---------|
| Install deps | `flutter pub get` |
| Lint | `flutter analyze` |
| Test | `flutter test` |
| Build web | `flutter build web` |
| Run web (dev) | `flutter run -d chrome --web-port=8080 --web-hostname=0.0.0.0` |

### Flutter SDK

Flutter is installed at `/opt/flutter`. The PATH is set in `~/.bashrc`:
```
export PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:$PATH"
```

The project requires Dart SDK `^3.11.4` (Flutter 3.41+).

### Web target caveats

- `flutter run -d chrome` launches the app but **Firebase initialization fails at runtime** because `firebase_options.dart` does not exist and the web `index.html` has no Firebase JS SDK config. The app gracefully shows a "TRIPMETIC could not start" error screen. This is expected and not a code bug.
- To fully run the app on web, you would need to either generate `firebase_options.dart` via `flutterfire configure` and pass options to `Firebase.initializeApp()`, or add Firebase JS SDK initialization to `web/index.html`.
- **Linux desktop** target requires additional C++ toolchain packages (`lld`, `llvm`, `libstdc++-13-dev`) and may still hit GTK/glib header compatibility issues in the cloud VM environment.

### Testing

All tests are pure Dart unit/widget tests under `test/`. They do not require Firebase, device emulators, or any external services. Run with `flutter test`.

### Existing lint issues

`flutter analyze` reports 5 **info-level** `use_build_context_synchronously` warnings in `lib/features/map/presentation/map_screen.dart`. These are pre-existing and not errors.
