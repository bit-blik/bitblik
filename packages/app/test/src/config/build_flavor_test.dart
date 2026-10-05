import 'package:bitblik/src/config/build_flavor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Bitway and Bittwint iOS installs use shared BitBlik source', () {
    final previousPaymentSystemId = buildDefaultPaymentSystemId;
    addTearDown(
      () => buildDefaultPaymentSystemId = previousPaymentSystemId,
    );

    for (final paymentSystemId in ['mbway', 'twint']) {
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
}
