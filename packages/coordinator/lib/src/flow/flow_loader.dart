import 'dart:io';
import 'dart:isolate';

import 'package:bitblik_core/core.dart';

/// Loads a bundled flow definition (`packages/core/<flowId>.yml`) at runtime.
///
/// The canonical `*.yml` files live at the root of the `bitblik_core` package
/// (single source of truth, also parsed by core's golden test). They are not
/// under `lib/`, so they are located by resolving the package's `core.dart`
/// library path and walking up to the package root.
class FlowLoader {
  /// Resolve and parse the flow with [flowId]. Returns null (and never throws)
  /// if the file cannot be located or fails to parse/validate — the coordinator
  /// then proceeds on hardcoded logic alone.
  /// Returns null when the flow file cannot be located (legitimate: the method
  /// has no bundled flow → legacy enforcement). **Parse/validation errors are
  /// NOT swallowed** — they propagate so the caller can fail loudly in generic
  /// mode instead of silently downgrading to legacy.
  static Future<FlowEngine?> load(String flowId) async {
    File file;
    try {
      final libUri = await Isolate.resolvePackageUri(
          Uri.parse('package:bitblik_core/core.dart'));
      if (libUri == null) return null;
      // libUri -> .../bitblik_core/lib/core.dart ; package root is two up.
      final packageRoot = Directory.fromUri(libUri).parent.parent;
      file = File.fromUri(packageRoot.uri.resolve('$flowId.yml'));
    } catch (_) {
      // Could not resolve the package/file location — treat as "not found".
      return null;
    }
    if (!file.existsSync()) return null;
    // Let FormatException from parse/validation propagate to the caller.
    return FlowEngine.fromYaml(file.readAsStringSync());
  }
}
