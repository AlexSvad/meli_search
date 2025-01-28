# Meli Search

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Search meli products with their details by Alex Svadeba.

---

## Getting Started

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

_\*Meli Search works on Android._

---

## Model–view–viewmodel (MVVM) architectural pattern

This architecture was implemented throughout the project.

## Running Tests

To install lcov and run all unit and widget tests use the following command:
```sh
./run_tests.sh
```

or

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```
---

93% of coverage:

<img width="1567" alt="coverage" src="https://github.com/user-attachments/assets/dd236042-d498-41e0-be0b-9d4007f6263e" />


## Video
[video.webm](https://github.com/user-attachments/assets/bc5a33ca-96be-4a32-a20f-c411b0946297)

## Download the .apk Android app

Link: https://drive.google.com/drive/folders/1M4RiVoUqrMfKsXh-MPapYiYV4F_7gG0V

## Android TV
[android tv.webm](https://github.com/user-attachments/assets/9224d18d-517d-45cd-888e-045e0629ee61)

Not the best choice for TV, but interesting reading: https://webostv.developer.lge.com/news/2024-07-15-new-and-successful-experiment-of-webos-with-flutter, https://developer.samsung.com/smarttv/develop/native/flutter.html and https://github.com/flutter-tizen/flutter-tizen

## Working with Translations

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
```

Alternatively, run `flutter run` and code generation will take place automatically.

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
