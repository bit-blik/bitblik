// Deployment configuration loaded from `window.appConfig` on web.
//
// Non-web builds use the stub implementation and therefore have no runtime
// deployment default.
export 'runtime_config_stub.dart'
    if (dart.library.html) 'runtime_config_web.dart';
