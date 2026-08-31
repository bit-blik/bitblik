import 'package:bitblik/src/coordinator_console/dispute_case_repository.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final offer = Offer(
    id: 'offer-123',
    amountSats: 30000,
    makerFees: 11,
    fiatAmount: 100,
    fiatCurrency: 'PLN',
    createdAt: DateTime.utc(2026),
    makerPubkey: 'maker',
    takerPubkey: 'taker',
    coordinatorPubkey: 'coordinator',
    status: OfferStatus.dispute,
  );
  final dispute = CoordinatorDisputeCase(
    offer: offer,
    stateHistory: const [],
    makerRefundInvoiceReady: false,
    paymentBackendType: 'lightning',
    paymentBackendAvailable: true,
    makerRefundSats: 30011,
    takerPayoutSats: 29800,
  );

  test('maker ruling informs both participants with case and amount', () {
    final messages = rulingChatMessages(dispute, makerWins: true);

    expect(messages.maker, contains('offer-123'));
    expect(messages.maker, contains('ruled in your favor'));
    expect(messages.maker, contains('30011 sats'));
    expect(messages.maker, contains('submit the refund invoice'));
    expect(messages.taker, contains('in favor of the maker'));
    expect(messages.taker, contains('30011 sats'));
  });

  test('taker ruling informs both participants with case and amount', () {
    final messages = rulingChatMessages(dispute, makerWins: false);

    expect(messages.maker, contains('offer-123'));
    expect(messages.maker, contains('in favor of the taker'));
    expect(messages.maker, contains('29800 sats'));
    expect(messages.taker, contains('ruled in your favor'));
    expect(messages.taker, contains('29800 sats'));
  });
}
