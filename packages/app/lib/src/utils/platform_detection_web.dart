import 'dart:html';

/// Web-specific implementation for platform detection using user agent

bool isAndroidUserAgent() {
  final userAgent = window.navigator.userAgent?.toLowerCase() ?? '';
  return userAgent.contains('android');
}

bool isIOSUserAgent() {
  final userAgent = window.navigator.userAgent?.toLowerCase() ?? '';
  return userAgent.contains('iphone') ||
      userAgent.contains('ipad') ||
      userAgent.contains('ipod');
}
