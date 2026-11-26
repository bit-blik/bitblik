import 'dart:convert';

import 'package:sqflite/sqflite.dart';

/// Stored before publication. Contains the original maker code/QR payload;
/// protect it like offer history and never include it in diagnostic logs.
class LocalOfferInitiation {
  final String maker;
  final String coordinator;
  final String operationId;
  final Map<String, dynamic> params;
  final Map<String, dynamic>? estimate;
  final Map<String, dynamic>? result;

  /// Milliseconds since epoch. Null for rows written by older app versions.
  final int? createdAt;

  const LocalOfferInitiation({
    required this.maker,
    required this.coordinator,
    required this.operationId,
    required this.params,
    this.estimate,
    this.result,
    this.createdAt,
  });

  factory LocalOfferInitiation.fromRow(Map<String, Object?> row) =>
      LocalOfferInitiation(
        maker: row['maker'] as String,
        coordinator: row['coordinator'] as String,
        operationId: row['operation_id'] as String,
        params: jsonDecode(row['params'] as String) as Map<String, dynamic>,
        estimate: row['estimate'] == null
            ? null
            : jsonDecode(row['estimate'] as String) as Map<String, dynamic>,
        result: row['result'] == null
            ? null
            : jsonDecode(row['result'] as String) as Map<String, dynamic>,
        createdAt: row['created_at'] as int?,
      );
}

/// Additive table in the existing offer database. No version bump or destructive
/// migration: old app versions ignore it (but cannot enforce its retry guard).
class OfferInitiationStore {
  final Future<Database> Function() database;
  Future<void>? _ready;
  OfferInitiationStore(this.database);

  Future<void> _ensure() => _ready ??= _create().catchError((Object error) {
    _ready = null;
    throw error;
  });

  Future<void> _create() async {
    final db = await database();
    await db.execute(
      '''CREATE TABLE IF NOT EXISTS offer_initiations (
      maker TEXT PRIMARY KEY,
      coordinator TEXT NOT NULL,
      operation_id TEXT NOT NULL,
      params TEXT NOT NULL,
      estimate TEXT,
      result TEXT,
      created_at INTEGER
    )''',
    );
    // Tables from older app versions lack the column. Adding a nullable
    // column is additive: older versions keep reading the table unchanged.
    if (!await _hasCreatedAt(db)) {
      try {
        await db.execute(
          'ALTER TABLE offer_initiations ADD COLUMN created_at INTEGER',
        );
      } catch (_) {
        // Another isolate sharing the database may have added it first.
        if (!await _hasCreatedAt(db)) rethrow;
      }
    }
  }

  static Future<bool> _hasCreatedAt(Database db) async =>
      (await db.rawQuery(
        'PRAGMA table_info(offer_initiations)',
      )).any((column) => column['name'] == 'created_at');

  Future<LocalOfferInitiation?> read(String maker) async {
    await _ensure();
    final rows = await (await database()).query(
      'offer_initiations',
      where: 'maker = ?',
      whereArgs: [maker],
    );
    return rows.isEmpty ? null : LocalOfferInitiation.fromRow(rows.single);
  }

  /// Only the caller whose row was inserted may publish a mutation. Competing
  /// isolates/tabs sharing this SQLite database must recover the winning row.
  Future<({LocalOfferInitiation attempt, bool inserted})> claim(
    LocalOfferInitiation attempt,
  ) async {
    await _ensure();
    return (await database()).transaction((txn) async {
      final existing = await txn.query(
        'offer_initiations',
        where: 'maker = ?',
        whereArgs: [attempt.maker],
      );
      if (existing.isNotEmpty) {
        return (
          attempt: LocalOfferInitiation.fromRow(existing.single),
          inserted: false,
        );
      }
      await txn.insert('offer_initiations', {
        'maker': attempt.maker,
        'coordinator': attempt.coordinator,
        'operation_id': attempt.operationId,
        'params': jsonEncode(attempt.params),
        'estimate': attempt.estimate == null
            ? null
            : jsonEncode(attempt.estimate),
        'created_at': attempt.createdAt,
      });
      return (attempt: attempt, inserted: true);
    });
  }

  Future<void> saveResult(
    LocalOfferInitiation attempt,
    Map<String, dynamic> result,
  ) async {
    await _ensure();
    final count = await (await database()).rawUpdate(
      '''UPDATE offer_initiations
      SET result = COALESCE(result, ?) WHERE maker = ? AND operation_id = ?''',
      [jsonEncode(result), attempt.maker, attempt.operationId],
    );
    if (count != 1) throw StateError('Offer initiation record is unavailable');
  }

  /// When the attempt was made. A row from an older app version has no time,
  /// so it is stamped with [nowMs] the first time it is seen and ages from there.
  Future<int> createdAtOrStamp(LocalOfferInitiation attempt, int nowMs) async {
    if (attempt.createdAt != null) return attempt.createdAt!;
    await _ensure();
    final db = await database();
    await db.rawUpdate(
      '''UPDATE offer_initiations SET created_at = ?
      WHERE maker = ? AND operation_id = ? AND created_at IS NULL''',
      [nowMs, attempt.maker, attempt.operationId],
    );
    final rows = await db.query(
      'offer_initiations',
      columns: ['created_at'],
      where: 'maker = ? AND operation_id = ?',
      whereArgs: [attempt.maker, attempt.operationId],
    );
    return rows.isEmpty ? nowMs : rows.single['created_at'] as int? ?? nowMs;
  }

  /// Drops an attempt whose invoice never reached this device. A row with a
  /// saved result is never touched: that invoice may have been shown and paid.
  /// Returns false when the row changed meanwhile (another isolate saved a
  /// result or replaced it).
  Future<bool> abandonUnanswered(LocalOfferInitiation attempt) async {
    await _ensure();
    final count = await (await database()).rawDelete(
      '''DELETE FROM offer_initiations
      WHERE maker = ? AND operation_id = ? AND result IS NULL''',
      [attempt.maker, attempt.operationId],
    );
    return count == 1;
  }

  /// Clears a stale initiation only when its exact result was persisted as a
  /// locally cancelled offer. Unknown and in-flight attempts remain protected.
  Future<void> completeCancelled(String maker) async {
    await _ensure();
    await (await database()).transaction((txn) async {
      final rows = await txn.query(
        'offer_initiations',
        where: 'maker = ?',
        whereArgs: [maker],
      );
      if (rows.isEmpty) return;
      final attempt = LocalOfferInitiation.fromRow(rows.single);
      final paymentHash = attempt.result?['paymentHash'];
      if (paymentHash is! String || paymentHash.isEmpty) return;
      final cancelled = await txn.query(
        'offers',
        columns: ['id'],
        where:
            'maker_pubkey = ? AND coordinator_pubkey = ? AND hold_invoice_payment_hash = ? AND status = ?',
        whereArgs: [maker, attempt.coordinator, paymentHash, 'cancelled'],
        limit: 1,
      );
      if (cancelled.isEmpty) return;
      await txn.delete(
        'offer_initiations',
        where: 'maker = ? AND operation_id = ?',
        whereArgs: [maker, attempt.operationId],
      );
    });
  }

  /// A caller/UI acknowledgement alone is insufficient. Require the matching
  /// offer already persisted locally; retain the attempt on write failure.
  Future<void> complete(String maker, String paymentHash) async {
    await _ensure();
    await (await database()).transaction((txn) async {
      final rows = await txn.query(
        'offer_initiations',
        where: 'maker = ?',
        whereArgs: [maker],
      );
      if (rows.isEmpty) return;
      final attempt = LocalOfferInitiation.fromRow(rows.single);
      if (attempt.result?['paymentHash'] != paymentHash) return;
      final offers = await txn.query(
        'offers',
        columns: ['id'],
        where:
            'maker_pubkey = ? AND coordinator_pubkey = ? AND hold_invoice_payment_hash = ?',
        whereArgs: [maker, attempt.coordinator, paymentHash],
        limit: 1,
      );
      if (offers.isEmpty) {
        throw StateError('Save the offer before completing initiation');
      }
      await txn.delete(
        'offer_initiations',
        where: 'maker = ? AND operation_id = ?',
        whereArgs: [maker, attempt.operationId],
      );
    });
  }
}
