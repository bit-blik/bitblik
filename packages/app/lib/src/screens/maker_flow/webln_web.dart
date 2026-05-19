import 'dart:js' show allowInterop;
import 'package:flutter_webln/flutter_webln.dart';
import 'package:ndk/shared/logger/logger.dart';

Future<bool> get isWeblnSupported async {
  try {
    await FlutterWebln.enable();
    final weblnValue = weblnDecode(FlutterWebln.webln);
    Logger.log.d(
      () => "!!!!!!!!!!!!!: isWeblnSupported weblnValue: $weblnValue",
    );
    if (weblnValue.isNotEmpty) {
      try {
        bool a = await FlutterWebln.getInfo().then((response) {
          Logger.log.d(() => '[!] getInfo method is $response');
          if (response != null) {
            return true;
          }
          return false;
        });
        return a;
      } catch (error) {
        Logger.log.d(() => '[!] Error in getInfo method is $error');
        return false;
      }
    }
    return false;
  } catch (e) {
    Logger.log.d(() => "!!!!!!!!!!!!!: isWeblnSupported $e");
    return false;
  }
}

Future<void> sendWeblnPayment(String invoice) async {
  try {
    await FlutterWebln.enable();
    final result = FlutterWebln.sendPayment(invoice: invoice);
    if (result is Future) {
      Logger.log.d(() => "!!!! send payment result $result");
    } else {
      Logger.log.d(() => "!!!! send payment result $result");
    }
  } catch (e) {
    Logger.log.d(() => "!!!!!!!!!!!!! send payment: $e");
    rethrow;
  }
}

void checkWeblnSupport(Function(bool) callback) async {
  callback(await isWeblnSupported);
}
