import 'dart:async';
import 'package:bitblik_core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Local SQLite store for offers.
///
/// History-preserving: rows are never deleted on cancel. Status updates
/// arriving later (e.g. coordinator publishes `funded` after a local
/// cancel race) overwrite the existing row, so a coordinator-driven
/// revival is possible.
class OfferDbService {
  static final OfferDbService _instance = OfferDbService._internal();
  factory OfferDbService() => _instance;
  OfferDbService._internal();

  static Database? _db;

  static const String _table = 'offers';

  /// Statuses that the maker UI no longer needs to drive. Used to find
  /// the current "active" offer.
  static const Set<OfferStatus> terminalStatuses = {
    OfferStatus.cancelled,
    OfferStatus.expired,
    OfferStatus.takerPaid,
  };

  static const String _createTableSql = '''
    CREATE TABLE $_table (
      id TEXT PRIMARY KEY,
      amount_sats INTEGER,
      maker_fees INTEGER,
      fiat_amount REAL,
      fiat_currency TEXT,
      status TEXT,
      created_at TEXT,
      maker_pubkey TEXT,
      coordinator_pubkey TEXT,
      taker_pubkey TEXT,
      reserved_at TEXT,
      blik_received_at TEXT,
      blik_code TEXT,
      hold_invoice_payment_hash TEXT,
      hold_invoice TEXT,
      taker_lightning_address TEXT,
      taker_invoice TEXT,
      hold_invoice_preimage TEXT,
      updated_at TEXT,
      maker_confirmed_at TEXT,
      settled_at TEXT,
      taker_paid_at TEXT,
      taker_fees INTEGER,
      taker_payment_failure_reason TEXT,
      category TEXT,
      payment_wallet_id TEXT
    )
  ''';

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = kIsWeb ? "bitblik.db" : await getDatabasesPath();
    final path = join(dbPath, 'offer.db');
    return await openDatabase(
      path,
      version: 8,
      onCreate: (db, version) async {
        await db.execute(_createTableSql);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 5) {
          // Move any in-flight active_offer row(s) into the new offers
          // history table. If the legacy table is missing or empty,
          // proceed with an empty offers table.
          await db.execute(_createTableSql);
          try {
            await db.execute(
              'INSERT OR REPLACE INTO $_table SELECT * FROM active_offer',
            );
          } catch (e) {
            Logger.log.w(
              () => '[OfferDbService] No legacy active_offer rows to migrate: $e',
            );
          }
          await db.execute('DROP TABLE IF EXISTS active_offer');
        }
        if (oldVersion < 6) {
          final columns = await db.rawQuery('PRAGMA table_info($_table)');
          final hasColumn = columns.any(
            (col) => col['name'] == 'payment_wallet_id',
          );
          if (!hasColumn) {
            await db.execute(
              'ALTER TABLE $_table ADD COLUMN payment_wallet_id TEXT',
            );
          }
        }
        if (oldVersion < 7) {
          final columns = await db.rawQuery('PRAGMA table_info($_table)');
          final hasColumn = columns.any((col) => col['name'] == 'category');
          if (!hasColumn) {
            await db.execute('ALTER TABLE $_table ADD COLUMN category TEXT');
          }
        }
        if (oldVersion < 8) {
          final columns = await db.rawQuery('PRAGMA table_info($_table)');
          final hasColumn = columns.any(
            (col) => col['name'] == 'taker_payment_failure_reason',
          );
          if (!hasColumn) {
            await db.execute(
              'ALTER TABLE $_table ADD COLUMN taker_payment_failure_reason TEXT',
            );
          }
        }
      },
    );
  }

  Future<void> upsertOffer(Offer offer) async {
    try {
      final db = await database;
      final jsonData = offer.toJson();
      Logger.log.d(
        () => '[OfferDbService] Upserting offer ${offer.id} status=${offer.status.name}',
      );
      await db.insert(
        _table,
        jsonData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e, stackTrace) {
      Logger.log.e(() => '[OfferDbService] Error upserting offer: $e');
      Logger.log.d(() => '[OfferDbService] Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Most-recent offer whose status is not in [terminalStatuses].
  Future<Offer?> getActiveOffer() async {
    final db = await database;
    final terminalNames =
        terminalStatuses.map((s) => "'${s.name}'").join(',');
    final maps = await db.rawQuery(
      'SELECT * FROM $_table WHERE status NOT IN ($terminalNames)',
    );
    final offers = _parseOffers(maps);
    if (offers.isEmpty) return null;
    offers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return offers.first;
  }

  Future<Offer?> getOfferById(String id) async {
    final db = await database;
    final maps = await db.query(_table, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    try {
      return Offer.fromJson(maps.first);
    } catch (_) {
      return null;
    }
  }

  Future<Offer?> getOfferByPaymentHash(String paymentHash) async {
    final db = await database;
    final maps = await db.query(
      _table,
      where: 'hold_invoice_payment_hash = ?',
      whereArgs: [paymentHash],
    );
    if (maps.isEmpty) return null;
    try {
      return Offer.fromJson(maps.first);
    } catch (_) {
      return null;
    }
  }

  Future<List<Offer>> listOffers({int? limit}) async {
    final db = await database;
    final maps = await db.query(_table);
    final offers = _parseOffers(maps);
    offers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    if (limit != null && offers.length > limit) {
      return offers.take(limit).toList();
    }
    return offers;
  }

  /// Locally-cancelled offers created within [window]. Used by the boot-time
  /// reconciliation sweep to recover offers a coordinator funded after the
  /// user cancelled locally.
  Future<List<Offer>> listRecentCancelled(Duration window) async {
    final db = await database;
    final maps = await db.query(
      _table,
      where: 'status = ?',
      whereArgs: [OfferStatus.cancelled.name],
    );
    final cutoff = DateTime.now().toUtc().subtract(window);
    final parsed = _parseOffers(maps);
    return parsed
        .where((o) => o.createdAt.toUtc().isAfter(cutoff))
        .toList();
  }

  List<Offer> _parseOffers(List<Map<String, Object?>> maps) {
    return maps
        .map((m) {
          try {
            return Offer.fromJson(m);
          } catch (e) {
            Logger.log.w(() => '[OfferDbService] Skipping unparsable offer row: $e');
            return null;
          }
        })
        .whereType<Offer>()
        .toList();
  }

  Future<void> deleteOfferById(String id) async {
    final db = await database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> markCancelled(String id) async {
    final existing = await getOfferById(id);
    if (existing == null) return;
    await upsertOffer(existing.copyWith(status: OfferStatus.cancelled));
  }

  /// Dev-only wipe. Removes the entire offers table.
  Future<void> clearAll() async {
    final db = await database;
    await db.delete(_table);
  }

  /// Force a database reset by closing and reopening the database
  /// This is useful for development when schema changes are made
  Future<void> resetDatabase() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
    // The next call to get database will recreate it with new schema
  }
}
