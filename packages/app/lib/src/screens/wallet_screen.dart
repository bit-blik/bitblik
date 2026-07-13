import '../config/build_flavor.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import '../services/nfc_lnurl_service.dart';
import 'wallet_details_screen.dart';

const String kNwcWalletId = 'bitblik_nwc_wallet';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  static const routeName = '/wallet';

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen>
    with WidgetsBindingObserver {
  final GlobalKey<NWalletsState> _nWalletsKey = GlobalKey<NWalletsState>();
  late final WalletProtocolDispatcher _walletProtocolDispatcher;
  late final NwcWalletAuthCoordinator _nwcWalletAuthCoordinator;
  AppLifecycleState? _appLifecycleState;
  String? _deferredProtocolUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appLifecycleState = WidgetsBinding.instance.lifecycleState;
    _walletProtocolDispatcher = ref.read(walletProtocolDispatcherProvider);
    _nwcWalletAuthCoordinator = ref.read(nwcWalletAuthCoordinatorProvider);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appLifecycleState = state;
    if (!mounted || state != AppLifecycleState.resumed) {
      return;
    }

    final deferredProtocolUrl = _deferredProtocolUrl;
    _deferredProtocolUrl = null;
    if (deferredProtocolUrl == null) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(_deliverProtocolUrlToWallets(deferredProtocolUrl));
    });
  }

  Future<bool> _deliverProtocolUrlToWallets(String url) async {
    final walletsState = _nWalletsKey.currentState;
    if (walletsState == null) {
      _deferredProtocolUrl = url;
      return false;
    }

    if (_appLifecycleState != AppLifecycleState.resumed) {
      _deferredProtocolUrl = url;
      return false;
    }

    return walletsState.onProtocolUrlReceived(url);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _walletProtocolDispatcher.detach(_deliverProtocolUrlToWallets);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final apiInit = ref.watch(initializedApiServiceProvider);
    final ndkFlutter = ref.watch(ndkFlutterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.wallet.title),
        actions: [
          if (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
            IconButton(
              tooltip: t.nfc.actions.scan,
              onPressed: () async {
                final service = ref.read(nfcLnurlServiceProvider);
                final result = await service.startManualScan();
                if (!context.mounted) return;

                final messenger = ScaffoldMessenger.of(context);
                switch (result) {
                  case NfcScanStartResult.started:
                    messenger.showSnackBar(
                      SnackBar(content: Text(t.nfc.feedback.readyToScan)),
                    );
                    break;
                  case NfcScanStartResult.alreadyRunning:
                    messenger.showSnackBar(
                      SnackBar(content: Text(t.nfc.feedback.alreadyScanning)),
                    );
                    break;
                  case NfcScanStartResult.disabled:
                    messenger.showSnackBar(
                      SnackBar(content: Text(t.nfc.errors.disabled)),
                    );
                    break;
                  case NfcScanStartResult.unsupported:
                    messenger.showSnackBar(
                      SnackBar(content: Text(t.nfc.errors.unsupported)),
                    );
                    break;
                }
              },
              icon: const Icon(Icons.nfc),
            ),
        ],
      ),
      body: apiInit.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Failed to initialize wallet services: $error'),
              ),
            ),
        data:
            (_) =>
                ndkFlutter == null
                    ? const Center(child: CircularProgressIndicator())
                    : Builder(
                      builder: (context) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!mounted) return;
                          _walletProtocolDispatcher.attach(
                            _deliverProtocolUrlToWallets,
                          );

                          final deferredProtocolUrl = _deferredProtocolUrl;
                          if (deferredProtocolUrl == null) return;
                          _deferredProtocolUrl = null;
                          unawaited(
                            _deliverProtocolUrlToWallets(deferredProtocolUrl),
                          );
                        });

                        return NWallets(
                          key: _nWalletsKey,
                          ndkFlutter: ndkFlutter,
                          nwcWalletAuthCoordinator: _nwcWalletAuthCoordinator,
                          title: t.wallet.title,
                          showWalletActions: false,
                          walletCardsScrollDirection: Axis.vertical,
                          showPendingTransactions: false,
                          showRecentTransactions: false,
                          albyGoConnectConfig: AlbyGoConnectConfig(
                            connectMethod: AlbyGoConnectMethod.nostrNwcCallback,
                            appName:
                                ref
                                    .watch(selectedPaymentSystemProvider)
                                    .brandName,
                            appIconUrl: buildNwcIconUrl,
                            callback: '$buildAppScheme://nwc-callback',
                          ),
                          onWalletSelected: (walletId) {
                            context.push(
                              WalletDetailsScreen.routeName,
                              extra: walletId,
                            );
                          },
                        );
                      },
                    ),
      ),
    );
  }
}
