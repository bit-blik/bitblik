import 'package:ndk/ndk.dart';

enum OfferStatus {
  created, // Initial state, invoice generated but not paid
  funded, // Hold invoice paid by maker, offer listed

  expired, // Offer timed out (e.g., reservation, BLIK confirmation)
  cancelled, // Offer explicitly cancelled by Maker while in 'funded' state

  reserved, // Taker has expressed interest, 15s timer started
  blikReceived, // Taker submitted BLIK, 120s timer started
  blikSentToMaker, // Maker requested BLIK code
  expiredBlik, // BLIK not confirmed in time
  expiredSentBlik, // Maker did not confirm BLIK in time

  takerCharged, // taker reported BLIK charged to their account

  invalidBlik, // Maker marked the BLIK code as invalid
  conflict, // Taker reported conflict after Maker marked BLIK as invalid
  dispute, // Maker opened a dispute after conflict

  makerConfirmed, // Maker confirmed BLIK payment success
  settled, // Hold invoice settled by coordinator

  payingTaker, // Taker is being paid
  takerPaymentFailed, // Settled, but LNURL payment to taker failed
  takerPaid, // Taker successfully paid via LNURL-pay

  // Sentinel: persisted status name not recognized by this client build.
  // Append-only enum — never rename or remove existing values; this catches
  // future statuses introduced by newer coordinators.
  unknown,
}

enum OfferCategory {
  shop,
  atm,
  online,
}

// Represents an offer listed by the coordinator.
class Offer {
  final String id;
  final int amountSats;
  final int makerFees; // Renamed from feeSats
  final double fiatAmount;
  final String fiatCurrency;
  final OfferStatus status;
  final DateTime createdAt;
  final String makerPubkey;
  final String coordinatorPubkey; // Added coordinator pubkey
  final String? takerPubkey;
  final DateTime? reservedAt;
  final DateTime? blikReceivedAt;
  final String? blikCode;
  String? holdInvoicePaymentHash;
  final String? holdInvoice; // The actual bolt11 invoice string
  // Added fields based on DB schema that might be useful
  final String? takerLightningAddress;
  final String? takerInvoice;
  final String?
      holdInvoicePreimage; // Might be sensitive, consider if needed on client
  final DateTime? updatedAt;
  final DateTime? makerConfirmedAt;
  final DateTime? settledAt;
  final DateTime? takerPaidAt;
  final int? takerFees;
  final String? takerPaymentFailureReason;
  final OfferCategory? category;

  /// Maker premium (%) above market price. `0` means no premium. A premium
  /// reduces the sats locked in the hold invoice for the same fiat amount, so
  /// the taker effectively pays above market.
  final double premiumPercent;

  /// Wallet ID used by the maker to pay the hold invoice.
  /// Null means the default sending wallet was used (or payment not yet made).
  /// Persisted so wallet balance/budget can be refreshed after app restart.
  final String? paymentWalletId;

  // Calculated getters for processing times
  int? get timeToReserveSeconds {
    if (reservedAt != null) {
      // createdAt is non-nullable
      return reservedAt!.difference(createdAt).inSeconds;
    }
    return null;
  }

  int? get timeToBlikSeconds {
    if (reservedAt != null && blikReceivedAt != null) {
      return blikReceivedAt!.difference(reservedAt!).inSeconds;
    }
    return null;
  }

  int? get timeToConfirmSeconds {
    if (blikReceivedAt != null && makerConfirmedAt != null) {
      return makerConfirmedAt!.difference(blikReceivedAt!).inSeconds;
    }
    return null;
  }

  int? get timeToPaySeconds {
    // This is the time from maker confirmation to taker payment
    if (makerConfirmedAt != null && takerPaidAt != null) {
      return takerPaidAt!.difference(makerConfirmedAt!).inSeconds;
    }
    return null;
  }

  int? get totalCompletionTimeTakerSeconds {
    if (settledAt != null) {
      return settledAt!.difference(createdAt).inSeconds;
    }
    return null;
  }

  int? get totalCompletionTimeMakerSeconds {
    // Total time from creation to taker payment for successful Maker flow
    // (useful for overall stats if offer was taken)
    if (takerPaidAt != null) {
      // createdAt is non-nullable
      return takerPaidAt!.difference(createdAt).inSeconds;
    }
    return null;
  }

  Offer({
    required this.id,
    required this.amountSats,
    required this.makerFees,
    required this.status,
    required this.fiatAmount,
    required this.fiatCurrency,
    required this.createdAt,
    required this.makerPubkey,
    required this.coordinatorPubkey,
    this.takerPubkey,
    this.reservedAt,
    this.blikReceivedAt,
    this.blikCode,
    this.holdInvoicePaymentHash,
    this.holdInvoice,
    this.takerLightningAddress,
    this.takerInvoice,
    this.holdInvoicePreimage,
    this.updatedAt,
    this.makerConfirmedAt,
    this.settledAt,
    this.takerPaidAt,
    this.takerFees,
    this.takerPaymentFailureReason,
    this.category,
    this.premiumPercent = 0,
    this.paymentWalletId,
  });

  // Factory constructor to create an Offer from JSON data (Map).
  factory Offer.fromJson(Map<String, dynamic> json) {
    DateTime? parseOptionalDateTime(dynamic value) {
      if (value == null) return null;
      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value, isUtc: true);
      }
      if (value is String) {
        final normalized = value.trim();
        if (normalized.isEmpty) return null;
        try {
          return DateTime.parse(normalized);
        } catch (_) {
          // Fallback: try parse as int millis inside a string
          final asInt = int.tryParse(normalized);
          if (asInt != null) {
            return DateTime.fromMillisecondsSinceEpoch(asInt, isUtc: true);
          }
        }
      }
      return null;
    }

    // Helper to safely parse string providing a default
    String safeString(dynamic value, String defaultValue) {
      return value is String ? value : defaultValue;
    }

    // Helper to safely parse int providing a default
    int safeInt(dynamic value, int defaultValue) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? defaultValue;
      return defaultValue;
    }

    // Helper to safely parse double providing a default
    double safeDouble(dynamic value, double defaultValue) {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? defaultValue;
      return defaultValue;
    }

    return Offer(
      id: safeString(
        json['id'],
        'unknown_id',
      ), // Default if 'id' is null or not a string
      amountSats: safeInt(
        json['amount_sats'],
        0,
      ), // Default if 'amount_sats' is null or not an int
      makerFees: safeInt(
        json['maker_fees'],
        0,
      ), // Default if 'maker_fees' is null or not an int
      fiatAmount: safeDouble(
        json['fiat_amount'],
        0.0,
      ), // Already handles null with ?? 0
      fiatCurrency: safeString(
        json['fiat_currency'],
        'UNK',
      ), // Default if 'fiat_currency' is null or not a string
      status: () {
        final raw = safeString(json['status'], OfferStatus.unknown.name);
        try {
          return OfferStatus.values.byName(raw);
        } catch (_) {
          // Unknown future status — preserve as sentinel instead of silently
          // downgrading to `created`, which could trigger duplicate actions on
          // an already-progressed offer.
          return OfferStatus.unknown;
        }
      }(),
      createdAt: () {
        final v = json['created_at'];
        if (v is int)
          return DateTime.fromMillisecondsSinceEpoch(v, isUtc: true);
        if (v is String) {
          final normalized = v.trim();
          try {
            return DateTime.parse(normalized);
          } catch (_) {
            final asInt = int.tryParse(normalized);
            if (asInt != null)
              return DateTime.fromMillisecondsSinceEpoch(asInt, isUtc: true);
          }
        }
        // Sensible fallback to "now" to avoid crash; ideally this should not happen.
        return DateTime.now().toUtc();
      }(),
      makerPubkey: safeString(
        json['maker_pubkey'],
        'unknown_maker',
      ), // Default if 'maker_pubkey' is null or not a string
      coordinatorPubkey: safeString(
        json['coordinator_pubkey'],
        'unknown_coordinator',
      ), // Added coordinator pubkey
      takerPubkey: json['taker_pubkey'] as String?, // Already nullable
      reservedAt: parseOptionalDateTime(json['reserved_at']),
      blikReceivedAt: parseOptionalDateTime(json['blik_received_at']),
      blikCode: json['blik_code'] as String?,
      holdInvoicePaymentHash: json['hold_invoice_payment_hash'] as String?,
      holdInvoice: json['hold_invoice'] as String?,
      // Parse additional fields if present in JSON
      takerLightningAddress: json['taker_lightning_address'] as String?,
      takerInvoice: json['taker_invoice'] as String?,
      holdInvoicePreimage:
          json['hold_invoice_preimage'] as String?, // Be cautious exposing this
      updatedAt: parseOptionalDateTime(json['updated_at']),
      makerConfirmedAt: parseOptionalDateTime(json['maker_confirmed_at']),
      settledAt: parseOptionalDateTime(json['settled_at']),
      takerPaidAt: parseOptionalDateTime(json['taker_paid_at']),
      takerFees: json['taker_fees'] as int?,
      takerPaymentFailureReason:
          json['taker_payment_failure_reason'] as String?,
      category: () {
        final raw = json['category'];
        if (raw is! String || raw.trim().isEmpty) return null;
        try {
          return OfferCategory.values.byName(raw);
        } catch (_) {
          return null;
        }
      }(),
      premiumPercent: safeDouble(json['premium_percent'], 0),
      paymentWalletId: json['payment_wallet_id'] as String?,
    );
  }

  // Method to convert Offer instance back to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount_sats': amountSats,
      'maker_fees': makerFees, // Renamed key and field
      'fiat_amount': fiatAmount,
      'fiat_currency': fiatCurrency,
      'status': status.name,
      'created_at': createdAt.toUtc().toIso8601String(),
      'maker_pubkey': makerPubkey,
      'coordinator_pubkey': coordinatorPubkey,
      'taker_pubkey': takerPubkey,
      'reserved_at': reservedAt?.toUtc().toIso8601String(),
      'blik_received_at': blikReceivedAt?.toUtc().toIso8601String(),
      'blik_code': blikCode,
      'hold_invoice_payment_hash': holdInvoicePaymentHash,
      'hold_invoice': holdInvoice,
      'taker_lightning_address': takerLightningAddress,
      'taker_invoice': takerInvoice,
      'hold_invoice_preimage': holdInvoicePreimage,
      'updated_at': updatedAt?.toUtc().toIso8601String(),
      'maker_confirmed_at': makerConfirmedAt?.toUtc().toIso8601String(),
      'settled_at': settledAt?.toUtc().toIso8601String(),
      'taker_paid_at': takerPaidAt?.toUtc().toIso8601String(),
      'taker_fees': takerFees,
      'taker_payment_failure_reason': takerPaymentFailureReason,
      'category': category?.name,
      'premium_percent': premiumPercent,
      'payment_wallet_id': paymentWalletId,
    };
  }

  /// Slim payload for the successful-offers stats list. Drops large fields
  /// (bolt11 invoices, preimage, blik code, pubkeys) to keep the RPC event
  /// under the relay size limit. Only the fields the stats UI reads are kept.
  Map<String, dynamic> toStatsJson() {
    return {
      'id': id,
      'fiat_amount': fiatAmount,
      'fiat_currency': fiatCurrency,
      'status': status.name,
      'created_at': createdAt.toUtc().toIso8601String(),
      'coordinator_pubkey': coordinatorPubkey,
      'reserved_at': reservedAt?.toUtc().toIso8601String(),
      'taker_paid_at': takerPaidAt?.toUtc().toIso8601String(),
    };
  }

  // Helper to get status as enum
  OfferStatus get statusEnum => status;

  bool get hasPremium => premiumPercent > 0;

  bool get isConflict => status == OfferStatus.conflict;

  bool get isInvalidBlik => status == OfferStatus.invalidBlik;

  bool get isDispute => status == OfferStatus.dispute;

  Map<String, dynamic> toJsonWithPubkeys() => toJson()
    ..addAll({
      'maker_pubkey': makerPubkey,
      'taker_pubkey': takerPubkey,
    });

  /// Compact offer payload for encrypted RPC responses.
  ///
  /// NIP-44 rejects plaintexts larger than 65,535 bytes. The coordinator's
  /// query endpoints do not need to ship bulky/sensitive fields such as the
  /// taker's invoice or the hold-invoice preimage on every poll, so omit them
  /// by default to preserve compatibility with older clients that still rely on
  /// `get_my_active_offer`.
  Map<String, dynamic> toRpcJson({
    bool includeBlikCode = false,
    bool includeTakerInvoice = false,
    bool includeHoldInvoicePreimage = false,
  }) {
    final json = toJsonWithPubkeys();
    if (!includeBlikCode) {
      json.remove('blik_code');
    }
    if (!includeTakerInvoice) {
      json.remove('taker_invoice');
    }
    if (!includeHoldInvoicePreimage) {
      json.remove('hold_invoice_preimage');
    }
    return json;
  }

  // copyWith method for updating state immutably
  Offer copyWith({
    String? id,
    int? amountSats,
    int? makerFees, // Renamed parameter
    OfferStatus? status,
    DateTime? createdAt,
    String? makerPubkey,
    String? coordinatorPubkey,
    String? takerPubkey,
    DateTime? reservedAt,
    DateTime? blikReceivedAt,
    String? blikCode,
    String? holdInvoicePaymentHash,
    String? holdInvoice,
    String? takerLightningAddress,
    String? takerInvoice,
    String? holdInvoicePreimage,
    DateTime? updatedAt,
    DateTime? makerConfirmedAt,
    DateTime? settledAt,
    DateTime? takerPaidAt,
    int? takerFees,
    String? takerPaymentFailureReason,
    OfferCategory? category,
    double? premiumPercent,
    String? paymentWalletId,
  }) {
    return Offer(
      id: id ?? this.id,
      amountSats: amountSats ?? this.amountSats,
      makerFees: makerFees ?? this.makerFees, // Renamed parameter and field
      status: status ?? this.status,
      fiatAmount: fiatAmount,
      fiatCurrency: fiatCurrency,
      createdAt: createdAt ?? this.createdAt,
      makerPubkey: makerPubkey ?? this.makerPubkey,
      coordinatorPubkey: coordinatorPubkey ?? this.coordinatorPubkey,
      takerPubkey: takerPubkey ?? this.takerPubkey,
      reservedAt: reservedAt ?? this.reservedAt,
      blikReceivedAt: blikReceivedAt ?? this.blikReceivedAt,
      blikCode: blikCode ?? this.blikCode,
      holdInvoicePaymentHash:
          holdInvoicePaymentHash ?? this.holdInvoicePaymentHash,
      holdInvoice: holdInvoice ?? this.holdInvoice,
      takerLightningAddress:
          takerLightningAddress ?? this.takerLightningAddress,
      takerInvoice: takerInvoice ?? this.takerInvoice,
      holdInvoicePreimage: holdInvoicePreimage ?? this.holdInvoicePreimage,
      updatedAt: updatedAt ?? this.updatedAt,
      makerConfirmedAt: makerConfirmedAt ?? this.makerConfirmedAt,
      settledAt: settledAt ?? this.settledAt,
      takerPaidAt: takerPaidAt ?? this.takerPaidAt,
      takerFees: takerFees ?? this.takerFees,
      takerPaymentFailureReason:
          takerPaymentFailureReason ?? this.takerPaymentFailureReason,
      category: category ?? this.category,
      premiumPercent: premiumPercent ?? this.premiumPercent,
      paymentWalletId: paymentWalletId ?? this.paymentWalletId,
    );
  }

  @override
  String toString() {
    return 'Offer(id: $id, amountSats: $amountSats, makerFees: $makerFees, status: $status, premium: $premiumPercent%, category: ${category?.name}, maker: ${makerPubkey.substring(0, 6)}..., taker: ${takerPubkey?.substring(0, 6)}..., createdAt: $createdAt)'; // Renamed field
  }

  /// Parse a kind [kKindOffer] Nostr event (NIP-69-ish parameterized
  /// replaceable order) into an [Offer]. Used by the app's live offer feed
  /// and by the cli's `offer list` command.
  factory Offer.fromNostrEvent(Nip01Event event) {
    final tagMap = <String, String>{};
    for (final t in event.tags) {
      if (t.length >= 2) tagMap[t[0]] = t[1];
    }

    DateTime? epochSecondsOrNull(String? raw) {
      final v = int.tryParse(raw ?? '');
      if (v == null || v == 0) return null;
      return DateTime.fromMillisecondsSinceEpoch(v * 1000, isUtc: true);
    }

    final createdAtSecs = int.tryParse(tagMap['created_at'] ?? '0') ?? 0;

    return Offer(
      id: tagMap['d'] ?? event.id,
      amountSats: int.tryParse(tagMap['amt'] ?? '0') ?? 0,
      makerFees: int.tryParse(tagMap['maker_fees'] ?? '0') ?? 0,
      fiatAmount: double.tryParse(tagMap['fa'] ?? '0') ?? 0.0,
      fiatCurrency: tagMap['f'] ?? 'PLN',
      status: _statusFromNip69(tagMap['s'] ?? 'pending') ?? OfferStatus.funded,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        createdAtSecs * 1000,
        isUtc: true,
      ),
      makerPubkey: tagMap['maker'] ?? event.pubKey,
      coordinatorPubkey: tagMap['p'] ?? event.pubKey,
      takerPubkey: tagMap['taker'],
      reservedAt: epochSecondsOrNull(tagMap['reserved_at']),
      takerPaidAt: epochSecondsOrNull(tagMap['paid_at']),
      takerFees: int.tryParse(tagMap['taker_fees'] ?? ''),
      category: () {
        final raw = tagMap['category'];
        if (raw == null || raw.isEmpty) return null;
        try {
          return OfferCategory.values.byName(raw);
        } catch (_) {
          return null;
        }
      }(),
      premiumPercent: double.tryParse(tagMap['premium'] ?? '0') ?? 0,
    );
  }
}

/// Map NIP-69 short status string back to an [OfferStatus]. Inverse of the
/// mapping the coordinator applies when broadcasting.
OfferStatus? _statusFromNip69(String s) {
  switch (s) {
    case 'pending':
      return OfferStatus.funded;
    case 'in-progress':
      return OfferStatus.reserved;
    case 'success':
      return OfferStatus.takerPaid;
    case 'canceled':
      return OfferStatus.cancelled;
    case 'dispute':
      return OfferStatus.conflict;
    default:
      return null;
  }
}
