import 'package:bitblik/src/utils/save_payment_qr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('gal');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    messenger.setMockMethodCallHandler(channel, null);
  });

  for (final platform in [TargetPlatform.android, TargetPlatform.iOS]) {
    test(
      '$platform saves exact bytes to photos after requesting access',
      () async {
        debugDefaultTargetPlatformOverride = platform;
        final bytes = Uint8List.fromList([137, 80, 78, 71]);
        final calls = <MethodCall>[];
        messenger.setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          if (call.method == 'requestAccess') return true;
          return null;
        });
        expect(await savePaymentQr(bytes), PaymentQrSaveResult.saved);
        expect(calls.map((call) => call.method), [
          'requestAccess',
          'putImageBytes',
        ]);
        expect(calls.last.arguments['bytes'], orderedEquals(bytes));
        expect(calls.last.arguments['name'], 'twint-payment');
        expect(calls.last.arguments['album'], isNull);
      },
    );
  }

  test(
    'native gallery failures propagate instead of reporting success',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      messenger.setMockMethodCallHandler(channel, (call) async {
        if (call.method == 'requestAccess') return true;
        throw PlatformException(code: 'ACCESS_DENIED');
      });
      await expectLater(savePaymentQr(Uint8List(1)), throwsException);
    },
  );
}
