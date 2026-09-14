import 'dart:io';

import 'package:bitblik/src/flow/flow_timeout.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FlowEngine engine;
  final received = DateTime.utc(2026, 9, 14, 12);

  setUpAll(() async {
    engine = await FlowEngine.fromYamlWithImports(
      File('../core/lib/flows/twint.yml').readAsStringSync(),
      (name) => File('../core/lib/flows/$name').readAsString(),
    );
  });

  Offer offer({OfferCategory? category, String state = 'reserved'}) => Offer(
    id: 'timer-test',
    amountSats: 1000,
    makerFees: 0,
    makerPubkey: 'maker',
    coordinatorPubkey: 'coordinator',
    status: OfferStatus.funded,
    statusRaw: state,
    createdAt: received.subtract(const Duration(minutes: 1)),
    updatedAt: received.add(const Duration(minutes: 2)),
    blikReceivedAt: received,
    fiatAmount: 7.10,
    fiatCurrency: 'CHF',
    category: category,
  );

  test(
    'TWINT deadline spans funding and reservation, including legacy offers',
    () {
      for (final category in [null, OfferCategory.online, OfferCategory.shop]) {
        final payment = offer(category: category);
        for (final state in ['funded', 'reserved']) {
          expect(
            flowStateDeadline(engine, state, payment),
            received.add(const Duration(minutes: 5)),
          );
        }
      }
    },
  );

  test('expiry grace window still starts from state entry', () {
    final payment = offer(state: 'expiredTwint');
    expect(
      flowStateDeadline(engine, payment.statusRaw, payment),
      payment.updatedAt!.add(const Duration(minutes: 5)),
    );
    expect(flowStateTimer(engine, 'takerPaid', payment), isNull);
  });
}
