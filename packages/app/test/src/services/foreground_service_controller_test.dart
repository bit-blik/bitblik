import 'dart:async';
import 'package:bitblik/src/services/notification_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'serializes updates, skips identical payloads and allows resume restart',
    () async {
      final calls = <String>[];
      final gate = Completer<void>();
      final controller = ForegroundServiceController(
        start: (title, body) async {
          calls.add(title);
          await gate.future;
        },
        stop: () async {
          calls.add('stop');
        },
      );
      final first = controller.update(('active', 'body'));
      final same = controller.update(('active', 'body'));
      final stop = controller.update(null);
      await Future<void>.delayed(Duration.zero);
      expect(calls, ['active']);
      gate.complete();
      await Future.wait([first, same, stop]);
      expect(calls, ['active', 'stop']);
      await controller.update(null);
      expect(calls.length, 2);
      await controller.update(('active', 'body'));
      controller.invalidate();
      await controller.update(('active', 'body'));
      expect(calls, ['active', 'stop', 'active', 'active']);
    },
  );

  test('failed start does not prevent retry or stop', () async {
    var attempts = 0;
    var stops = 0;
    final controller = ForegroundServiceController(
      start: (_, _) async {
        if (++attempts == 1) throw StateError('OS start limit');
      },
      stop: () async {
        stops++;
      },
    );
    await expectLater(controller.update(('active', 'body')), throwsStateError);
    await controller.update(('active', 'body'));
    await controller.update(null);
    expect(attempts, 2);
    expect(stops, 1);
  });
}
