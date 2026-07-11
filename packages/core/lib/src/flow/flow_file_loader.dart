import 'dart:io';
import 'dart:isolate';

import 'flow_engine.dart';

/// Loads flow definitions (`<flowId>.yml` + its imports) from the canonical
/// `bitblik_core/lib/flows/` sources at runtime — no code generation.
///
/// Resolution order, first hit wins (applied to the root file and every
/// import):
///  1. `FLOW_DIR` env var — an explicit directory of `*.yml` files
///     (Docker/AOT deployments; also how the coordinator ships them).
///  2. A `flows/` directory beside the running executable — where a
///     `dart build`-produced standalone binary bundle keeps them.
///  3. The `package:bitblik_core/flows/...` URI — works under `dart run` and
///     `dart pub global activate`, where a package config is present.
///
/// Throws [FileSystemException] when a file resolves through none of these.
class FlowFileLoader {
  static String? _fromDir(String dir, String fileName) {
    final f = File('$dir/$fileName');
    return f.existsSync() ? f.readAsStringSync() : null;
  }

  static Future<String?> _fromPackage(String fileName) async {
    try {
      final uri = await Isolate.resolvePackageUri(
          Uri.parse('package:bitblik_core/flows/$fileName'));
      if (uri == null) return null;
      final f = File.fromUri(uri);
      return f.existsSync() ? f.readAsStringSync() : null;
    } catch (_) {
      return null;
    }
  }

  /// Resolve one flow file (root or import) by name, e.g. `twint.yml`.
  static Future<String> loadSource(String fileName) async {
    final flowDir = Platform.environment['FLOW_DIR'];
    if (flowDir != null) {
      final s = _fromDir(flowDir, fileName);
      if (s != null) return s;
    }
    final exeDir = File(Platform.resolvedExecutable).parent.path;
    final beside = _fromDir('$exeDir/flows', fileName);
    if (beside != null) return beside;

    final pkg = await _fromPackage(fileName);
    if (pkg != null) return pkg;

    throw FileSystemException(
      'Flow definition not found. Set FLOW_DIR or ship a flows/ directory '
      'beside the executable.',
      fileName,
    );
  }

  /// Resolve and parse the flow with [flowId] (e.g. `twint`) and its imports.
  static Future<FlowEngine> load(String flowId) async {
    final root = await loadSource('$flowId.yml');
    return FlowEngine.fromYamlWithImports(root, loadSource);
  }
}
