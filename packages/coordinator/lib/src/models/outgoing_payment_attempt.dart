enum OutgoingPaymentType { bolt11, bolt12 }

enum OutgoingPaymentAttemptState {
  prepared,
  submitted,
  pending,
  succeeded,
  failed,
  unknown,
}

class OutgoingPaymentAttempt {
  final String id;
  final String offerId;
  final String purpose;
  final int generation;
  final OutgoingPaymentType paymentType;
  final String? bolt11Invoice;
  final String? bolt12Offer;
  final int expectedAmountSats;
  final int? feeLimitSats;
  final String backendType;
  final String? backendPaymentId;
  final OutgoingPaymentAttemptState state;
  final String? paymentHash;
  final String? preimage;
  final String? payerProof;
  final int? feePaidSats;
  final String? failureReason;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? settledAt;

  const OutgoingPaymentAttempt({
    required this.id,
    required this.offerId,
    required this.purpose,
    required this.generation,
    required this.paymentType,
    required this.expectedAmountSats,
    required this.backendType,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    this.bolt11Invoice,
    this.bolt12Offer,
    this.feeLimitSats,
    this.backendPaymentId,
    this.paymentHash,
    this.preimage,
    this.payerProof,
    this.feePaidSats,
    this.failureReason,
    this.settledAt,
  });

  String get encoded => bolt11Invoice ?? bolt12Offer!;

  bool get isTerminal =>
      state == OutgoingPaymentAttemptState.succeeded ||
      state == OutgoingPaymentAttemptState.failed;
}
