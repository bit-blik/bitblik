import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';

void main() {
  CoordinatorService serviceFor(String transition) {
    final engine = FlowEngine.fromYaml('''
id: actor_validation
states:
  funded:
    initial: true
    transitions:
$transition
  done:
    terminal: true
''');
    return CoordinatorService(
      MockDatabaseService(),
      paymentServiceForTest: MockPaymentService(),
      paymentSystemIdForTest: 'blik',
      flowEngineForTest: engine,
    );
  }

  test('startup rejects a user action with no actor', () async {
    final service = serviceFor('''
      - on: unsafe_action
        to: done
''');

    await expectLater(
      service.init(),
      throwsA(isA<StateError>().having(
        (e) => e.toString(),
        'message',
        contains('by: maker|taker|coordinator'),
      )),
    );
  });

  test('startup rejects a user action declared by server', () async {
    final service = serviceFor('''
      - on: unsafe_action
        by: server
        to: done
''');

    await expectLater(
      service.init(),
      throwsA(isA<StateError>().having(
        (e) => e.toString(),
        'message',
        contains('by: maker|taker|coordinator'),
      )),
    );
  });

  test('startup accepts authenticated user actors', () async {
    for (final actor in ['maker', 'taker', 'coordinator']) {
      final service = serviceFor('''
      - on: safe_action
        by: $actor
        to: done
''');
      await service.init();
    }
  });
}
