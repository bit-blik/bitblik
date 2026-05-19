import 'dart:async';
import 'dart:io' show Platform; // Import Platform

import 'package:app_links/app_links.dart';
import 'package:bitblik/src/screens/maker_flow/maker_confirm_payment_screen.dart';
import 'package:bitblik/src/screens/maker_flow/maker_invalid_blik_screen.dart';
import 'package:bitblik/src/screens/maker_flow/maker_pay_invoice_screen.dart';
import 'package:bitblik/src/screens/maker_flow/maker_success_screen.dart';
import 'package:bitblik/src/screens/maker_flow/maker_wait_for_blik_screen.dart';
import 'package:bitblik/src/screens/maker_flow/maker_wait_taker_screen.dart';
import 'package:bitblik/src/screens/taker_flow/taker_invalid_blik_screen.dart';
import 'package:bitblik/src/screens/taker_flow/taker_payment_failed_screen.dart';
import 'package:bitblik/src/screens/taker_flow/taker_payment_process_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, kDebugMode; // Import kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Keep for GlobalMaterialLocalizations.delegates
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/entities.dart';
import 'package:ndk_flutter/l10n/app_localizations.dart' as ndk_l10n;
import 'package:ndk/shared/logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter/services.dart'
    show rootBundle, Clipboard, ClipboardData;
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;

import 'i18n/gen/strings.g.dart'; // Import Slang from new path
import 'src/models/offer.dart'; // Needed for OfferStatus enum
import 'src/providers/providers.dart';
import 'src/screens/coordinator_management_screen.dart';
import 'src/screens/faq_screen.dart'; // Import the FAQ screen
import 'src/screens/maker_flow/maker_amount_form.dart';
import 'src/screens/maker_flow/maker_conflict_screen.dart'; // Import the maker conflict screen
import 'src/screens/neko_management_screen.dart';
import 'src/screens/offer_details_screen.dart';
import 'src/screens/offer_list_screen.dart';
import 'src/screens/role_selection_screen.dart';
import 'src/screens/settings_screen.dart';
import 'src/screens/taker_flow/taker_conflict_screen.dart'; // Import the taker conflict screen
import 'src/screens/taker_flow/taker_submit_blik_screen.dart';
import 'src/screens/taker_flow/taker_wait_confirmation_screen.dart';
import 'src/screens/wallet_screen.dart';
import 'src/utils/platform_detection.dart'; // Import our platform detection utility

final double kMakerFeePercentage = 0.5;
final double kTakerFeePercentage = 0.5;
final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
late AppLocale appLocale;

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
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
          GoRoute(
            path: '/wait-taker',
            builder: (context, state) => const MakerWaitTakerScreen(),
          ),
          GoRoute(
            path: '/wait-blik',
            builder: (context, state) => const MakerWaitForBlikScreen(),
          ),
          GoRoute(
            path: '/confirm-blik',
            builder: (context, state) => const MakerConfirmPaymentScreen(),
          ),
          GoRoute(
            path: '/maker-success',
            builder: (context, state) {
              if (state.extra == null) {
                context.go("/");
                return Container();
              } else {
                return MakerSuccessScreen(completedOffer: state.extra as Offer);
              }
            },
          ),
          GoRoute(
            path: '/coordinators',
            builder: (context, state) => const CoordinatorManagementScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: '/wallet',
            builder: (context, state) => const WalletScreen(),
          ),
          GoRoute(
            path: '/neko-management',
            builder: (context, state) => const NekoManagementScreen(),
          ),
          GoRoute(
            path: '/submit-blik',
            builder: (context, state) {
              if (state.extra == null) {
                context.go("/");
                return Container();
              } else {
                return TakerSubmitBlikScreen(
                  initialOffer: state.extra as Offer,
                );
              }
            },
          ),
          GoRoute(
            path: '/wait-confirmation',
            builder: (context, state) {
              if (state.extra == null) {
                context.go("/");
                return Container();
              } else {
                return TakerWaitConfirmationScreen(offer: state.extra as Offer);
              }
            },
          ),
          GoRoute(
            path: '/taker-failed',
            builder: (context, state) {
              if (state.extra == null) {
                context.go("/");
                return Container();
              } else {
                return TakerPaymentFailedScreen(offer: state.extra as Offer);
              }
            },
          ),
          GoRoute(
            path: '/paying-taker',
            builder: (context, state) => TakerPaymentProcessScreen(),
          ),
          GoRoute(
            path: '/taker-invalid-blik',
            builder: (context, state) {
              if (state.extra == null) {
                context.go("/");
                return Container();
              } else {
                return TakerInvalidBlikScreen(offer: state.extra as Offer);
              }
            },
          ),
          GoRoute(
            path: '/taker-conflict',
            builder:
                (context, state) =>
                    TakerConflictScreen(offerId: state.extra as String),
          ),
          GoRoute(
            path: '/maker-invalid-blik',
            builder: (context, state) {
              if (state.extra == null) {
                context.go("/");
                return Container();
              } else {
                return MakerInvalidBlikScreen(offer: state.extra as Offer);
              }
            },
          ),
          GoRoute(
            path: '/maker-conflict',
            builder: (context, state) {
              if (state.extra == null) {
                context.go("/");
                return Container();
              } else {
                return MakerConflictScreen(offer: state.extra as Offer);
              }
            },
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
  String? localeString = await asyncPrefs.getString('app_locale');
  if (localeString != null) {
    appLocale = localeString == 'pl' ? AppLocale.pl : AppLocale.en;
  } else {
    appLocale = AppLocaleUtils.findDeviceLocale();
  }
  LocaleSettings.setLocale(appLocale);
  runApp(
    TranslationProvider(
      // Wrap with TranslationProvider
      child: const ProviderScope(child: SafeArea(child: MyApp())),
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
  final AppLinks _appLinks = AppLinks();
  bool _routerReady = false;
  String? _pendingRouteNavigation;
  final List<Uri> _pendingDeepLinks = [];
  AppLifecycleState? _appLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appLifecycleState = WidgetsBinding.instance.lifecycleState;
    try {
      ref.read(keyServiceProvider);
      ref.read(apiServiceProvider);

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
        // Trigger coordinator discovery
        ref.watch(discoveredCoordinatorsProvider);

        // Initialize the offer status subscription manager
        ref.read(offerStatusSubscriptionManagerProvider);

        // Initialize app lifecycle provider (reconnects NDK when app resumes)
        ref.read(appLifecycleProvider);

        // Warm up wallets (especially NWC) in background regardless of route.
        ref.read(walletWarmupProvider);

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

  Future<void> _handleDeepLink(Uri uri) async {
    if (!_routerReady) {
      _pendingDeepLinks.add(uri);
      return;
    }

    final router = ref.read(routerProvider);
    final scheme = uri.scheme.toLowerCase();

    Logger.log.i(() => '🔗 Deep link received: $uri (scheme: $scheme)');

    // Handle nostr+walletconnect:// scheme (NWC connection)
    if (scheme == 'nostr+walletconnect') {
      await _handleNwcDeepLink(uri.toString());
      return;
    }
    // Handle bitblik:// scheme
    if (scheme == 'bitblik') {
      // Check if it's an NWC connection string passed via bitblik scheme
      final path = uri.host + uri.path;
      if (path.startsWith('value') ||
          uri.queryParameters.containsKey('value')) {
        final nwcString = uri.queryParameters['value'];
        if (nwcString != null) {
          await _handleNwcDeepLink(nwcString);
        }
        return;
      }
      if (path.endsWith('nwc-callback')) {
        _openPostNwcConnectionRoute();
        ref.read(walletProtocolDispatcherProvider).dispatch(uri.toString());
        return;
      }

      // Handle other bitblik:// paths
      if (path == 'offers' || path == '/offers') {
        router.push('/offers');
        return;
      }
    }

    // Handle https://bitblik.app deep links
    if (scheme == 'https') {
      final path = uri.path;
      final fragment = uri.fragment;
      if (path == '/offers' || fragment == '/offers') {
        router.push('/offers');
      }
    }
  }

  void _openPostNwcConnectionRoute() {
    final activeOffer = ref.read(activeOfferProvider);

    if (activeOffer != null && activeOffer.status == OfferStatus.created.name) {
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

  /// Handle NWC deep link: connect wallet and navigate based on active offer status
  Future<void> _handleNwcDeepLink(String connectionString) async {
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

      final nwcWallet = NwcWallet(
        id: kNwcWalletId,
        name: 'NWC Wallet',
        supportedUnits: {'sat'},
        nwcUrl: connectionString.trim(),
      );

      await ndk.wallets.addWallet(nwcWallet);
      ndk.wallets.setDefaultWallet(kNwcWalletId);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final t = Translations.of(context);

    return MaterialApp.router(
      title: t.app.title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      locale: LocaleSettings.currentLocale.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        ndk_l10n.AppLocalizations.delegate,
      ],
      routerConfig: router,
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

  /// Shows the changelog in a dialog with rendered markdown
  Future<void> _showChangelogDialog(BuildContext context) async {
    final t = Translations.of(context);
    try {
      final changelogContent = await rootBundle.loadString('CHANGELOG.md');
      if (!context.mounted) return;

      // Convert Markdown to HTML
      final htmlContent = md.markdownToHtml(
        changelogContent,
        inlineSyntaxes: [md.InlineHtmlSyntax()],
      );

      showDialog(
        context: context,
        builder:
            (context) => Dialog(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  maxHeight: 600,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            t.app.changelog,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Html(
                          data: htmlContent,
                          onLinkTap: (url, attributes, element) async {
                            if (url != null) {
                              await launchUrl(Uri.parse(url));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      );
    } catch (e) {
      Logger.log.e(() => 'Error loading changelog: $e');
    }
  }

  /// Shows the AltStore installation dialog for iOS web users
  void _showAltStoreDialog(BuildContext context) {
    final t = Translations.of(context);
    bool showFallback = false;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => Dialog(
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
                                    child: Link(
                                      uri: Uri.parse(
                                        'https://altstore.io/download',
                                      ),
                                      target: LinkTarget.blank,
                                      builder:
                                          (
                                            context,
                                            followLink,
                                          ) => ElevatedButton(
                                            onPressed: followLink,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFFE8F5E9,
                                              ),
                                              foregroundColor: Colors.black,
                                              elevation: 0,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24),
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
                                    t.altstore.step2Title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Link(
                                      uri: Uri.parse(
                                        'altstore://source?url=https://bitblik.app/.well-known/sources/alt-store-source.json',
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
                                      builder:
                                          (
                                            context,
                                            followLink,
                                          ) => ElevatedButton(
                                            onPressed: () {
                                              followLink?.call();
                                              Future.delayed(
                                                const Duration(
                                                  milliseconds: 3000,
                                                ),
                                              ).then((_) {
                                                if (mounted) {
                                                  setState(() {
                                                    showFallback = true;
                                                  });
                                                }
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFFE3F2FD,
                                              ),
                                              foregroundColor: Colors.blue,
                                              elevation: 0,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                            ),
                                            child: Text(
                                              t.altstore.step2Button,
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
                                          const ClipboardData(
                                            text:
                                                'https://bitblik.app/.well-known/sources/alt-store-source.json',
                                          ),
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              t.common.clipboard.copied,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          'bitblik.app/.well-known/sources/alt-store-source.json',
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
      backgroundColor: Colors.white,
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
                decoration: const BoxDecoration(color: Colors.white),
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
                        placeholder:
                            (context, url) => const CircularProgressIndicator(),
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
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
                title: Text(t.landing.actions.payBlik),
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
            ],
          );
        },
        loading:
            () => const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            ),
        error:
            (error, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Error: ${error.toString()}'),
              ),
            ),
      ),
    );
  }

  /// Get the color for a relay connection state
  Color _getStateColor(RelayConnectionState state) {
    switch (state) {
      case RelayConnectionState.connected:
        return Colors.green;
      case RelayConnectionState.connecting:
        return Colors.blue;
      case RelayConnectionState.reconnecting:
        return Colors.orange;
      case RelayConnectionState.disconnected:
        return Colors.red;
    }
  }

  /// Get the state name for tooltip (i18n)
  String _getStateName(RelayConnectionState state, Translations t) {
    switch (state) {
      case RelayConnectionState.connected:
        return t.relays.status.connected;
      case RelayConnectionState.connecting:
        return t.relays.status.connecting;
      case RelayConnectionState.reconnecting:
        return t.relays.status.reconnecting;
      case RelayConnectionState.disconnected:
        return t.relays.status.disconnected;
    }
  }

  /// Shows the relay status popup when tapped
  void _showRelayStatusPopup(
    BuildContext context,
    Map<String, RelayStatus> relays,
  ) {
    final t = Translations.of(context);
    final connectedCount = relays.values.where((r) => r.isConnected).length;
    final totalCount = relays.length;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (dialogContext) {
        return Stack(
          children: [
            // Invisible barrier that closes the dialog when tapped
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(dialogContext).pop(),
                child: Container(color: Colors.transparent),
              ),
            ),
            // The popup positioned near the top right
            Positioned(
              top: kToolbarHeight + MediaQuery.of(context).padding.top + 8,
              right: 16,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.relays.popup.title(
                          connected: connectedCount.toString(),
                          total: totalCount.toString(),
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...relays.entries.map((e) {
                        final shortUrl = e.key
                            .replaceFirst('wss://', '')
                            .replaceFirst('ws://', '');
                        final stateColor = _getStateColor(e.value.state);
                        final stateName = _getStateName(e.value.state, t);
                        final isConnecting =
                            e.value.state == RelayConnectionState.connecting ||
                            e.value.state == RelayConnectionState.reconnecting;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isConnecting)
                                SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: stateColor,
                                  ),
                                )
                              else
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: stateColor,
                                  ),
                                ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  shortUrl,
                                  style: const TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                stateName,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: stateColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRelayConnectivityIndicator() {
    final relays = ref.watch(relayConnectivityProvider);

    if (relays.isEmpty) {
      // No relay data yet, show loading/unknown state
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.grey),
        ),
      );
    }

    final connectedCount = relays.values.where((r) => r.isConnected).length;
    final totalCount = relays.length;
    final allConnected = connectedCount == totalCount;
    final someConnected = connectedCount > 0;

    // Determine overall icon color based on connectivity
    final Color overallColor;
    if (allConnected) {
      overallColor = Colors.green;
    } else if (someConnected) {
      overallColor = Colors.orange;
    } else {
      overallColor = Colors.red;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _showRelayStatusPopup(context, relays),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Show individual state indicators for each relay
              ...relays.entries.map((e) {
                final stateColor = _getStateColor(e.value.state);
                final isConnecting =
                    e.value.state == RelayConnectionState.connecting ||
                    e.value.state == RelayConnectionState.reconnecting;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child:
                      isConnecting
                          ? SizedBox(
                            width: 8,
                            height: 8,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: stateColor,
                            ),
                          )
                          : Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: stateColor,
                            ),
                          ),
                );
              }),
              const SizedBox(width: 4),
              Text(
                '$connectedCount/$totalCount',
                style: TextStyle(
                  fontSize: 11,
                  color: overallColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final publicKeyAsync = ref.watch(publicKeyProvider);

    Widget appBarTitle;
    // bool canGoBack = GoRouter.of(context).canGoBack(); // Removed this line

    if (widget.pageTitle != null && widget.pageTitle!.isNotEmpty) {
      appBarTitle = Text(widget.pageTitle!);
    } else {
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
          child: Image.asset(
            'assets/logo-horizontal.png',
            height: 30,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  ].map<DropdownMenuItem<AppLocale>>((AppLocale locale) {
                    final String flagEmoji =
                        locale.languageCode == 'en'
                            ? '🇬🇧'
                            : locale.languageCode == 'pl'
                            ? '🇵🇱'
                            : locale.languageCode == 'it'
                            ? '🇮🇹'
                            : '';
                    final String displayName =
                        locale.languageCode == 'en'
                            ? 'EN'
                            : locale.languageCode == 'pl'
                            ? 'PL'
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
            data:
                (publicKey) =>
                    publicKey != null
                        ? Builder(
                          builder:
                              (builderContext) => IconButton(
                                icon: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://robohash.org/$publicKey?set=set4',
                                    placeholder:
                                        (context, url) => const SizedBox(
                                          width: 32,
                                          height: 32,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
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
            error: (_, __) => const SizedBox.shrink(),
          ),
          kDebugMode ? SizedBox(width: 40) : Container(),
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
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Divider(),

              // Version, GitHub link, and download buttons on the same line
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
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
                          child: InkWell(
                            onTap: () => _showChangelogDialog(context),
                            child: Text(
                              _clientVersion != null ? 'v$_clientVersion' : '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // InkWell(
                        //   onTap: () async {
                        //     final Uri url = Uri.parse('https://github.com/bit-blik/client');
                        //     await launchUrl(url, mode: LaunchMode.externalApplication);
                        //   },
                        //   child: Image.asset('assets/github.png', width: 20, height: 20),
                        // ),
                        // const SizedBox(width: 8),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse(
                              'https://njump.to/npub1k3g092rlzvn7nftz3jte9pkx63zp705nh78r6hjpjm55fjg7r2cqx8stj3',
                            );
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Image.asset(
                            'assets/nostr.png',
                            width: 36,
                            height: 36,
                          ),
                        ),
                      ],
                    ),
                    // Download buttons on the right (only when on web)
                    if (kIsWeb)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // iOS section with icon, text, and AltStore button
                          InkWell(
                            onTap: () async {
                              final uri = Uri.parse(
                                'altstore://source?url=https://bitblik.app/.well-known/sources/alt-store-source.json',
                              );

                              try {
                                // Try to launch with externalNonBrowserApplication mode
                                // This prevents opening in Safari and only tries to open the app
                                await launchUrl(
                                  uri,
                                  // mode: LaunchMode.externalNonBrowserApplication,
                                  mode: LaunchMode.platformDefault,
                                  webOnlyWindowName: '_self',
                                );

                                // If launch failed or always show dialog
                                if (context.mounted) {
                                  _showAltStoreDialog(context);
                                }
                              } catch (e) {
                                // If the URL scheme is not supported, show the dialog
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
                          Link(
                            uri: Uri.parse(
                              'https://github.com/bit-blik/client/releases',
                            ),
                            target: LinkTarget.blank,
                            builder:
                                (context, followLink) => InkWell(
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
                          Link(
                            uri: Uri.parse('zapstore://app.bitblik'),
                            builder:
                                (context, followLink) => InkWell(
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

  // Body builder that handles both direct routes and role-based content
  Widget _buildBody(Widget directChild) {
    if (directChild is! RoleSelectionScreen) {
      return directChild;
    }
    return const RoleSelectionScreen();
  }
}
