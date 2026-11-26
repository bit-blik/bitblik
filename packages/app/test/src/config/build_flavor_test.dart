import 'package:bitblik/src/config/build_flavor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Bitway, Bittwint, veks.li iOS installs use shared BitBlik source', () {
    final previousPaymentSystemId = buildDefaultPaymentSystemId;
    addTearDown(
      () => buildDefaultPaymentSystemId = previousPaymentSystemId,
    );

    for (final paymentSystemId in ['mbway', 'twint', 'sk']) {
      buildDefaultPaymentSystemId = paymentSystemId;

      expect(usesSharedBitblikIosApp, isTrue);
      expect(buildAltStoreAppName, 'BitBlik');
      expect(
        buildAltStoreSourceUrl,
        'https://bitblik.app/.well-known/sources/alt-store-source.json',
      );
    }
  });

  test('veks.li flavor pins Slovak ATM branding and links', () {
    forcePaymentSystem('sk');

    expect(buildDefaultPaymentSystemId, 'sk');
    expect(buildAppName, 'veks.li');
    expect(buildAppScheme, 'veksli');
    expect(buildPrimaryHost, 'app.veks.li');
    expect(
      externalUpdateUrlForPaymentSystem('sk'),
      Uri.parse('https://veks.li'),
    );
    expect(buildQrLogoAsset, 'assets/veksli-icon.png');
    expect(isBuildPaymentSystemForced, isTrue);
  });

  test('each flavor keeps its own brand and an ASCII scheme', () {
    const expected = {
      'blik': ('BitBlik', 'bitblik'),
      'mbway': ('BitWay', 'bitway'),
      'twint': ('Bittwint', 'bittwint'),
      'sk': ('veks.li', 'veksli'),
    };
    for (final MapEntry(key: id, value: (name, scheme)) in expected.entries) {
      forcePaymentSystem(id);
      expect(buildAppName, name, reason: id);
      // buildAppScheme feeds deep links and the RPC clientId, so it must stay
      // a plain identifier even when the display name has punctuation.
      expect(buildAppScheme, scheme, reason: id);
    }
  });

  test('download links follow the build flavor', () {
    const expected = {
      'blik': ('app.bitblik', 'bitblik'),
      'mbway': ('me.bitway', 'bitway'),
      'twint': ('app.bittwint', 'bittwint'),
      'sk': ('li.veks', 'veksli'),
    };
    for (final MapEntry(key: id, value: (appId, repo)) in expected.entries) {
      forcePaymentSystem(id);
      expect(buildAndroidAppId, appId, reason: id);
      expect(buildZapstoreUrl, 'https://zapstore.dev/apps/$appId', reason: id);
      expect(
        buildGithubReleasesUrl,
        'https://github.com/bit-blik/$repo/releases',
        reason: id,
      );
    }
  });
}
