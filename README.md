### WarmNest

WarmNest is a multi-screen Flutter application designed to support mental wellness with a serene dark-mode first experience. It offers guided breathing exercises, a supportive chatbot, journaling, music therapy, focus (Pomodoro) tools, and basic assessment, with persistent local storage and simple internationalization (English and Tamil).

## Features
- **Dashboard and Navigation**: Drawer-based navigation with a dark, minimal UI.
- **Breathing Exercises**: Track breathing sessions and durations.
- **Chatbot (stub)**: Conversational interface scaffold with local history storage.
- **Journal**: Write and store journal entries with timestamps and tags.
- **Music Therapy**: Intended integration with `audioplayers` for calming audio.
- **Focus Mode (Pomodoro)**: Track focus/break cycles and session history.
- **Task Assessment**: Placeholder for lightweight self-assessments.
- **Profile and Onboarding**: Basic profile, theme, and language settings with onboarding flow.
- **Dark/Light Theme**: Comprehensive theming in `lib/theme.dart` with Material 3.
- **Internationalization (i18n)**: Simple string map-based i18n in `lib/i18n.dart` for `en` and `ta`.
- **Local Persistence**: `SharedPreferences`-backed storage via `lib/storage_service.dart`.

## Architecture Overview
- **Entry point**: `lib/main.dart`
  - Initializes error handling and wires up `AppState` via `AppStateProvider`.
  - Chooses initial screen based on login and onboarding state.
  - Declares named routes for feature screens.
- **State Management**: Minimal, custom `ChangeNotifier` in `lib/app_state.dart`.
  - Holds `UserProfile`, mood logs, journal entries, breathing/pomodoro sessions, and chat history.
  - Persists changes through `StorageService`.
- **Storage**: `lib/storage_service.dart`
  - Thin wrapper over `SharedPreferences` for JSON, lists, strings, and booleans.
- **Models**: `lib/models.dart`
  - Immutable models with `toJson`/`fromJson` for persistence.
- **Theming**: `lib/theme.dart`
  - Light and dark color palettes with an Inter-based `TextTheme`.
- **i18n**: `lib/i18n.dart`
  - String lookups keyed by `AppState.language`.
- **UI**: `lib/home_page.dart` plus feature screens under `lib/screens/` (see note in Issues).

## Project Structure
```
lib/
  app_state.dart           # App-wide state (ChangeNotifier)
  home_page.dart           # Drawer-based navigation shell
  i18n.dart                # Simple i18n key-value store
  main.dart                # App entry, routing
  models.dart              # Data models and JSON helpers
  storage_service.dart     # SharedPreferences-backed persistence
  theme.dart               # Material 3 themes and typography
  screens/                 # Feature screens (expected)
```

## Getting Started
Prerequisites:
- Flutter SDK (3.6+ per `pubspec.yaml` environment)
- Dart SDK (bundled with Flutter)
- Android Studio/Xcode for mobile builds

Install dependencies:
```bash
flutter pub get
```

Run on a device or emulator:
```bash
flutter run
```

Run for the web:
```bash
flutter run -d chrome
```

Build release artifacts:
```bash
# Android APK/AAB
flutter build apk
flutter build appbundle

# iOS (requires macOS/Xcode)
flutter build ios --release

# Web
flutter build web --release
```

## Configuration
- **App ID (Android)**: `android/app/build.gradle` currently uses `com.example.warmnest`. Change to your unique ID before publishing.
- **Signing (Android)**: Release build type uses debug signing by default. Provide a `key.properties` and update `signingConfigs.release` for production.
- **iOS Podfile**: Uses `use_frameworks!`. Ensure this aligns with your plugin set and performance expectations.
- **Fonts**: The theme references the `Inter` font family, but no font asset or `google_fonts` is configured (see Issues). Add fonts to `pubspec.yaml` or use `google_fonts`.

## State, Storage, and Privacy
- Data (profile, moods, journals, sessions, chat history) is stored locally using `SharedPreferences`.
- No network sync is implemented. All data is device-local and unencrypted at rest by default (see Issues for security considerations).

## Internationalization
- Keys are defined in `lib/i18n.dart` for `en` and `ta`.
- Language can be toggled in `AppState` via `setLanguage`, and UI strings are retrieved using `I18n.t(context, key)`.

## Known Screens and Routes
Declared routes in `main.dart`:
- `/breathing`, `/chatbot`, `/journal`, `/music`, `/focus`, `/assessment`, `/login`, `/onboarding`

The `HomePage` drawer also references `Dashboard` and `Profile`. Ensure corresponding widgets exist under `lib/screens/`.

## Identified Issues and Gaps
1. Missing screens in repository
   - `main.dart` and `home_page.dart` import many widgets under `lib/screens/` (e.g., `breathing_exercises_screen.dart`, `chatbot_screen.dart`, `journal_screen.dart`, `music_therapy_screen.dart`, `focus_mode_screen.dart`, `task_assessment_screen.dart`, `login_screen.dart`, `onboarding_screen.dart`, `dashboard_screen.dart`, `profile_screen.dart`), but the `lib/screens/` directory does not exist in the workspace snapshot. The app will not compile until these files are added.
2. Hard-coded user details in drawer
   - `home_page.dart` displays a hard-coded user avatar and email. It should bind to `AppState.user` and avoid placeholder data.
3. Non-functional search field in drawer
   - The search UI is static. Consider implementing search or removing the control.
4. Inconsistent navigation patterns
   - `HomePage` both swaps local `_screens` and pushes named routes on tap. Pick one pattern to avoid duplicate stacks and inconsistent state.
5. Theme references `Inter` without font setup
   - `theme.dart` uses `fontFamily: 'Inter'`, but `pubspec.yaml` lacks `fonts:` assets and `google_fonts` is commented out. Text will fall back to defaults.
6. Web `index.html` metadata is inconsistent
   - Title and Apple title are `dreamflow_counter`. Update to "WarmNest" for consistency.
7. Android release signing uses debug config
   - `android/app/build.gradle` sets `signingConfig = signingConfigs.debug` for release. Provide a real keystore for production.
8. Example package name
   - `applicationId` is `com.example.warmnest`. Use a unique reverse-DNS identifier for release builds.
9. Unencrypted local storage of PII
   - `SharedPreferences` stores profile and journal data in plain text. Consider platform-secure storage, encryption, or data minimization.
10. Error handling uses `print`
   - `main.dart` logs errors via `print`. Consider `FlutterError.reportError`, Crashlytics/Sentry, and user-friendly retry flows.
11. No tests
   - `flutter_test` is configured, but no unit/widget/integration tests are present.
12. i18n coverage is minimal
   - Only a handful of keys are defined. Many UI strings are hard-coded. Expand key coverage.
13. App state persistence coupling
   - `AppState.updateProfile` both updates in-memory state and persists synchronously. Consider isolating persistence or adding error handling.
14. Random ID strategy
   - `_randomId()` produces 12 base-36 chars from `Random()`. Low collision risk for local use, but not suitable for multi-user/distributed IDs.
15. Drawer avatar initials hard-coded
   - Use user initials from profile or an avatar image if available.
16. Web base href/title
   - Ensure `web/index.html` base/title match deployment path and app name.

## How to Fix the Critical Build Blockers
- Add the missing screens under `lib/screens/` matching the imports and routes in `main.dart` and `home_page.dart`.
- Or, temporarily comment out the missing imports and routes to get a minimal shell running.

## Contributing
1. Create a feature branch.
2. Make changes with tests where applicable.
3. Run `flutter analyze` and `flutter test`.
4. Open a PR describing the change and any UI impacts.

## License
Add a suitable license file (e.g., MIT) if you intend to publish the source.


