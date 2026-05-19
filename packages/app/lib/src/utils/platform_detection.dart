import 'package:flutter/foundation.dart' show kIsWeb;

// Platform-specific imports
import 'platform_detection_stub.dart'
    if (dart.library.html) 'platform_detection_web.dart'
    if (dart.library.io) 'platform_detection_io.dart';

/// Utility class for platform detection, especially for web environments
class PlatformDetection {
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
