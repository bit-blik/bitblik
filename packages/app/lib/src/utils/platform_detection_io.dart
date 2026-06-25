import 'dart:io' show Platform;

/// IO-specific implementation for platform detection
/// For non-web platforms, these always return false

String currentPlatformSlug() {
  if (Platform.isAndroid) return 'android';
  if (Platform.isIOS) return 'ios';
  if (Platform.isLinux) return 'linux';
  if (Platform.isMacOS) return 'macos';
  if (Platform.isWindows) return 'windows';
  if (Platform.isFuchsia) return 'fuchsia';
  return 'unknown';
}

bool isAndroidUserAgent() => false;

bool isIOSUserAgent() => false;
