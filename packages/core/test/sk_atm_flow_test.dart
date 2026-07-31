import 'dart:io';

import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

void main() {
  group('sk_atm.yml (Slovak ATM generic flow)', () {
    late FlowEngine engine;

    setUpAll(() async {
      final source = await File('lib/flows/sk_atm.yml').readAsString();
      engine = await FlowEngine.fromYamlWithImports(
        source,
        (name) => File('lib/flows/$name').readAsString(),
      );
    });

    test('parses, imports common states, funded is initial', () {
      expect(engine.definition.id, 'sk_atm');
      expect(engine.initialState, 'funded');
      // Imported payout tail + terminals present.
      expect(engine.isTerminal('takerPaid'), isTrue);
      expect(engine.isTerminal('cancelled'), isTrue);
      expect(engine.definition.state('payingTaker'), isNotNull);
    });

    test('code-lifetime timeouts are parametric (\$code_validity)', () {
      final blikReceived = engine.timeoutFor('blikReceived')!;
      expect(blikReceived.durationSeconds, isNull);
      expect(blikReceived.durationParam, 'code_validity');
      expect(blikReceived.fromField, 'code_received_at');
      expect(blikReceived.target, 'expiredBlik');

      final blikSent = engine.timeoutFor('blikSentToMaker')!;
      expect(blikSent.durationParam, 'code_validity');
      expect(blikSent.fromField, 'code_received_at');
    });

    test('operational timeouts stay fixed (reservation, funded expiry)', () {
      expect(engine.timeoutFor('funded')!.durationSeconds, isNotNull);
      expect(engine.timeoutFor('reserved')!.durationSeconds, isNotNull);
      // These carry no runtime parameter.
      expect(engine.timeoutFor('funded')!.durationParam, isNull);
      expect(engine.timeoutFor('reserved')!.durationParam, isNull);
    });

    test('pull-style: taker submits code, maker fetches then confirms', () {
      expect(engine.transitionFor('reserved', 'submit_blik')?.actor,
          FlowActor.taker);
      expect(engine.transitionFor('blikReceived', 'get_blik')?.actor,
          FlowActor.maker);
      expect(engine.transitionFor('blikSentToMaker', 'confirm_payment')?.actor,
          FlowActor.maker);
    });
  });
}
