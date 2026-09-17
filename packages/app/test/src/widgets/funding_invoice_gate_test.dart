import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/screens/maker_flow/maker_pay_invoice_screen.dart';
import 'package:bitblik/src/services/funding_payment.dart';
import 'package:bitblik/src/widgets/funding_invoice_gate.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/test/support/funding_invoices.dart';

class _ActiveOffer extends StateNotifier<Offer?>
    implements ActiveOfferNotifier {
  _ActiveOffer(super.state);
  @override
  Future<void> setActiveOffer(Offer? offer) async => state = offer;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Offer _offer(
  String invoice, {
  int sats = 1490,
  int fees = 10,
  double fiat = 10,
  String currency = 'PLN',
}) => Offer(
  id: fundingHash,
  amountSats: sats,
  makerFees: fees,
  status: OfferStatus.created,
  fiatAmount: fiat,
  fiatCurrency: currency,
  createdAt: fundingTime,
  makerPubkey: 'maker',
  coordinatorPubkey: 'coordinator',
  holdInvoice: invoice,
  holdInvoicePaymentHash: fundingHash,
);

FundingEstimate _estimate({int total = 1498, int fees = 10}) => FundingEstimate(
  coordinatorPubkey: 'coordinator',
  makerPubkey: 'maker',
  fiatAmount: 10,
  fiatCurrency: 'PLN',
  premiumPercent: 0,
  totalSats: total,
  makerFeesSats: fees,
);

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('amount tolerance is symmetric, bounded, and never compounded', () {
    for (final (amount, tolerance) in [(100, 5), (10000, 50), (1000000, 100)]) {
      final estimate = _estimate(total: amount);
      expect(estimate.toleranceSats, tolerance);
      for (final delta in [-tolerance, 0, tolerance]) {
        expect(
          () => estimate.requireMatches(_offer('', sats: amount + delta - 10)),
          returnsNormally,
        );
      }
      for (final delta in [-tolerance - 1, tolerance + 1]) {
        expect(
          () => estimate.requireMatches(_offer('', sats: amount + delta - 10)),
          throwsFormatException,
        );
      }
    }
    final estimate = _estimate(total: 10000);
    estimate.requireMatches(_offer('', sats: 10040));
    expect(
      () => estimate.requireMatches(_offer('', sats: 10090)),
      throwsFormatException,
    );
  });

  test(
    'fee and original request fields cannot hide inside total tolerance',
    () {
      final estimate = _estimate(total: 1500);
      final offer = _offer('');
      expect(
        () => estimate.requireMatches(_offer('', sats: 1489, fees: 11)),
        returnsNormally,
      );
      for (final changed in [
        _offer('', sats: 1488, fees: 12),
        offer.copyWith(coordinatorPubkey: 'other'),
        offer.copyWith(makerPubkey: 'other'),
        _offer('', fiat: 11),
        _offer('', currency: 'EUR'),
        offer.copyWith(premiumPercent: 1),
      ]) {
        expect(() => estimate.requireMatches(changed), throwsFormatException);
      }
      final free = _estimate(total: 1500, fees: 0);
      expect(
        () => free.requireMatches(_offer('', sats: 1499, fees: 1)),
        throwsFormatException,
      );
    },
  );

  test(
    'approval is independent of subsequently inflated quote and invoice',
    () {
      final original = _offer(fundingInvoice());
      final approval = FundingPaymentAuthorization.review(
        original,
        original.holdInvoice!,
        network: 'mainnet',
        makerPubkey: 'maker',
        now: fundingTime,
      );
      final inflated = _offer(fundingInvoice(hrp: 'lnbc30u'), sats: 2990);
      expect(
        () => approval.requireCurrent(
          inflated,
          inflated.holdInvoice!,
          network: 'mainnet',
          makerPubkey: 'maker',
          now: fundingTime,
        ),
        throwsFormatException,
      );
      expect(
        () => approval.requireCurrent(
          original.copyWith(coordinatorPubkey: 'changed'),
          original.holdInvoice!,
          network: 'mainnet',
          makerPubkey: 'maker',
          now: fundingTime,
        ),
        throwsFormatException,
      );
      expect(
        () => approval.requireCurrent(
          original.copyWith(makerFees: 11),
          original.holdInvoice!,
          network: 'mainnet',
          makerPubkey: 'maker',
          now: fundingTime,
        ),
        throwsFormatException,
      );
      expect(
        () => approval.requireCurrent(
          original,
          original.holdInvoice!,
          network: 'mainnet',
          makerPubkey: 'maker',
          now: fundingTime.add(const Duration(hours: 1)),
        ),
        throwsFormatException,
      );
    },
  );

  testWidgets(
    'small rate discrepancy exposes controls directly; changed quotes stay blocked',
    (tester) async {
      final invoice = fundingInvoice();
      var active = _offer(invoice);
      final estimate = _estimate();
      Widget gate() => MaterialApp(
        home: Scaffold(
          body: FundingInvoiceGate(
            offer: active,
            invoice: active.holdInvoice,
            makerPubkey: 'maker',
            network: 'mainnet',
            estimate: estimate,
            now: () => fundingTime,
            onCancel: () {},
            builder: (_, approval) => Text('authorized:${approval.totalSats}'),
          ),
        ),
      );
      await tester.pumpWidget(gate());
      expect(find.byKey(const Key('approve-funding')), findsNothing);
      expect(find.text('Payment blocked'), findsNothing);
      expect(find.text('authorized:1500'), findsOneWidget);
      active = _offer(fundingInvoice(hrp: 'lnbc30u'), sats: 2990);
      await tester.pumpWidget(gate());
      expect(find.text('authorized:1500'), findsNothing);
      expect(find.text('authorized:3000'), findsNothing);
      expect(find.text('Payment blocked'), findsOneWidget);
      active = _offer(invoice);
      await tester.pumpWidget(gate());
      expect(find.text('authorized:1500'), findsNothing);
      expect(find.text('Payment blocked'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets('expiry removes validated QR/payment subtree', (tester) async {
    var now = fundingTime;
    final invoice = fundingInvoice(expiry: 2);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FundingInvoiceGate(
            offer: _offer(invoice),
            invoice: invoice,
            makerPubkey: 'maker',
            network: 'mainnet',
            now: () => now,
            estimate: _estimate(),
            onCancel: () {},
            builder: (_, _) => const Text('payment controls'),
          ),
        ),
      ),
    );
    expect(find.text('payment controls'), findsOneWidget);
    now = fundingTime.add(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('payment controls'), findsNothing);
    expect(find.text('Payment blocked'), findsOneWidget);
  });

  Future<_ActiveOffer> screen(
    WidgetTester tester,
    Offer offer, {
    String? estimateOfferId = fundingHash,
  }) async {
    final active = _ActiveOffer(offer);
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            ndkProvider.overrideWithValue(null),
            fundingEstimateProvider.overrideWith(
              (ref) => estimateOfferId == null
                  ? null
                  : (offerId: estimateOfferId, estimate: _estimate()),
            ),
            activeOfferProvider.overrideWith((ref) => active),
            publicKeyProvider.overrideWith((ref) async => 'maker'),
            selectedPaymentSystemProvider.overrideWith(
              (ref) => SelectedPaymentSystemNotifier(kBlik),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: MakerPayInvoiceScreen()),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    return active;
  }

  for (final scenario in [
    'inflated',
    'wrong hash',
    'wrong network',
    'expired',
    'fractional',
    'amountless',
    'invalid signature',
  ]) {
    testWidgets(
      'real payment screen exposes no wallet/QR/clipboard path for $scenario invoice',
      (tester) async {
        final now = DateTime.now().toUtc();
        final invoice = fundingInvoice(
          hrp: switch (scenario) {
            'inflated' => 'lnbc30u',
            'wrong network' => 'lntb15u',
            'fractional' => 'lnbc15000010p',
            'amountless' => 'lnbc',
            _ => 'lnbc15u',
          },
          hash: scenario == 'wrong hash' ? '22' * 32 : fundingHash,
          createdAt: scenario == 'expired'
              ? now.subtract(const Duration(hours: 2))
              : now,
          invalidSignature: scenario == 'invalid signature',
        );
        await screen(tester, _offer(invoice));
        expect(find.text('Payment blocked'), findsOneWidget);
        expect(find.byType(PrettyQrView), findsNothing);
        expect(find.byIcon(Icons.copy), findsNothing);
        expect(
          find.byIcon(Icons.account_balance_wallet_outlined),
          findsNothing,
        );
        expect(find.byIcon(Icons.bolt), findsNothing);
        expect(find.byKey(const Key('approve-funding')), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final estimateOfferId in [null, 'another-offer']) {
    testWidgets(
      'missing or unrelated estimate ($estimateOfferId) blocks payment',
      (tester) async {
        await screen(
          tester,
          _offer(fundingInvoice(createdAt: DateTime.now().toUtc())),
          estimateOfferId: estimateOfferId,
        );
        expect(
          find.textContaining('original client estimate is unavailable'),
          findsOneWidget,
        );
        expect(find.byType(PrettyQrView), findsNothing);
        expect(find.byIcon(Icons.copy), findsNothing);
        expect(find.byKey(const Key('approve-funding')), findsNothing);
      },
    );
  }

  testWidgets(
    'self-consistent inflated quote and invoice show the independent limit',
    (tester) async {
      await screen(
        tester,
        _offer(
          fundingInvoice(hrp: 'lnbc30u', createdAt: DateTime.now().toUtc()),
          sats: 2990,
        ),
      );
      expect(find.text('Payment blocked'), findsOneWidget);
      expect(
        find.textContaining('allowed difference is 7 sats'),
        findsOneWidget,
      );
      expect(find.byType(PrettyQrView), findsNothing);
      expect(find.byIcon(Icons.copy), findsNothing);
      expect(find.byKey(const Key('approve-funding')), findsNothing);
    },
  );

  testWidgets(
    'real screen exposes valid QR/copy directly and revokes after response inflation',
    (tester) async {
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            copied = (call.arguments as Map)['text'] as String;
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      final now = DateTime.now().toUtc();
      final invoice = fundingInvoice(createdAt: now);
      final active = await screen(tester, _offer(invoice));
      expect(find.byKey(const Key('approve-funding')), findsNothing);
      expect(find.byType(PrettyQrView), findsOneWidget);
      await tester.ensureVisible(find.byIcon(Icons.copy));
      await tester.tap(find.byIcon(Icons.copy));
      await tester.pump();
      expect(copied, invoice);
      await active.setActiveOffer(
        _offer(fundingInvoice(hrp: 'lnbc30u', createdAt: now), sats: 2990),
      );
      await tester.pump();
      expect(find.byType(PrettyQrView), findsNothing);
      expect(find.byIcon(Icons.copy), findsNothing);
      expect(find.text('Payment blocked'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}
