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
  static Future<FlowEngine?> load(String flowId) async {
    try {
      final libUri =
          await Isolate.resolvePackageUri(Uri.parse('package:bitblik_core/core.dart'));
      if (libUri == null) return null;
      // libUri -> .../bitblik_core/lib/core.dart ; package root is two up.
      final packageRoot = Directory.fromUri(libUri).parent.parent;
      final file = File.fromUri(packageRoot.uri.resolve('$flowId.yml'));
      if (!file.existsSync()) return null;
      return FlowEngine.fromYaml(file.readAsStringSync());
    } catch (_) {
      return null;
    }
  }
}
