import 'package:bitblik/src/coordinator_console/dispute_read_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const store = DisputeReadStore();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('restores read message ids for the same coordinator', () async {
    await store.save('ABCDEF', {'message-2', 'message-1'});

    expect(await store.load('abcdef'), {'message-1', 'message-2'});
  });

  test('keeps coordinator read states isolated', () async {
    await store.save('coordinator-a', {'message-a'});
    await store.save('coordinator-b', {'message-b'});

    expect(await store.load('coordinator-a'), {'message-a'});
    expect(await store.load('coordinator-b'), {'message-b'});
  });
}
