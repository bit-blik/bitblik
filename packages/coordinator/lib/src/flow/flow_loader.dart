import 'dart:io';
import 'dart:isolate';

import 'package:bitblik_core/core.dart';

/// Loads a bundled flow definition (`packages/core/lib/flows/<flowId>.yml`) at
/// runtime.
///
/// The canonical `*.yml` files live under `bitblik_core/lib/flows/` — a single
/// source of truth shared by the coordinator (this loader), the Flutter app
/// (bundled as `packages/bitblik_core/flows/*.yml` assets), and core's tests.
/// They resolve directly by package URI (`package:bitblik_core/flows/x.yml`).
///
/// In AOT deployments (Docker) there is no package config to resolve against,
/// so `FLOW_DIR` must point at a directory containing the `*.yml` files.
class FlowLoader {
  static Future<String> _loadFromDir(String dir, String fileName) async {
    final file = File('$dir/$fileName');
    if (!file.existsSync()) {
      throw FileSystemException('Flow import not found', file.path);
    }
    return file.readAsStringSync();
  }

  static Future<String> _loadFromPackage(String fileName) async {
    final uri = await Isolate.resolvePackageUri(
        Uri.parse('package:bitblik_core/flows/$fileName'));
    if (uri == null) {
      throw FileSystemException('Flow import not found', fileName);
    }
    final file = File.fromUri(uri);
    if (!file.existsSync()) {
      throw FileSystemException('Flow import not found', file.path);
    }
    return file.readAsStringSync();
  }

  /// Resolve and parse the flow with [flowId]. Returns null when the flow file
  /// cannot be located. Parse/validation errors propagate so coordinator
  /// startup fails loudly; every payment system requires a valid bundled flow.
  static Future<FlowEngine?> load(String flowId) async {
    // Explicit dir (Docker/AOT deployments, where Isolate.resolvePackageUri
    // returns null) takes precedence over package resolution.
    final flowDir = Platform.environment['FLOW_DIR'];
    if (flowDir != null) {
      final file = File('$flowDir/$flowId.yml');
      if (!file.existsSync()) return null;
      return FlowEngine.fromYamlWithImports(
        file.readAsStringSync(),
        (importPath) => _loadFromDir(flowDir, importPath),
      );
    }

    File file;
    try {
      // The flow files live under core's lib/ (single source of truth, also
      // bundled by the Flutter app as package assets), so they resolve directly
      // by package URI.
      final uri = await Isolate.resolvePackageUri(
          Uri.parse('package:bitblik_core/flows/$flowId.yml'));
      if (uri == null) return null;
      file = File.fromUri(uri);
    } catch (_) {
      // Could not resolve the package/file location — treat as "not found".
      return null;
    }
    if (!file.existsSync()) return null;
    // Let FormatException from parse/validation propagate to the caller.
    return FlowEngine.fromYamlWithImports(
      file.readAsStringSync(),
      _loadFromPackage,
    );
  }
}
