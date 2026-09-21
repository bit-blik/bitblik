import 'package:bitblik/src/utils/code_label_ext.dart';
import 'dart:async';
import 'dart:io' show Platform; // Import Platform

import 'package:app_links/app_links.dart';
import 'package:bitblik/src/screens/maker_flow/maker_pay_invoice_screen.dart';
import 'package:bitblik/src/flow/flow_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Keep for GlobalMaterialLocalizations.delegates
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk_flutter/l10n/app_localizations.dart' as ndk_l10n;
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

import 'i18n/gen/strings.g.dart'; // Import Slang from new path
import 'package:bitblik_core/core.dart'; // Needed for OfferStatus enum
import 'src/config/build_flavor.dart';
import 'src/config/runtime_config.dart';
import 'src/providers/providers.dart';
import 'src/settings/app_preferences.dart';
import 'src/theme/app_theme.dart';
import 'src/services/notification_service.dart';
import 'src/utils/app_link_uri.dart';
import 'src/screens/coordinator_details_screen.dart';
import 'src/screens/coordinator_console_access_screen.dart';
import 'src/screens/coordinator_management_screen.dart';
import 'src/screens/display_settings_screen.dart';
import 'src/screens/faq_screen.dart'; // Import the FAQ screen
import 'src/screens/maker_flow/maker_amount_form.dart';
import 'src/screens/local_offer_details_screen.dart';
import 'src/screens/market_onboarding_screen.dart';
import 'src/screens/my_offers_screen.dart';
import 'src/screens/neko_management_screen.dart';
import 'src/screens/offer_details_screen.dart';
import 'src/screens/offer_list_screen.dart';
import 'src/screens/offer_creation_settings_screen.dart';
import 'src/screens/role_selection_screen.dart';
import 'src/screens/settings_screen.dart';
import 'src/screens/notification_settings_screen.dart';
import 'src/screens/wallet_details_screen.dart';
import 'src/screens/wallet_screen.dart';
import 'src/widgets/relay_dots.dart';

// Import our platform detection utility

// BitBlik flavor entrypoint.
//
// Build/run with this entrypoint explicitly:
//   flutter run   --flavor bitblik -t lib/main_bitblik.dart
//   flutter build apk --flavor bitblik -t lib/main_bitblik.dart

final double kMakerFeePercentage = 0.5;
final double kTakerFeePercentage = 0.5;
final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
late AppLocale appLocale;
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Builds link controls without url_launcher's web `HtmlElementView`.
///
/// Persistent invisible anchor platform views can outlive their compositor
/// frame in optimized CanvasKit builds. Direct launches preserve behavior
/// without adding platform views to the Flutter scene.
class _PlatformFreeLink extends StatelessWidget {
  final Uri uri;
  final bool openInNewTab;
  final Widget Function(BuildContext, VoidCallback?) builder;

  const _PlatformFreeLink({
    required this.uri,
    this.openInNewTab = false,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) => builder(context, () {
    unawaited(
      launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: openInNewTab ? '_blank' : '_self',
      ),
    );
  });
}

final routerProvider = Provider<GoRouter>((ref) {
  // On a fresh install (no market saved yet), start at the market-selection
  // onboarding so the first coordinator-discovery sweep only runs after the
  // user picks their country. See [needsMarketOnboardingProvider].
  final startOnboarding = ref.read(needsMarketOnboardingProvider);
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: startOnboarding ? MarketOnboardingScreen.routeName : '/',
    navigatorKey: rootNavigatorKey,
    redirect: (context, state) {
      if (kIsWeb) return null;
      final appUri = normalizeAppLinkUri(state.uri);
      return appUri == state.uri ? null : appUri.toString();
    },
    routes: [
      // Top-level (outside the ShellRoute) so onboarding renders full-screen
      // without the app's nav chrome.
      GoRoute(
        path: MarketOnboardingScreen.routeName,
        builder: (context, state) => const MarketOnboardingScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          String? pageTitle;
          bool hideBackButton = false;
          bool showBackButton = false;

          final path = state.uri.path;
          if (path == FaqScreen.routeName) {
            hideBackButton = true;
          }

          return AppScaffold(
            body: child,
            pageTitle: pageTitle,
            showBackButton: showBackButton,
            hideBackButton: hideBackButton,
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const RoleSelectionScreen(),
          ),
          GoRoute(
            path: '/offers',
            builder: (context, state) => const OfferListScreen(),
          ),
          GoRoute(
            path: MyOffersScreen.routeName,
            builder: (context, state) => const MyOffersScreen(),
          ),
          GoRoute(
            path: LocalOfferDetailsScreen.routeName,
            builder: (context, state) {
              final offerId = state.pathParameters['id'];
              if (offerId == null) {
                return const Center(child: Text('No offer ID provided.'));
              }
              return LocalOfferDetailsScreen(offerId: offerId);
            },
          ),
          GoRoute(
            path: '/offers/:id',
            builder: (context, state) {
              final offerId = state.pathParameters['id'];
              if (offerId == null) {
                return const Center(child: Text('No offer ID provided.'));
              }
              return OfferDetailsScreen(offerId: offerId);
            },
          ),
          GoRoute(
            path: '/create',
            builder: (context, state) => const MakerAmountForm(),
          ),
          GoRoute(
            path: '/pay',
            builder: (context, state) => const MakerPayInvoiceScreen(),
          ),
          // Single flow-driven screen for generic (yaml) flows (TWINT). Renders
          // the body for the active offer's raw state + the user's role and
          // re-renders as the coordinator advances the state.
          GoRoute(
            path: '/flow',
            builder: (context, state) => const FlowScreen(),
          ),
          GoRoute(
            path: '/coordinators',
            builder: (context, state) => const CoordinatorManagementScreen(),
          ),
          GoRoute(
            path: '${CoordinatorDetailsScreen.routeName}/:pubkey',
            builder: (context, state) {
              final pubkey = state.pathParameters['pubkey'];
              if (pubkey == null) {
                return const Center(child: Text('No coordinator provided.'));
              }
              return CoordinatorDetailsScreen(pubkey: pubkey);
            },
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: CoordinatorConsoleAccessScreen.routeName,
            builder: (context, state) => const CoordinatorConsoleAccessScreen(),
          ),
          GoRoute(
            path: NotificationSettingsScreen.routeName,
            builder: (context, state) => const NotificationSettingsScreen(),
          ),
          GoRoute(
            path: OfferCreationSettingsScreen.routeName,
            builder: (context, state) => const OfferCreationSettingsScreen(),
          ),
          GoRoute(
            path: DisplaySettingsScreen.routeName,
            builder: (context, state) => const DisplaySettingsScreen(),
          ),
          GoRoute(
            path: '/wallet',
            builder: (context, state) => const WalletScreen(),
          ),
          GoRoute(
            path: WalletDetailsScreen.routeName,
            builder: (context, state) {
              final walletId = state.extra as String?;
              if (walletId == null) {
                return const Center(child: Text('No wallet provided.'));
              }
              return WalletDetailsScreen(walletId: walletId);
            },
          ),
          GoRoute(
            path: '/neko-management',
            builder: (context, state) => const NekoManagementScreen(),
          ),
          GoRoute(
            path: FaqScreen.routeName,
            builder: (context, state) => const FaqScreen(),
          ),
        ],
      ),
    ],
  );
});

Future<void> main() async {
  // Initialize FFI for desktop platforms
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await initBuildFlavor();
  final deploymentDefaultPaymentSystemId = RuntimeConfig.defaultPaymentSystemId;
  // Try to resolve the market from the device country (IP geolocation) and
  // auto-select it when the deployment did not provide a runtime default.
  // Only when neither is available do we show the first-launch market picker.
  final marketSelected = await AppPreferencesStore.ensureMarketSelectedOrDetect(
    deploymentDefaultPaymentSystemId: deploymentDefaultPaymentSystemId,
  );
  await NotificationService().init();
  String? localeString = await asyncPrefs.getString('app_locale');
  if (localeString != null) {
    appLocale = switch (localeString) {
      'pl' => AppLocale.pl,
      'it' => AppLocale.it,
      'pt' => AppLocale.pt,
      'de' => AppLocale.de,
      'fr' => AppLocale.fr,
      'sk' => AppLocale.sk,
      _ => AppLocale.en,
    };
  } else {
    appLocale = AppLocaleUtils.findDeviceLocale();
  }
  LocaleSettings.setLocale(appLocale);
  // Preload the saved market so the FIRST coordinator-discovery sweep already
  // targets it. Otherwise selectedPaymentSystemProvider starts at the default
  // (BLIK) and the saved market (e.g. Tatra banka) only loads asynchronously —
  // by then discovery has run for BLIK and the Slovak coordinators don't appear
  // until a manual re-enable in Settings.
  final savedMethod = await AppPreferencesStore.loadSelectedPaymentSystem(
    deploymentDefaultPaymentSystemId: deploymentDefaultPaymentSystemId,
  );
  final savedThemePreference = await AppPreferencesStore.loadThemePreference();
  runApp(
    TranslationProvider(
      // Wrap with TranslationProvider
      child: ProviderScope(
        overrides: [
          selectedPaymentSystemProvider.overrideWith(
            (ref) => SelectedPaymentSystemNotifier(savedMethod),
          ),
          needsMarketOnboardingProvider.overrideWith((ref) => !marketSelected),
          themePreferenceProvider.overrideWith(
            (ref) => ThemePreferenceNotifier(savedThemePreference),
          ),
        ],
        child: const SafeArea(child: MyApp()),
      ),
    ),
  );
}

// Replace MyApp with a ConsumerStatefulWidget to handle deep links
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  StreamSubscription<Uri>? _sub;
  StreamSubscription<NotificationTap>? _notificationTapSub;
  StreamSubscription<String>? _nfcLightningAddressSub;
  final AppLinks _appLinks = AppLinks();
  bool _routerReady = false;
  String? _pendingRouteNavigation;
  String? _pendingNfcLightningAddress;
  final List<Uri> _pendingDeepLinks = [];
  AppLifecycleState? _appLifecycleState;
  bool _showingNfcDialog = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appLifecycleState = WidgetsBinding.instance.lifecycleState;
    try {
      ref.read(keyServiceProvider);
      ref.read(apiServiceProvider);
      _nfcLightningAddressSub = ref
          .read(nfcLnurlServiceProvider)
          .lightningAddresses
          .listen(_handleNfcLightningAddressFound);

      Logger.log.i(
        () =>
            '🚀 App initialized: API service and coordinator discovery started',
      );
    } catch (e) {
      Logger.log.e(() => '❌ Error during app initialization: $e');
    }

    // Initialize API service and start coordinator discovery
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _routerReady = true;
      _tryHandlePendingRouteNavigation();
      if (_pendingDeepLinks.isNotEmpty) {
        final queued = List<Uri>.from(_pendingDeepLinks);
        _pendingDeepLinks.clear();
        for (final queuedUri in queued) {
          unawaited(_handleDeepLink(queuedUri));
        }
      }

      try {
        await ref.read(initializedApiServiceProvider.future);
        // Prime the cold-start stream before discovery starts so the overlay
        // cannot miss a short-lived bootstrap state in release builds.
        ref.read(coordinatorColdStartProvider);
        // Prime the coordinator stream without using `watch` outside build.
        // Keeps [discoveryIdentityInitializer] alive so that, if the user picks a
        // different market than the build default on the first-launch onboarding,
        // discovery re-points and sweeps for the chosen market automatically.
        ref.read(discoveredCoordinatorsProvider);
        final registry = await ref.read(coordinatorRegistryProvider.future);
        // Discover for the build default up front (as always). During onboarding
        // the cold-start overlay is suppressed, so this pre-warm stays invisible;
        // if the user then picks a different market, discovery re-points to it.
        unawaited(() async {
          try {
            await registry.discover();
            await registry.probeAllEnabled();
          } catch (e) {
            Logger.log.e(() => 'Initial coordinator discovery failed: $e');
          }
        }());

        // Initialize the offer status subscription manager
        ref.read(offerStatusSubscriptionManagerProvider);

        // Initialize app lifecycle provider (reconnects NDK when app resumes)
        ref.read(appLifecycleProvider);

        // Warm up wallets (especially NWC) in background regardless of route.
        ref.read(walletWarmupProvider);
        unawaited(ref.read(nfcLnurlServiceProvider).ensureForegroundScanning());

        // // Start listening to connectivity changes
        // _connectivitySubscription = listenToConnectivityChanges(ref);

        Logger.log.i(
          () =>
              '🚀 App initialized: API service and coordinator discovery started',
        );
      } catch (e) {
        Logger.log.e(() => '❌ Error during app initialization: $e');
      }
    });

    _notificationTapSub = NotificationService().tapStream.listen((tap) {
      final payload = tap.payload ?? '';
      if (!payload.startsWith('offer:')) return;
      final offerId = payload.substring('offer:'.length);
      if (tap.actionId == NotificationService.actionTakeOffer) {
        ref.read(pendingAutoTakeOfferIdProvider.notifier).state = offerId;
      }
      _goToRouteWhenReady('/offers/$offerId');
    });

    // Only listen for deep links on Android/iOS/macOS, not web
    if (!kIsWeb) {
      _sub = _appLinks.uriLinkStream.listen(
        (Uri? uri) {
          if (uri != null) {
            _handleDeepLink(uri);
          }
        },
        onError: (err) {
          Logger.log.e(() => 'Deep link error: $err');
        },
      );

      // Check initial link after first frame so router is mounted.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(_checkInitialLink());
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appLifecycleState = state;
    if (state == AppLifecycleState.resumed) {
      _tryHandlePendingRouteNavigation();
      _tryHandlePendingNfcLightningAddress();
      unawaited(ref.read(nfcLnurlServiceProvider).ensureForegroundScanning());
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      unawaited(ref.read(nfcLnurlServiceProvider).stopScanning());
    }
  }

  void _tryHandlePendingRouteNavigation() {
    final route = _pendingRouteNavigation;
    if (route == null) return;
    if (!_routerReady) return;
    if (_appLifecycleState != AppLifecycleState.resumed) return;

    _pendingRouteNavigation = null;
    _goToRoute(route);
  }

  void _tryHandlePendingNfcLightningAddress() {
    final address = _pendingNfcLightningAddress;
    if (address == null) return;
    if (!_routerReady) return;
    if (_appLifecycleState != AppLifecycleState.resumed) return;

    _pendingNfcLightningAddress = null;
    unawaited(_showNfcLightningAddressDialog(address));
  }

  Future<void> _checkInitialLink() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      Logger.log.e(() => 'Error getting initial link: $e');
    }
  }

  void _openWalletScreen() {
    _goToRouteWhenReady(WalletScreen.routeName);
  }

  void _goToRouteWhenReady(String route) {
    if (!mounted) return;
    if (!_routerReady || _appLifecycleState != AppLifecycleState.resumed) {
      _pendingRouteNavigation = route;
      return;
    }
    _goToRoute(route);
  }

  void _goToRoute(String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final goRouter = ref.read(routerProvider);
      final currentPath = goRouter.routerDelegate.currentConfiguration.uri.path;
      if (currentPath == route) return;
      goRouter.go(route);
    });
  }

  Future<void> _handleNfcLightningAddressFound(String address) async {
    if (!_routerReady || _appLifecycleState != AppLifecycleState.resumed) {
      _pendingNfcLightningAddress = address;
      return;
    }

    await _showNfcLightningAddressDialog(address);
  }

  Future<void> _showNfcLightningAddressDialog(String address) async {
    if (_showingNfcDialog) {
      _pendingNfcLightningAddress = address;
      return;
    }

    final initialDialogContext = rootNavigatorKey.currentContext;
    if (initialDialogContext == null || !mounted) {
      _pendingNfcLightningAddress = address;
      return;
    }

    _showingNfcDialog = true;
    final t = Translations.of(initialDialogContext);
    final keyService = ref.read(keyServiceProvider);

    try {
      final currentAddress = await keyService.getLightningAddress();
      if (!mounted) return;

      if (currentAddress?.toLowerCase() == address.toLowerCase()) {
        final messengerContext = rootNavigatorKey.currentContext;
        if (messengerContext != null) {
          ScaffoldMessenger.of(
            messengerContext,
          ).showSnackBar(SnackBar(content: Text(t.nfc.feedback.alreadyAdded)));
        }
        return;
      }

      final dialogContext = rootNavigatorKey.currentContext;
      if (dialogContext == null) {
        _pendingNfcLightningAddress = address;
        return;
      }

      final shouldSave = await showDialog<bool>(
        context: dialogContext,
        builder: (context) {
          return AlertDialog(
            title: Text(t.nfc.prompts.addTitle),
            content: Text(t.nfc.prompts.addMessage(address: address)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(t.common.buttons.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(t.nfc.actions.addWallet),
              ),
            ],
          );
        },
      );

      if (shouldSave == true) {
        await keyService.saveLightningAddress(address);
        ref.invalidate(lightningAddressProvider);
        if (!mounted) return;
        final messengerContext = rootNavigatorKey.currentContext;
        if (messengerContext != null) {
          ScaffoldMessenger.of(
            messengerContext,
          ).showSnackBar(SnackBar(content: Text(t.nfc.feedback.walletAdded)));
        }
      }
    } catch (error) {
      if (!mounted) return;
      final messengerContext = rootNavigatorKey.currentContext;
      if (messengerContext != null) {
        ScaffoldMessenger.of(messengerContext).showSnackBar(
          SnackBar(
            content: Text(t.nfc.errors.reading(details: error.toString())),
          ),
        );
      }
    } finally {
      _showingNfcDialog = false;
      _tryHandlePendingNfcLightningAddress();
    }
  }

  Future<void> _handleDeepLink(Uri uri) async {
    if (!_routerReady) {
      _pendingDeepLinks.add(uri);
      return;
    }

    final router = ref.read(routerProvider);
    final scheme = uri.scheme.toLowerCase();

    // Wallet callback query parameters can contain NWC credentials.
    Logger.log.i(() => '🔗 Deep link received (scheme: $scheme)');

    // Handle nostr+walletconnect:// scheme (NWC connection)
    if (scheme == 'nostr+walletconnect') {
      await _handleNwcDeepLink(uri.toString());
      return;
    }
    // Handle app-specific deep-link schemes (bitblik://, bitway://, bittwint://)
    if (scheme == 'bitblik' || scheme == 'bitway' || scheme == 'bittwint') {
      final path = uri.host + uri.path;
      if (path.endsWith('nwc-callback') ||
          path.startsWith('value') ||
          uri.queryParameters.containsKey('value')) {
        // Preserve callback URI and correlation parameters for NDK validation.
        await _handleNwcDeepLink(uri.toString());
        return;
      }

      // Handle other app:// paths
      if (path == 'offers' || path == '/offers') {
        router.push('/offers');
        return;
      }
    }

    // Handle https deep links (BitBlik / BitWay domains / bittwint.app)
    if (scheme == 'https') {
      final appUri = normalizeAppLinkUri(uri);
      final segments = appUri.pathSegments;
      if (appUri.path == '/') {
        router.go(appUri.toString());
        return;
      }
      if (segments.isNotEmpty && segments.first == 'offers') {
        if (segments.length >= 2 && segments[1].isNotEmpty) {
          router.push(
            appUri
                .replace(pathSegments: ['', 'offers', segments[1]])
                .toString(),
          );
        } else {
          router.push(appUri.replace(path: '/offers').toString());
        }
      }
    }
  }

  void _openPostNwcConnectionRoute() {
    final activeOffer = ref.read(activeOfferProvider);

    if (activeOffer != null && activeOffer.status == OfferStatus.created) {
      Logger.log.i(
        () =>
            '📝 Active offer found in created status, navigating to pay screen',
      );
      _goToRouteWhenReady('/pay');
      return;
    }

    Logger.log.i(
      () => '💳 No active offer in created status, navigating to wallet',
    );
    _openWalletScreen();
  }

  /// Complete NDK's connection before navigating, even without a wallet screen.
  Future<void> _handleNwcDeepLink(String callbackUrl) async {
    Logger.log.i(() => '🔗 NWC deep link: connecting wallet...');

    try {
      // Ensure NDK is initialized before adding the wallet
      final apiService = await ref.read(initializedApiServiceProvider.future);
      final ndk = apiService.ndk;
      if (ndk == null) {
        Logger.log.e(() => '❌ NDK not initialized - cannot add NWC wallet');
        _openWalletScreen();
        return;
      }

      if (!mounted) return;
      final callbackContext = rootNavigatorKey.currentContext;
      if (callbackContext == null) return;
      final coordinator = ref.read(nwcWalletAuthCoordinatorProvider);
      final existingWalletIds = {
        for (final wallet in await ndk.wallets.getWallets()) wallet.id,
      };
      if (!mounted || !callbackContext.mounted) return;
      final handled = await coordinator.processProtocolUrl(
        callbackContext,
        ref.read(ndkFlutterProvider) ?? NdkFlutter(ndk: ndk),
        callbackUrl,
      );
      if (!mounted) return;
      if (!handled ||
          coordinator.connectionState.value.phase !=
              WalletConnectionPhase.connected) {
        _openWalletScreen();
        return;
      }

      // NDK assigns the wallet ID and retains provider metadata. Select the
      // newly connected wallet without consuming the widget's selection event.
      final addedWallets = (await ndk.wallets.getWallets())
          .where((wallet) => !existingWalletIds.contains(wallet.id))
          .toList();
      if (!mounted) return;
      if (addedWallets.length == 1) {
        ndk.wallets.setDefaultWallet(addedWallets.single.id);
      }
      ref.read(defaultWalletProvider.notifier).refresh();

      Logger.log.i(() => '💰 NWC connected via deep link');

      _openPostNwcConnectionRoute();
    } catch (e) {
      Logger.log.e(() => '❌ Error connecting NWC via deep link: $e');
      // Still navigate to wallet screen on error so user can see what happened
      _openWalletScreen();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sub?.cancel();
    _notificationTapSub?.cancel();
    _nfcLightningAddressSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final themePreference = ref.watch(themePreferenceProvider);
    final t = Translations.of(context);

    return MaterialApp.router(
      title: t.app.title(
        app: ref.watch(selectedPaymentSystemProvider).brandName,
      ),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: switch (themePreference) {
        AppThemePreference.system => ThemeMode.system,
        AppThemePreference.light => ThemeMode.light,
        AppThemePreference.dark => ThemeMode.dark,
      },
      locale: LocaleSettings.currentLocale.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        // Wrapped so a market/device locale ndk doesn't translate (e.g. sk)
        // falls back to English for ndk's own strings instead of warning
        // "locale not supported by all localization delegates".
        const _NdkLocalizationsFallbackDelegate(),
      ],
      builder: (context, child) => Stack(
        children: [
          if (child != null) child,
          const _CoordinatorColdStartOverlay(),
        ],
      ),
      routerConfig: router,
    );
  }
}

class _CoordinatorColdStartOverlay extends ConsumerWidget {
  const _CoordinatorColdStartOverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Don't pop the discovery overlay over the first-launch market picker.
    if (ref.watch(needsMarketOnboardingProvider)) {
      return const SizedBox.shrink();
    }
    final async = ref.watch(coordinatorColdStartProvider);
    final state = async.valueOrNull;
    if (state == null) return const SizedBox.shrink();

    final t = Translations.of(context);
    final method = ref.watch(selectedPaymentSystemProvider);
    final brand = method.brandName;
    final colors = Theme.of(context).colorScheme;
    final showInfoPanel = state.origin == CoordinatorColdStartOrigin.onboarding;

    void dismiss() {
      ref
          .read(coordinatorRegistryProvider.future)
          .then((registry) => registry.dismissColdStartState());
    }

    return Stack(
      children: [
        const ModalBarrier(dismissible: false, color: Colors.black54),
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 420,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Material(
              color: colors.surfaceContainerHigh,
              elevation: 12,
              borderRadius: BorderRadius.circular(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              t.coordinator.coldStart.title,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          IconButton(
                            onPressed: dismiss,
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.coordinator.coldStart.body(app: brand),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(value: _progressFor(state.phase)),
                      const SizedBox(height: 10),
                      Text(
                        _phaseLabel(t, state.phase),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _ColdStartStatChip(
                            label: t.coordinator.coldStart.discovered,
                            value: '${state.discoveredCount}',
                          ),
                          _ColdStartStatChip(
                            label: t.coordinator.coldStart.candidates,
                            value: '${state.candidateCount}',
                          ),
                          _ColdStartStatChip(
                            label: t.coordinator.coldStart.enabled,
                            value: '${state.enabledCount}',
                          ),
                        ],
                      ),
                      if (state.records.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          t.coordinator.coldStart.recordsTitle,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 220),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.records.length,
                            separatorBuilder: (_, index) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final record = state.records[index];
                              return ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: ClipOval(
                                  child: buildCoordinatorLogo(
                                    record.icon,
                                    size: 32,
                                    revealLogo: true,
                                  ),
                                ),
                                title: Text(
                                  record.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  _recordLabel(t, record, state.phase),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: _recordIcon(record, state.phase),
                              );
                            },
                          ),
                        ),
                      ],
                      if (showInfoPanel) ...[
                        const SizedBox(height: 16),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: colors.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: colors.outlineVariant),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Icon(
                                    Icons.info_outline,
                                    size: 18,
                                    color: colors.onSecondaryContainer,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    t.coordinator.coldStart.settingsHint,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: colors.onSecondaryContainer,
                                          height: 1.35,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton(
                          onPressed: dismiss,
                          child: Text(
                            state.phase == CoordinatorColdStartPhase.completed
                                ? t.coordinator.coldStart.ok
                                : t.common.buttons.close,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  double _progressFor(CoordinatorColdStartPhase phase) {
    return switch (phase) {
      CoordinatorColdStartPhase.loadingMuteList => 0.1,
      CoordinatorColdStartPhase.discovering => 0.3,
      CoordinatorColdStartPhase.loadingProfiles => 0.5,
      CoordinatorColdStartPhase.loadingStats => 0.65,
      CoordinatorColdStartPhase.checkingHealth => 0.82,
      CoordinatorColdStartPhase.finalizing => 0.94,
      CoordinatorColdStartPhase.completed => 1.0,
    };
  }

  String _phaseLabel(Translations t, CoordinatorColdStartPhase phase) {
    return switch (phase) {
      CoordinatorColdStartPhase.loadingMuteList =>
        t.coordinator.coldStart.phases.loadingMuteList,
      CoordinatorColdStartPhase.discovering =>
        t.coordinator.coldStart.phases.discovering,
      CoordinatorColdStartPhase.loadingProfiles =>
        t.coordinator.coldStart.phases.loadingProfiles,
      CoordinatorColdStartPhase.loadingStats =>
        t.coordinator.coldStart.phases.loadingStats,
      CoordinatorColdStartPhase.checkingHealth =>
        t.coordinator.coldStart.phases.checkingHealth,
      CoordinatorColdStartPhase.finalizing =>
        t.coordinator.coldStart.phases.finalizing,
      CoordinatorColdStartPhase.completed =>
        t.coordinator.coldStart.phases.completed,
    };
  }

  String _recordLabel(
    Translations t,
    CoordinatorColdStartRecord record,
    CoordinatorColdStartPhase phase,
  ) {
    if (record.enabled) {
      return t.coordinator.coldStart.recordEnabled;
    }
    if (record.candidate && record.responsive == true) {
      return t.coordinator.coldStart.recordHealthyCandidate;
    }
    // Unknown responsiveness only counts as "checking" while the health phase
    // is live. Once it's over, an unresolved candidate is offline.
    if (record.candidate &&
        record.responsive == null &&
        phase == CoordinatorColdStartPhase.checkingHealth) {
      return t.coordinator.coldStart.recordChecking;
    }
    if (record.candidate) {
      return t.coordinator.coldStart.recordOfflineCandidate;
    }
    return t.coordinator.coldStart.recordDiscovered;
  }

  Widget _recordIcon(
    CoordinatorColdStartRecord record,
    CoordinatorColdStartPhase phase,
  ) {
    if (record.enabled) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 18);
    }
    // Spinner ONLY while the health phase is live and this candidate hasn't
    // resolved yet. In any later phase an unresolved candidate is offline, so
    // it can never spin forever.
    if (record.candidate &&
        record.responsive == null &&
        phase == CoordinatorColdStartPhase.checkingHealth) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    if (record.responsive == false ||
        (record.candidate && record.responsive == null)) {
      return const Icon(
        Icons.remove_circle_outline,
        color: Colors.redAccent,
        size: 18,
      );
    }
    return const Icon(Icons.visibility_outlined, color: Colors.grey, size: 18);
  }
}

class _ColdStartStatChip extends StatelessWidget {
  const _ColdStartStatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class AppScaffold extends ConsumerStatefulWidget {
  final Widget body;
  final String? pageTitle; // Optional page title
  final bool showBackButton; // Whether to show back button
  final bool hideBackButton; // Whether to explicitly hide back button

  const AppScaffold({
    super.key,
    required this.body,
    this.pageTitle,
    this.showBackButton = false,
    this.hideBackButton = false,
  });

  @override
  ConsumerState<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  String? _clientVersion;

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _clientVersion = info.version;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Shows the AltStore installation dialog for iOS web users
  // ignore: unused_element
  void _showAltStoreDialog(BuildContext context) {
    final t = Translations.of(context);
    bool showFallback = false;
    final useSharedBitblikIosApp = usesSharedBitblikIosApp;
    final altStoreAppName = buildAltStoreAppName;
    final sharedIosPaymentSystem = buildDefaultPaymentSystemId == 'mbway'
        ? 'MB WAY'
        : 'TWINT';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title with emoji
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      t.altstore.dialogTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('🫣', style: TextStyle(fontSize: 22)),
                  ],
                ),
                const SizedBox(height: 32),

                if (useSharedBitblikIosApp) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      t.altstore.approvalNotice(
                        app: buildAppName,
                        paymentSystem: sharedIosPaymentSystem,
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Step 1
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.altstore.step1Title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: _PlatformFreeLink(
                              uri: Uri.parse('https://altstore.io/download'),
                              openInNewTab: true,
                              builder: (context, followLink) => ElevatedButton(
                                onPressed: followLink,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE8F5E9),
                                  foregroundColor: Colors.black,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  t.altstore.step1Button,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            t.altstore.step1Warning,
                            style: const TextStyle(
                              color: Colors.pink,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Step 2
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.altstore.step2Title(app: altStoreAppName),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: _PlatformFreeLink(
                              uri: Uri.parse(
                                'altstore://source?url=$buildAltStoreSourceUrl',
                              ),
                              // builder:
                              //     (context, followLink) => InkWell(
                              //   onTap: () {
                              //     showFallback = true;
                              //     followLink?.call();
                              //   },
                              //   child: Image.asset(
                              //     'assets/apk.png',
                              //     width: 100,
                              //     height: 31,
                              //     fit: BoxFit.contain,
                              //   ),
                              // ),
                              //
                              builder: (context, followLink) => ElevatedButton(
                                onPressed: () {
                                  followLink?.call();
                                  Future.delayed(
                                    const Duration(milliseconds: 3000),
                                  ).then((_) {
                                    if (mounted) {
                                      setState(() {
                                        showFallback = true;
                                      });
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE3F2FD),
                                  foregroundColor: Colors.blue,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  t.altstore.step2Button(app: altStoreAppName),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Fallback: manual source URL (shown after button click)
                          if (showFallback) ...[
                            const SizedBox(height: 12),
                            Text(
                              t.altstore.step2Fallback,
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: buildAltStoreSourceUrl),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(t.common.clipboard.copied),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  buildAltStoreSourceUrl,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'monospace',
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Close button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    t.common.buttons.close,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNekoDrawer(
    BuildContext context,
    AsyncValue<String?> publicKeyAsync,
  ) {
    final t = Translations.of(context);
    return Drawer(
      child: publicKeyAsync.when(
        data: (publicKey) {
          if (publicKey == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No Neko found'),
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (kIsWeb) {
                          context.go(NekoManagementScreen.routeName);
                        } else {
                          context.push(NekoManagementScreen.routeName);
                        }
                      },
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                        imageUrl: 'https://robohash.org/$publicKey?set=set4',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (kIsWeb) {
                          context.go(NekoManagementScreen.routeName);
                        } else {
                          context.push(NekoManagementScreen.routeName);
                        }
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              t.nekoInfo.title,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.info_outline, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.flash_on, color: Color(0xFFFF0000)),
                title: Text(
                  t.landing.actions.payBlik(
                    code: ref
                        .read(selectedPaymentSystemProvider)
                        .localizedCodeLabel,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  if (kIsWeb) {
                    context.go("/create");
                  } else {
                    context.push("/create");
                  }
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/sell-blik.png',
                  width: 24,
                  height: 24,
                ),
                title: Text(t.landing.actions.sellBlik),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  if (kIsWeb) {
                    context.go("/offers");
                  } else {
                    context.push("/offers");
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.receipt_long),
                title: Text(t.myOffers.menuLabel),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  if (kIsWeb) {
                    context.go(MyOffersScreen.routeName);
                  } else {
                    context.push(MyOffersScreen.routeName);
                  }
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(t.settings.title),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  if (kIsWeb) {
                    context.go("/settings");
                  } else {
                    context.push("/settings");
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: Text(t.landing.actions.howItWorks),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  if (kIsWeb) {
                    context.go("/faq");
                  } else {
                    context.push("/faq");
                  }
                },
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error: ${error.toString()}'),
          ),
        ),
      ),
    );
  }

  Widget _buildRelayConnectivityIndicator() {
    final coordinatorRelays = ref.watch(coordinatorRelaysInUseProvider);
    final raw = ref.watch(relayConnectivityProvider);

    // No enabled coordinators → no coordinator relays in use. Show a single red
    // dot that navigates to coordinator management, instead of dumping every
    // NDK relay (NWC / discovery) into the bar.
    if (coordinatorRelays.isEmpty) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.push('/coordinators'),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Container(
              width: 13,
              height: 13,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );
    }

    // Coordinator relays known but NDK hasn't reported any of them yet → loading.
    final hasAnyInPool = raw.entries.any(
      (e) => coordinatorRelays.contains(normalizeRelayUrl(e.key)),
    );
    if (!hasAnyInPool) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.grey),
        ),
      );
    }

    // Dots, count, and the tap → status overlay are all handled by RelayDots,
    // which caps the visible dots so the AppBar doesn't crowd out other actions.
    return RelayDots(
      relays: coordinatorRelays,
      size: 8,
      showCount: true,
      overlayTitle: Translations.of(context).relays.coordinatorRelays,
    );
  }

  @override
  Widget build(BuildContext context) {
    final publicKeyAsync = ref.watch(publicKeyProvider);
    final appUpdateController = ref.watch(zapstoreAppUpdateControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    Widget appBarTitle;
    // bool canGoBack = GoRouter.of(context).canGoBack(); // Removed this line

    if (widget.pageTitle != null && widget.pageTitle!.isNotEmpty) {
      appBarTitle = Text(widget.pageTitle!);
    } else {
      final providerLogoAsset = ref
          .watch(selectedPaymentSystemProvider)
          .logoAsset;
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final logoAsset = switch ((providerLogoAsset, isDark)) {
        ('assets/bitway.png', true) => 'assets/bitway-dark.png',
        ('assets/bittwint.png', true) => 'assets/bittwint-dark.png',
        ('assets/veksli.png', true) => 'assets/veksli-dark.png',
        (final asset?, _) => asset,
        (null, true) => 'assets/logo-horizontal-dark.png',
        (null, false) => 'assets/logo-horizontal.png',
      };
      final needsLightAssetBacking = logoAsset == 'assets/bittwint.png';
      appBarTitle = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            // Reset relevant state providers (but keep active offer)
            ref.read(holdInvoiceProvider.notifier).state = null;
            ref.read(paymentHashProvider.notifier).state = null;
            ref.read(receivedBlikCodeProvider.notifier).state = null;
            ref.read(errorProvider.notifier).state = null;
            ref.read(isLoadingProvider.notifier).state = false;
            ref.invalidate(availableOffersProvider);

            // Navigate to home
            context.go('/');
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: needsLightAssetBacking ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: needsLightAssetBacking
                  ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
                  : EdgeInsets.zero,
              child: Image.asset(
                // BitBlik uses a dedicated dark-mode wordmark; opaque Bittwint
                // artwork keeps its light backing in both themes.
                logoAsset,
                height: providerLogoAsset != null ? 40 : 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        automaticallyImplyLeading:
            !widget.hideBackButton &&
            ((widget.pageTitle != null && widget.pageTitle!.isNotEmpty) ||
                widget.showBackButton),
        // Show back button if pageTitle is present or showBackButton is true, unless hideBackButton is true
        title: appBarTitle,
        // Add a divider at the bottom of the AppBar
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1.0, thickness: 1.0),
        ),
        actions: [
          // Relay Connectivity Indicator
          _buildRelayConnectivityIndicator(),
          // Language Switcher Dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<AppLocale>(
              value: LocaleSettings.currentLocale,
              icon: const SizedBox.shrink(),
              // Hide the dropdown arrow
              isDense: true,
              selectedItemBuilder: (BuildContext context) {
                // This controls what's shown when the dropdown is closed
                // Custom order: en, pl, it
                const orderedLocales = [
                  AppLocale.en,
                  AppLocale.pl,
                  AppLocale.it,
                  AppLocale.pt,
                  AppLocale.de,
                  AppLocale.fr,
                  AppLocale.sk,
                ];
                return orderedLocales.map<Widget>((AppLocale locale) {
                  return Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(minWidth: 48),
                    child: Image.asset(
                      'assets/lang-switcher.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.fitHeight,
                    ),
                  );
                }).toList();
              },
              onChanged: (AppLocale? newLocale) async {
                if (newLocale != null) {
                  await asyncPrefs.setString(
                    'app_locale',
                    newLocale.languageCode,
                  );
                  if (LocaleSettings.currentLocale.languageCode !=
                      newLocale.languageCode) {
                    LocaleSettings.setLocale(
                      AppLocaleUtils.parse(newLocale.languageCode),
                    );
                    if (mounted) {
                      setState(() {});
                    }
                  }
                }
              },
              // Custom order: en, pl, it
              items:
                  const [
                    AppLocale.en,
                    AppLocale.pl,
                    AppLocale.it,
                    AppLocale.pt,
                    AppLocale.de,
                    AppLocale.fr,
                    AppLocale.sk,
                  ].map<DropdownMenuItem<AppLocale>>((AppLocale locale) {
                    final String flagEmoji = locale.languageCode == 'en'
                        ? '🇬🇧'
                        : locale.languageCode == 'pl'
                        ? '🇵🇱'
                        : locale.languageCode == 'it'
                        ? '🇮🇹'
                        : locale.languageCode == 'pt'
                        ? '🇵🇹'
                        : locale.languageCode == 'de'
                        ? '🇩🇪'
                        : locale.languageCode == 'fr'
                        ? '🇫🇷'
                        : locale.languageCode == 'sk'
                        ? '🇸🇰'
                        : '';
                    final String displayName = locale.languageCode == 'en'
                        ? 'EN'
                        : locale.languageCode == 'pl'
                        ? 'PL'
                        : locale.languageCode == 'fr'
                        ? 'FR'
                        : locale.languageCode.toUpperCase();
                    return DropdownMenuItem<AppLocale>(
                      value: locale,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(flagEmoji, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              displayName,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
          // Neko icon - opens side menu
          publicKeyAsync.when(
            data: (publicKey) => publicKey != null
                ? Builder(
                    builder: (builderContext) => IconButton(
                      icon: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: 'https://robohash.org/$publicKey?set=set4',
                          placeholder: (context, url) => const SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, size: 24),
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ),
                      tooltip: t.nekoInfo.title,
                      onPressed: () {
                        Scaffold.of(builderContext).openEndDrawer();
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, error) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 625), // Adjust this value
          child: _buildBody(widget.body),
        ),
      ),
      endDrawer: _buildNekoDrawer(context, publicKeyAsync),
      bottomNavigationBar: SizedBox(
        // 8px outer padding + 8px divider + 48px icon row + 4px row padding.
        height: 68,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Divider(height: 8),

              // Version, GitHub link, and download buttons on the same line
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Version and GitHub link on the left
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: appUpdateController == null
                              ? Text(
                                  _clientVersion != null
                                      ? 'v$_clientVersion'
                                      : '',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                )
                              : NAppVersion(
                                  controller: appUpdateController,
                                  fallbackVersion: _clientVersion,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Download buttons on the right (only when on web)
                        if (kIsWeb)
                          Builder(
                            builder: (context) {
                              // Download links follow the build flavor (pinned at
                              // startup), not the user's runtime currency switch.
                              final isMbway =
                                  buildDefaultPaymentSystemId == 'mbway';
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // iOS AltStore install for every web flavor.
                                  InkWell(
                                    onTap: () async {
                                      final uri = Uri.parse(
                                        'altstore://source?url=$buildAltStoreSourceUrl',
                                      );
                                      try {
                                        await launchUrl(
                                          uri,
                                          mode: LaunchMode.platformDefault,
                                          webOnlyWindowName: '_self',
                                        );
                                        if (context.mounted) {
                                          _showAltStoreDialog(context);
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          _showAltStoreDialog(context);
                                        }
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/altstore.png',
                                      width: 80,
                                      height: 25,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Android GitHub APK button
                                  _PlatformFreeLink(
                                    uri: Uri.parse(
                                      isMbway
                                          ? 'https://github.com/bit-blik/bitway/releases'
                                          : buildDefaultPaymentSystemId ==
                                                'twint'
                                          ? 'https://github.com/bit-blik/bittwint/releases'
                                          : 'https://github.com/bit-blik/bitblik/releases',
                                    ),
                                    openInNewTab: true,
                                    builder: (context, followLink) => InkWell(
                                      onTap: followLink,
                                      child: Image.asset(
                                        'assets/apk.png',
                                        width: 80,
                                        height: 25,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Android Zapstore button
                                  _PlatformFreeLink(
                                    uri: Uri.parse(
                                      isMbway
                                          ? 'https://zapstore.dev/apps/me.bitway'
                                          : buildDefaultPaymentSystemId ==
                                                'twint'
                                          ? 'https://zapstore.dev/apps/app.bittwint'
                                          : 'https://zapstore.dev/apps/app.bitblik',
                                    ),
                                    builder: (context, followLink) => InkWell(
                                      onTap: followLink,
                                      child: Image.asset(
                                        'assets/zapstore.png',
                                        width: 80,
                                        height: 25,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              );
                            },
                          ),
                        IconButton(
                          constraints: const BoxConstraints.tightFor(
                            width: 48,
                            height: 48,
                          ),
                          tooltip:
                              Theme.of(context).brightness == Brightness.dark
                              ? t.theme.switchToLight
                              : t.theme.switchToDark,
                          onPressed: () async {
                            final next =
                                Theme.of(context).brightness == Brightness.dark
                                ? AppThemePreference.light
                                : AppThemePreference.dark;
                            await ref
                                .read(themePreferenceProvider.notifier)
                                .set(next);
                          },
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            child: Icon(
                              Theme.of(context).brightness == Brightness.dark
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              key: ValueKey(Theme.of(context).brightness),
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: IconButton(
                            constraints: const BoxConstraints.tightFor(
                              width: 48,
                              height: 48,
                            ),
                            padding: const EdgeInsets.all(4),
                            tooltip: t.theme.openNostr,
                            onPressed: () async {
                              final npub = ref
                                  .read(selectedPaymentSystemProvider)
                                  .discoveryNpub;
                              final url = Uri.parse('https://njump.to/$npub');
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            icon: Image.asset(
                              'assets/nostr.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(Widget directChild) {
    if (directChild is! RoleSelectionScreen) {
      return directChild;
    }
    return const RoleSelectionScreen();
  }
}

/// Wraps ndk_flutter's [ndk_l10n.AppLocalizations] delegate so it accepts any
/// locale: for a locale ndk doesn't translate (it ships en/es/fr/ja/ru/zh —
/// not sk), it loads its English strings instead of reporting the locale
/// unsupported, which otherwise triggers Flutter's "not supported by all of its
/// localization delegates" warning.
class _NdkLocalizationsFallbackDelegate
    extends LocalizationsDelegate<ndk_l10n.AppLocalizations> {
  const _NdkLocalizationsFallbackDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<ndk_l10n.AppLocalizations> load(Locale locale) {
    final supported = ndk_l10n.AppLocalizations.supportedLocales.any(
      (l) => l.languageCode == locale.languageCode,
    );
    return ndk_l10n.AppLocalizations.delegate.load(
      supported ? locale : const Locale('en'),
    );
  }

  @override
  bool shouldReload(_NdkLocalizationsFallbackDelegate old) => false;
}
