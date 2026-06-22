import 'dart:convert';
import 'dart:io';

import 'package:bitblik_core/core.dart';

import 'cli_context.dart';

/// File-backed [CoordinatorStore] for the CLI. Persists records under
/// `$HOME/.config/<brand>/coordinators.json`, where `<brand>` is the active
/// payment system's brand (e.g. `bitblik` for BLIK, `bitway` for MB WAY) so a
/// market only ever loads its own discovered coordinators. Read failures fall
/// back to an empty list so a malformed file doesn't crash startup.
class CoordinatorFileStore implements CoordinatorStore {
  CoordinatorFileStore({File? file, PaymentSystem? paymentSystem})
      : _file = file ?? _defaultFile(paymentSystem ?? activePaymentSystem);

  final File _file;

  static File _defaultFile(PaymentSystem ps) {
    final home =
        Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
    if (home == null) {
      throw StateError('Cannot determine home directory');
    }
    return File('$home/.config/${ps.brandName.toLowerCase()}/coordinators.json');
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

  @override
  Future<bool> loadBootstrapCompleted(String paymentSystemId) async {
    return _file.exists();
  }

  @override
  Future<void> saveBootstrapCompleted(String paymentSystemId, bool value) async {}
}
