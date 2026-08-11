// RoleSelectionScreen: Modern landing page with centralized design matching the provided layout
import 'package:bitblik/src/utils/code_label_ext.dart';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../i18n/gen/strings.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:bitblik_core/core.dart'; // Import Offer model
import '../providers/providers.dart';
import '../services/key_service.dart';
import '../services/offer_db_service.dart';
import '../widgets/offer_list_tile.dart';

class RoleSelectionScreen extends ConsumerStatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  ConsumerState<RoleSelectionScreen> createState() =>
      _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends ConsumerState<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  bool _isSyncing = false;
  bool _hasTriggeredInitialSync = false;
  bool _bffDismissed = false;
  AnimationController? _logoController;

  static const _kBffDismissedKey = 'bff_banner_dismissed';

  bool _userParticipatesInOffer(Offer offer, String? pubkey) {
    return pubkey != null &&
        (offer.makerPubkey == pubkey || offer.takerPubkey == pubkey);
  }

  @override
  void initState() {
    super.initState();
    Logger.log.d(() => '[RoleSelectionScreen] initState called');
    if (_isBffActive()) {
      _logoController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      )..repeat();
      _loadBffDismissed();
    }
  }

  Future<void> _loadBffDismissed() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _bffDismissed = prefs.getBool(_kBffDismissedKey) ?? false;
      });
    }
  }

  Future<void> _dismissBffBanner() async {
    setState(() => _bffDismissed = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kBffDismissedKey, true);
  }

  @override
  void dispose() {
    _logoController?.dispose();
    super.dispose();
  }

  /// Syncs the local active offer state with the coordinator's state
  Future<void> _syncActiveOfferWithCoordinator() async {
    Logger.log.d(
      () => '[RoleSelectionScreen] _syncActiveOfferWithCoordinator called',
    );

    if (_isSyncing) {
      Logger.log.d(() => '[RoleSelectionScreen] Already syncing, skipping');
      return;
    }

    final activeOffer = ref.read(activeOfferProvider);
    String? publicKey;
    try {
      publicKey = await ref.read(publicKeyProvider.future);
    } catch (e) {
      Logger.log.w(
        () =>
            '[RoleSelectionScreen] Unable to load public key for initial sync: $e',
      );
      return;
    }

    Logger.log.d(
      () =>
          '[RoleSelectionScreen] activeOffer: ${activeOffer?.id}, publicKey: ${publicKey?.substring(0, 8)}...',
    );

    // Only sync if we have an active offer and a public key
    if (activeOffer == null) {
      Logger.log.d(
        () => '[RoleSelectionScreen] No active offer, skipping sync',
      );
      return;
    }

    if (publicKey == null) {
      Logger.log.d(() => '[RoleSelectionScreen] No public key, skipping sync');
      return;
    }

    // Skip sync for offers with 'created' status - they only exist locally
    if (activeOffer.status == OfferStatus.created) {
      Logger.log.d(
        () =>
            '[RoleSelectionScreen] Offer has created status, skipping coordinator sync',
      );
      return;
    }

    // Mark that we're doing the sync
    _hasTriggeredInitialSync = true;

    setState(() {
      _isSyncing = true;
    });

    try {
      Logger.log.i(
        () =>
            '[RoleSelectionScreen] Fetching offer details from coordinator for offer ${activeOffer.id}',
      );
      final apiService = ref.read(apiServiceProvider);
      final fetchedOffer = await apiService.getOfferDetails(
        activeOffer,
        activeOffer.coordinatorPubkey,
      );
      Logger.log.d(
        () =>
            '[RoleSelectionScreen] Fetched offer result: ${fetchedOffer != null ? "found" : "null"}',
      );

      final fetchedOfferObj =
          fetchedOffer != null ? Offer.fromJson(fetchedOffer) : null;
      if (fetchedOfferObj == null) {
        Logger.log.i(
          () =>
              '[RoleSelectionScreen] No active offer found on coordinator. Clearing local active offer.',
        );
        await OfferDbService().deleteOfferById(activeOffer.id);
        await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
        return;
      }
      if (!_userParticipatesInOffer(fetchedOfferObj, publicKey)) {
        Logger.log.i(
          () =>
              '[RoleSelectionScreen] Coordinator offer ${fetchedOfferObj.id} no longer belongs to current user. Removing stale local active offer.',
        );
        await OfferDbService().deleteOfferById(activeOffer.id);
        await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
        return;
      }
      if (fetchedOfferObj.statusEnum == OfferStatus.takerPaid ||
          fetchedOfferObj.statusEnum == OfferStatus.expired ||
          fetchedOfferObj.statusEnum == OfferStatus.cancelled ||
          fetchedOfferObj.id != activeOffer.id) {
        // Coordinator says no active offer, or taker has paid - clear local state
        Logger.log.i(
          () =>
              '[RoleSelectionScreen] No active offer on coordinator or taker has paid. Clearing local active offer.',
        );
        await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
      } else {
        // Check if the status differs
        if (fetchedOfferObj.status != activeOffer.status ||
            fetchedOfferObj.takerFees != activeOffer.takerFees ||
            fetchedOfferObj.makerFees != activeOffer.makerFees) {
          Logger.log.i(
            () =>
                '[RoleSelectionScreen] Offer status mismatch. Local: ${activeOffer.status}, Coordinator: ${fetchedOfferObj.status}. Updating local state.',
          );

          // Update local state to match coordinator
          await ref
              .read(activeOfferProvider.notifier)
              .setActiveOffer(fetchedOfferObj);
        } else {
          Logger.log.d(
            () =>
                '[RoleSelectionScreen] Offer status in sync: ${activeOffer.status}',
          );
        }
      }
    } catch (e) {
      Logger.log.e(
        () =>
            '[RoleSelectionScreen] Error syncing active offer with coordinator: $e',
      );
      // Don't show error to user - this is a background sync operation
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
      }
    }
  }

  // Every market is flow-driven: resume into the single flow screen, which
  // renders the body for the offer's current state + role.
  void _resumeIntoFlow(BuildContext context, Offer offer) {
    ref.read(activeOfferProvider.notifier).setActiveOffer(offer);
    context.go('/flow');
  }

  @override
  Widget build(BuildContext context) {
    final activeOffer = ref.watch(activeOfferProvider);
    final publicKeyAsync = ref.watch(publicKeyProvider);
    ref.watch(lightningAddressProvider);
    final t = Translations.of(context);

    // Listen for when activeOffer becomes available and trigger sync
    ref.listen<Offer?>(activeOfferProvider, (previous, current) {
      Logger.log.d(
        () =>
            '[RoleSelectionScreen] activeOfferProvider changed: previous=${previous?.id}, current=${current?.id}',
      );
      if (current != null && !_hasTriggeredInitialSync && !_isSyncing) {
        Logger.log.d(
          () =>
              '[RoleSelectionScreen] Active offer loaded: ${current.id}, triggering sync',
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _syncActiveOfferWithCoordinator();
          }
        });
      }
    });

    if (publicKeyAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (publicKeyAsync.hasError) {
      return _buildInitializationErrorState(context, publicKeyAsync.error!, t);
    }

    final currentPubKey = publicKeyAsync.valueOrNull;
    bool hasActiveOffer =
        activeOffer != null &&
        currentPubKey != null &&
        (activeOffer.statusEnum != OfferStatus.expired) &&
        (activeOffer.statusEnum != OfferStatus.cancelled);
    final isTakerPaid =
        hasActiveOffer && activeOffer.status == OfferStatus.takerPaid;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Main content area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: hasActiveOffer ? 40 : 80),

                // Main title
                Text(
                  t.landing.mainTitle(
                    code:
                        ref
                            .watch(selectedPaymentSystemProvider)
                            .localizedCodeLabel,
                  ),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: MediaQuery.of(context).size.width > 600 ? 48 : 32,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Subtitle
                Text(
                  t.landing.subtitle(
                    code:
                        ref
                            .watch(selectedPaymentSystemProvider)
                            .localizedCodeLabel,
                  ),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: hasActiveOffer ? 40 : 100),

                if (hasActiveOffer && !isTakerPaid) ...[
                  _buildActiveOfferSection(
                    context,
                    ref,
                    activeOffer,
                    currentPubKey,
                    t,
                  ),
                  const SizedBox(height: 32),
                ],

                // Action cards
                Builder(
                  builder: (context) {
                    final cardHeight =
                        220.0; //screenWidth > 600 ? 200.0 : 180.0; // Responsive height

                    return Row(
                      children: [
                        // Pay BLIK card (gradient)
                        Expanded(
                          child: SizedBox(
                            height: cardHeight,
                            child: _buildActionCard(
                              context: context,
                              title: t.landing.actions.payBlik(
                                code:
                                    ref
                                        .watch(selectedPaymentSystemProvider)
                                        .localizedCodeLabel,
                              ),
                              subtitle: t.landing.actions.payBlikSubtitle,
                              icon: Icons.flash_on,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFFF0000), // Bright red/pink
                                  Color(0xFFFF007F), // Bright magenta/pink
                                ],
                              ),
                              textColor: Colors.white,
                              onTap: () {
                                if (kIsWeb) {
                                  context.go("/create");
                                } else {
                                  context.push("/create");
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Sell BLIK card (white)
                        Expanded(
                          child: SizedBox(
                            height: cardHeight,
                            child: _buildActionCard(
                              context: context,
                              title: t.landing.actions.sellBlik,
                              subtitle: t.landing.actions.sellBlikSubtitle(
                                code:
                                    ref
                                        .watch(selectedPaymentSystemProvider)
                                        .localizedCodeLabel,
                              ),
                              iconImage: 'assets/sell-blik.png',
                              backgroundColor: Colors.white,
                              textColor: const Color(0xFF000000),
                              borderColor: Colors.grey[300],
                              onTap: () {
                                if (kIsWeb) {
                                  context.go("/offers");
                                } else {
                                  context.push("/offers");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                // FAQ link
                TextButton(
                  onPressed: () {
                    if (kIsWeb) {
                      context.go("/faq");
                    } else {
                      context.push("/faq");
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.help_outline,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        t.landing.actions.howItWorks,
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isBffActive() && !_bffDismissed) ...[
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    t.landing.partnership,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3, bottom: 3),
                  child: GestureDetector(
                    onTap: _dismissBffBanner,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.close,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _buildMovieStripSeparator(),
            _buildBffBanner(),
            _buildMovieStripSeparator(),
          ],
        ],
      ),
    );
  }

  Widget _buildInitializationErrorState(
    BuildContext context,
    Object error,
    Translations t,
  ) {
    final message =
        error is KeyServiceInitializationException
            ? error.message
            : error.toString();

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 48,
                    color: Color(0xFFFF007F),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.wallet.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      ref.invalidate(publicKeyProvider);
                      ref.invalidate(lightningAddressProvider);
                      ref.invalidate(initializedApiServiceProvider);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    IconData? icon,
    String? iconImage,
    Color? backgroundColor,
    Gradient? gradient,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: gradient == null ? backgroundColor : null,
            gradient: gradient,
            border: borderColor != null ? Border.all(color: borderColor) : null,
          ),
          padding: const EdgeInsets.all(16), // Reduced from 24 to 16
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Added to prevent overflow
            children: [
              if (iconImage != null)
                Image.asset(
                  iconImage,
                  width: 44,
                  height: 44,
                  fit: BoxFit.contain,
                )
              else if (icon != null)
                Icon(
                  icon,
                  size: 44, // Reduced from 48 to 40
                  color: textColor,
                ),
              const SizedBox(height: 14), // Reduced from 16 to 12
              Flexible(
                // Wrapped title in Flexible
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22, // Reduced from 24 to 20
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2, // Added max lines to prevent overflow
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2), // Reduced from 4 to 2
              Flexible(
                // Wrapped subtitle in Flexible
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14, // Reduced from 16 to 14
                    color: textColor.withValues(alpha: 0.8),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2, // Added max lines to prevent overflow
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveOfferSection(
    BuildContext context,
    WidgetRef ref,
    Offer activeOffer,
    String? currentPubKey,
    Translations t,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.offers.details.activeOffer,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          child: OfferListTile(
            offer: activeOffer,
            showPremium: true,
            onTap:
                activeOffer.status == OfferStatus.takerPaid
                    ? () {}
                    : () => _handleActiveOfferTap(
                      context,
                      ref,
                      activeOffer,
                      currentPubKey,
                      t,
                    ),
          ),
        ),
      ],
    );
  }

  void _handleActiveOfferTap(
    BuildContext context,
    WidgetRef ref,
    Offer activeOffer,
    String? currentPubKey,
    Translations t,
  ) {
    if (activeOffer.holdInvoicePaymentHash != null) {
      ref.read(paymentHashProvider.notifier).state =
          activeOffer.holdInvoicePaymentHash!;
    }

    if (currentPubKey == activeOffer.makerPubkey ||
        currentPubKey == activeOffer.takerPubkey) {
      _resumeIntoFlow(context, activeOffer);
    }
  }

  bool _isBffActive() {
    return false;
    // final now = DateTime.now();
    // final start = DateTime(2026, 5, 31);
    // final end = DateTime(2026, 6, 13, 23, 59, 59);
    // return now.isAfter(start) && now.isBefore(end);
  }

  Widget _buildMovieStripSeparator() {
    return SizedBox(
      height: 22,
      width: double.infinity,
      child: CustomPaint(
        painter: _FilmStripPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }

  Widget _buildBffBanner() {
    return GestureDetector(
      onTap: () async {
        await launchUrl(
          Uri.parse('https://bitcoinfilmfest.com/?ref=bitblikapp'),
          mode: LaunchMode.externalApplication,
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                'assets/bff-rabbit.png',
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            Flexible(
              child: Image.asset(
                'assets/bff-laurs.png',
                height: 64,
                fit: BoxFit.contain,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: AnimatedBuilder(
                  animation: _logoController ?? const AlwaysStoppedAnimation(0),
                  builder: (context, child) {
                    final t = _logoController?.value ?? 0.0;
                    final angle = sin(t * 2 * pi) * 0.5;
                    return Transform.rotate(angle: angle, child: child);
                  },
                  child: Image.asset(
                    'assets/bff-logo.png',
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDouble(double value) {
    // Check if the value is effectively a whole number
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    } else {
      // Format with up to 2 decimal places, removing trailing zeros
      String asString = value.toStringAsFixed(2);
      // Remove trailing zeros after decimal point
      if (asString.contains('.')) {
        asString = asString.replaceAll(RegExp(r'0+$'), '');
        // Remove decimal point if it's the last character
        if (asString.endsWith('.')) {
          asString = asString.substring(0, asString.length - 1);
        }
      }
      return asString;
    }
  }
}

class _FilmStripPainter extends CustomPainter {
  static const _blue = Color(0xFF33B9FD);
  static const _holeW = 10.0;
  static const _holeH = 14.0;
  static const _gap = 7.0;
  static const _radius = Radius.circular(2);

  @override
  void paint(Canvas canvas, Size size) {
    // Black background
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black);

    final holePaint = Paint()..color = _blue;
    final vPad = (size.height - _holeH) / 2;
    final unit = _holeW + _gap;
    final count = (size.width / unit).ceil() + 1;

    for (int i = 0; i < count; i++) {
      final x = _gap / 2 + i * unit;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, vPad, _holeW, _holeH),
          _radius,
        ),
        holePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
