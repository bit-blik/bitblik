// Veksli (Slovak cardless ATM) flavor entrypoint.
//
// Build/run with this entrypoint so the SK ATM payment system is selected from
// the first frame:
//   flutter run   --flavor veksli -t lib/main_veksli.dart
//   flutter build apk --flavor veksli -t lib/main_veksli.dart
import 'main_bitblik.dart' as app;
import 'src/config/build_flavor.dart';

Future<void> main() async {
  forcePaymentSystem('sk');
  await app.main();
}
