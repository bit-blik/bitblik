import 'package:ndk/shared/logger/logger.dart';

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
}

// Represents an offer listed by the coordinator.
class Offer {
  final String id;
  final int amountSats;
  final int makerFees; // Renamed from feeSats
  final double fiatAmount;
  final String fiatCurrency;
  final String status; // e.g., "funded", "reserved", etc. Use OfferStatus.name
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
  });

  // Factory constructor to create an Offer from JSON data (Map).
  factory Offer.fromJson(Map<String, dynamic> json) {
    DateTime? parseOptionalDateTime(dynamic value) {
      if (value == null) return null;
      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
      if (value is String) {
        // Try ISO8601 first
        try {
          return DateTime.parse(value);
        } catch (_) {
          // Fallback: try parse as int millis inside a string
          final asInt = int.tryParse(value);
          if (asInt != null) {
            return DateTime.fromMillisecondsSinceEpoch(asInt);
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
      status: safeString(
        json['status'],
        OfferStatus.takerPaid.name,
      ), // Default to takerPaid for stats if missing
      createdAt: () {
        final v = json['created_at'];
        if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
        if (v is String) {
          try {
            return DateTime.parse(v);
          } catch (_) {
            final asInt = int.tryParse(v);
            if (asInt != null)
              return DateTime.fromMillisecondsSinceEpoch(asInt);
          }
        }
        // Sensible fallback to "now" to avoid crash; ideally this should not happen.
        return DateTime.now();
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
      takerFees: json['taker_fees'] as int?, // Renamed key and field
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
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'maker_pubkey': makerPubkey,
      'coordinator_pubkey': coordinatorPubkey,
      'taker_pubkey': takerPubkey,
      'reserved_at': reservedAt?.toIso8601String(),
      'blik_received_at': blikReceivedAt?.toIso8601String(),
      'blik_code': blikCode,
      'hold_invoice_payment_hash': holdInvoicePaymentHash,
      'hold_invoice': holdInvoice,
      'taker_lightning_address': takerLightningAddress,
      'taker_invoice': takerInvoice,
      'hold_invoice_preimage': holdInvoicePreimage,
      'updated_at': updatedAt?.toIso8601String(),
      'maker_confirmed_at': makerConfirmedAt?.toIso8601String(),
      'settled_at': settledAt?.toIso8601String(),
      'taker_paid_at': takerPaidAt?.toIso8601String(),
      'taker_fees': takerFees, // Renamed key and field
    };
  }

  // Helper to get status as enum
  OfferStatus get statusEnum {
    try {
      return OfferStatus.values.byName(status);
    } catch (e) {
      // Handle cases where the string doesn't match any enum value
      Logger.log.w(
        () => 'Warning: Unknown offer status "$status", defaulting to created.',
      );
      return OfferStatus
          .created; // Or throw an error, depending on desired behavior
    }
  }

  bool get isConflict => status == OfferStatus.conflict.name;

  bool get isInvalidBlik => status == OfferStatus.invalidBlik.name;

  bool get isDispute => status == OfferStatus.dispute.name;

  // copyWith method for updating state immutably
  Offer copyWith({
    String? id,
    int? amountSats,
    int? makerFees, // Renamed parameter
    String? status,
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
    int? takerFees, // Renamed parameter
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
      takerFees: takerFees ?? this.takerFees, // Renamed parameter and field
      // No copyWith for getters
    );
  }

  @override
  String toString() {
    return 'Offer(id: $id, amountSats: $amountSats, makerFees: $makerFees, status: $status, maker: ${makerPubkey.substring(0, 6)}..., taker: ${takerPubkey?.substring(0, 6)}..., createdAt: $createdAt)'; // Renamed field
  }
}
