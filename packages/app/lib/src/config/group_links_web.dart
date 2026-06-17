import 'dart:js' as js;
import 'package:ndk/shared/logger/logger.dart';
import 'group_links_constants.dart';

/// Web-specific implementation for group links loaded from JavaScript config at runtime
/// The config is loaded from /config.js which can be mounted/overwritten in Docker
class GroupLinks {
  static String? _telegramOverride;
  static String? _matrixOverride;
  static String? _simplexOverride;
  static String? _signalOverride;
  static bool _initialized = false;

  /// Read deployment-level overrides from window.appConfig once. An override
  /// applies regardless of the selected payment system; unset fields fall
  /// back to the per-payment-system default constants.
  static void _initialize() {
    if (_initialized) return;

    try {
      // Access window.appConfig from JavaScript using dart:js
      final windowObj = js.context['window'] ?? js.context;
      final appConfig = windowObj['appConfig'];

      if (appConfig != null) {
        _telegramOverride = appConfig['telegramGroupLink'] as String?;
        _matrixOverride = appConfig['matrixGroupLink'] as String?;
        _simplexOverride = appConfig['simplexGroupLink'] as String?;
        _signalOverride = appConfig['signalGroupLink'] as String?;
      }
    } catch (e) {
      Logger.log.w(() => '⚠️ Error loading group links config: $e');
    }

    _initialized = true;
  }

  /// Links for the given payment system id, honoring debug/release mode and
  /// any window.appConfig overrides.
  static GroupLinkSet of(String paymentSystemId) {
    _initialize();
    final defaults = GroupLinksConstants.forPaymentSystem(paymentSystemId);
    return GroupLinkSet(
      telegram: _telegramOverride?.isNotEmpty == true
          ? _telegramOverride!
          : defaults.telegram,
      matrix: _matrixOverride?.isNotEmpty == true
          ? _matrixOverride!
          : defaults.matrix,
      simplex: _simplexOverride?.isNotEmpty == true
          ? _simplexOverride!
          : defaults.simplex,
      signal: _signalOverride?.isNotEmpty == true
          ? _signalOverride!
          : defaults.signal,
    );
  }
}
