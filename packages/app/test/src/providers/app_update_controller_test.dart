import 'package:bitblik/src/config/build_flavor.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final (flavor, appIdentifier) in [
    ('blik', 'app.bitblik'),
    ('mbway', 'me.bitway'),
    ('twint', 'app.bittwint'),
    ('sk', 'li.veks'),
  ]) {
    test(
      '$flavor download URL follows payment selection, not package identity',
      () async {
        final previousFlavor = buildDefaultPaymentSystemId;
        buildDefaultPaymentSystemId = flavor;
        addTearDown(() => buildDefaultPaymentSystemId = previousFlavor);
        SharedPreferences.setMockInitialValues({});
        PackageInfo.setMockInitialValues(
          appName: 'Update test',
          packageName: appIdentifier,
          version: '0.10.1',
          buildNumber: '1',
          buildSignature: '',
        );
        final ndk = Ndk.emptyBootstrapRelaysConfig();
        addTearDown(ndk.destroy);
        final container = ProviderContainer(
          overrides: [
            ndkFlutterProvider.overrideWithValue(NdkFlutter(ndk: ndk)),
            selectedPaymentSystemProvider.overrideWith(
              (ref) => SelectedPaymentSystemNotifier(paymentSystemById(flavor)),
            ),
          ],
        );
        addTearDown(container.dispose);

        container.read(zapstoreAppUpdateControllerProvider);
        await container.pump();
        final initial = container.read(zapstoreAppUpdateControllerProvider)!;
        expect(initial.app.identifier, appIdentifier);

        for (final (paymentSystem, expectedUrl) in [
          (kMbway, 'https://bitway.me'),
          (kTwint, 'https://bitblik.app'),
          (kSlovakia, 'https://veks.li'),
          (kBlik, 'https://bitblik.app'),
        ]) {
          await container
              .read(selectedPaymentSystemProvider.notifier)
              .set(paymentSystem);
          final controller = container.read(
            zapstoreAppUpdateControllerProvider,
          )!;
          expect(controller.externalUpdateUrl.toString(), expectedUrl);
          expect(controller.app.identifier, appIdentifier);
          expect(controller.currentVersion, '0.10.1');
        }
      },
    );
  }
}
