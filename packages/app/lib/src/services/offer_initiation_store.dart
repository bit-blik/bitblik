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

  const LocalOfferInitiation({
    required this.maker,
    required this.coordinator,
    required this.operationId,
    required this.params,
    this.estimate,
    this.result,
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
    await (await database()).execute(
      '''CREATE TABLE IF NOT EXISTS offer_initiations (
      maker TEXT PRIMARY KEY,
      coordinator TEXT NOT NULL,
      operation_id TEXT NOT NULL,
      params TEXT NOT NULL,
      estimate TEXT,
      result TEXT
    )''',
    );
  }

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
