// Keep this aligned with group_links_web.dart until the app migrates all
// window.appConfig access to dart:js_interop together.
// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:js' as js;

import 'package:ndk/shared/logger/logger.dart';

/// Web runtime configuration supplied by `/config.js`.
class RuntimeConfig {
  /// Payment-system id used when the browser has no saved user choice.
  static String? get defaultPaymentSystemId {
    try {
      // `js.context` already represents the browser's global Window object.
      // Reading `window` from it produces a dart:html Window wrapper, which
      // does not support the `[]` operator in a compiled release build.
      final appConfig = js.context['appConfig'];
      final value = appConfig?['paymentSystem'];
      if (value is! String) return null;
      final normalized = value.trim();
      return normalized.isEmpty ? null : normalized;
    } catch (e) {
      Logger.log.w(() => 'Error loading runtime payment-system default: $e');
      return null;
    }
  }
}
