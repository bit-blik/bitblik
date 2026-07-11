import 'package:bitblik_coordinator/src/flow/flow_loader.dart';
import 'package:test/test.dart';

void main() {
  test('loads bundled blik flow via package-uri resolution', () async {
    final engine = await FlowLoader.load('blik');
    expect(engine, isNotNull,
        reason: 'blik.yml should resolve from the bitblik_core package root');
    expect(engine!.initialState, 'funded');
  });

  test('returns null for an unknown flow id', () async {
    expect(await FlowLoader.load('does_not_exist'), isNull);
  });
}
