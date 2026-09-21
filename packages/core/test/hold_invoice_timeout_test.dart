import 'dart:io';

import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

void main() {
  const holdInvoiceDependentStates = {
    'blik': [
      'invalidBlik',
      'expiredSentBlik',
      'takerCharged',
      'conflict',
    ],
    'mbway': [
      'invalidBlik',
      'expiredSentBlik',
      'takerCharged',
      'conflict',
    ],
    'sk_atm': [
      'invalidBlik',
      'expiredSentBlik',
      'takerCharged',
      'conflict',
    ],
    'twint': [
      'invalidTwint',
      'takerCharged',
    ],
  };

  for (final entry in holdInvoiceDependentStates.entries) {
    test('${entry.key} hold-invoice-dependent timeouts are configured safely',
        () async {
      final engine = await FlowEngine.fromYamlWithImports(
        await File('lib/flows/${entry.key}.yml').readAsString(),
        (name) => File('lib/flows/$name').readAsString(),
      );

      for (final state in entry.value) {
        final timeout = engine.timeoutFor(state)!;
        if (state == 'takerCharged') {
          expect(timeout.durationParam, 'taker_charged_auto_confirm');
        } else {
          expect(
            timeout.durationSeconds,
            1800,
            reason: '${entry.key}.$state must resolve before hold funds expire',
          );
        }
      }
    });
  }
}
