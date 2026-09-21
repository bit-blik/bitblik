These tests exercise the real Linux ZXing native decoder. From packages/app:

```sh
flutter build linux --debug -t lib/main_bitblik.dart
LD_LIBRARY_PATH="$PWD/build/linux/x64/debug/bundle/lib" flutter test --no-pub test_native/full_frame_qr_scanner_test.dart
```

Kept outside test/ so ordinary widget tests do not require a Linux native build.

TWINT image-import regression tests use real native QR decoding and mock Android
ML Kit's amount-only response. Optionally include the original online screenshot:

```sh
LD_LIBRARY_PATH="$PWD/build/linux/x64/debug/bundle/lib" \
  TWINT_IMPORT_SCREENSHOT=/path/to/twint.png \
  flutter test --no-pub test_native/twint_screenshot_import_test.dart
```
