import 'package:bitblik_coordinator/src/models/outgoing_payment_attempt.dart';
import 'package:mockito/mockito.dart';

import 'test_mocks.mocks.dart';

void stubOutgoingPaymentAttempts(
  MockDatabaseService db, {
  OutgoingPaymentAttemptState initialState =
      OutgoingPaymentAttemptState.prepared,
  String? backendPaymentId,
}) {
  OutgoingPaymentAttempt? current;
  when(db.getOrCreateOutgoingPaymentAttempt(
    id: anyNamed('id'),
    offerId: anyNamed('offerId'),
    purpose: anyNamed('purpose'),
    paymentType: anyNamed('paymentType'),
    encoded: anyNamed('encoded'),
    expectedAmountSats: anyNamed('expectedAmountSats'),
    feeLimitSats: anyNamed('feeLimitSats'),
    backendType: anyNamed('backendType'),
  )).thenAnswer((invocation) async {
    final now = DateTime.now().toUtc();
    final previous = current;
    if (previous?.state == OutgoingPaymentAttemptState.failed) current = null;
    current ??= OutgoingPaymentAttempt(
      id: invocation.namedArguments[#id] as String,
      offerId: invocation.namedArguments[#offerId] as String,
      purpose: invocation.namedArguments[#purpose] as String,
      generation: previous == null ? 0 : previous.generation + 1,
      paymentType:
          invocation.namedArguments[#paymentType] as OutgoingPaymentType,
      bolt11Invoice:
          invocation.namedArguments[#paymentType] == OutgoingPaymentType.bolt11
              ? invocation.namedArguments[#encoded] as String
              : null,
      bolt12Offer:
          invocation.namedArguments[#paymentType] == OutgoingPaymentType.bolt12
              ? invocation.namedArguments[#encoded] as String
              : null,
      expectedAmountSats: invocation.namedArguments[#expectedAmountSats] as int,
      feeLimitSats: invocation.namedArguments[#feeLimitSats] as int?,
      backendType: invocation.namedArguments[#backendType] as String,
      backendPaymentId: backendPaymentId,
      state: initialState,
      createdAt: now,
      updatedAt: now,
    );
    return current!;
  });
  when(db.updateOutgoingPaymentAttempt(
    any,
    state: anyNamed('state'),
    backendPaymentId: anyNamed('backendPaymentId'),
    paymentHash: anyNamed('paymentHash'),
    preimage: anyNamed('preimage'),
    payerProof: anyNamed('payerProof'),
    feePaidSats: anyNamed('feePaidSats'),
    failureReason: anyNamed('failureReason'),
  )).thenAnswer((invocation) async {
    final old = current!;
    final now = DateTime.now().toUtc();
    current = OutgoingPaymentAttempt(
      id: old.id,
      offerId: old.offerId,
      purpose: old.purpose,
      generation: old.generation,
      paymentType: old.paymentType,
      bolt11Invoice: old.bolt11Invoice,
      bolt12Offer: old.bolt12Offer,
      expectedAmountSats: old.expectedAmountSats,
      feeLimitSats: old.feeLimitSats,
      backendType: old.backendType,
      backendPaymentId:
          invocation.namedArguments[#backendPaymentId] as String? ??
              old.backendPaymentId,
      state: invocation.namedArguments[#state] as OutgoingPaymentAttemptState,
      preimage: invocation.namedArguments[#preimage] as String? ?? old.preimage,
      payerProof:
          invocation.namedArguments[#payerProof] as String? ?? old.payerProof,
      feePaidSats:
          invocation.namedArguments[#feePaidSats] as int? ?? old.feePaidSats,
      failureReason: invocation.namedArguments[#failureReason] as String? ??
          old.failureReason,
      createdAt: old.createdAt,
      updatedAt: now,
      settledAt: invocation.namedArguments[#state] ==
              OutgoingPaymentAttemptState.succeeded
          ? now
          : old.settledAt,
    );
    return current!;
  });
}
