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

  test('Veksli flavor pins Slovak ATM branding and links', () {
    forcePaymentSystem('sk');

    expect(buildDefaultPaymentSystemId, 'sk');
    expect(buildAppName, 'Veksli');
    expect(buildAppScheme, 'veksli');
    expect(buildPrimaryHost, 'app.veks.li');
    expect(
      externalUpdateUrlForPaymentSystem('sk'),
      Uri.parse('https://veks.li'),
    );
    expect(buildQrLogoAsset, 'assets/veksli-icon.png');
    expect(isBuildPaymentSystemForced, isTrue);
  });
}
