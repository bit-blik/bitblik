// BitWay (MB WAY / Portugal) flavor entrypoint.
//
// Build/run with this entrypoint so the default payment system is baked
// deterministically (no dart-define caching, no appId lookup, correct on the
// first frame):
//   flutter run   --flavor bitway -t lib/main_bitway.dart
//   flutter build apk --flavor bitway -t lib/main_bitway.dart
import 'main_bitblik.dart' as app;
import 'src/config/build_flavor.dart';

Future<void> main() async {
  forcePaymentSystem('mbway');
  await app.main();
}
