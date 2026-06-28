import 'main_bitblik.dart' as app;
import 'src/config/build_flavor.dart';

Future<void> main() async {
  forcePaymentSystem('twint');
  await app.main();
}
