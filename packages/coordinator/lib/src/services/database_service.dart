import 'dart:convert';

import 'package:postgres/postgres.dart';
import 'package:dotenv/dotenv.dart';
import '../models/offer.dart';
import '../logging/app_logger.dart';

class DatabaseService {
  static final RegExp _uuidLikePattern = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );

  PostgreSQLConnection? _connection;
  late DotEnv _env;
  bool _auditTableReady = false;

  DatabaseService() {
    _env = DotEnv(includePlatformEnvironment: true)..load();
  }

  Future<void> connect() async {
    if (_connection?.isClosed == false) {
      return; // Already connected
    }

    final dbHost = _env['DB_HOST'] ?? 'localhost';
    final dbPort = int.tryParse(_env['DB_PORT'] ?? '') ?? 5432;
    final dbName = _env['DB'] ?? 'bitblik';
    final dbUser = _env['DB_USER'] ?? 'postgres';
    final dbPassword = _env['DB_PASSWORD'] ?? '**********';

    _connection = PostgreSQLConnection(
      dbHost,
      dbPort,
      dbName,
      username: dbUser,
      password: dbPassword,
    );
    try {
      await _connection!.open();
      AppLogger.info('Database connection established.',
          action: 'database.connection.opened');
      await _ensureOffersTable();
      await _ensureLogAuditTable();
    } catch (e) {
      AppLogger.severe(
        'Error connecting to database: $e',
        action: 'database.connection.error',
        error: e,
      );
      _connection = null;
      rethrow;
    }
  }

  Future<void> disconnect() async {
    await _connection?.close();
    _connection = null;
    AppLogger.info('Database connection closed.',
        action: 'database.connection.closed');
  }

  Future<void> _ensureOffersTable() async {
    if (_connection == null) throw StateError('Database not connected.');
    await _connection!.execute('''
      CREATE TABLE IF NOT EXISTS offers (
        id UUID PRIMARY KEY,
        amount_sats BIGINT NOT NULL,
        maker_fees BIGINT NOT NULL, -- Renamed
        maker_pubkey TEXT NOT NULL,
        taker_pubkey TEXT,
        taker_lightning_address TEXT,
        taker_invoice TEXT,
        taker_invoice_fees BIGINT,
        blik_code TEXT,
        hold_invoice_payment_hash TEXT UNIQUE NOT NULL,
        hold_invoice_preimage TEXT NOT NULL,
        status TEXT NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMPTZ,
        reserved_at TIMESTAMPTZ,
        blik_received_at TIMESTAMPTZ,
        maker_confirmed_at TIMESTAMPTZ,
        settled_at TIMESTAMPTZ,
        taker_paid_at TIMESTAMPTZ,
        taker_fees BIGINT NULL, -- Renamed
        fiat_amount NUMERIC,
        fiat_currency TEXT
      );
    ''');
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_offers_status ON offers (status);
    ''');
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_offers_maker_pubkey ON offers (maker_pubkey);
    ''');
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_offers_taker_pubkey ON offers (taker_pubkey);
    ''');
    AppLogger.info('Offers table checked/created.',
        action: 'database.schema.offers.ready');
  }

  Future<void> _ensureLogAuditTable() async {
    if (_connection == null) throw StateError('Database not connected.');
    await _connection!.execute('''
      CREATE TABLE IF NOT EXISTS log_audit (
        id BIGSERIAL PRIMARY KEY,
        offer_id TEXT,
        action TEXT NOT NULL,
        level TEXT NOT NULL,
        logger_name TEXT NOT NULL,
        message TEXT NOT NULL,
        error TEXT,
        stack_trace TEXT,
        metadata JSONB,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
      );
    ''');
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_log_audit_offer_id ON log_audit (offer_id);
    ''');
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_log_audit_action ON log_audit (action);
    ''');
    await _connection!.execute("""
      UPDATE log_audit
      SET offer_id = NULL
      WHERE offer_id IS NOT NULL
        AND offer_id !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\$';
    """);
    _auditTableReady = true;
    AppLogger.info('log_audit table checked/created.',
        action: 'database.schema.log_audit.ready');
  }

  Future<void> insertAuditLog({
    required String level,
    required String loggerName,
    required String message,
    required String action,
    String? offerId,
    String? error,
    String? stackTrace,
    Map<String, dynamic>? metadata,
  }) async {
    if (_connection == null || _connection!.isClosed) {
      return;
    }
    if (!_auditTableReady) {
      await _ensureLogAuditTable();
    }

    final normalizedOfferId = _normalizeOfferId(offerId);

    await _connection!.execute(
      '''
        INSERT INTO log_audit (offer_id, action, level, logger_name, message, error, stack_trace, metadata, created_at)
        VALUES (@offer_id, @action, @level, @logger_name, @message, @error, @stack_trace, CAST(@metadata AS JSONB), @created_at)
      ''',
      substitutionValues: {
        'offer_id': normalizedOfferId,
        'action': action,
        'level': level,
        'logger_name': loggerName,
        'message': message,
        'error': error,
        'stack_trace': stackTrace,
        'metadata': metadata == null ? null : jsonEncode(metadata),
        'created_at': DateTime.now().toUtc(),
      },
    );
  }

  String? _normalizeOfferId(String? candidate) {
    if (candidate == null) {
      return null;
    }
    final trimmed = candidate.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    return _uuidLikePattern.hasMatch(trimmed) ? trimmed : null;
  }

  Future<Offer> createOffer(Offer offer) async {
    if (_connection == null) throw StateError('Database not connected.');

    final now = DateTime.now().toUtc();
    await _connection!.execute(
      '''
        INSERT INTO offers (id, amount_sats, maker_fees, taker_fees, maker_pubkey, hold_invoice_payment_hash, hold_invoice_preimage, status, created_at, updated_at, fiat_amount, fiat_currency)
        VALUES (@id, @amount_sats, @maker_fees, @taker_fees, @maker_pubkey, @hold_invoice_payment_hash, @hold_invoice_preimage, @status, @created_at, @updated_at, @fiat_amount, @fiat_currency)
      ''',
      substitutionValues: {
        'id': offer.id,
        'amount_sats': offer.amountSats,
        'maker_fees': offer.makerFees,
        'taker_fees': offer.takerFees,
        'maker_pubkey': offer.makerPubkey,
        'hold_invoice_payment_hash': offer.holdInvoicePaymentHash,
        'hold_invoice_preimage': offer.holdInvoicePreimage,
        'status': offer.status.name,
        'created_at': offer.createdAt.toUtc(),
        'updated_at': now,
        'fiat_amount': offer.fiatAmount,
        'fiat_currency': offer.fiatCurrency,
      },
    );
    offer.updatedAt = now;
    return offer;
  }

  Future<Offer?> getOfferById(String id) async {
    if (_connection == null) throw StateError('Database not connected.');
    final results = await _connection!.query(
      'SELECT * FROM offers WHERE id = @id LIMIT 1',
      substitutionValues: {'id': id},
    );
    if (results.isEmpty) return null;
    return _mapRowToOffer(results.first);
  }

  Future<Offer?> getOfferByPaymentHash(String paymentHash) async {
    if (_connection == null) throw StateError('Database not connected.');
    final results = await _connection!.query(
      'SELECT * FROM offers WHERE hold_invoice_payment_hash = @paymentHash LIMIT 1',
      substitutionValues: {'paymentHash': paymentHash},
    );
    if (results.isEmpty) return null;
    return _mapRowToOffer(results.first);
  }

  Future<List<Offer>> getOffersByStatus(OfferStatus status,
      {int limit = 50, int offset = 0}) async {
    if (_connection == null) throw StateError('Database not connected.');
    final results = await _connection!.query(
      'SELECT * FROM offers WHERE status = @status ORDER BY created_at DESC LIMIT @limit OFFSET @offset',
      substitutionValues: {
        'status': status.name,
        'limit': limit,
        'offset': offset,
      },
    );
    return results.map(_mapRowToOffer).toList();
  }

  Future<bool> updateTakerInvoice(String id, String takerInvoice) async {
    if (_connection == null) throw StateError('Database not connected.');
    final now = DateTime.now().toUtc();
    final affectedRows = await _connection!.execute(
      'UPDATE offers SET taker_invoice = @taker_invoice, updated_at = @updated_at WHERE id = @id',
      substitutionValues: {
        'id': id,
        'taker_invoice': takerInvoice,
        'updated_at': now,
      },
    );
    return affectedRows == 1;
  }

  Future<bool> updateTakerInvoiceFees(String id, int fees) async {
    if (_connection == null) throw StateError('Database not connected.');
    final now = DateTime.now().toUtc();
    final affectedRows = await _connection!.execute(
      'UPDATE offers SET taker_invoice_fees = @fees, updated_at = @updated_at WHERE id = @id',
      substitutionValues: {
        'id': id,
        'fees': fees,
        'updated_at': now,
      },
    );
    return affectedRows == 1;
  }

  Future<bool> updateOfferStatus(
      // Return type back to bool
      String id,
      OfferStatus newStatus,
      {String? takerPubkey,
      String? blikCode,
      String? takerLightningAddress,
      DateTime? reservedAt,
      DateTime? blikReceivedAt,
      int? takerFees}) async {
    // Renamed parameter
    // Added takerFees
    if (_connection == null) throw StateError('Database not connected.');
    final now = DateTime.now().toUtc(); // Keep 'now' for updated_at
    Map<String, dynamic> params = {
      'id': id,
      'status': newStatus.name,
      'updated_at': now,
    };
    List<String> setClauses = ['status = @status', 'updated_at = @updated_at'];

    switch (newStatus) {
      case OfferStatus.reserved:
        if (takerPubkey == null)
          throw ArgumentError('takerPubkey required for reserved status');
        if (reservedAt == null)
          throw ArgumentError(
              'reservedAt required for reserved status'); // Ensure timestamp is passed
        params['taker_pubkey'] = takerPubkey;
        params['reserved_at'] = reservedAt.toUtc(); // Use passed timestamp
        setClauses.add('taker_pubkey = @taker_pubkey');
        setClauses.add('reserved_at = @reserved_at');
        break;
      case OfferStatus.blikReceived:
        if (blikCode == null)
          throw ArgumentError('blikCode required for blikReceived status');
        if (blikReceivedAt == null)
          throw ArgumentError(
              'blikReceivedAt required for blikReceived status'); // Ensure timestamp is passed
        if (takerLightningAddress == null) {
          setClauses.add('taker_lightning_address = NULL');
        } else {
          params['taker_lightning_address'] = takerLightningAddress;
          setClauses.add('taker_lightning_address = @taker_lightning_address');
        }
        params['blik_code'] = blikCode;
        params['blik_received_at'] =
            blikReceivedAt.toUtc(); // Use passed timestamp
        setClauses.add('blik_code = @blik_code');
        setClauses.add('blik_received_at = @blik_received_at');
        break;
      case OfferStatus.makerConfirmed:
        params['maker_confirmed_at'] = now;
        setClauses.add('maker_confirmed_at = @maker_confirmed_at');
        break;
      case OfferStatus.settled:
        params['settled_at'] = now;
        setClauses.add('settled_at = @settled_at');
        break;
      case OfferStatus.takerPaid:
        if (takerFees == null) {
          // Renamed check
          // Optionally throw an error, or just log a warning if fees are expected
          AppLogger.info(
              'Warning: Updating status to takerPaid without providing takerFees for offer $id',
              offerId: id);
        }
        params['taker_paid_at'] = now;
        params['taker_fees'] = takerFees; // Renamed parameter and column
        setClauses.add('taker_paid_at = @taker_paid_at');
        setClauses.add('taker_fees = @taker_fees'); // Renamed column
        break;
      case OfferStatus.funded: // Explicitly handle reverting to funded
      case OfferStatus.expired:
      case OfferStatus.cancelled: // Also clear fields when cancelling
        setClauses.add('taker_pubkey = NULL');
        setClauses.add('reserved_at = NULL');
        setClauses.add('blik_code = NULL');
        setClauses.add('taker_lightning_address = NULL');
        setClauses.add('taker_invoice = NULL');
        setClauses.add('taker_invoice_fees = NULL');
        setClauses.add('blik_received_at = NULL');
        break;
      case OfferStatus.invalidBlik: // Add case for invalidBlik
      case OfferStatus.conflict: // Add case for conflict
        // No specific fields to update/clear when moving TO these states
        break;
      default:
        break;
    }

    // AppLogger.info(
    //     '[DatabaseService.updateOfferStatus] Executing update for offer $id with status $newStatus. Params: $params',
    //     offerId: id);
    // AppLogger.info(
    //     '[DatabaseService.updateOfferStatus] SQL: UPDATE offers SET ${setClauses.join(', ')} WHERE id = @id');

    final affectedRows = await _connection!.execute(
      'UPDATE offers SET ${setClauses.join(', ')} WHERE id = @id',
      substitutionValues: params,
    );
    // Return bool indicating success
    return affectedRows == 1;
  }

  // Cancel an offer (set status to cancelled) only if it's currently funded
  Future<bool> cancelOffer(String id, String makerPubkey) async {
    if (_connection == null) throw StateError('Database not connected.');
    final now = DateTime.now().toUtc();
    final affectedRows = await _connection!.execute(
      '''
         UPDATE offers
         SET status = @newStatus,
             updated_at = @updated_at,
             taker_pubkey = NULL,
             reserved_at = NULL,
             blik_code = NULL,
             taker_lightning_address = NULL,
             taker_invoice = NULL,
             taker_invoice_fees = NULL,
             blik_received_at = NULL
         WHERE id = @id
           AND maker_pubkey = @makerPubkey
           AND status = @requiredStatus
       ''',
      substitutionValues: {
        'id': id,
        'makerPubkey': makerPubkey,
        'newStatus': OfferStatus.cancelled.name, // Use cancelled status
        'requiredStatus': OfferStatus.funded.name,
        'updated_at': now,
      },
    );
    return affectedRows == 1;
  }

  // Fetch active offers where the user is either maker or taker
  Future<List<Offer>> getMyActiveOffers(String userPubkey) async {
    await connect(); // Ensure connection is open
    if (_connection == null)
      throw StateError(
          'Database not connected.'); // Should not happen after connect() but keep for safety
    // Define "active" statuses (exclude terminal/cancelled states)
    final activeStatuses = [
      OfferStatus.created.name,
      OfferStatus.funded.name,
      OfferStatus.reserved.name,
      OfferStatus.blikReceived.name,
      OfferStatus.blikSentToMaker.name,
      OfferStatus.expiredBlik.name,
      OfferStatus.expiredSentBlik.name,
      OfferStatus.takerCharged.name,
      OfferStatus.invalidBlik.name,
      OfferStatus.conflict.name,
      OfferStatus.makerConfirmed.name,
      OfferStatus.payingTaker.name,
      OfferStatus.takerPaymentFailed.name,
      OfferStatus.takerPaid.name
    ];

    final results = await _connection!.query(
      '''
         SELECT * FROM offers
         WHERE (maker_pubkey = @userPubkey OR taker_pubkey = @userPubkey)
         AND status = ANY(@activeStatuses)
         ORDER BY created_at DESC
       ''',
      substitutionValues: {
        'userPubkey': userPubkey,
        'activeStatuses': activeStatuses,
      },
    );
    return results.map(_mapRowToOffer).toList();
  }

  /// Get all offers from the last hours for rebroadcasting to Nostr
  Future<List<Offer>> getOffersFromLastHours() async {
    if (_connection == null) throw StateError('Database not connected.');

    final twentyFourHoursAgo =
        DateTime.now().toUtc().subtract(Duration(hours: 12));

    final results = await _connection!.query(
      '''
         SELECT * FROM offers
         WHERE created_at >= @cutoff_time
         ORDER BY created_at DESC
       ''',
      substitutionValues: {
        'cutoff_time': twentyFourHoursAgo,
      },
    );
    return results.map(_mapRowToOffer).toList();
  }

  Offer _mapRowToOffer(PostgreSQLResultRow row) {
    final map = row.toColumnMap();
    return Offer(
      id: map['id'],
      amountSats: map['amount_sats'],
      makerFees: map['maker_fees'], // Renamed field and column
      makerPubkey: map['maker_pubkey'],
      holdInvoicePaymentHash: map['hold_invoice_payment_hash'],
      holdInvoicePreimage: map['hold_invoice_preimage'],
      status: OfferStatus.values.byName(map['status']),
      createdAt: (map['created_at'] as DateTime).toLocal(),
      fiatAmount: double.parse(map['fiat_amount']),
      fiatCurrency: map['fiat_currency'] ?? '?',
    )
      ..takerPubkey = map['taker_pubkey']
      ..takerLightningAddress = map['taker_lightning_address']
      ..takerInvoice = map['taker_invoice']
      ..takerInvoiceFees = map['taker_invoice_fees']
      ..blikCode = map['blik_code']
      ..updatedAt = (map['updated_at'] as DateTime?)?.toLocal()
      ..reservedAt = (map['reserved_at'] as DateTime?)?.toLocal()
      ..blikReceivedAt = (map['blik_received_at'] as DateTime?)?.toLocal()
      ..makerConfirmedAt = (map['maker_confirmed_at'] as DateTime?)?.toLocal()
      ..settledAt = (map['settled_at'] as DateTime?)?.toLocal()
      ..takerPaidAt = (map['taker_paid_at'] as DateTime?)?.toLocal()
      ..takerFees = map['taker_fees']; // Renamed field and column
  }
}
