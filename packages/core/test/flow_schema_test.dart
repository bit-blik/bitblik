import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

/// Flow schema v2: `on/by/do/to/on_fail/after/from`, plus nip69, returns, and
/// the FlowEngine.transitionFor helper.
void main() {
  FlowEngine engineFrom(String body) => FlowEngine.fromYaml('''
id: test
states:
$body
''');

  test('user-action transitions parse from on/by/do/to', () {
    final e = engineFrom('''
  a:
    initial: true
    transitions:
      - on: go
        by: maker
        to: b
        do: [settle_offer_funds]
  b:
    terminal: true
''');
    final a = e.definition.state('a')!;
    expect(a.transitions.first.actions, ['settle_offer_funds']);
    expect(a.transitions.first.actor, FlowActor.maker);
    expect(a.transitions.first.event, 'go');
  });

  test('do/on_fail/returns parse cleanly', () {
    final e = engineFrom('''
  a:
    initial: true
    nip69: in-progress
    do: [send_offer_notifications]
    transitions:
      - on: get_blik
        to: b
        returns: blik_code
        do: [validate_code, stamp_code_received_at]
        on_fail: failed
  b:
    terminal: true
  failed:
    terminal: true
''');
    final a = e.definition.state('a')!;
    expect(a.nip69, 'in-progress');
    expect(a.actions, ['send_offer_notifications']);
    final t = a.transitions.first;
    expect(t.returns, 'blik_code');
    expect(t.actions, ['validate_code', 'stamp_code_received_at']);
    expect(t.onFailTarget, 'failed');
  });

  test('timeout uses after/from', () {
    final e = engineFrom('''
  a:
    initial: true
    transitions:
      - on: timeout
        after: 120
        from: created_at
        to: b
  b:
    terminal: true
''');
    final t = e.timeoutFor('a')!;
    expect(t.durationSeconds, 120);
    expect(t.fromField, 'created_at');
  });

  test('timeout after accepts a \$param (parametric duration)', () {
    final e = engineFrom('''
  a:
    initial: true
    transitions:
      - on: timeout
        after: \$code_validity
        from: code_received_at
        to: b
  b:
    terminal: true
''');
    final t = e.timeoutFor('a')!;
    expect(t.durationSeconds, isNull);
    expect(t.durationParam, 'code_validity');
    expect(t.fromField, 'code_received_at');
  });

  test('timeout after rejects a non-int, non-\$param string', () {
    expect(
      () => engineFrom('''
  a:
    initial: true
    transitions:
      - on: timeout
        after: soon
        to: b
  b:
    terminal: true
'''),
      throwsA(isA<FormatException>()),
    );
  });

  test('transitionFor resolves by event (and actor)', () {
    final e = engineFrom('''
  a:
    initial: true
    transitions:
      - on: go
        by: maker
        to: b
  b:
    terminal: true
''');
    expect(e.transitionFor('a', 'go')?.target, 'b');
    expect(e.transitionFor('a', 'go', actor: FlowActor.maker)?.target, 'b');
    expect(e.transitionFor('a', 'go', actor: FlowActor.taker), isNull);
    expect(e.transitionFor('a', 'nope'), isNull);
  });

  test('imports merge shared states before validation', () async {
    final engine = await FlowEngine.fromYamlWithImports(
        '''
id: imported
imports: [common.yml]
states:
  funded:
    initial: true
    transitions:
      - on: reserve_offer
        by: taker
        to: makerConfirmed
''',
        (importPath) async => '''
states:
  makerConfirmed:
    transitions:
      - on: auto
        to: takerPaid
  takerPaid:
    terminal: true
''');
    expect(engine.transitionFor('funded', 'reserve_offer')?.target,
        'makerConfirmed');
    expect(engine.isTerminal('takerPaid'), isTrue);
  });
}
