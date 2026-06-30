import 'dart:io';

import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

/// Structural + transition checks for the generic TWINT flow. Unlike blik, twint
/// has no legacy hardcoded reference; this asserts the flow is internally
/// consistent and that the key happy/sad paths resolve as intended.
void main() {
  late FlowEngine engine;

  setUpAll(() {
    engine = FlowEngine.fromYaml(File('twint.yml').readAsStringSync());
  });

  test('parses, single initial, all targets defined', () {
    expect(engine.initialState, 'funded');
    expect(engine.definition.id, 'twint');
  });

  test('happy path resolves by RPC + actor', () {
    expect(
        engine
            .resolveUserAction(
                fromState: 'funded',
                event: 'reserve_offer',
                actor: FlowActor.taker)
            .target,
        'reserved');
    expect(
        engine
            .resolveUserAction(
                fromState: 'reserved',
                event: 'mark_blik_charged',
                actor: FlowActor.taker)
            .target,
        'twint_charged');
    expect(
        engine
            .resolveUserAction(
                fromState: 'twint_charged',
                event: 'confirm_payment',
                actor: FlowActor.maker)
            .target,
        'makerConfirmed');
  });

  test('twint-specific states are NOT OfferStatus values', () {
    expect(offerStatusFromFlowState('twint_charged'), OfferStatus.unknown);
    expect(offerStatusFromFlowState('expired_twint'), OfferStatus.unknown);
    // ...while the payout-tail states ARE shared with the enum.
    expect(offerStatusFromFlowState('maker_confirmed'), OfferStatus.makerConfirmed);
    expect(offerStatusFromFlowState('settled'), OfferStatus.settled);
  });

  test('timeouts drive the documented targets', () {
    expect(engine.timeoutFor('funded')!.target, 'expired');
    expect(engine.timeoutFor('reserved')!.target, 'expired_twint');
    expect(engine.timeoutFor('twint_charged')!.target, 'makerConfirmed');
    expect(engine.timeoutFor('expired_twint')!.target, 'expired');
    expect(engine.timeoutFor('conflict')!.target, 'dispute');
  });

  test('wrong actor rejected', () {
    expect(
        engine
            .resolveUserAction(
                fromState: 'twint_charged',
                event: 'confirm_payment',
                actor: FlowActor.taker)
            .allowed,
        isFalse);
  });

  test('terminals: cancelled, expired, takerPaid, dispute', () {
    for (final s in ['cancelled', 'expired', 'takerPaid', 'dispute']) {
      expect(engine.isTerminal(s), isTrue, reason: s);
    }
  });
}
