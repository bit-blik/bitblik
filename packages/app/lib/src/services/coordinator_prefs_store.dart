import 'dart:convert';

import 'package:bitblik_core/core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:ndk/shared/nips/nip19/nip19.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences-backed [CoordinatorStore].
///
/// Stores the whole record list as one JSON blob under a single key. On
/// first load, migrates legacy `coordinators.blacklist` /
/// `coordinators.customWhitelist` entries into the new schema. Old keys
/// are intentionally left in place after migration so an older app
/// binary (rollback) can still read them.
class CoordinatorPrefsStore implements CoordinatorStore {
  static const String _key = 'coordinators.v2';
  static const String _migrationFlag = 'coordinators.migrated_v2';
  static const String _legacyBlacklistKey = 'coordinators.blacklist';
  static const String _legacyCustomWhitelistKey =
      'coordinators.customWhitelist';
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static String _bootstrapKey(String paymentSystemId) =>
      'coordinators.bootstrap.$paymentSystemId';

  @override
  Future<List<CoordinatorRecord>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null && raw.isNotEmpty) {
      try {
        final list = jsonDecode(raw) as List<dynamic>;
        return list
            .map((e) => CoordinatorRecord.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (e) {
        Logger.log.w(() => 'Failed to decode coordinator records: $e');
      }
    }
    if (!(prefs.getBool(_migrationFlag) ?? false)) {
      final migrated = _migrateFromLegacy(prefs);
      if (migrated.isNotEmpty) {
        await save(migrated);
      }
      await prefs.setBool(_migrationFlag, true);
      return migrated;
    }
    return [];
  }

  @override
  Future<void> save(List<CoordinatorRecord> records) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        jsonEncode(records.map((r) => r.toJson()).toList(growable: false));
    await prefs.setString(_key, encoded);
  }

  @override
  Future<bool> loadBootstrapCompleted(String paymentSystemId) async {
    final value = await _secureStorage.read(key: _bootstrapKey(paymentSystemId));
    return value == 'true';
  }

  @override
  Future<void> saveBootstrapCompleted(String paymentSystemId, bool value) async {
    await _secureStorage.write(
      key: _bootstrapKey(paymentSystemId),
      value: value ? 'true' : 'false',
    );
  }

  List<CoordinatorRecord> _migrateFromLegacy(SharedPreferences prefs) {
    final blacklist = prefs.getStringList(_legacyBlacklistKey) ?? const [];
    final custom = prefs.getStringList(_legacyCustomWhitelistKey) ?? const [];
    final records = <String, CoordinatorRecord>{};

    for (final pubkey in blacklist) {
      final hex = _normalize(pubkey);
      records[hex] = CoordinatorRecord(
        pubkeyHex: hex,
        enabled: false,
      );
    }

    for (final pubkey in custom) {
      final hex = _normalize(pubkey);
      final base = records[hex] ?? CoordinatorRecord(pubkeyHex: hex);
      records[hex] = base.copyWith(enabled: true, manualAdded: true);
    }

    if (records.isNotEmpty) {
      Logger.log.i(
        () => '🔁 Migrated ${records.length} legacy coordinator entries',
      );
    }
    return records.values.toList();
  }

  static String _normalize(String pubkey) {
    final trimmed = pubkey.trim();
    if (trimmed.startsWith('npub')) {
      try {
        return Nip19.decode(trimmed);
      } catch (_) {
        return trimmed;
      }
    }
    return trimmed;
  }
}
