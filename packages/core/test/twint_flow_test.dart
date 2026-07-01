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

  test('every twint state maps to a known OfferStatus', () {
    // The twint flow was aligned to the OfferStatus vocabulary (camelCase),
    // so the raw state stored/broadcast equals status.name for every state.
    for (final name in engine.definition.states.keys) {
      expect(offerStatusFromFlowState(name), isNot(OfferStatus.unknown),
          reason: 'flow state "$name" has no matching OfferStatus');
    }
  });

  test('timeouts drive the documented targets', () {
    expect(engine.timeoutFor('funded')!.target, 'invalidBlik');
    expect(engine.timeoutFor('reserved')!.target, 'expiredBlik');
    expect(engine.timeoutFor('expiredBlik')!.target, 'invalidBlik');
    expect(engine.timeoutFor('invalidBlik')!.target, 'cancelled');
    expect(engine.timeoutFor('takerCharged')!.target, 'makerConfirmed');
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
