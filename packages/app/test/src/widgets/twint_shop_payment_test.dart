import 'dart:async';
import 'dart:io';

import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/widgets/twint_payment_qr.dart';
import 'package:bitblik/src/widgets/twint_shop_payment.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const payload = 'Q4SIXZB8VXJ5000000000710CHF00025837';

void main() {
  late FlowEngine engine;
  late DateTime received;
  setUpAll(() async {
    engine = await FlowEngine.fromYamlWithImports(
      File('../core/lib/flows/twint.yml').readAsStringSync(),
      (name) => File('../core/lib/flows/$name').readAsString(),
    );
  });
  setUp(() => received = DateTime.now().toUtc());

  Offer offer() => Offer(
    id: 'shop',
    amountSats: 10000,
    makerFees: 50,
    status: OfferStatus.reserved,
    statusRaw: 'reserved',
    fiatAmount: 7.10,
    fiatCurrency: 'CHF',
    paymentSystemId: 'twint',
    category: OfferCategory.shop,
    createdAt: received,
    blikReceivedAt: received,
    reservedAt: received,
    makerPubkey: 'maker',
    takerPubkey: 'taker',
    coordinatorPubkey: 'coordinator',
    blikCode: payload,
  );

  Future<void> showPayment(
    WidgetTester tester,
    Offer current,
    Future<Offer?> Function(Offer) load,
  ) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: TwintShopPayment(
                offer: current,
                engine: engine,
                loadOffer: load,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('cached QR stays hidden until fresh authorized response', (
    tester,
  ) async {
    final pending = Completer<Offer?>();
    final current = offer();
    await showPayment(tester, current, (_) => pending.future);
    expect(find.byType(TwintPaymentQr), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    final replacement = payload.replaceFirst('00025837', '00025838');
    pending.complete(current.copyWith(blikCode: replacement));
    await tester.pump();
    expect(
      tester.widget<TwintPaymentQr>(find.byType(TwintPaymentQr)).payload,
      replacement,
    );
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('changed reservation hides QR and ignores stale response', (
    tester,
  ) async {
    final first = Completer<Offer?>();
    final second = Completer<Offer?>();
    final original = offer();
    await showPayment(tester, original, (_) => first.future);
    final next = original.copyWith(
      reservedAt: received.add(const Duration(seconds: 1)),
    );
    await showPayment(tester, next, (_) => second.future);
    first.complete(original);
    await tester.pump();
    expect(find.byType(TwintPaymentQr), findsNothing);
    second.complete(next);
    await tester.pump();
    expect(find.byType(TwintPaymentQr), findsOneWidget);
    // Another revision must remove the accepted QR immediately.
    await showPayment(
      tester,
      next.copyWith(statusRaw: 'expiredTwint'),
      (_) async => null,
    );
    expect(find.byType(TwintPaymentQr), findsNothing);
    expect(find.text(t.twint.shop.expired), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('unavailable response can retry without exposing cached data', (
    tester,
  ) async {
    var attempts = 0;
    final current = offer();
    await showPayment(
      tester,
      current,
      (_) async => ++attempts == 1 ? null : current,
    );
    expect(find.text(t.twint.shop.loadingFailed), findsOneWidget);
    expect(find.byType(TwintPaymentQr), findsNothing);
    await tester.tap(find.text(t.common.buttons.retry));
    await tester.pump();
    expect(attempts, 2);
    expect(find.byType(TwintPaymentQr), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('rejects unrelated, altered or no-longer-reserved responses', (
    tester,
  ) async {
    final current = offer();
    for (final remote in [
      current.copyWith(id: 'other'),
      current.copyWith(takerPubkey: 'other'),
      Offer.fromJson(current.toJson()..['fiat_amount'] = 7.11),
      Offer.fromJson(current.toJson()..['fiat_currency'] = 'EUR'),
      current.copyWith(blikCode: 'invalid'),
      current.copyWith(statusRaw: 'funded'),
      current.copyWith(category: OfferCategory.online),
      current.copyWith(reservedAt: received.add(const Duration(seconds: 1))),
    ]) {
      await showPayment(tester, current, (_) async => remote);
      expect(find.byType(TwintPaymentQr), findsNothing);
      expect(find.text(t.twint.shop.loadingFailed), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
    }
  });

  testWidgets('original code clock controls expiry after reservation', (
    tester,
  ) async {
    final current = offer().copyWith(
      blikReceivedAt: received.subtract(const Duration(minutes: 6)),
    );
    await showPayment(tester, current, (_) async => current);
    expect(find.byType(Image), findsNothing);
    expect(find.text(t.twint.shop.expired), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'second-precision status timestamps accept matching RPC snapshot',
    (tester) async {
      final remote = offer();
      final fromStatus = remote.copyWith(
        reservedAt: DateTime.fromMillisecondsSinceEpoch(
          remote.reservedAt!.millisecondsSinceEpoch ~/ 1000 * 1000,
          isUtc: true,
        ),
      );
      await showPayment(tester, fromStatus, (_) async => remote);
      expect(find.byType(TwintPaymentQr), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
