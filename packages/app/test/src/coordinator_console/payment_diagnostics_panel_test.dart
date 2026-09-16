import 'package:bitblik/src/coordinator_console/dispute_case_repository.dart';
import 'package:bitblik/src/coordinator_console/payment_diagnostics_panel.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

CoordinatorDisputeCase example({
  String state = 'payingTaker',
  bool ready = true,
  bool processing = false,
}) => CoordinatorDisputeCase(
  offer: Offer(
    id: 'offer-1',
    makerPubkey: 'maker',
    coordinatorPubkey: 'coordinator',
    amountSats: 1500,
    makerFees: 10,
    status: OfferStatus.unknown,
    statusRaw: state,
    fiatAmount: 100,
    fiatCurrency: 'PLN',
    createdAt: DateTime.utc(2026, 9, 16),
  ),
  stateHistory: const [],
  makerRefundInvoiceReady: ready,
  paymentBackendType: 'ldk-server',
  paymentBackendAvailable: true,
  makerRefundSats: 1510,
  takerPayoutSats: 1500,
  paymentDiagnostics: {
    'retry_supported': true,
    'processing': processing,
    'last_error': {
      'message': 'InvoiceRequestExpired',
      'stack_trace': 'full stack trace',
    },
    'attempts': [
      {'id': 'attempt-1', 'state': 'unknown', 'amount_sats': 1500},
    ],
  },
);

void main() {
  for (final width in [360.0, 1280.0]) {
    testWidgets('retry and full details fit ${width.toInt()}px', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var retries = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentDiagnosticsPanel(
              item: example(),
              busy: false,
              onRetry: () => retries++,
            ),
          ),
        ),
      );
      expect(find.textContaining('InvoiceRequestExpired'), findsOneWidget);
      await tester.tap(find.text('Retry taker payment'));
      expect(retries, 1);
      await tester.tap(find.text('Payment details (1)'));
      await tester.pumpAndSettle();
      expect(find.text('Copy details'), findsOneWidget);
      expect(find.byType(SelectableText), findsOneWidget);
      final details = tester
          .widget<SelectableText>(find.byType(SelectableText))
          .data!;
      expect(details, contains('full stack trace'));
      expect(details, contains('attempt-1'));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('missing refund instruction and pending check disable retry', (
    tester,
  ) async {
    var retries = 0;
    for (final item in [
      example(state: 'refundingMaker', ready: false),
      example(state: 'payingMaker', processing: true),
    ]) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentDiagnosticsPanel(
              item: item,
              busy: false,
              onRetry: () => retries++,
            ),
          ),
        ),
      );
      await tester.tap(find.text('Retry maker refund'));
      expect(retries, 0);
      expect(tester.takeException(), isNull);
    }
  });
}
