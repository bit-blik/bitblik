// ignore_for_file: avoid_print
import 'package:flutter/services.dart' show appFlavor;
import 'package:package_info_plus/package_info_plus.dart';

/// `--dart-define=PAYMENT_SYSTEM=mbway` override; empty when not set.
const String _dartDefinePaymentSystem =
    String.fromEnvironment('PAYMENT_SYSTEM', defaultValue: '');

/// Default payment system id for a fresh install. Set synchronously before
/// `runApp` (via the flavor entrypoint or [initBuildFlavor]) so the very first
/// frame renders the correct brand/logo. The user's saved choice still wins.
String buildDefaultPaymentSystemId = 'blik';

/// Brand name (BitBlik / BitWay), follows [buildDefaultPaymentSystemId].
String buildAppName = 'BitBlik';

/// Public icon URL used for the Alby Go NWC connection prompt, per flavor.
String buildNwcIconUrl = 'https://bitblik.app/assets/assets/logo.png';

bool _forced = false;

/// Force the payment system synchronously from a flavor entrypoint
/// (e.g. `lib/main_bitblik.dart` / `lib/main_bitway.dart`). This is the
/// authoritative, deterministic path — no defines, no async, no appId lookup.
/// Call before `runApp`.
void forcePaymentSystem(String id) {
  _forced = true;
  _apply(id);
}

void _apply(String id) {
  buildDefaultPaymentSystemId = id;
  buildAppName = id == 'mbway' ? 'BitWay' : 'BitBlik';
  buildNwcIconUrl = id == 'mbway'
      ? 'https://bitblik.app/assets/assets/bitway-icon.png'
      : 'https://bitblik.app/assets/assets/logo.png';
}

/// Fallback resolver for builds that didn't use a flavor entrypoint. Tries the
/// dart-define, then `appFlavor`, then the installed appId at runtime
/// (`me.bitway` → mbway — immune to the dart-define build cache). No-op if a
/// flavor entrypoint already called [forcePaymentSystem]. Awaited in `main()`
/// before `runApp`, so the result is still ready for the first frame.
Future<void> initBuildFlavor() async {
  if (_forced) {
    print('BITFLAVOR forced=$buildDefaultPaymentSystemId');
    return;
  }
  String pkg = '?';
  try {
    pkg = (await PackageInfo.fromPlatform()).packageName;
  } catch (e) {
    pkg = 'ERR:$e';
  }
  String id;
  if (_dartDefinePaymentSystem.isNotEmpty) {
    id = _dartDefinePaymentSystem;
  } else if (appFlavor == 'bitway' || pkg.contains('bitway')) {
    id = 'mbway';
  } else {
    id = 'blik';
  }
  _apply(id);
  print('BITFLAVOR resolved=$id appFlavor=$appFlavor pkg=$pkg '
      'dartDefine="$_dartDefinePaymentSystem"');
}
