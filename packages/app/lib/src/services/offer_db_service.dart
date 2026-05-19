import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/offer.dart';

class OfferDbService {
  static final OfferDbService _instance = OfferDbService._internal();
  factory OfferDbService() => _instance;
  OfferDbService._internal();

  static Database? _db;

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
      version: 4,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE active_offer (
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
            taker_fees INTEGER
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          // Drop the old table and recreate with new schema
          await db.execute('DROP TABLE IF EXISTS active_offer');
          await db.execute('''
            CREATE TABLE active_offer (
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
              taker_fees INTEGER
            )
          ''');
        }
      },
    );
  }

  Future<void> upsertActiveOffer(Offer offer) async {
    try {
      final db = await database;
      final jsonData = offer.toJson();
      Logger.log.d(
        () => '[OfferDbService] Upserting offer with data: $jsonData',
      );

      // // Debug: Check table schema
      // final tableInfo = await db.rawQuery('PRAGMA table_info(active_offer)');
      // Logger.log.d(() => '[OfferDbService] Table schema: $tableInfo');
      await deleteActiveOffer();
      await db.insert(
        'active_offer',
        jsonData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      Logger.log.d(() => '[OfferDbService] Successfully upserted offer');
    } catch (e, stackTrace) {
      Logger.log.d(() => '[OfferDbService] Error upserting offer: $e');
      Logger.log.d(() => '[OfferDbService] Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<Offer?> getActiveOffer() async {
    final db = await database;
    final maps = await db.query(
      'active_offer',
      limit: 1,
      orderBy: 'created_at DESC',
    );
    if (maps.isNotEmpty) {
      try {
        return Offer.fromJson(maps.first);
      } catch (e) {
        Logger.log.e(() => 'could not parse offer from json: $e');
      }
    }
    return null;
  }

  Future<void> deleteActiveOffer() async {
    final db = await database;
    await db.delete('active_offer');
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
