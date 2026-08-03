import 'dart:io';

import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

/// Canonical BLIK flow behavior test.
///
/// One allowed (fromState, event, actor) -> target row.
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
  _Row('funded', 'cancel_offer', _maker, 'cancelling'),
  _Row('funded', 'reserve_offer', _taker, 'reserved'),
  // reserved
  _Row('reserved', 'submit_blik', _taker, 'blikReceived'),
  _Row('reserved', 'cancel_reservation', _taker, 'funded'),
  // blikReceived
  _Row('blikReceived', 'get_blik', _maker, 'blikSentToMaker'),
  // blikSentToMaker
  _Row('blikSentToMaker', 'confirm_payment', _maker, 'makerConfirmed'),
  _Row('blikSentToMaker', 'mark_blik_invalid', _maker, 'invalidBlik'),
  // invalidBlik
  _Row('invalidBlik', 'mark_blik_charged', _taker, 'conflict'),
  _Row('invalidBlik', 'reserve_offer', _taker, 'reserved'),
  _Row('invalidBlik', 'cancel_reservation', _taker, 'funded'),
  // expiredBlik
  _Row('expiredBlik', 'reserve_offer', _taker, 'reserved'),
  _Row('expiredBlik', 'cancel_reservation', _taker, 'funded'),
  // expiredSentBlik
  _Row('expiredSentBlik', 'confirm_payment', _maker, 'makerConfirmed'),
  _Row('expiredSentBlik', 'mark_blik_invalid', _maker, 'invalidBlik'),
  _Row('expiredSentBlik', 'mark_blik_charged', _taker, 'takerCharged'),
  _Row('expiredSentBlik', 'reserve_offer', _taker, 'reserved'),
  // takerCharged
  _Row('takerCharged', 'confirm_payment', _maker, 'makerConfirmed'),
  _Row('takerCharged', 'mark_blik_invalid', _maker, 'conflict'),
  // conflict
  _Row('conflict', 'confirm_payment', _maker, 'makerConfirmed'),
  _Row('conflict', 'open_dispute', _maker, 'securingDispute'),
  // takerPaymentFailed
  _Row('takerPaymentFailed', 'update_taker_invoice', _taker, 'payingTaker'),
  _Row('takerPaymentFailed', 'retry_taker_payment', _taker, 'payingTaker'),
];

// (fromState -> expected timeout target, default duration seconds).
// (fromState -> expected timeout TARGET). Only the target is structural and
// locked here; `duration_seconds` is tunable config (env-overridable on the
// coordinator), so it is NOT asserted to a fixed value — retuning a duration in
// the yml must not break this golden test, only changing a target/transition
// (real behaviour) should.
const _timeouts = <String, String>{
  'funded': 'expiring',
  'reserved': 'funded',
  'blikReceived': 'expiredBlik',
  'blikSentToMaker': 'expiredSentBlik',
  'invalidBlik': 'securingDispute',
  'expiredBlik': 'funded',
  'expiredSentBlik': 'securingDispute',
  'takerCharged': 'makerConfirmed',
  'conflict': 'securingDispute',
};

const _terminalStates = {
  'takerPaid',
  'cancelled',
  'expired',
};

void main() {
  late FlowEngine engine;

  Future<String> loadFlowImport(String importPath) async =>
      File('lib/flows/$importPath').readAsStringSync();

  setUpAll(() async {
    final src = File('lib/flows/blik.yml').readAsStringSync();
    engine = await FlowEngine.fromYamlWithImports(src, loadFlowImport);
  });

  test('parses and validates structurally', () {
    expect(engine.initialState, 'funded');
  });

  group('allowed user-action transitions match the canonical table', () {
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
          fromState: 'blikSentToMaker',
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

  group('timeout transitions go to the documented target', () {
    _timeouts.forEach((state, target) {
      test('$state times out to $target', () {
        final t = engine.timeoutFor(state);
        expect(t, isNotNull, reason: '$state has no timeout');
        expect(t!.target, target);
        // Duration is tunable config — only require it to be present + positive,
        // not a fixed value, so retuning the yml doesn't break this test.
        expect(t.durationSeconds, isNotNull,
            reason: '$state timeout has no duration_seconds');
        expect(t.durationSeconds! > 0, isTrue,
            reason: '$state duration must be positive');
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

  test('statesAllowing(confirm_payment) covers every BLIK confirm source', () {
    expect(
      engine.statesAllowing('confirm_payment', actor: _maker),
      {
        'conflict',
        'takerCharged',
        'blikSentToMaker',
        'expiredSentBlik',
      },
    );
  });
}
