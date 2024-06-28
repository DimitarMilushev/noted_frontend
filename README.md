# noted_frontend

## Code generation

- dart run build_runner watch ~ Generates the riverpod and freezed files  
- dart run build_runner watch --delete-conflicting-outputs ~ Generates the riverpod and freezed files wthout duplicates/conflicting files

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
