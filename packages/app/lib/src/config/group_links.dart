/// Configuration for group links loaded from JavaScript config at runtime
/// The config is loaded from /config.js which can be mounted/overwritten in Docker
/// Platform-specific implementations are in group_links_web.dart and group_links_stub.dart
export 'group_links_stub.dart' if (dart.library.html) 'group_links_web.dart';
