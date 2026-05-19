import 'group_links_constants.dart';

/// Stub implementation for non-web platforms
/// Uses default constants as group links are only configurable on web
class GroupLinks {
  static String? _telegram;
  static String? _element;
  static String? _simplex;
  static String? _signal;
  static bool _initialized = false;

  static void _initialize() {
    if (_initialized) return;
    _telegram = GroupLinksConstants.defaultTelegram;
    _element = GroupLinksConstants.defaultElement;
    _simplex = GroupLinksConstants.defaultSimplex;
    _signal = GroupLinksConstants.defaultSignal;
    _initialized = true;
  }

  static String get telegram {
    _initialize();
    return _telegram ?? GroupLinksConstants.defaultTelegram;
  }

  static String get element {
    _initialize();
    return _element ?? GroupLinksConstants.defaultElement;
  }

  static String get simplex {
    _initialize();
    return _simplex ?? GroupLinksConstants.defaultSimplex;
  }

  static String get signal {
    _initialize();
    return _signal ?? GroupLinksConstants.defaultSignal;
  }

  static bool get hasAnyLinks {
    _initialize();
    return telegram.isNotEmpty ||
        element.isNotEmpty ||
        simplex.isNotEmpty ||
        signal.isNotEmpty;
  }
}
