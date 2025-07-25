# Climora 🌤️

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A modern Flutter weather application built with clean architecture principles. Climora provides real-time weather information, 5-day forecasts, location search, and intelligent caching for optimal performance.

## ✨ Features

- 🌡️ **Current Weather**: Real-time weather conditions for any location
- 📅 **5-Day Forecast**: Detailed weather predictions with hourly breakdowns
- � **Location Search**: Find weather for any city worldwide
- 📍 **GPS Integration**: Automatic location detection with permission handling
- 💾 **Smart Caching**: Offline support with intelligent data caching
- 🌐 **Internationalization**: Multi-language support (English/Spanish)
- 🎨 **Modern UI**: Clean, intuitive interface with Material Design 3

## 📋 Requirements

- **Flutter**: 3.32.5 or higher
- **Dart**: 3.8.0 or higher
- **Android**: API level 21+ (Android 5.0+)
- **iOS**: iOS 11.0+

## 🚀 Getting Started

### 1. Environment Setup

Create a `.env` file in the project root with your OpenWeatherMap API key:

```env
WEATHER_API_KEY=your_openweathermap_api_key_here
```

**Get your API key:**
1. Sign up at [OpenWeatherMap](https://openweathermap.org/api)
2. Go to API Keys section
3. Copy your API key to the `.env` file

**Important**: The `.env` file is required for the app to access the weather API. Make sure it's in the project root directory.

### 2. Install Dependencies

```sh
flutter pub get
```

### 3. Run the Application

This project contains 3 flavors for different environments and requires the `.env` file to be loaded:

```sh
# Development (Debug mode with development API endpoints)
flutter run --flavor development --target lib/main_development.dart --dart-define-from-file .env

# Staging (Testing environment)
flutter run --flavor staging --target lib/main_staging.dart --dart-define-from-file .env

# Production (Release-ready build)
flutter run --flavor production --target lib/main_production.dart --dart-define-from-file .env
```

For quick development, use:
```sh
flutter run --flavor development -t lib/main_development.dart --dart-define-from-file .env
```

**Note**: The `--dart-define-from-file .env` parameter is required to load environment variables from your `.env` file.

### 4. Generate Localizations (if needed)

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

## 🏗️ Architecture

Climora follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── 📱 presentation/     # UI Layer (Widgets, Cubits, States)
│   ├── modules/
│   │   ├── weather/     # Weather display screens
│   │   ├── forecast/    # Forecast screens
│   │   └── search/      # Location search
│   └── widgets/         # Reusable UI components
│
├── 🏛️ domain/          # Business Logic Layer
│   ├── entities/        # Core business objects
│   └── repositories/    # Repository interfaces
│
├── 💾 data/            # Data Layer
│   ├── datasources/
│   │   ├── remote/      # API data sources
│   │   └── local/       # Local storage & caching
│   ├── models/          # Data transfer objects
│   └── repositories/    # Repository implementations
│
├── 🛠️ core/            # Shared utilities
│   ├── db/             # Database configuration
│   ├── error/          # Error handling
│   └── widgets/        # Core UI components
│
└── 🌐 l10n/            # Internationalization
```

### 📐 Architecture Layers

#### **1. Presentation Layer**
- **Cubits**: State management using BLoC pattern
- **Screens**: Main application screens
- **Widgets**: Reusable UI components
- **States**: Application state definitions

#### **2. Domain Layer**
- **Entities**: Pure business objects (Weather, Forecast, Location)
- **Repositories**: Abstract contracts for data access
- **Use Cases**: Business logic operations

#### **3. Data Layer**
- **Remote Data Sources**: OpenWeatherMap API integration
- **Local Data Sources**: SQLite caching and favorites
- **Models**: JSON serialization objects
- **Repository Implementations**: Concrete data access logic

### 🔄 Data Flow

```
UI → Cubit → Repository → Data Source → API/Cache
                ↓
UI ← Cubit ← Repository ← Data Source ← Response
```

### 🗄️ Caching Strategy

- **Weather Data**: 30-minute cache expiry
- **Forecast Data**: 3-hour cache expiry
- **Location Data**: Persistent storage
- **Offline Support**: Automatic fallback to cached data

### 🧩 Key Dependencies

- **State Management**: `flutter_bloc` - Predictable state management
- **HTTP Client**: `dio` - Network requests with retry logic
- **Local Storage**: `sqflite` - SQLite database for caching
- **Location Services**: `geolocator` - GPS and location permissions
- **Dependency Injection**: `get_it` - Service locator pattern

---

## 🧪 Running Tests

To run all unit and widget tests use the following command:

```sh
very_good test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov):

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```

---

## 🌐 Working with Translations

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`:arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:climora/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

---

## 📱 Platform Support

Climora works on multiple platforms:

- ✅ **Android** (API 21+)
- ✅ **iOS** (11.0+)
- ✅ **Web** (Chrome, Firefox, Safari)
- ✅ **Windows** (Windows 10+)

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [OpenWeatherMap](https://openweathermap.org/) for weather data API
- [Very Good CLI](https://github.com/VeryGoodOpenSource/very_good_cli) for project structure
- Flutter team for the amazing framework

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
