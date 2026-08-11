import 'dart:io';

import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

/// Structural + transition checks for the generic TWINT flow. Unlike blik, twint
/// has no legacy hardcoded reference; this asserts the flow is internally
/// consistent and that the key happy/sad paths resolve as intended.
void main() {
  late FlowEngine engine;

  Future<String> loadFlowImport(String importPath) async =>
      File('lib/flows/$importPath').readAsStringSync();

  setUpAll(() async {
    engine = await FlowEngine.fromYamlWithImports(
      File('lib/flows/twint.yml').readAsStringSync(),
      loadFlowImport,
    );
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

  test('timeouts drive the documented targets', () {
    expect(engine.timeoutFor('funded')!.target, 'invalidTwint');
    expect(engine.timeoutFor('reserved')!.target, 'expiredTwint');
    expect(engine.timeoutFor('expiredTwint')!.target, 'invalidTwint');
    expect(engine.timeoutFor('invalidTwint')!.target, 'cancelling');
    expect(engine.timeoutFor('takerCharged')!.target, 'makerConfirmed');
  });

  test('taker payout invoice captured at reserve', () {
    // Captured at reserve so an early maker confirm_payment (allowed from
    // reserved/expiredTwint) already has an invoice for the payout.
    final reserve =
        engine.transitionFor('funded', 'reserve_offer', actor: FlowActor.taker);
    expect(reserve!.actions, contains('accept_taker_invoice'));
    final charged = engine.transitionFor('reserved', 'mark_twint_charged',
        actor: FlowActor.taker);
    expect(charged!.actions, isNot(contains('accept_taker_invoice')));
  });

  test('maker can confirm early from reserved and expiredTwint', () {
    for (final s in ['reserved', 'expiredTwint', 'takerCharged']) {
      expect(
          engine
              .resolveUserAction(
                  fromState: s,
                  event: 'confirm_payment',
                  actor: FlowActor.maker)
              .target,
          'makerConfirmed',
          reason: 'maker confirm from $s');
    }
  });

  test('enter_new_twint (invalidTwint -> funded) swaps the code', () {
    final t = engine.transitionFor('invalidTwint', 'enter_new_twint',
        actor: FlowActor.maker);
    expect(t!.target, 'funded');
    expect(t.actions, contains('set_new_code'));
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

  test('terminals: cancelled, takerPaid (dispute is resolvable)', () {
    for (final s in ['cancelled', 'takerPaid']) {
      expect(engine.isTerminal(s), isTrue, reason: s);
    }
    // A private intermediate state first secures escrow post-commit, then the
    // coordinator exposes/resolves the existing dispute state.
    expect(engine.isTerminal('dispute'), isFalse);
    expect(engine.definition.state('securingDispute')!.actions,
        contains('settle_offer_funds'));
    expect(
        engine.definition.state('securingDispute')!.transitions.single.target,
        'dispute');
    expect(
        engine.transitionFor('dispute', 'resolve_dispute_refund_maker')?.target,
        'refundingMaker');
    expect(engine.transitionFor('dispute', 'resolve_dispute_pay_taker')?.target,
        'payingTaker');
  });

  test('escrow mutations are post-commit state actions', () {
    const irreversible = {
      'cancel_hold_invoice',
      'settle_offer_funds',
      'send_payment',
      'refund_maker',
    };
    for (final state in engine.definition.states.values) {
      for (final transition in state.transitions) {
        expect(transition.actions.toSet().intersection(irreversible), isEmpty,
            reason: '${state.name} transition mutates escrow pre-commit');
      }
    }
    expect(engine.definition.state('cancelling')!.actions,
        contains('cancel_hold_invoice'));
    expect(engine.definition.state('makerConfirmed')!.actions,
        contains('settle_offer_funds'));
    expect(engine.definition.state('payingTaker')!.actions,
        contains('send_payment'));
    expect(engine.definition.state('refundingMaker')!.actions,
        contains('refund_maker'));
  });
}
