import 'package:flutter/foundation.dart' show kIsWeb;

// Platform-specific imports
import 'platform_detection_stub.dart'
    if (dart.library.html) 'platform_detection_web.dart'
    if (dart.library.io) 'platform_detection_io.dart';

/// Utility class for platform detection, especially for web environments
class PlatformDetection {
  /// Short, stable identifier for the running platform, used in the RPC
  /// `client` field so the coordinator can attribute requests to a build+OS.
  ///
  /// Native: `android`, `ios`, `linux`, `macos`, `windows`, `fuchsia`.
  /// Web: `web-ios`, `web-android`, `web` (desktop/other).
  static String get platformSlug => currentPlatformSlug();

  /// Checks if the current platform is a web browser running on Android
  static bool get isWebAndroid {
    if (!kIsWeb) {
      return false;
    }
    return isAndroidUserAgent();
  }

  /// Checks if the current platform is a web browser running on iOS
  static bool get isWebIOS {
    if (!kIsWeb) {
      return false;
    }
    return isIOSUserAgent();
  }

  /// Checks if the current platform is a web browser running on desktop
  static bool get isWebDesktop {
    if (!kIsWeb) {
      return false;
    }
    return !isAndroidUserAgent() && !isIOSUserAgent();
  }
}
