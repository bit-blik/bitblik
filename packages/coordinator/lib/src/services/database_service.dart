import 'dart:convert';

import 'package:postgres/postgres.dart';
import 'package:dotenv/dotenv.dart';
import 'package:bitblik_core/core.dart';
import '../logging/app_logger.dart';
import '../models/outgoing_payment_attempt.dart';

/// Context for a single offer state transition, recorded in
/// `offer_state_history` when [DatabaseService.recordStateHistory] is on.
///
/// [trigger] is the cause class: `user_action` (an RPC from maker/taker),
/// `timeout` (a server timer fired), `auto` (a coordinator-driven follow-up such
/// as the settlement/payout tail) or `coordinator`. When a status-changing DB
/// call supplies no meta, the transition is still recorded with trigger `auto`.
class StateTransitionMeta {
  final String trigger;
  final String? event;
  final String? actor;
  final String? actorPubkey;
  final Map<String, dynamic>? extra;

  const StateTransitionMeta({
    required this.trigger,
    this.event,
    this.actor,
    this.actorPubkey,
    this.extra,
  });

  static const StateTransitionMeta auto = StateTransitionMeta(trigger: 'auto');
}

/// A Telegram message sent for an offer, tracked so it can be edited later.
class TelegramOfferMessage {
  final String offerId;
  final String chatId;
  final int messageId;
  final String messageText;

  const TelegramOfferMessage({
    required this.offerId,
    required this.chatId,
    required this.messageId,
    required this.messageText,
  });
}

class DatabaseService {
  static final RegExp _uuidLikePattern = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );

  PostgreSQLConnection? _connection;
  late DotEnv _env;
  bool _auditTableReady = false;
  bool _stateHistoryTableReady = false;

  /// When true, every offer status change is appended to `offer_state_history`.
  /// Enabled for the generic YAML flow, where it replaces the log_audit trail.
  bool recordStateHistory = false;

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
      await _ensureOfferStateHistoryTable();
      await _ensureOutgoingPaymentAttemptsTable();
      await _ensureTelegramOfferMessagesTable();
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
        taker_invoice TEXT,
        maker_refund_invoice TEXT,
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
        dispute_at TIMESTAMPTZ,
        taker_charged_at TIMESTAMPTZ,
        dispute_escalation_reason TEXT,
        taker_paid_at TIMESTAMPTZ,
        taker_fees BIGINT NULL, -- Renamed
        taker_payment_failure_reason TEXT NULL,
        fiat_amount NUMERIC,
        fiat_currency TEXT,
        category TEXT,
        premium_percent NUMERIC NOT NULL DEFAULT 0,
        bank TEXT
      );
    ''');
    // LNURL payout was removed: drop the taker's Lightning-address column on
    // existing databases (fresh schemas above no longer create it).
    await _connection!.execute('''
      ALTER TABLE offers
      DROP COLUMN IF EXISTS taker_lightning_address;
    ''');
    await _connection!.execute('''
      ALTER TABLE offers
      ADD COLUMN IF NOT EXISTS category TEXT;
    ''');
    await _connection!.execute('''
      ALTER TABLE offers
      ADD COLUMN IF NOT EXISTS premium_percent NUMERIC NOT NULL DEFAULT 0;
    ''');
    await _connection!.execute('''
      ALTER TABLE offers
      ADD COLUMN IF NOT EXISTS taker_payment_failure_reason TEXT NULL;
    ''');
    await _connection!.execute('''
      ALTER TABLE offers
      ADD COLUMN IF NOT EXISTS maker_refund_invoice TEXT;
    ''');
    await _connection!.execute('''
      ALTER TABLE offers
      ADD COLUMN IF NOT EXISTS dispute_at TIMESTAMPTZ;
    ''');
    await _connection!.execute('''
      ALTER TABLE offers
      ADD COLUMN IF NOT EXISTS taker_charged_at TIMESTAMPTZ;
    ''');
    await _connection!.execute('''
      ALTER TABLE offers
      ADD COLUMN IF NOT EXISTS dispute_escalation_reason TEXT;
    ''');
    // Client (app/cli + version) that created the offer. Server-only column,
    // surfaced on the dashboard; never returned to clients.
    await _connection!.execute('''
      ALTER TABLE offers
      ADD COLUMN IF NOT EXISTS client_version TEXT;
    ''');
    // Bank the offer runs on, for bank-scoped markets (SK ATM: tatrabanka /
    // slsp / vub). Chosen by the maker at creation; null for bank-agnostic
    // markets. Drives the per-offer code-validity timeout.
    await _connection!.execute('''
      ALTER TABLE offers
      ADD COLUMN IF NOT EXISTS bank TEXT;
    ''');
    // Composite (status, created_at DESC) serves both the status-equality
    // lookups (getOffersByStatus) AND their `ORDER BY created_at DESC LIMIT`
    // without a sort step. Leading column also answers plain `status =`/`ANY`
    // lookups, so the old single-column status index is redundant.
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_offers_status_created_at
        ON offers (status, created_at DESC);
    ''');
    await _connection!.execute('''
      DROP INDEX IF EXISTS idx_offers_status;
    ''');
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_offers_maker_pubkey ON offers (maker_pubkey);
    ''');
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_offers_taker_pubkey ON offers (taker_pubkey);
    ''');
    // getOffersFromLastHours: `WHERE created_at >= ? ORDER BY created_at DESC`.
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_offers_created_at
        ON offers (created_at DESC);
    ''');
    // Dashboard recent-offers list/pagination orders by the last activity
    // time. Expression index must match the query expression exactly.
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_offers_recent_sort
        ON offers (COALESCE(updated_at, created_at) DESC);
    ''');
    AppLogger.info('Offers table checked/created.',
        action: 'database.schema.offers.ready');
  }

  Future<void> _ensureOutgoingPaymentAttemptsTable() async {
    if (_connection == null) throw StateError('Database not connected.');
    await _connection!.execute('''
      CREATE TABLE IF NOT EXISTS outgoing_payment_attempts (
        id UUID PRIMARY KEY,
        offer_id UUID NOT NULL REFERENCES offers(id) ON DELETE CASCADE,
        purpose TEXT NOT NULL,
        generation INTEGER NOT NULL,
        payment_type TEXT NOT NULL,
        bolt11_invoice TEXT,
        bolt12_offer TEXT,
        expected_amount_sats BIGINT NOT NULL,
        fee_limit_sats BIGINT,
        backend_type TEXT NOT NULL,
        backend_payment_id TEXT,
        state TEXT NOT NULL,
        payment_hash TEXT,
        preimage TEXT,
        payer_proof TEXT,
        fee_paid_sats BIGINT,
        failure_reason TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        settled_at TIMESTAMPTZ,
        UNIQUE (offer_id, purpose, generation),
        CHECK (
          (payment_type = 'bolt11' AND bolt11_invoice IS NOT NULL AND bolt12_offer IS NULL)
          OR
          (payment_type = 'bolt12' AND bolt12_offer IS NOT NULL AND bolt11_invoice IS NULL)
        ),
        CHECK (state IN ('prepared','submitted','pending','succeeded','failed','unknown'))
      );
    ''');
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_outgoing_attempts_nonterminal
        ON outgoing_payment_attempts (state, updated_at)
        WHERE state IN ('prepared','submitted','pending','unknown');
    ''');
  }

  Future<OutgoingPaymentAttempt> getOrCreateOutgoingPaymentAttempt({
    required String id,
    required String offerId,
    required String purpose,
    required OutgoingPaymentType paymentType,
    required String encoded,
    required int expectedAmountSats,
    int? feeLimitSats,
    required String backendType,
  }) async {
    if (_connection == null) throw StateError('Database not connected.');
    final latestResult = await _connection!.query(
      '''SELECT * FROM outgoing_payment_attempts
         WHERE offer_id = @offer_id AND purpose = @purpose
         ORDER BY generation DESC LIMIT 1''',
      substitutionValues: {'offer_id': offerId, 'purpose': purpose},
    );
    var generation = 0;
    if (latestResult.isNotEmpty) {
      final latest = _mapRowToOutgoingPaymentAttempt(latestResult.first);
      if (latest.paymentType == paymentType &&
          latest.encoded == encoded &&
          latest.state != OutgoingPaymentAttemptState.failed) {
        _validateOutgoingPaymentAttempt(
          latest,
          expectedAmountSats: expectedAmountSats,
          feeLimitSats: feeLimitSats,
          backendType: backendType,
        );
        return latest;
      }
      if (latest.state != OutgoingPaymentAttemptState.failed) {
        throw StateError(
          'Cannot replace a ${latest.state.name} outgoing payment attempt',
        );
      }
      generation = latest.generation + 1;
    }

    await _connection!.execute(
      '''INSERT INTO outgoing_payment_attempts (
           id, offer_id, purpose, generation, payment_type,
           bolt11_invoice, bolt12_offer, expected_amount_sats, fee_limit_sats,
           backend_type, state, created_at, updated_at
         ) VALUES (
           @id, @offer_id, @purpose, @generation, @payment_type,
           @bolt11_invoice, @bolt12_offer, @expected_amount_sats, @fee_limit_sats,
           @backend_type, 'prepared', @now, @now
         ) ON CONFLICT (offer_id, purpose, generation) DO NOTHING''',
      substitutionValues: {
        'id': id,
        'offer_id': offerId,
        'purpose': purpose,
        'generation': generation,
        'payment_type': paymentType.name,
        'bolt11_invoice':
            paymentType == OutgoingPaymentType.bolt11 ? encoded : null,
        'bolt12_offer':
            paymentType == OutgoingPaymentType.bolt12 ? encoded : null,
        'expected_amount_sats': expectedAmountSats,
        'fee_limit_sats': feeLimitSats,
        'backend_type': backendType,
        'now': DateTime.now().toUtc(),
      },
    );
    final result = await _connection!.query(
      '''SELECT * FROM outgoing_payment_attempts
         WHERE offer_id = @offer_id AND purpose = @purpose AND generation = @generation''',
      substitutionValues: {
        'offer_id': offerId,
        'purpose': purpose,
        'generation': generation,
      },
    );
    final attempt = _mapRowToOutgoingPaymentAttempt(result.single);
    if (attempt.paymentType != paymentType || attempt.encoded != encoded) {
      throw StateError(
        'A different outgoing payment attempt won the concurrent write',
      );
    }
    _validateOutgoingPaymentAttempt(
      attempt,
      expectedAmountSats: expectedAmountSats,
      feeLimitSats: feeLimitSats,
      backendType: backendType,
    );
    return attempt;
  }

  void _validateOutgoingPaymentAttempt(
    OutgoingPaymentAttempt attempt, {
    required int expectedAmountSats,
    required int? feeLimitSats,
    required String backendType,
  }) {
    if (attempt.expectedAmountSats != expectedAmountSats ||
        attempt.feeLimitSats != feeLimitSats ||
        attempt.backendType != backendType) {
      throw StateError(
        'Outgoing payment attempt parameters do not match persisted state',
      );
    }
  }

  Future<OutgoingPaymentAttempt> updateOutgoingPaymentAttempt(
    String id, {
    required OutgoingPaymentAttemptState state,
    String? backendPaymentId,
    String? paymentHash,
    String? preimage,
    String? payerProof,
    int? feePaidSats,
    String? failureReason,
  }) async {
    if (_connection == null) throw StateError('Database not connected.');
    final now = DateTime.now().toUtc();
    final result = await _connection!.query(
      '''UPDATE outgoing_payment_attempts SET
           state = @state,
           backend_payment_id = COALESCE(@backend_payment_id, backend_payment_id),
           payment_hash = COALESCE(@payment_hash, payment_hash),
           preimage = COALESCE(@preimage, preimage),
           payer_proof = COALESCE(@payer_proof, payer_proof),
           fee_paid_sats = COALESCE(@fee_paid_sats, fee_paid_sats),
           failure_reason = CASE
             WHEN @state = 'succeeded' THEN NULL
             ELSE COALESCE(@failure_reason, failure_reason)
           END,
           updated_at = @now,
           settled_at = CASE WHEN @state = 'succeeded' THEN COALESCE(settled_at, @now) ELSE settled_at END
         WHERE id = @id RETURNING *''',
      substitutionValues: {
        'id': id,
        'state': state.name,
        'backend_payment_id': backendPaymentId,
        'payment_hash': paymentHash,
        'preimage': preimage,
        'payer_proof': payerProof,
        'fee_paid_sats': feePaidSats,
        'failure_reason': failureReason,
        'now': now,
      },
    );
    if (result.isEmpty)
      throw StateError('Outgoing payment attempt $id not found');
    return _mapRowToOutgoingPaymentAttempt(result.single);
  }

  OutgoingPaymentAttempt _mapRowToOutgoingPaymentAttempt(
    PostgreSQLResultRow row,
  ) {
    final map = row.toColumnMap();
    return OutgoingPaymentAttempt(
      id: map['id'].toString(),
      offerId: map['offer_id'].toString(),
      purpose: map['purpose'] as String,
      generation: map['generation'] as int,
      paymentType:
          OutgoingPaymentType.values.byName(map['payment_type'] as String),
      bolt11Invoice: map['bolt11_invoice'] as String?,
      bolt12Offer: map['bolt12_offer'] as String?,
      expectedAmountSats: map['expected_amount_sats'] as int,
      feeLimitSats: map['fee_limit_sats'] as int?,
      backendType: map['backend_type'] as String,
      backendPaymentId: map['backend_payment_id'] as String?,
      state: OutgoingPaymentAttemptState.values.byName(map['state'] as String),
      paymentHash: map['payment_hash'] as String?,
      preimage: map['preimage'] as String?,
      payerProof: map['payer_proof'] as String?,
      feePaidSats: map['fee_paid_sats'] as int?,
      failureReason: map['failure_reason'] as String?,
      createdAt: map['created_at'] as DateTime,
      updatedAt: map['updated_at'] as DateTime,
      settledAt: map['settled_at'] as DateTime?,
    );
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
    // Audit fetch is `WHERE offer_id = ? ORDER BY created_at DESC, id DESC`.
    // Composite covers the filter + ordering; supersedes the plain offer_id idx.
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_log_audit_offer_created
        ON log_audit (offer_id, created_at DESC, id DESC);
    ''');
    await _connection!.execute('''
      DROP INDEX IF EXISTS idx_log_audit_offer_id;
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

  Future<void> _ensureOfferStateHistoryTable() async {
    if (_connection == null) throw StateError('Database not connected.');
    await _connection!.execute('''
      CREATE TABLE IF NOT EXISTS offer_state_history (
        id BIGSERIAL PRIMARY KEY,
        offer_id UUID NOT NULL,
        from_state TEXT,
        to_state TEXT NOT NULL,
        trigger_type TEXT NOT NULL,
        event TEXT,
        actor TEXT,
        actor_pubkey TEXT,
        metadata JSONB,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
      );
    ''');
    // Per-offer chronological read: WHERE offer_id = ? ORDER BY created_at, id.
    await _connection!.execute('''
      CREATE INDEX IF NOT EXISTS idx_offer_state_history_offer
        ON offer_state_history (offer_id, created_at, id);
    ''');
    _stateHistoryTableReady = true;
    AppLogger.info('offer_state_history table checked/created.',
        action: 'database.schema.offer_state_history.ready');
  }

  /// Append one transition row. Best-effort: never throws into the caller's
  /// main flow (a history write must not fail an offer transition).
  Future<void> _recordStateTransition({
    required String offerId,
    required String? fromState,
    required String toState,
    StateTransitionMeta? meta,
  }) async {
    if (!recordStateHistory) return;
    if (_connection == null || _connection!.isClosed) return;
    final m = meta ?? StateTransitionMeta.auto;
    try {
      if (!_stateHistoryTableReady) {
        await _ensureOfferStateHistoryTable();
      }
      await _connection!.execute(
        '''
          INSERT INTO offer_state_history
            (offer_id, from_state, to_state, trigger_type, event, actor, actor_pubkey, metadata)
          VALUES
            (@offer_id, @from_state, @to_state, @trigger_type, @event, @actor, @actor_pubkey, CAST(@metadata AS JSONB))
        ''',
        substitutionValues: {
          'offer_id': offerId,
          'from_state': fromState,
          'to_state': toState,
          'trigger_type': m.trigger,
          'event': m.event,
          'actor': m.actor,
          'actor_pubkey': m.actorPubkey,
          'metadata': m.extra == null ? null : jsonEncode(m.extra),
        },
      );
    } catch (e) {
      AppLogger.warning('Failed to record offer_state_history for $offerId: $e',
          offerId: offerId);
    }
  }

  /// Public entry point for recording a transition the flow engine performed
  /// outside the status-update methods (e.g. the genesis funded entry, which is
  /// an INSERT rather than an UPDATE). No-op unless [recordStateHistory] is on.
  Future<void> recordOfferTransition({
    required String offerId,
    required String? fromState,
    required String toState,
    StateTransitionMeta? meta,
  }) =>
      _recordStateTransition(
          offerId: offerId, fromState: fromState, toState: toState, meta: meta);

  /// Chronological transition history for an offer (oldest first).
  Future<List<Map<String, dynamic>>> getOfferStateHistory(
      String offerId) async {
    if (_connection == null) throw StateError('Database not connected.');
    final rows = await _connection!.query(
      '''
        SELECT from_state, to_state, trigger_type, event, actor, actor_pubkey, metadata, created_at
        FROM offer_state_history
        WHERE offer_id = @offer_id
        ORDER BY created_at, id
      ''',
      substitutionValues: {'offer_id': offerId},
    );
    return rows
        .map((r) => {
              'from_state': r[0],
              'to_state': r[1],
              'trigger_type': r[2],
              'event': r[3],
              'actor': r[4],
              'actor_pubkey': r[5],
              'metadata': r[6],
              'created_at': (r[7] as DateTime?)?.toUtc().toIso8601String(),
            })
        .toList();
  }

  Future<void> _ensureTelegramOfferMessagesTable() async {
    if (_connection == null) throw StateError('Database not connected.');
    await _connection!.execute('''
      CREATE TABLE IF NOT EXISTS telegram_offer_messages (
        offer_id UUID NOT NULL,
        chat_id TEXT NOT NULL,
        message_id BIGINT NOT NULL,
        message_text TEXT NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        PRIMARY KEY (offer_id, chat_id)
      );
    ''');
    // Rows for offers that completed normally are never struck out and
    // would accumulate forever; funded offers expire within hours, so
    // anything older than 7 days can no longer need editing.
    await _connection!.execute('''
      DELETE FROM telegram_offer_messages
      WHERE created_at < NOW() - INTERVAL '7 days';
    ''');
    AppLogger.info('telegram_offer_messages table checked/created.',
        action: 'database.schema.telegram_offer_messages.ready');
  }

  Future<void> saveTelegramOfferMessage({
    required String offerId,
    required String chatId,
    required int messageId,
    required String messageText,
  }) async {
    if (_connection == null) throw StateError('Database not connected.');
    await _connection!.execute(
      '''
        INSERT INTO telegram_offer_messages (offer_id, chat_id, message_id, message_text)
        VALUES (@offer_id, @chat_id, @message_id, @message_text)
        ON CONFLICT (offer_id, chat_id)
        DO UPDATE SET message_id = @message_id, message_text = @message_text
      ''',
      substitutionValues: {
        'offer_id': offerId,
        'chat_id': chatId,
        'message_id': messageId,
        'message_text': messageText,
      },
    );
  }

  Future<List<TelegramOfferMessage>> getTelegramOfferMessages(
      String offerId) async {
    if (_connection == null) throw StateError('Database not connected.');
    final results = await _connection!.query(
      'SELECT chat_id, message_id, message_text FROM telegram_offer_messages WHERE offer_id = @offer_id',
      substitutionValues: {'offer_id': offerId},
    );
    return results
        .map((row) => TelegramOfferMessage(
              offerId: offerId,
              chatId: row[0] as String,
              messageId: row[1] as int,
              messageText: row[2] as String,
            ))
        .toList();
  }

  Future<void> deleteTelegramOfferMessages(String offerId) async {
    if (_connection == null) throw StateError('Database not connected.');
    await _connection!.execute(
      'DELETE FROM telegram_offer_messages WHERE offer_id = @offer_id',
      substitutionValues: {'offer_id': offerId},
    );
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
        INSERT INTO offers (id, amount_sats, maker_fees, taker_fees, maker_pubkey, blik_code, blik_received_at, hold_invoice_payment_hash, hold_invoice_preimage, status, created_at, updated_at, fiat_amount, fiat_currency, category, premium_percent, client_version, bank)
        VALUES (@id, @amount_sats, @maker_fees, @taker_fees, @maker_pubkey, @blik_code, @blik_received_at, @hold_invoice_payment_hash, @hold_invoice_preimage, @status, @created_at, @updated_at, @fiat_amount, @fiat_currency, @category, @premium_percent, @client_version, @bank)
      ''',
      substitutionValues: {
        'id': offer.id,
        'amount_sats': offer.amountSats,
        'maker_fees': offer.makerFees,
        'taker_fees': offer.takerFees,
        'maker_pubkey': offer.makerPubkey,
        'blik_code': offer.blikCode,
        'blik_received_at': offer.blikReceivedAt?.toUtc(),
        'hold_invoice_payment_hash': offer.holdInvoicePaymentHash,
        'hold_invoice_preimage': offer.holdInvoicePreimage,
        'status': offer.status.name,
        'created_at': offer.createdAt.toUtc(),
        'updated_at': now,
        'fiat_amount': offer.fiatAmount,
        'fiat_currency': offer.fiatCurrency,
        'category': offer.category?.name,
        'premium_percent': offer.premiumPercent,
        'client_version': offer.clientVersion,
        'bank': offer.bankId,
      },
    );
    return offer.copyWith(updatedAt: now);
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

  // ─── YAML flow persistence ──────────────────────────────────────────
  // These operate on raw state strings because flow states are not enum-bound.
  // GenericOfferFlow decides which fields to set/clear; the DB applies them.

  Future<List<Offer>> getOffersByRawStatus(String status,
      {int limit = 1000, int offset = 0}) async {
    if (_connection == null) throw StateError('Database not connected.');
    final results = await _connection!.query(
      'SELECT * FROM offers WHERE status = @status ORDER BY created_at DESC LIMIT @limit OFFSET @offset',
      substitutionValues: {
        'status': status,
        'limit': limit,
        'offset': offset,
      },
    );
    return results.map(_mapRowToOffer).toList();
  }

  /// All offers whose raw status is NOT one of [terminalStatuses]. Used by the
  /// generic startup sweep to re-arm timers.
  Future<List<Offer>> getOffersNotInRawStatuses(List<String> terminalStatuses,
      {int limit = 5000}) async {
    if (_connection == null) throw StateError('Database not connected.');
    final results = await _connection!.query(
      'SELECT * FROM offers WHERE NOT (status = ANY(CAST(@terminals AS TEXT[]))) '
      'ORDER BY created_at DESC LIMIT @limit',
      substitutionValues: {'terminals': terminalStatuses, 'limit': limit},
    );
    return results.map(_mapRowToOffer).toList();
  }

  /// Atomic compare-and-set on a raw status string. Applies any provided field
  /// updates; when [clearTakerFields] is set, clears the taker/code/timestamp
  /// columns (used by revert-to-open and terminal transitions).
  /// [preserveCodeOnClear] keeps `blik_code` through such a clear — for flows
  /// where the code belongs to the maker (e.g. TWINT), not the taker.
  Future<bool> updateOfferRawStatusIfCurrent(
    String id,
    String newStatus, {
    List<String>? expectedCurrentStatuses,
    String? expectedTakerPubkey,
    String? takerPubkey,
    String? code,
    String? takerInvoice,
    String? takerOffer,
    String? makerRefundInvoice,
    String? makerRefundOffer,
    DateTime? reservedAt,
    DateTime? codeReceivedAt,
    DateTime? takerChargedAt,
    DateTime? makerConfirmedAt,
    DateTime? settledAt,
    DateTime? takerPaidAt,
    DateTime? disputeAt,
    int? takerFees,
    int? takerInvoiceFees,
    String? failureReason,
    bool clearTakerFields = false,
    bool preserveCodeOnClear = false,
    StateTransitionMeta? transitionMeta,
  }) async {
    if (_connection == null) throw StateError('Database not connected.');
    if (takerInvoice != null && takerOffer != null) {
      throw ArgumentError('Exactly one taker payout instruction is allowed');
    }
    if (makerRefundInvoice != null && makerRefundOffer != null) {
      throw ArgumentError('Exactly one maker refund instruction is allowed');
    }
    final now = DateTime.now().toUtc();
    final params = <String, dynamic>{
      'id': id,
      'status': newStatus,
      'updated_at': now,
    };
    final set = <String>['status = @status', 'updated_at = @updated_at'];

    void put(String col, String key, dynamic value) {
      params[key] = value;
      set.add('$col = @$key');
    }

    if (clearTakerFields) {
      // NULL the taker-owned columns, except those this same write explicitly
      // sets — a transition may clear the taker AND write fresh values in one
      // atomic update (e.g. enter_new_twint: clear_taker_fields + set_new_code
      // + stamp_code_received_at). Explicit updates below always win.
      set.addAll([
        if (takerPubkey == null) 'taker_pubkey = NULL',
        if (reservedAt == null) 'reserved_at = NULL',
        // In maker-provides-code flows (preserveCodeOnClear) the code and its
        // issued-at stamp belong to the maker and survive the clear.
        if (code == null && !preserveCodeOnClear) 'blik_code = NULL',
        if (takerInvoice == null && takerOffer == null) 'taker_invoice = NULL',
        if (takerInvoiceFees == null) 'taker_invoice_fees = NULL',
        if (codeReceivedAt == null && !preserveCodeOnClear)
          'blik_received_at = NULL',
        if (takerChargedAt == null) 'taker_charged_at = NULL',
        if (disputeAt == null) 'dispute_at = NULL',
        'dispute_escalation_reason = NULL',
      ]);
    }
    if (takerPubkey != null) put('taker_pubkey', 'taker_pubkey', takerPubkey);
    if (code != null) put('blik_code', 'blik_code', code);
    if (takerInvoice != null) {
      put('taker_invoice', 'taker_invoice', takerInvoice);
    }
    if (takerOffer != null) {
      put('taker_invoice', 'taker_invoice', takerOffer);
    }
    if (makerRefundInvoice != null) {
      put('maker_refund_invoice', 'maker_refund_invoice', makerRefundInvoice);
    }
    if (makerRefundOffer != null) {
      put('maker_refund_invoice', 'maker_refund_invoice', makerRefundOffer);
    }
    if (reservedAt != null) {
      put('reserved_at', 'reserved_at', reservedAt.toUtc());
    }
    if (codeReceivedAt != null) {
      put('blik_received_at', 'blik_received_at', codeReceivedAt.toUtc());
    }
    if (takerChargedAt != null) {
      params['taker_charged_at'] = takerChargedAt.toUtc();
      set.add(
          'taker_charged_at = COALESCE(taker_charged_at, @taker_charged_at)');
    }
    if (makerConfirmedAt != null) {
      put('maker_confirmed_at', 'maker_confirmed_at', makerConfirmedAt);
    }
    if (settledAt != null) put('settled_at', 'settled_at', settledAt);
    if (takerPaidAt != null) put('taker_paid_at', 'taker_paid_at', takerPaidAt);
    if (takerFees != null) put('taker_fees', 'taker_fees', takerFees);
    if (takerInvoiceFees != null) {
      put('taker_invoice_fees', 'taker_invoice_fees', takerInvoiceFees);
    }
    if (failureReason != null) {
      put('taker_payment_failure_reason', 'taker_payment_failure_reason',
          failureReason);
    }
    if (disputeAt != null) {
      params['dispute_at'] = disputeAt.toUtc();
      set.add('dispute_at = COALESCE(dispute_at, @dispute_at)');
    }

    final where = <String>['id = @id'];
    if (expectedCurrentStatuses != null && expectedCurrentStatuses.isNotEmpty) {
      params['expected_current_statuses'] = expectedCurrentStatuses;
      where.add('status = ANY(CAST(@expected_current_statuses AS TEXT[]))');
    }
    if (expectedTakerPubkey != null) {
      params['expected_taker_pubkey'] = expectedTakerPubkey;
      where.add('taker_pubkey = @expected_taker_pubkey');
    }

    // When recording history, capture the pre-update status atomically via a
    // self-join subquery (evaluated against the statement-start snapshot) and
    // RETURN it, so from_state is race-free.
    if (recordStateHistory) {
      final result = await _connection!.query(
        'UPDATE offers AS o SET ${set.join(', ')} '
        'FROM (SELECT status AS old_status FROM offers WHERE id = @id) AS prev '
        'WHERE ${where.join(' AND ')} RETURNING prev.old_status',
        substitutionValues: params,
      );
      final ok = result.affectedRowCount == 1;
      if (ok) {
        await _recordStateTransition(
          offerId: id,
          fromState: result.first.first as String?,
          toState: newStatus,
          meta: transitionMeta,
        );
      }
      return ok;
    }
    final result = await _connection!.query(
      'UPDATE offers SET ${set.join(', ')} WHERE ${where.join(' AND ')}',
      substitutionValues: params,
    );
    return result.affectedRowCount == 1;
  }

  // Fetch active offers where the user is either maker or taker
  Future<List<Offer>> getMyActiveOffers(String userPubkey) async {
    await connect(); // Ensure connection is open
    if (_connection == null)
      throw StateError(
          'Database not connected.'); // Should not happen after connect() but keep for safety
    // Define "active" statuses (exclude terminal/cancelled states)
    final activeStatuses = [
      OfferStatus.created,
      OfferStatus.funded,
      OfferStatus.reserved,
      OfferStatus.blikReceived,
      OfferStatus.blikSentToMaker,
      OfferStatus.expiredBlik,
      OfferStatus.expiredSentBlik,
      OfferStatus.takerCharged,
      OfferStatus.invalidBlik,
      OfferStatus.conflict,
      OfferStatus.makerConfirmed,
      OfferStatus.payingTaker,
      OfferStatus.takerPaymentFailed,
      OfferStatus.takerPaid
    ].map((status) => status.name).toList(growable: false);

    final results = await _connection!.query(
      '''
         SELECT * FROM offers
         WHERE (maker_pubkey = @userPubkey OR taker_pubkey = @userPubkey)
         AND status = ANY(CAST(@activeStatuses AS TEXT[]))
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
    OfferCategory? parseCategory(dynamic raw) {
      if (raw is! String || raw.trim().isEmpty) return null;
      try {
        return OfferCategory.values.byName(raw);
      } catch (_) {
        return null;
      }
    }

    final takerPayment = map['taker_invoice'] as String?;
    final makerRefundPayment = map['maker_refund_invoice'] as String?;
    return Offer(
      id: map['id'],
      amountSats: map['amount_sats'],
      makerFees: map['maker_fees'],
      makerPubkey: map['maker_pubkey'],
      coordinatorPubkey: map['coordinator_pubkey'] ?? '',
      holdInvoicePaymentHash: map['hold_invoice_payment_hash'],
      holdInvoicePreimage: map['hold_invoice_preimage'],
      // Generic (yaml-driven) flows store raw state strings that have no
      // OfferStatus value; keep the verbatim string in statusRaw and fall back
      // to the unknown sentinel for the enum view.
      status: () {
        try {
          return OfferStatus.values.byName(map['status'] as String);
        } catch (_) {
          return OfferStatus.unknown;
        }
      }(),
      statusRaw: map['status'] as String,
      createdAt: (map['created_at'] as DateTime).toLocal(),
      fiatAmount: double.parse(map['fiat_amount']),
      fiatCurrency: map['fiat_currency'] ?? '?',
      takerPubkey: map['taker_pubkey'],
      takerInvoice:
          takerPayment != null && isBolt11(takerPayment) ? takerPayment : null,
      takerOffer: takerPayment != null && isBolt12Offer(takerPayment)
          ? takerPayment
          : null,
      makerRefundInvoice:
          makerRefundPayment != null && isBolt11(makerRefundPayment)
              ? makerRefundPayment
              : null,
      makerRefundOffer:
          makerRefundPayment != null && isBolt12Offer(makerRefundPayment)
              ? makerRefundPayment
              : null,
      blikCode: map['blik_code'],
      updatedAt: (map['updated_at'] as DateTime?)?.toLocal(),
      reservedAt: (map['reserved_at'] as DateTime?)?.toLocal(),
      blikReceivedAt: (map['blik_received_at'] as DateTime?)?.toLocal(),
      makerConfirmedAt: (map['maker_confirmed_at'] as DateTime?)?.toLocal(),
      settledAt: (map['settled_at'] as DateTime?)?.toLocal(),
      disputeAt: (map['dispute_at'] as DateTime?)?.toLocal(),
      takerChargedAt: (map['taker_charged_at'] as DateTime?)?.toLocal(),
      disputeEscalationReason: () {
        final raw = map['dispute_escalation_reason'];
        if (raw is! String || raw.trim().isEmpty) return null;
        try {
          return DisputeEscalationReason.values.byName(raw);
        } catch (_) {
          return DisputeEscalationReason.unknown;
        }
      }(),
      takerPaidAt: (map['taker_paid_at'] as DateTime?)?.toLocal(),
      takerFees: map['taker_fees'],
      takerPaymentFailureReason: map['taker_payment_failure_reason'],
      category: parseCategory(map['category']),
      premiumPercent: () {
        final v = map['premium_percent'];
        if (v is num) return v.toDouble();
        if (v is String) return double.tryParse(v) ?? 0.0;
        return 0.0;
      }(),
      // `bank` column exists only after migration; older rows / other markets
      // return null via the column map.
      bankId: map.containsKey('bank') ? map['bank'] as String? : null,
      clientVersion: map['client_version'] as String?,
    );
  }
}
