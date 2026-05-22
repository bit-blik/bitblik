import 'dart:convert';
import 'dart:io';

import 'package:bitblik_core/core.dart';

/// File-backed [CoordinatorStore] for the CLI. Persists records under
/// `$HOME/.config/bitblik/coordinators.json`. Read failures fall back
/// to an empty list so a malformed file doesn't crash startup.
class CoordinatorFileStore implements CoordinatorStore {
  CoordinatorFileStore({File? file}) : _file = file ?? _defaultFile();

  final File _file;

  static File _defaultFile() {
    final home =
        Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
    if (home == null) {
      throw StateError('Cannot determine home directory');
    }
    return File('$home/.config/bitblik/coordinators.json');
  }

  @override
  Future<List<CoordinatorRecord>> load() async {
    if (!await _file.exists()) return [];
    try {
      final raw = await _file.readAsString();
      if (raw.trim().isEmpty) return [];
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => CoordinatorRecord.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> save(List<CoordinatorRecord> records) async {
    await _file.parent.create(recursive: true);
    final encoded = const JsonEncoder.withIndent('  ').convert(
      records.map((r) => r.toJson()).toList(growable: false),
    );
    await _file.writeAsString(encoded);
  }
}
