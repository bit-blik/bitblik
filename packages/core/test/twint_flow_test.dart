import 'dart:io';

import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

/// Structural + transition checks for the generic TWINT flow. Unlike blik, twint
/// has no legacy hardcoded reference; this asserts the flow is internally
/// consistent and that the key happy/sad paths resolve as intended.
void main() {
  late FlowEngine engine;

  setUpAll(() {
    engine = FlowEngine.fromYaml(File('lib/flows/twint.yml').readAsStringSync());
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
                event: 'mark_twint_charged',
                actor: FlowActor.taker)
            .target,
        'takerCharged');
    expect(
        engine
            .resolveUserAction(
                fromState: 'takerCharged',
                event: 'confirm_payment',
                actor: FlowActor.maker)
            .target,
        'makerConfirmed');
  });

  test('twint-specific states are intentionally non-enum; the rest map', () {
    // invalidTwint / expiredTwint are new generic states with NO OfferStatus
    // value (stored/broadcast as raw strings). Every other twint state shares
    // its name with the enum (payout tail + lifecycle).
    const twintOnly = {'invalidTwint', 'expiredTwint'};
    for (final name in engine.definition.states.keys) {
      final mapped = offerStatusFromFlowState(name);
      if (twintOnly.contains(name)) {
        expect(mapped, OfferStatus.unknown, reason: '$name should be non-enum');
      } else {
        expect(mapped, isNot(OfferStatus.unknown),
            reason: 'flow state "$name" has no matching OfferStatus');
      }
    }
  });

  test('timeouts drive the documented targets', () {
    expect(engine.timeoutFor('funded')!.target, 'invalidTwint');
    expect(engine.timeoutFor('reserved')!.target, 'expiredTwint');
    expect(engine.timeoutFor('expiredTwint')!.target, 'invalidTwint');
    expect(engine.timeoutFor('invalidTwint')!.target, 'cancelled');
    expect(engine.timeoutFor('takerCharged')!.target, 'makerConfirmed');
  });

  test('taker payout invoice captured at reserve', () {
    // Captured at reserve so an early maker confirm_payment (allowed from
    // reserved/expiredTwint) already has an invoice for the payout.
    final reserve =
        engine.transitionFor('funded', 'reserve_offer', actor: FlowActor.taker);
    expect(reserve!.effects, contains('accept_taker_invoice'));
    final charged = engine.transitionFor('reserved', 'mark_twint_charged',
        actor: FlowActor.taker);
    expect(charged!.effects, isNot(contains('accept_taker_invoice')));
  });

  test('maker can confirm early from reserved and expiredTwint', () {
    for (final s in ['reserved', 'expiredTwint', 'takerCharged']) {
      expect(
          engine
              .resolveUserAction(
                  fromState: s, event: 'confirm_payment', actor: FlowActor.maker)
              .target,
          'makerConfirmed',
          reason: 'maker confirm from $s');
    }
  });

  test('enter_new_twint (invalidTwint -> funded) swaps the code', () {
    final t = engine.transitionFor('invalidTwint', 'enter_new_twint',
        actor: FlowActor.maker);
    expect(t!.target, 'funded');
    expect(t.effects, contains('set_new_code'));
  });

  test('wrong actor rejected', () {
    expect(
        engine
            .resolveUserAction(
                fromState: 'takerCharged',
                event: 'confirm_payment',
                actor: FlowActor.taker)
            .allowed,
        isFalse);
  });

  test('terminals: cancelled, takerPaid, dispute', () {
    for (final s in ['cancelled', 'takerPaid', 'dispute']) {
      expect(engine.isTerminal(s), isTrue, reason: s);
    }
  });
}
