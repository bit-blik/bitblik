import 'dart:html';

/// Web-specific implementation for platform detection using user agent

String currentPlatformSlug() {
  final userAgent = window.navigator.userAgent?.toLowerCase() ?? '';
  if (userAgent.contains('iphone') ||
      userAgent.contains('ipad') ||
      userAgent.contains('ipod')) {
    return 'web-ios';
  }
  if (userAgent.contains('android')) {
    return 'web-android';
  }
  return 'web';
}

bool isAndroidUserAgent() => currentPlatformSlug() == 'web-android';

bool isIOSUserAgent() => currentPlatformSlug() == 'web-ios';
