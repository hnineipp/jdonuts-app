# J'Donuts Flutter App

A feature-first Flutter application for the J'Donuts assessment. It demonstrates local authentication, offline-first product browsing, product details, and an animated Rewards experience.

## 1. SDK and technologies

| Technology | Version / choice |
|---|---|
| Flutter | 3.47.2 (stable) |
| Dart | 3.13.2 |
| State management | Riverpod 2.6.1 |
| Navigation | GoRouter 14.8.1 |
| Local database | Hive CE |
| Session storage | flutter_secure_storage |
| Connectivity | connectivity_plus + internet reachability check |
| Localization | Flutter gen-l10n (English and Burmese) |

> These are the versions reported for the development environment. Confirm with `flutter --version` before submitting if the final build was produced with a different SDK.

## 2. How to run

Requirements: Flutter SDK and Android Studio or Xcode.

```bash
flutter pub get
flutter gen-l10n
flutter run
```

Run static analysis and tests:

```bash
flutter analyze
flutter test
flutter test integration_test
```

## 3. Architecture and folder map

The project uses a feature-first structure with separation between presentation, domain, and data responsibilities.

```text
lib/
├── app/                 # App bootstrap, routing and app-wide providers
├── core/                # Shared errors, motion, navigation, network,
│                        # storage, theme and reusable widgets
├── data/
│   └── catalog/         # Shared local catalogue used by Home,
│                        # Product and Rewards
├── features/
│   ├── auth/            # Authentication data, domain and presentation
│   ├── home/            # Home presentation
│   ├── product/         # Product detail presentation
│   ├── rewards/         # Rewards presentation
│   └── welcome/         # Welcome presentation
└── l10n/                # English and Burmese ARB files
```

**Architecture choices**

- Riverpod manages state and dependency injection.
- GoRouter handles navigation and authentication redirects.
- Shared catalogue data is outside the Home feature because Home, Product and Rewards use the same source.
- Shared design tokens and reusable infrastructure live in `core/`.
- Feature-specific UI and view models remain within their respective features.

## 4. Offline strategy and local database

The assessment does not require a backend. The app uses bundled local data and persistent storage.

- `assets/data/catalog.json` provides the initial catalogue.
- Hive CE stores the catalogue on the device.
- The database is seeded on first launch and uses a schema version for migration.
- Product and shop images needed offline are bundled as app assets.
- Home, Product and Rewards read the same local catalogue and member record, keeping member points consistent across screens.
- `connectivity_plus` detects network interface changes; a separate reachability check helps determine whether the internet is actually reachable.
- Pull-to-refresh reloads the local catalogue. There is no remote server synchronization because no backend is configured.

Authentication/session demonstration:

- OTP verification is simulated locally; no SMS is sent.
- Registered-user data is stored locally.
- Session state is persisted using `flutter_secure_storage`.
- Session restoration and logout are supported.

## 5. Animations implemented

**Onboarding and authentication**
- Screen entrance and route transition animations.
- Button interaction feedback.

**Home**
- Skeleton loading states.
- Staggered section entrance.
- Auto-playing promotional banner carousel.

**Product detail**
- Product image Hero transition.
- Animated quantity changes and live total updates.

**Rewards**
- Animated points counter and custom-painted points ring.
- Animated Silver, Gold and Platinum tier progression.
- Moving tab indicator and animated content transition.
- Staggered challenge-card entrance.
- Donut and coffee challenge progress artwork.
- Earn-button feedback and Rewards badge entrance animation.

**Navigation**
- Animated active navigation indicator between tabs.

## 6. Fake OTP code

| Item | Behaviour |
|---|---|
| Demo OTP | `123456` |
| SMS delivery | Not implemented |
| Verification | Local simulation |
| Backend authentication | Not configured |
| Session persistence | `flutter_secure_storage` |

This is a demonstration flow only and is not production authentication.

## 7. Localization

The app uses Flutter `gen-l10n`.

- English: `lib/l10n/app_en.arb`
- Burmese: `lib/l10n/app_my.arb`

Generate localization files with:

```bash
flutter gen-l10n
```

## 8. Tests

The test suite covers unit, widget and integration behaviour, including:

- Phone validation, OTP attempt policy and session behaviour.
- Local database initialization and schema migration.
- Rewards and challenge progress calculations.
- Login and registration validation.
- Product quantity and total calculations.
- Rewards and Gift tab interactions.
- Registration-to-Home-to-Product navigation.
- Shared member data and offline navigation.

Run the suites with:

```bash
flutter test
```

**Reported test status:** The developer reports that the unit, widget and integration tests have been run and passed. Re-run them against the final submission build before submission.

## 9. Known limitations

- OTP and authentication are simulated; there is no SMS provider or production authentication backend.
- There is no remote catalogue API or server synchronization.
- Rewards tier thresholds and challenge data are demonstration data, not connected to a live loyalty service.

## 10. Development time

**Actual development time:** 16 hours

