/// Status notification emitted by a coordinator on an offer it manages.
///
/// Wire-format: JSON payload inside the encrypted content of a kind
/// [kKindOfferStatusUpdate] event. `coordinatorPubkey` is derived from the
/// outer event's author (not part of the encrypted payload).
class OfferStatusUpdate {
  final String offerId;
  final String paymentHash;
  final String status;
  final String coordinatorPubkey;
  final DateTime? createdAt;
  final DateTime? reservedAt;
  final DateTime timestamp;

  OfferStatusUpdate({
    required this.offerId,
    required this.paymentHash,
    required this.status,
    this.createdAt,
    this.reservedAt,
    required this.coordinatorPubkey,
    required this.timestamp,
  });

  factory OfferStatusUpdate.fromJson(
    Map<String, dynamic> json,
    String coordinatorPubkey,
  ) {
    DateTime? parseEpochSeconds(dynamic v) {
      if (v == null) return null;
      if (v is int) {
        return DateTime.fromMillisecondsSinceEpoch(v * 1000, isUtc: true);
      }
      if (v is num) {
        return DateTime.fromMillisecondsSinceEpoch(
          v.toInt() * 1000,
          isUtc: true,
        );
      }
      return null;
    }

    return OfferStatusUpdate(
      offerId: json['offer_id'] as String,
      paymentHash: json['payment_hash'] as String,
      status: json['status'] as String,
      createdAt: parseEpochSeconds(json['created_at']),
      reservedAt: parseEpochSeconds(json['reserved_at']),
      coordinatorPubkey: coordinatorPubkey,
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        (json['timestamp'] as int) * 1000,
        isUtc: true,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offer_id': offerId,
      'payment_hash': paymentHash,
      'status': status,
      if (createdAt != null)
        'created_at': createdAt!.millisecondsSinceEpoch ~/ 1000,
      if (reservedAt != null)
        'reserved_at': reservedAt!.millisecondsSinceEpoch ~/ 1000,
      'timestamp': timestamp.millisecondsSinceEpoch ~/ 1000,
    };
  }
}
