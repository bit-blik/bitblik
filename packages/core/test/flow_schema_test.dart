import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

/// Phase 0 schema additions: list-valued effects / on_entry, nip69, returns,
/// and the FlowEngine.transitionFor helper. Asserts back-compat so existing
/// scalar yaml keeps parsing unchanged.
void main() {
  FlowEngine engineFrom(String body) => FlowEngine.fromYaml('''
id: test
states:
$body
''');

  test('scalar on_entry / action stay back-compatible', () {
    final e = engineFrom('''
  a:
    initial: true
    on_entry: send_offer_notifications
    transitions:
      - trigger: user_action
        event: go
        target: b
        action: settle_hold_invoice
  b:
    terminal: true
''');
    final a = e.definition.state('a')!;
    expect(a.onEntry, 'send_offer_notifications');
    expect(a.onEntryEffects, ['send_offer_notifications']);
    final t = a.transitions.first;
    expect(t.action, 'settle_hold_invoice');
    // effects falls back to [action] when no explicit `effects:`.
    expect(t.effects, ['settle_hold_invoice']);
  });

  test('list-valued on_entry / effects, plus nip69 and returns', () {
    final e = engineFrom('''
  a:
    initial: true
    nip69: in-progress
    on_entry: [reveal_code_to_taker, notify_maker_of_charge]
    transitions:
      - trigger: user_action
        event: get_blik
        target: b
        returns: blik_code
        effects: [validate_code, stamp_code_received_at]
  b:
    terminal: true
''');
    final a = e.definition.state('a')!;
    expect(a.nip69, 'in-progress');
    expect(a.onEntry, isNull); // list form -> scalar getter null
    expect(a.onEntryEffects, ['reveal_code_to_taker', 'notify_maker_of_charge']);
    final t = a.transitions.first;
    expect(t.returns, 'blik_code');
    expect(t.effects, ['validate_code', 'stamp_code_received_at']);
    expect(t.action, isNull);
  });

  test('transitionFor resolves by event (and actor)', () {
    final e = engineFrom('''
  a:
    initial: true
    transitions:
      - trigger: user_action
        event: go
        actor: maker
        target: b
  b:
    terminal: true
''');
    expect(e.transitionFor('a', 'go')?.target, 'b');
    expect(e.transitionFor('a', 'go', actor: FlowActor.maker)?.target, 'b');
    expect(e.transitionFor('a', 'go', actor: FlowActor.taker), isNull);
    expect(e.transitionFor('a', 'nope'), isNull);
  });
}
