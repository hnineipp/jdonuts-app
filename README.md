# J'Donuts Flutter App

A feature-first Flutter application developed for the J'Donuts assessment. It demonstrates local authentication, offline-first product browsing, product details, and an animated Rewards experience.

## 1. SDK and Technologies

| Technology | Version / Choice |
|---|---|
| Flutter | 3.47.9 (stable) |
| Dart | 3.13.7 |
| State Management | Riverpod 2.6.1 |
| Navigation | GoRouter 14.8.1 |
| Local Database | Hive CE |
| Session Storage | flutter_secure_storage |
| Connectivity | connectivity_plus + internet reachability check |
| Localization | Flutter gen-l10n (English and Burmese) |

> These are the versions reported for the development environment. Confirm with `flutter --version` if the final build uses a different SDK.

## 2. How to Run

**Requirements:** Flutter SDK and Android Studio or Xcode.

Install dependencies and run the application:

```bash
flutter pub get
flutter gen-l10n
flutter run
```

Run static analysis and tests:

```bash
flutter analyze
flutter test

# Run all unit and widget tests
flutter test

# Run unit tests only
flutter test test/unit

# Run widget tests only
flutter test test/widget
```

## 3. Architecture

The project follows a feature-first architecture with separation of presentation, domain, and data responsibilities.

**Architecture decisions:**

- **Riverpod** manages application state and dependency injection.
- **GoRouter** handles navigation and authentication redirects.
- **Core** contains shared infrastructure, including errors, networking, storage, navigation, motion, theme, and reusable widgets.
- **Data layer** separates authentication, local storage, store, and rewards responsibilities.
- **LocalAppDataSource** provides shared access to application data.
- **Store and Rewards** have separate repositories and services, allowing each module to access only the data it requires.
- **Presentation layer** keeps feature-specific screens, widgets, and view models within their respective features.
- Shared design tokens and reusable infrastructure are maintained in `core/`.

## 4. Offline Strategy and Local Database

The assessment does not require a backend. The application uses bundled local data and persistent storage.

- `assets/data/app_data.json` provides the initial application data.
- Hive CE stores application data locally on the device.
- The database is initialized on first launch and uses schema versioning for migrations.
- Existing member information is preserved during database migration.
- Product and shop images required offline are bundled as application assets.
- Home, Product, Store, and Rewards access shared local data through dedicated data sources and repositories.
- `connectivity_plus` detects network interface changes.
- A separate internet reachability check determines whether the internet is actually accessible.
- Pull-to-refresh reloads the local data.
- No remote server synchronization is configured.

**Authentication and session management:**

- OTP verification is simulated locally; no SMS is sent.
- Registered-user data is stored locally.
- Session state is persisted using `flutter_secure_storage`.
- Session restoration and logout are supported.

## 5. Animations Implemented

**Onboarding and Authentication**
- Screen entrance and route transition animations.
- Button interaction feedback.

**Home**
- Skeleton loading states.
- Staggered section entrance.
- Auto-playing promotional banner carousel.

**Product Detail**
- Product image Hero transition.
- Animated quantity changes and live total updates.

**Rewards**
- Animated points counter and custom-painted points ring.
- Animated Silver, Gold, and Platinum tier progression.
- Moving tab indicator and animated content transition.
- Staggered challenge-card entrance.
- Donut and coffee challenge progress artwork.
- Earn-button feedback and Rewards badge entrance animation.

**Navigation**
- Animated active navigation indicator between tabs.

## 6. Demo OTP Code

| Item | Behaviour |
|---|---|
| Demo OTP | `123456` |
| SMS Delivery | Not implemented |
| Verification | Local simulation |
| Backend Authentication | Not configured |
| Session Persistence |