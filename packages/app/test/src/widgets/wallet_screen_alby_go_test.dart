import 'dart:async';

import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/screens/wallet_screen.dart';
import 'package:bitblik/src/services/api_service_nostr.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/data_layer/repositories/wallets/mem_wallets_repo.dart';
import 'package:ndk_flutter/l10n/app_localizations.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _UnusedApiService implements ApiServiceNostr {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected API access: ${invocation.memberName}');
}

class _QrCoordinator extends NwcWalletAuthCoordinator {
  @override
  Future<bool> completePendingWalletAuth(
    BuildContext context,
    NdkFlutter ndkFlutter, {
    Duration? timeout = const Duration(seconds: 15),
    bool showMessages = true,
  }) async => false; // Keep relay discovery outside this UI regression test.
}

void main() {
  for (final platform in [
    TargetPlatform.linux,
    TargetPlatform.macOS,
    TargetPlatform.windows,
    TargetPlatform.android,
    TargetPlatform.iOS,
  ]) {
    testWidgets(
      '${platform.name} Alby Go uses the appropriate connection flow',
      (tester) async {
        debugDefaultTargetPlatformOverride = platform;
        addTearDown(() => debugDefaultTargetPlatformOverride = null);
        SharedPreferences.setMockInitialValues({});
        final ndk = Ndk(
          NdkConfig(
            cache: MemCacheManager(),
            walletsRepo: MemWalletsRepo(),
            bootstrapRelays: const [],
            eventVerifier: Bip340EventVerifier(),
          ),
        );
        final ndkFlutter = NdkFlutter(ndk: ndk);
        final coordinator = _QrCoordinator();
        await tester.pumpWidget(
          TranslationProvider(
            child: ProviderScope(
              overrides: [
                initializedApiServiceProvider.overrideWith(
                  (ref) async => _UnusedApiService(),
                ),
                ndkFlutterProvider.overrideWithValue(ndkFlutter),
                nwcWalletAuthCoordinatorProvider.overrideWithValue(coordinator),
                selectedPaymentSystemProvider.overrideWith(
                  (ref) => SelectedPaymentSystemNotifier(kBlik),
                ),
              ],
              child: MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: const Locale('en'),
                home: const WalletScreen(),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final wallets = tester.widget<NWallets>(find.byType(NWallets));
        final mobile =
            platform == TargetPlatform.android ||
            platform == TargetPlatform.iOS;
        expect(
          wallets.albyGoConnectConfig.connectMethod,
          mobile
              ? AlbyGoConnectMethod.nostrNwcCallback
              : AlbyGoConnectMethod.walletAuth,
        );
        expect(wallets.albyGoConnectConfig.appName, kBlik.brandName);

        if (platform == TargetPlatform.linux) {
          final context = tester.element(find.byType(NWallets));
          unawaited(
            coordinator.connectAlbyGo(
              context,
              ndkFlutter,
              config: wallets.albyGoConnectConfig,
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(PrettyQrView), findsOneWidget);
          expect(
            find.text('In Alby Go, tap Send, then scan this QR code.'),
            findsOneWidget,
          );
          expect(coordinator.hasPendingSession, isTrue);
          await tester.tap(find.text('Cancel').last);
          await tester.pumpAndSettle();
          expect(coordinator.hasPendingSession, isFalse);
        }
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
        coordinator.connectionState.dispose();
        await tester.runAsync(ndk.destroy);
        debugDefaultTargetPlatformOverride = null;
      },
    );
  }
}
