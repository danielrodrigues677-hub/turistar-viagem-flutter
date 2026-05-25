# AGENTS.md

## Cursor Cloud specific instructions

### Overview
This is a **Flutter 3.x** travel platform app (Turistar Viagem) targeting Web, iOS, and Android. The app is primarily a UI-demo with stubbed services — it does not connect to live backends.

### Flutter SDK
- Flutter is installed at `/opt/flutter` and added to PATH via `~/.bashrc`.
- SDK version: 3.24.5, Dart 3.5.4.

### Running the app
```bash
flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0
```
Chrome (`flutter run -d chrome`) also works if you need DevTools.

### Key commands
| Action | Command |
|--------|---------|
| Install deps | `flutter pub get` |
| Lint/analyze | `flutter analyze` |
| Build web | `flutter build web --no-tree-shake-icons` |
| Run web (debug) | `flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0` |
| Run tests | `flutter test` (no tests exist yet) |

### Gotchas
- **Firebase packages are disabled** in `pubspec.yaml` because the pinned versions (firebase_core ^2.24, firebase_auth ^4.10) are incompatible with Dart 3.5 (`PromiseJsImpl` type errors). Re-enable with updated versions when Firebase integration is needed.
- **`stripe_flutter` and `backdrop_filter`** packages do not exist on pub.dev and are commented out.
- **`web/index.html`** must use `<script src="flutter_bootstrap.js" async></script>` (not the old `flutter.js` script tag approach). This is required for Flutter 3.22+.
- **Asset directories** (`assets/images/`, `assets/icons/`, `assets/logos/`, `assets/fonts/`) must exist (even if empty with `.gitkeep`) for the build to succeed.
- **Font declarations** in `pubspec.yaml` are commented out; fonts are loaded via the `google_fonts` package at runtime.
- **No `pubspec.lock`** is committed; `flutter pub get` generates it fresh.
- **`flutter analyze` shows only warnings** (unused imports/fields). Zero errors.
