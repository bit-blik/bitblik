import 'dart:io';

import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

/// Golden backward-compatibility test.
///
/// Asserts that the FlowEngine built from the canonical `blik.yml` reproduces
/// exactly the transition table the historical hardcoded `CoordinatorService`
/// enforced. Each row below was extracted from a guard in that service. If this
/// test fails, the YAML has drifted from the coordinator's real behaviour —
/// reconcile before relying on the engine for enforcement.

/// One allowed (fromState, event, actor) -> target row from the legacy code.
class _Row {
  final String from;
  final String event;
  final FlowActor actor;
  final String target;
  const _Row(this.from, this.event, this.actor, this.target);
}

const _maker = FlowActor.maker;
const _taker = FlowActor.taker;

// The faithful BLIK user-action table (timeouts asserted separately).
const _allowed = <_Row>[
  // funded
  _Row('funded', 'cancel_offer', _maker, 'cancelled'),
  _Row('funded', 'reserve_offer', _taker, 'reserved'),
  // reserved
  _Row('reserved', 'submit_blik', _taker, 'blik_received'),
  _Row('reserved', 'cancel_reservation', _taker, 'funded'),
  // blik_received
  _Row('blik_received', 'get_blik', _maker, 'blik_sent_to_maker'),
  // blik_sent_to_maker
  _Row('blik_sent_to_maker', 'confirm_payment', _maker, 'maker_confirmed'),
  _Row('blik_sent_to_maker', 'mark_blik_invalid', _maker, 'invalid_blik'),
  // invalid_blik
  _Row('invalid_blik', 'mark_blik_charged', _taker, 'conflict'),
  _Row('invalid_blik', 'reserve_offer', _taker, 'reserved'),
  _Row('invalid_blik', 'cancel_reservation', _taker, 'funded'),
  // expired_blik
  _Row('expired_blik', 'reserve_offer', _taker, 'reserved'),
  _Row('expired_blik', 'cancel_reservation', _taker, 'funded'),
  // expired_sent_blik
  _Row('expired_sent_blik', 'confirm_payment', _maker, 'maker_confirmed'),
  _Row('expired_sent_blik', 'mark_blik_invalid', _maker, 'invalid_blik'),
  _Row('expired_sent_blik', 'mark_blik_charged', _taker, 'taker_charged'),
  _Row('expired_sent_blik', 'reserve_offer', _taker, 'reserved'),
  // taker_charged
  _Row('taker_charged', 'confirm_payment', _maker, 'maker_confirmed'),
  _Row('taker_charged', 'mark_blik_invalid', _maker, 'conflict'),
  // conflict
  _Row('conflict', 'confirm_payment', _maker, 'maker_confirmed'),
  _Row('conflict', 'open_dispute', _maker, 'dispute'),
  // taker_payment_failed
  _Row('taker_payment_failed', 'update_taker_invoice', _taker,
      'paying_taker'),
  _Row('taker_payment_failed', 'retry_taker_payment', _taker, 'paying_taker'),
];

// (fromState -> expected timeout target, default duration seconds).
const _timeouts = <String, MapEntry<String, int>>{
  'funded': MapEntry('expired', 600),
  'reserved': MapEntry('funded', 30),
  'blik_received': MapEntry('expired_blik', 120),
  'blik_sent_to_maker': MapEntry('expired_sent_blik', 120),
  'invalid_blik': MapEntry('dispute', 3600),
  'expired_blik': MapEntry('funded', 60),
  'expired_sent_blik': MapEntry('dispute', 3600),
  'taker_charged': MapEntry('maker_confirmed', 3600),
  'conflict': MapEntry('dispute', 3600),
};

const _terminalStates = {
  'taker_paid',
  'cancelled',
  'expired',
  'dispute',
};

void main() {
  late FlowEngine engine;

  setUpAll(() {
    final src = File('blik.yml').readAsStringSync();
    engine = FlowEngine.fromYaml(src);
  });

  test('parses and validates structurally', () {
    expect(engine.initialState, 'funded');
    // Every state in the definition is a known OfferStatus (or maps cleanly).
    for (final name in engine.definition.states.keys) {
      expect(offerStatusFromFlowState(name), isNot(OfferStatus.unknown),
          reason: 'flow state "$name" has no matching OfferStatus');
    }
  });

  group('allowed user-action transitions match legacy table', () {
    for (final r in _allowed) {
      test('${r.from} --${r.event}/${r.actor.name}--> ${r.target}', () {
        final res = engine.resolveUserAction(
            fromState: r.from, event: r.event, actor: r.actor);
        expect(res.allowed, isTrue, reason: res.rejectReason);
        expect(res.target, r.target);
      });
    }
  });

  group('wrong actor is rejected', () {
    test('taker cannot confirm payment', () {
      final res = engine.resolveUserAction(
          fromState: 'blik_sent_to_maker',
          event: 'confirm_payment',
          actor: _taker);
      expect(res.allowed, isFalse);
    });
    test('maker cannot reserve', () {
      final res = engine.resolveUserAction(
          fromState: 'funded', event: 'reserve_offer', actor: _maker);
      expect(res.allowed, isFalse);
    });
  });

  group('timeout transitions match legacy timers', () {
    _timeouts.forEach((state, expected) {
      test('$state times out to ${expected.key}', () {
        final t = engine.timeoutFor(state);
        expect(t, isNotNull, reason: '$state has no timeout');
        expect(t!.target, expected.key);
        expect(t.durationSeconds, expected.value);
      });
    });
  });

  group('terminal states have no transitions', () {
    for (final s in _terminalStates) {
      test('$s is terminal', () {
        expect(engine.isTerminal(s), isTrue);
        final res = engine.resolveUserAction(
            fromState: s, event: 'anything', actor: _maker);
        expect(res.allowed, isFalse);
      });
    }
  });

  test('statesAllowing(maker_confirms) covers every legacy confirm source', () {
    // confirmMakerPayment CAS list: conflict, takerCharged, blikSentToMaker,
    // expiredSentBlik (reserved is twint-only and not in blik.yml).
    expect(
      engine.statesAllowing('confirm_payment', actor: _maker),
      {
        'conflict',
        'taker_charged',
        'blik_sent_to_maker',
        'expired_sent_blik',
      },
    );
  });

  test('OfferStatus <-> flow-state name round-trips', () {
    const sample = OfferStatus.blikSentToMaker;
    expect(flowStateForOfferStatus(sample), 'blik_sent_to_maker');
    expect(offerStatusFromFlowState('blik_sent_to_maker'), sample);
    expect(offerStatusFromFlowState('not_a_real_state'), OfferStatus.unknown);
  });
}
