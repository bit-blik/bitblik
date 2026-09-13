// ignore_for_file: avoid_print
import 'package:flutter/services.dart' show appFlavor;
import 'package:package_info_plus/package_info_plus.dart';

/// `--dart-define=PAYMENT_SYSTEM=mbway` override; empty when not set.
const String _dartDefinePaymentSystem = String.fromEnvironment(
  'PAYMENT_SYSTEM',
  defaultValue: '',
);

/// Default payment system id for a fresh install. Set synchronously before
/// `runApp` (via the flavor entrypoint or [initBuildFlavor]) so the very first
/// frame renders the correct brand/logo. The user's saved choice still wins.
String buildDefaultPaymentSystemId = 'blik';

/// Brand name (BitBlik / BitWay / Bittwint), follows
/// [buildDefaultPaymentSystemId].
String buildAppName = 'BitBlik';

/// Public icon URL used for the Alby Go NWC connection prompt, per flavor.
String buildNwcIconUrl =
    'https://npub1k3g092rlzvn7nftz3jte9pkx63zp705nh78r6hjpjm55fjg7r2cqx8stj3.nsite.lol/app/assets/assets/logo.png';

/// Brand logo embedded inside generated QR codes. Pinned to the build flavor
/// (not the user's runtime payment-system selection) so a branded build always
/// shows its own icon, even if the device has a stale saved selection.
String buildQrLogoAsset = 'assets/logo2.png';

String get buildAppScheme => switch (buildDefaultPaymentSystemId) {
  'mbway' => 'bitway',
  'twint' => 'bittwint',
  _ => 'bitblik',
};

String get buildPrimaryHost => switch (buildDefaultPaymentSystemId) {
  'mbway' =>
    'npub180nj93uqjvvjksryaxaz8fk9gxwwtg06gxlkd5csrj6rqfg3phhs09n5s9.nsite.lol',
  'twint' => 'bittwint.app',
  _ =>
    'npub1k3g092rlzvn7nftz3jte9pkx63zp705nh78r6hjpjm55fjg7r2cqx8stj3.nsite.lol',
};

String get buildAltStoreSourceUrl =>
    'https://$buildPrimaryHost/.well-known/sources/alt-store-source.json';

bool _forced = false;

/// Whether the selected payment system is pinned by the flavor entrypoint.
/// Branded builds should not auto-switch markets on first launch.
bool get isBuildPaymentSystemForced => _forced;

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
  buildAppName = switch (id) {
    'mbway' => 'BitWay',
    'twint' => 'Bittwint',
    _ => 'BitBlik',
  };
  buildNwcIconUrl = switch (id) {
    'mbway' =>
      'https://npub180nj93uqjvvjksryaxaz8fk9gxwwtg06gxlkd5csrj6rqfg3phhs09n5s9.nsite.lol/app/assets/assets/bitway-icon.png',
    'twint' => 'https://bittwint.app/assets/assets/bittwint-icon.png',
    _ =>
      'https://npub1k3g092rlzvn7nftz3jte9pkx63zp705nh78r6hjpjm55fjg7r2cqx8stj3.nsite.lol/app/assets/assets/logo.png',
  };
  buildQrLogoAsset = switch (id) {
    'mbway' => 'assets/bitway-icon.png',
    'twint' => 'assets/bittwint-icon.png',
    _ => 'assets/logo2.png',
  };
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
  } else if (appFlavor == 'bittwint' || pkg.contains('bittwint')) {
    id = 'twint';
  } else {
    id = 'blik';
  }
  _apply(id);
  print(
    'BITFLAVOR resolved=$id appFlavor=$appFlavor pkg=$pkg '
    'dartDefine="$_dartDefinePaymentSystem"',
  );
}
