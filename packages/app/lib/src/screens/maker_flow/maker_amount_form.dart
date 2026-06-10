import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../i18n/gen/strings.g.dart';
import 'package:bitblik_core/core.dart';
import '../../config/build_flavor.dart';
import '../../providers/providers.dart';
import '../../services/api_service_nostr.dart';
import '../../settings/app_preferences.dart';
import '../coordinator_details_screen.dart';
// CoordinatorRecord comes from bitblik_core

// Progress indicator widget for maker flow
class MakerProgressIndicator extends ConsumerWidget {
  final int activeStep; // 1, 2, or 3

  const MakerProgressIndicator({super.key, this.activeStep = 1});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final code = ref.watch(selectedPaymentSystemProvider).codeLabel;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          // Step 1: Create Offer
          Text(
            t.maker.amountForm.progress.step1,
            style: TextStyle(
              fontSize: 13,
              fontWeight: activeStep >= 1 ? FontWeight.w500 : FontWeight.w400,
              color: activeStep == 1 ? Colors.black : Colors.grey,
            ),
          ),
          const Text('>', style: TextStyle(fontSize: 14, color: Colors.grey)),
          // Step 2: Wait for Taker
          Text(
            t.maker.amountForm.progress.step2,
            style: TextStyle(
              fontSize: 13,
              fontWeight: activeStep >= 2 ? FontWeight.w500 : FontWeight.w400,
              color: activeStep == 2 ? Colors.black : Colors.grey,
            ),
          ),
          const Text('>', style: TextStyle(fontSize: 14, color: Colors.grey)),
          // Step 3: Use BLIK
          Text(
            t.maker.amountForm.progress.step3(code: code),
            style: TextStyle(
              fontSize: 13,
              fontWeight: activeStep == 3 ? FontWeight.w500 : FontWeight.w400,
              color: activeStep >= 3 ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingBeakPainter extends CustomPainter {
  const _OnboardingBeakPainter({
    required this.color,
    required this.shadowColor,
  });

  final Color color;
  final Color shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final shadowPath =
        Path()
          ..moveTo(size.width * 0.5, 0)
          ..lineTo(0, size.height)
          ..lineTo(size.width, size.height)
          ..close();
    canvas.drawShadow(shadowPath, shadowColor, 2, false);

    final fillPath =
        Path()
          ..moveTo(size.width * 0.5, 0)
          ..lineTo(size.width * 0.15, size.height)
          ..lineTo(size.width * 0.85, size.height)
          ..close();
    final paint = Paint()..color = color;
    canvas.drawPath(fillPath, paint);
  }

  @override
  bool shouldRepaint(covariant _OnboardingBeakPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.shadowColor != shadowColor;
  }
}

class MakerAmountForm extends ConsumerStatefulWidget {
  const MakerAmountForm({super.key});

  @override
  ConsumerState<MakerAmountForm> createState() => _MakerAmountFormState();
}

class _MakerAmountFormState extends ConsumerState<MakerAmountForm> {
  /// Active payment method chosen by the user; drives the offer currency and
  /// the fiat exchange-rate lookup.
  PaymentSystem get _method => ref.read(selectedPaymentSystemProvider);

  static const _categoryOnboardingDismissedKey =
      'maker_category_onboarding_dismissed';
  static final _categoryOnboardingNewCutoff = DateTime(2026, 10, 1);

  final _fiatController = TextEditingController();
  final _amountFocusNode = FocusNode(); // Add FocusNode for amount input
  double? _satsEquivalent;
  double? _rate;
  String? _amountErrorText;

  bool _isLoadingInitialData = true;
  String? _coordinatorInfoError;

  String? _selectedCoordinatorPubkey; // Remember selected coordinator pubkey
  CoordinatorInfo? _selectedCoordinatorInfo;
  bool _coordinatorPickerOpen = false; // Drives the dropdown arrow direction
  bool _termsAccepted = false; // Track if terms of usage are accepted
  bool _hasTriedAutoSelect = false; // Track if we've tried to auto-select
  // True once the user manually picks a coordinator from the chooser. While
  // set, amount-driven auto re-selection won't override their choice (unless
  // the chosen coordinator no longer fits the entered amount).
  bool _userPickedCoordinator = false;
  OfferCategory? _selectedCategory = OfferCategory.shop;
  OfferCategory _defaultCategoryPreference = OfferCategory.shop;
  double _premiumPercent = 0; // Maker premium % above market price
  double _defaultPremiumPreference = 0;
  bool _premiumEnabled = false;
  bool _userAdjustedPremium = false;
  String? _preferredCoordinatorPubkey;
  BitcoinDisplayUnit _bitcoinDisplayUnit = BitcoinDisplayUnit.sats;
  bool _ecommerceRiskAccepted = false;
  bool _showCategoryOnboarding = false;
  bool _categoryOnboardingExpanded = false;

  /// For the ATM category the amount is picked from preset buttons by default;
  /// the "Custom" button flips this to the free-form text input.
  bool _customAmountMode = false;

  @override
  void initState() {
    super.initState();
    _fiatController.addListener(_validateAndRecalculate);
    _amountFocusNode.addListener(_onAmountFocusChange);
    _loadInitialData();
    _loadEcommerceRiskAccepted();
    _loadCategoryOnboardingState();

    // Auto-focus the amount input field when screen is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _amountFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _fiatController.removeListener(_validateAndRecalculate);
    _amountFocusNode.removeListener(_onAmountFocusChange);
    _fiatController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadEcommerceRiskAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _ecommerceRiskAccepted =
          prefs.getBool('maker_ecommerce_risk_accepted') ?? false;
    });
  }

  Future<void> _saveEcommerceRiskAccepted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('maker_ecommerce_risk_accepted', value);
  }

  Future<void> _loadCategoryOnboardingState() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _showCategoryOnboarding =
          !(prefs.getBool(_categoryOnboardingDismissedKey) ?? false);
    });
  }

  Future<void> _dismissCategoryOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_categoryOnboardingDismissedKey, true);
    if (!mounted) return;
    setState(() {
      _showCategoryOnboarding = false;
      _categoryOnboardingExpanded = false;
    });
  }

  String _categoryOnboardingTitle(Translations t) {
    final now = DateTime.now();
    if (now.isBefore(_categoryOnboardingNewCutoff)) {
      return '${t.maker.amountForm.onboarding.titlePrefix}: ${t.maker.amountForm.onboarding.title}';
    }
    return t.maker.amountForm.onboarding.title;
  }

  Future<void> _loadInitialData() async {
    if (!mounted) return;
    setState(() {
      _isLoadingInitialData = true;
      _coordinatorInfoError = null;
      _rate = null;
    });

    final apiService = ref.read(apiServiceProvider);

    try {
      final preferences = await AppPreferencesStore.load();
      if (!mounted) return;
      setState(() {
        _defaultCategoryPreference = preferences.offerCreation.defaultCategory;
        _selectedCategory = preferences.offerCreation.defaultCategory;
        _premiumEnabled = preferences.offerCreation.premiumEnabled;
        _defaultPremiumPreference =
            preferences.offerCreation.defaultPremiumPercent;
        _premiumPercent =
            preferences.offerCreation.premiumEnabled
                ? preferences.offerCreation.defaultPremiumPercent
                : 0;
        _preferredCoordinatorPubkey =
            preferences.offerCreation.preferredCoordinatorPubkey;
        _bitcoinDisplayUnit = preferences.display.bitcoinDisplayUnit;
      });

      final rate = await apiService.getBtcRate(_method.currency);
      if (!mounted) return;
      setState(() {
        _rate = rate;
      });

      // Auto-select first responsive coordinator if available
      _autoSelectCoordinator();

      // min/max will be set when coordinator is selected
      _validateAndRecalculate();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _coordinatorInfoError = t.system.errors.loadingCoordinatorConfig;
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoadingInitialData = false;
      });
    }
  }

  void _autoSelectCoordinator() {
    if (_selectedCoordinatorPubkey != null) return; // Already selected

    final coordinatorsAsync = ref.read(enabledCoordinatorsProvider);
    if (coordinatorsAsync is AsyncData<List<CoordinatorRecord>>) {
      final coordinators = _filterByAmount(coordinatorsAsync.value);
      final responsiveCoordinators =
          coordinators.where((c) => c.responsive == true).toList();
      if (responsiveCoordinators.isNotEmpty) {
        _selectCoordinator(_choosePreferredCoordinator(responsiveCoordinators));
      }
    }
  }

  void _onAmountFocusChange() {
    if (!_amountFocusNode.hasFocus) {
      _reSelectCoordinatorForAmount();
    }
  }

  void _reSelectCoordinatorForAmount() {
    final coordinatorsAsync = ref.read(enabledCoordinatorsProvider);
    if (coordinatorsAsync is! AsyncData<List<CoordinatorRecord>>) return;

    final filtered = _filterByAmount(coordinatorsAsync.value);
    final responsive = filtered.where((c) => c.responsive == true).toList();

    if (responsive.isEmpty) {
      if (_satsEquivalent != null) {
        setState(() {
          _selectedCoordinatorPubkey = null;
          _selectedCoordinatorInfo = null;
          _hasTriedAutoSelect = false;
        });
      }
      return;
    }

    // Respect a manual choice as long as it still fits the entered amount.
    if (_userPickedCoordinator) {
      final stillFits = responsive.any(
        (c) => c.pubkey == _selectedCoordinatorPubkey,
      );
      if (stillFits) return;
    }

    // Otherwise settle on the first (highest-priority) coordinator that fits.
    final best = _choosePreferredCoordinator(responsive);
    if (best.pubkey != _selectedCoordinatorPubkey) {
      _selectCoordinator(best);
    }
  }

  CoordinatorRecord _choosePreferredCoordinator(
    List<CoordinatorRecord> candidates,
  ) {
    final preferredPubkey = _preferredCoordinatorPubkey;
    if (preferredPubkey ==
        OfferCreationPreferences.cheapestCoordinatorSentinel) {
      return candidates.reduce((a, b) => b.makerFee < a.makerFee ? b : a);
    }
    if (preferredPubkey != null) {
      for (final coordinator in candidates) {
        if (coordinator.pubkey == preferredPubkey) return coordinator;
      }
    }
    return candidates.first;
  }

  Future<void> _selectCoordinator(
    CoordinatorRecord coordinator, {
    bool userInitiated = false,
  }) async {
    final supportsCategory = _supportsOfferCategory(coordinator.version);
    setState(() {
      // Sticky for the current screen session: once the user has manually
      // touched the coordinator picker, blur-time auto-selection should stop
      // overriding their in-range choice.
      if (userInitiated) {
        _userPickedCoordinator = true;
      }
      _selectedCoordinatorPubkey = coordinator.pubkey;
      _selectedCoordinatorInfo = coordinator.toCoordinatorInfo();
      if (!supportsCategory) {
        _selectedCategory = null;
        _ecommerceRiskAccepted = false;
      } else {
        // Clamp to categories the active payment method allows (MB WAY = ATM
        // only). Falls back to the method's first supported category.
        final supported = _method.supportedCategories;
        if (_selectedCategory == null ||
            !supported.contains(_selectedCategory)) {
          _selectedCategory =
              supported.contains(_defaultCategoryPreference)
                  ? _defaultCategoryPreference
                  : supported.first;
        }
      }
      // Clamp premium to the newly selected coordinator's advertised max.
      final maxPremium = coordinator.maxPremium;
      if (!_premiumEnabled || maxPremium <= 0) {
        _premiumPercent = 0;
      } else if (!_userAdjustedPremium && _premiumPercent <= 0) {
        _premiumPercent = _defaultPremiumPreference.clamp(0, maxPremium);
      } else if (_premiumPercent > maxPremium) {
        _premiumPercent = maxPremium;
      }
    });

    // Load terms acceptance from SharedPreferences
    if (coordinator.termsOfUsageNaddr != null) {
      final prefs = await SharedPreferences.getInstance();
      final key = 'terms_accepted_${coordinator.pubkey}';
      final accepted = prefs.getBool(key) ?? false;
      setState(() {
        _termsAccepted = accepted;
      });
    } else {
      setState(() {
        _termsAccepted = true; // No terms to accept
      });
    }

    // min/max values are used for validation only
    _validateAndRecalculate();
  }

  void _validateAndRecalculate() {
    final text = _fiatController.text;
    String? currentError;
    double? parsedFiat;
    double? sats;

    // Parse first; compute sats independently from coordinator selection
    // so we can match against any enabled coordinator's range.
    if (text.isEmpty) {
      parsedFiat = null;
    } else {
      final fiatString = text.replaceAll(',', '.');
      parsedFiat = double.tryParse(fiatString);
      if (parsedFiat == null) {
        currentError = t.exchange.errors.invalidFormat;
      } else if (parsedFiat <= 0) {
        currentError = t.exchange.errors.mustBePositive;
      } else if (_rate != null) {
        sats = parsedFiat * (1 / _rate!) * 100000000;
      }
    }

    // Validate against the union of all enabled coordinators' ranges.
    // "Too low/high" only when no coordinator fits at all.
    final enabledAsync = ref.read(enabledCoordinatorsProvider);
    final enabled =
        enabledAsync is AsyncData<List<CoordinatorRecord>>
            ? enabledAsync.value
            : const <CoordinatorRecord>[];

    if (currentError == null && sats != null && enabled.isNotEmpty) {
      final satsInt = sats.round();
      // Find any match (responsive or not) for range error messaging.
      CoordinatorRecord? anyMatch;
      for (final c in enabled) {
        if (satsInt >= c.minAmountSats && satsInt <= c.maxAmountSats) {
          anyMatch = c;
          break;
        }
      }
      if (anyMatch == null && _rate != null) {
        final globalMinSats = enabled
            .map((c) => c.minAmountSats)
            .reduce((a, b) => a < b ? a : b);
        final globalMaxSats = enabled
            .map((c) => c.maxAmountSats)
            .reduce((a, b) => a > b ? a : b);
        final minFiat =
            ((globalMinSats / 100000000.0) * _rate! * 100).ceil() / 100;
        final maxFiat =
            ((globalMaxSats / 100000000.0) * _rate!).floor().toDouble();
        if (parsedFiat! < minFiat) {
          currentError = t.exchange.errors.tooLowFiat(
            minAmount: minFiat.toStringAsFixed(2),
            currency: _method.currencySymbol,
          );
        } else if (parsedFiat > maxFiat) {
          currentError = t.exchange.errors.tooHighFiat(
            maxAmount: maxFiat.toStringAsFixed(0),
            currency: _method.currencySymbol,
          );
        }
      }
    }

    // ATM cash-out must be an amount the ATM can actually dispense (a
    // combination of the method's banknote nominals).
    if (currentError == null &&
        parsedFiat != null &&
        _selectedCategory == OfferCategory.atm &&
        !_method.canDispenseAtmAmount(parsedFiat)) {
      currentError = t.exchange.errors.atmNotDispensable(
        notes:
            '${_method.atmBanknoteDenominations.join(', ')} ${_method.currencySymbol}',
      );
    }

    setState(() {
      _amountErrorText = currentError;
      _satsEquivalent = (currentError == null) ? sats : null;
    });
  }

  Future<void> _initiateOffer() async {
    final coordinatorPubkey = _selectedCoordinatorPubkey;
    if (coordinatorPubkey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a coordinator first'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    final supportsCategory = _supportsOfferCategory(
      _selectedCoordinatorInfo?.version,
    );
    if (supportsCategory && _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.maker.amountForm.errors.categoryRequired)),
      );
      return;
    }
    if (supportsCategory &&
        _selectedCategory == OfferCategory.online &&
        !_ecommerceRiskAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.maker.amountForm.errors.ecommerceConfirmationRequired,
          ),
        ),
      );
      return;
    }

    final publicKeyAsyncValue = ref.read(publicKeyProvider);
    final makerId = publicKeyAsyncValue.value;
    if (makerId == null) {
      ref.read(errorProvider.notifier).state =
          t.maker.amountForm.errors.publicKeyNotLoaded;
      return;
    }

    final fiatString = _fiatController.text.replaceAll(',', '.');
    final fiatAmount = double.parse(fiatString);

    ref.read(isLoadingProvider.notifier).state = true;
    ref.read(errorProvider.notifier).state = null;

    try {
      final apiService = ref.read(apiServiceProvider);
      final result = await apiService.initiateOfferFiat(
        fiatAmount: fiatAmount,
        makerId: makerId,
        fiatCurrency: _method.currency,
        category: supportsCategory ? _selectedCategory : null,
        coordinatorPubkey: coordinatorPubkey,
        premiumPercent: _premiumPercent,
      );
      final paymentHash = result['paymentHash'] as String;
      ref.read(holdInvoiceProvider.notifier).state = result['holdInvoice'];
      ref.read(paymentHashProvider.notifier).state = paymentHash;
      await ref
          .read(activeOfferProvider.notifier)
          .setActiveOffer(
            Offer(
              id: paymentHash,
              amountSats: result['makerFees'] + result['amountSats'],
              makerFees: result['makerFees'],
              status: OfferStatus.created,
              fiatAmount: fiatAmount,
              fiatCurrency: _method.currency,
              createdAt: DateTime.now(),
              holdInvoicePaymentHash: paymentHash,
              holdInvoice: result['holdInvoice'],
              makerPubkey: makerId,
              coordinatorPubkey: coordinatorPubkey,
              category: supportsCategory ? _selectedCategory : null,
              premiumPercent:
                  (result['premiumPercent'] as num?)?.toDouble() ??
                  _premiumPercent,
            ),
          );
      if (mounted) {
        context.push("/pay");
      }
    } catch (e) {
      ref.read(errorProvider.notifier).state = t.maker.amountForm.errors
          .initiating(details: e.toString());
    } finally {
      if (mounted) {
        ref.read(isLoadingProvider.notifier).state = false;
      }
    }
  }

  /// Logo for the selected coordinator. Prefers the kind-0 profile picture
  /// over the kind-15125 info icon.
  Widget _buildSelectedCoordinatorLogo() {
    final pk = _selectedCoordinatorPubkey;
    final icon =
        pk == null
            ? null
            : ref.watch(coordinatorRecordByPubkeyProvider(pk))?.icon;
    if (icon != null && icon.isNotEmpty) {
      return icon.startsWith('http')
          ? Image.network(icon, width: 22, height: 22)
          : Image.asset(icon, width: 22, height: 22);
    }
    return const Icon(Icons.account_circle, size: 24);
  }

  Widget _buildDetailRow(
    String label,
    Widget value, {
    IconData? infoIcon,
    VoidCallback? onInfoTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: infoIcon != null ? onInfoTap : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                if (infoIcon != null) ...[
                  const SizedBox(width: 4),
                  Icon(infoIcon, size: 16, color: Colors.grey),
                ],
              ],
            ),
          ),
          const Spacer(),
          value,
        ],
      ),
    );
  }

  void _showExchangeRateSourcesDialog(BuildContext context) {
    final apiService = ref.read(apiServiceProvider);
    final t = Translations.of(context);
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                constraints: const BoxConstraints(maxWidth: 320),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FutureBuilder<
                  ({Map<String, double?> rates, DateTime fetchedAt})
                >(
                  future: apiService.getSourceRates(_method.currency),
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    final rates = data?.rates;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          t.offers.tooltips.ratesSources,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...ApiServiceNostr.exchangeRateSourceNames.map((name) {
                          final rate = rates?[name];
                          final rateText =
                              rates == null
                                  ? '…'
                                  : rate != null
                                  ? '${_formatNumber(rate.round())} ${_method.currency}/BTC'
                                  : '—';
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  rateText,
                                  style: TextStyle(
                                    color:
                                        rate != null
                                            ? Colors.white
                                            : Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        if (data != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            '${t.offers.tooltips.ratesFetchedAt} ${data.fetchedAt.hour.toString().padLeft(2, '0')}:${data.fetchedAt.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
    );
  }

  /// Restrict the coordinator list by the currently entered sats amount.
  /// When no amount is entered yet we show every coordinator so the user
  /// can still browse.
  List<CoordinatorRecord> _filterByAmount(List<CoordinatorRecord> source) {
    final sats = _satsEquivalent;
    if (sats == null) return source;
    final satsInt = sats.round();
    return source
        .where((c) => satsInt >= c.minAmountSats && satsInt <= c.maxAmountSats)
        .toList(growable: false);
  }

  Future<void> _showCoordinatorPicker(BuildContext context) async {
    final coordinatorsAsync = ref.read(enabledCoordinatorsProvider);
    if (coordinatorsAsync is AsyncData<List<CoordinatorRecord>>) {
      final coordinators = coordinatorsAsync.value;
      if (coordinators.isEmpty) return;
      setState(() => _coordinatorPickerOpen = true);
      await showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              children:
                  coordinators.map((coordinator) {
                    final rate = _rate ?? 1.0;
                    final minPln = (coordinator.minAmountSats /
                            100000000.0 *
                            rate)
                        .toStringAsFixed(2);
                    final maxPln =
                        (coordinator.maxAmountSats / 100000000.0 * rate)
                            .floor()
                            .toString();
                    final feePct = coordinator.makerFee.toStringAsFixed(2);
                    final t = Translations.of(context);
                    final sats = _satsEquivalent;
                    final outOfRange =
                        sats != null &&
                        (sats.round() < coordinator.minAmountSats ||
                            sats.round() > coordinator.maxAmountSats);
                    final notResponsive =
                        coordinator.responsive == false ||
                        coordinator.responsive == null;
                    final disabled = notResponsive || outOfRange;
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              (coordinator.icon != null &&
                                      coordinator.icon!.isNotEmpty)
                                  ? (coordinator.icon!.startsWith('http')
                                      ? Image.network(
                                        coordinator.icon!,
                                        width: 32,
                                        height: 32,
                                      )
                                      : Image.asset(
                                        coordinator.icon!,
                                        width: 32,
                                        height: 32,
                                      ))
                                  : const Icon(Icons.account_circle, size: 32),
                              const SizedBox(width: 8),
                              Text(
                                coordinator.name,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: disabled ? Colors.grey : null,
                                ),
                              ),
                              if (coordinator.responsive == true && !outOfRange)
                                const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 18,
                                  ),
                                ),
                              const Spacer(),
                              Radio<String>(
                                value: coordinator.pubkey,
                                groupValue: _selectedCoordinatorPubkey,
                                onChanged:
                                    disabled
                                        ? null
                                        : (_) {
                                          Navigator.of(context).pop();
                                          _selectCoordinator(
                                            coordinator,
                                            userInitiated: true,
                                          );
                                        },
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Wrap(
                            spacing: 12,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              if (coordinator.version.isNotEmpty)
                                Text(
                                  'v${coordinator.version}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                              Text(
                                t.coordinator.info.rangeDisplay(
                                  minAmount: minPln,
                                  maxAmount: maxPln,
                                  currency: _method.currencySymbol,
                                ),
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: disabled ? Colors.grey : null,
                                ),
                              ),
                              Text(
                                t.coordinator.info.feeDisplay(fee: feePct),
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.blueGrey),
                              ),
                              Text(
                                '${t.coordinator.management.metricNetworkOffers}: ${coordinator.networkFinishedCount}',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap:
                          disabled
                              ? null
                              : () {
                                Navigator.of(context).pop();
                                _selectCoordinator(
                                  coordinator,
                                  userInitiated: true,
                                );
                              },
                      tileColor:
                          disabled ? Colors.grey.withValues(alpha: 0.15) : null,
                    );
                  }).toList(),
            ),
          );
        },
      );
      if (mounted) setState(() => _coordinatorPickerOpen = false);
    }
  }

  Widget _buildGradientButton({
    required VoidCallback? onPressed,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient:
            onPressed != null
                ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFF0000), // Bright red/pink
                    Color(0xFFFF007F), // Bright magenta/pink
                  ],
                )
                : null,
        color: onPressed == null ? Colors.grey[300] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Center(child: child),
        ),
      ),
    );
  }

  Widget _buildCategoryOnboardingCard(Translations t) {
    const noteBackground = Color(0xFFFFF4CC);
    const noteAccent = Color(0xFF8A5A00);

    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: SizedBox(
              width: 18,
              height: 12,
              child: CustomPaint(
                painter: _OnboardingBeakPainter(
                  color: noteBackground.withValues(alpha: 0.96),
                  shadowColor: const Color(0x12000000),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            decoration: BoxDecoration(
              color: noteBackground.withValues(alpha: 0.96),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x16000000),
                  blurRadius: 14,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE8A3).withValues(alpha: 0.96),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline,
                        color: noteAccent,
                        size: 19,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _categoryOnboardingTitle(t),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF513400),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _dismissCategoryOnboarding,
                      icon: const Icon(Icons.close, size: 17),
                      visualDensity: VisualDensity.compact,
                      splashRadius: 17,
                      color: Colors.grey[600],
                      tooltip: t.common.buttons.close,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  t.maker.amountForm.onboarding.body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
                    color: Color(0xFF6B4B06),
                  ),
                ),
                const SizedBox(height: 14),
                Column(
                  children: OfferCategory.values
                      .map((category) {
                        final label = switch (category) {
                          OfferCategory.shop =>
                            t.maker.amountForm.category.options.physicalShop,
                          OfferCategory.atm =>
                            t.maker.amountForm.category.options.atmCashout,
                          OfferCategory.online =>
                            t.maker.amountForm.category.options.onlineService,
                        };
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                category != OfferCategory.values.last ? 8 : 0,
                          ),
                          child: Row(
                            children: [
                              _categoryIconWidget(category, 22, noteAccent),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  label,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF6B4B06),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                      .toList(growable: false),
                ),
                const SizedBox(height: 10),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    setState(() {
                      _categoryOnboardingExpanded =
                          !_categoryOnboardingExpanded;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE9A8).withValues(alpha: 0.78),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _categoryOnboardingExpanded
                                ? t.maker.amountForm.onboarding.hideWhy
                                : t.maker.amountForm.onboarding.showWhy,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: noteAccent,
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          turns: _categoryOnboardingExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 180),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: noteAccent,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8DE).withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.maker.amountForm.onboarding.whyTitle,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF6B4B06),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            t.maker.amountForm.onboarding.whyBody,
                            style: const TextStyle(
                              fontSize: 12.5,
                              height: 1.42,
                              color: Color(0xFF7A5A10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  crossFadeState:
                      _categoryOnboardingExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 180),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _dismissCategoryOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor: noteAccent,
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(t.maker.amountForm.onboarding.cta),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _categoryShortLabel(OfferCategory category, Translations t) {
    switch (category) {
      case OfferCategory.shop:
        return t.maker.amountForm.category.shortLabels.shop;
      case OfferCategory.atm:
        return t.maker.amountForm.category.shortLabels.atm;
      case OfferCategory.online:
        return t.maker.amountForm.category.shortLabels.online;
    }
  }

  void _showAllCategoriesInfoDialog() {
    final t = Translations.of(context);
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(t.maker.amountForm.category.label),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    OfferCategory.values.map((category) {
                      final supported =
                          _method.supportedCategories.contains(category);
                      final hint = switch (category) {
                        OfferCategory.shop =>
                          t.maker.amountForm.category.physicalShopHint(code: _method.codeLabel, app: buildAppName),
                        OfferCategory.atm =>
                          t.maker.amountForm.category.atmHint,
                        OfferCategory.online =>
                          t.maker.amountForm.category.ecommerceWarningBody(code: _method.codeLabel),
                      };
                      final name = switch (category) {
                        OfferCategory.shop =>
                          t.maker.amountForm.category.options.physicalShop,
                        OfferCategory.atm =>
                          t.maker.amountForm.category.options.atmCashout,
                        OfferCategory.online =>
                          t.maker.amountForm.category.options.onlineService,
                      };
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              category != OfferCategory.values.last ? 16 : 0,
                        ),
                        child: Opacity(
                          // Dim categories the chosen payment method can't serve.
                          opacity: supported ? 1.0 : 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  _categoryIconWidget(
                                    category,
                                    22,
                                    Colors.grey[700]!,
                                    grayscale: !supported,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: supported ? null : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                hint,
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                  color: supported ? null : Colors.grey,
                                ),
                              ),
                              if (!supported) ...[
                                const SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.block,
                                      size: 14,
                                      color: Colors.red[400],
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        t.maker.amountForm.category
                                            .unsupportedForSystem(
                                          system: _method.label,
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red[400],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(t.common.buttons.close),
              ),
            ],
          ),
    );
  }

  IconData _categoryIcon(OfferCategory category) {
    switch (category) {
      case OfferCategory.shop:
        return Icons.storefront_outlined;
      case OfferCategory.atm:
        return Icons.local_atm_outlined;
      case OfferCategory.online:
        return Icons.shopping_cart_checkout_outlined;
    }
  }

  String? _categoryAsset(OfferCategory category) {
    switch (category) {
      case OfferCategory.shop:
        return 'assets/category_shop.png';
      case OfferCategory.atm:
        return 'assets/category_atm.png';
      case OfferCategory.online:
        return 'assets/category_online.png';
    }
  }

  Widget _buildAtmAmountPresets(Translations t) {
    // Only show presets within the selected coordinator's amount range.
    final rate = _rate;
    final info = _selectedCoordinatorInfo;
    double? minFiat;
    double? maxFiat;
    if (rate != null && info != null) {
      minFiat = (info.minAmountSats / 100000000.0) * rate;
      maxFiat = (info.maxAmountSats / 100000000.0) * rate;
    }
    final presets = _method.atmPresetAmounts
        .where((amt) =>
            (maxFiat == null || amt <= maxFiat) &&
            (minFiat == null || amt >= minFiat))
        .toList(growable: false);
    final current = _fiatController.text.trim();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          for (final amt in presets)
            _amountPresetChip(
              label: '$amt ${_method.currencySymbol}',
              selected: current == '$amt',
              // The controller listener recalculates and rebuilds.
              onTap: () => _fiatController.text = '$amt',
            ),
          _amountPresetChip(
            label: t.maker.amountForm.labels.customAmount,
            selected: false,
            icon: Icons.tune,
            onTap: () {
              setState(() => _customAmountMode = true);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _amountFocusNode.requestFocus();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _amountPresetChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? Colors.red : Colors.grey.shade300,
            width: selected ? 1.6 : 1,
          ),
          color: selected ? const Color(0xFFFFF2F6) : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 18, color: selected ? Colors.red : Colors.grey[700]),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? Colors.red : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryIconWidget(
    OfferCategory category,
    double size,
    Color color, {
    bool grayscale = false,
  }) {
    final asset = _categoryAsset(category);
    if (asset != null) {
      final image = Image.asset(asset, width: size, height: size);
      if (!grayscale) return image;
      // Desaturate the PNG logo for disabled categories (color is ignored by
      // Image.asset, so apply a luminance grayscale matrix instead).
      return ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0, //
          0.2126, 0.7152, 0.0722, 0, 0, //
          0.2126, 0.7152, 0.0722, 0, 0, //
          0, 0, 0, 1, 0, //
        ]),
        child: image,
      );
    }
    return Icon(_categoryIcon(category), size: size, color: color);
  }

  String _categoryWarningTitle(BuildContext context, OfferCategory category) {
    final t = Translations.of(context);
    switch (category) {
      case OfferCategory.atm:
        return t.maker.amountForm.category.options.atmCashout;
      case OfferCategory.online:
        return t.maker.amountForm.category.options.onlineService;
      case OfferCategory.shop:
        return t.maker.amountForm.category.options.physicalShop;
    }
  }

  void _showCategoryInfoDialog(OfferCategory category) {
    final t = Translations.of(context);
    final title = _categoryWarningTitle(context, category);

    showDialog<void>(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setDialogState) {
              Widget? content;

              if (category == OfferCategory.shop) {
                content = Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          t.maker.amountForm.category
                              .physicalShopHint(code: _method.codeLabel, app: buildAppName),
                          style: const TextStyle(fontSize: 13, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (category == OfferCategory.atm) {
                content = Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          t.maker.amountForm.category.atmHint,
                          style: const TextStyle(fontSize: 13, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (category == OfferCategory.online) {
                final warningColor = Colors.amber[700]!;
                content = Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: warningColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: warningColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: warningColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              t.maker.amountForm.category.ecommerceWarningBody(code: _method.codeLabel),
                              style: const TextStyle(fontSize: 13, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _ecommerceRiskAccepted,
                          activeColor: Colors.red,
                          visualDensity: VisualDensity.compact,
                          onChanged: (value) {
                            final v = value ?? false;
                            setState(() {
                              _ecommerceRiskAccepted = v;
                            });
                            setDialogState(() {});
                            _saveEcommerceRiskAccepted(v);
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              final v = !_ecommerceRiskAccepted;
                              setState(() {
                                _ecommerceRiskAccepted = v;
                              });
                              setDialogState(() {});
                              _saveEcommerceRiskAccepted(v);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                t
                                    .maker
                                    .amountForm
                                    .category
                                    .ecommerceConfirmation,
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }

              return AlertDialog(
                title: Text(title),
                content: content,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(t.common.buttons.close),
                  ),
                ],
              );
            },
          ),
    );
  }

  // Offer categories are always available; selectable categories are limited
  // only by the chosen payment method's supportedCategories.
  bool _supportsOfferCategory(String? version) => true;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final globalErrorMessage = ref.watch(errorProvider);
    final publicKeyAsyncValue = ref.watch(publicKeyProvider);
    final coordinatorsAsync = ref.watch(enabledCoordinatorsProvider);
    final t = Translations.of(context);
    final supportsCategory = _supportsOfferCategory(
      _selectedCoordinatorInfo?.version,
    );

    // Auto-select coordinator when they become available (only once).
    // Gate on !_isLoadingInitialData so this never fires before
    // _loadInitialData has applied the preferred-coordinator preference;
    // otherwise it races and picks candidates.first instead of the preferred.
    if (coordinatorsAsync is AsyncData<List<CoordinatorRecord>> &&
        !_isLoadingInitialData &&
        !_hasTriedAutoSelect &&
        _selectedCoordinatorPubkey == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _selectedCoordinatorPubkey == null) {
          _hasTriedAutoSelect = true;
          _autoSelectCoordinator();
        }
      });
    }

    if (_isLoadingInitialData) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_coordinatorInfoError != null) {
      return Center(child: Text(_coordinatorInfoError!));
    }

    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside of text field
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Progress indicator
              const MakerProgressIndicator(),

              if (globalErrorMessage != null) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    globalErrorMessage,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],

              if (supportsCategory) ...[
                const SizedBox(height: 12),
                Row(
                  children: OfferCategory.values
                      .map((category) {
                        // Categories not served by the active payment method
                        // (e.g. MB WAY supports ATM only) are shown but disabled.
                        final isSupported = _method.supportedCategories
                            .contains(category);
                        final selected =
                            isSupported && _selectedCategory == category;
                        final Color accent =
                            !isSupported
                                ? Colors.grey.shade400
                                : selected
                                ? Colors.red
                                : Colors.grey[700]!;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right:
                                  category != OfferCategory.values.last ? 8 : 0,
                            ),
                            // Empty message for supported tiles: the InkWell
                            // consumes the tap so the tooltip never fires. For
                            // disabled tiles the InkWell is inert, so a tap
                            // falls through and shows the explanation.
                            child: Tooltip(
                              message:
                                  isSupported
                                      ? ''
                                      : t.maker.amountForm.category
                                          .unsupportedForSystem(
                                            system: _method.label,
                                          ),
                              triggerMode: TooltipTriggerMode.tap,
                              child: Opacity(
                                opacity: isSupported ? 1.0 : 0.5,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(999),
                                  onTap:
                                      isSupported
                                          ? () {
                                            setState(() {
                                              _selectedCategory = category;
                                              // ATM defaults to preset amounts.
                                              _customAmountMode = false;
                                              if (category !=
                                                  OfferCategory.online) {
                                                _ecommerceRiskAccepted = false;
                                              }
                                            });
                                          }
                                          : null,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 120),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                      border: Border.all(
                                        color:
                                            selected
                                                ? Colors.red
                                                : Colors.grey.shade300,
                                        width: selected ? 1.6 : 1,
                                      ),
                                      color:
                                          !isSupported
                                              ? Colors.grey.shade100
                                              : selected
                                              ? const Color(0xFFFFF2F6)
                                              : Colors.white,
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _categoryIconWidget(
                                            category,
                                            28,
                                            accent,
                                            grayscale: !isSupported,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            _categoryShortLabel(category, t),
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight:
                                                  selected
                                                      ? FontWeight.w600
                                                      : FontWeight.w400,
                                              color: accent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                      .toList(growable: false),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _showAllCategoriesInfoDialog,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              t.maker.amountForm.category.whyThisIsNeeded,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(width: 3),
                            Icon(
                              Icons.info_outline,
                              size: 13,
                              color: Colors.grey[500],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedCategory == OfferCategory.online) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.amber.withValues(alpha: 0.35),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _ecommerceRiskAccepted,
                            activeColor: Colors.red,
                            visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -4,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (value) {
                              final v = value ?? false;
                              setState(() {
                                _ecommerceRiskAccepted = v;
                              });
                              _saveEcommerceRiskAccepted(v);
                            },
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: GestureDetector(
                              onTap:
                                  () => _showCategoryInfoDialog(
                                    OfferCategory.online,
                                  ),
                              child: Text(
                                t
                                    .maker
                                    .amountForm
                                    .category
                                    .ecommerceConfirmation,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 28,
                              minHeight: 28,
                            ),
                            visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -4,
                            ),
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.amber,
                              size: 18,
                            ),
                            onPressed:
                                () => _showCategoryInfoDialog(
                                  OfferCategory.online,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                // if (_showCategoryOnboarding)
                //   Padding(
                //     padding: const EdgeInsets.only(top: 10),
                //     child: _buildCategoryOnboardingCard(t),
                //   ),
                const SizedBox(height: 4),
              ],
              // Amount entry: ATM presets (default) or the traditional input.
              if (_selectedCategory == OfferCategory.atm && !_customAmountMode)
                _buildAtmAmountPresets(t)
              else
              // Large amount input field
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 22.0,
                  horizontal: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: _amountFocusNode,
                        controller: _fiatController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                        decoration: InputDecoration(
                          hintText: t.maker.amountForm.labels.enterAmount,
                          hintStyle: TextStyle(
                            fontSize: 36,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w300,
                          ),
                          border: InputBorder.none,
                          errorText: null, // Error shown below
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _method.currencySymbol,
                      style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              if (_amountErrorText != null) ...[
                Text(
                  _amountErrorText!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
              const SizedBox(height: 16),

              // Details section
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    // Coordinator row - clickable to select/change coordinator
                    GestureDetector(
                      onTap: () async {
                        if (_selectedCoordinatorInfo == null) {
                          final registry = await ref.read(
                            coordinatorRegistryProvider.future,
                          );
                          unawaited(registry.discover());
                        }
                        if (!mounted) return;
                        _showCoordinatorPicker(this.context);
                      },
                      child: _buildDetailRow(
                        t.maker.amountForm.labels.coordinator,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Dropdown indicator before the logo (opens the
                            // chooser via the row's GestureDetector). Points
                            // right when closed, down while the chooser is open.
                            Icon(
                              _coordinatorPickerOpen
                                  ? Icons.arrow_drop_down_sharp
                                  : Icons.arrow_right_sharp,
                              size: 32,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 2),
                            if (_selectedCoordinatorInfo != null) ...[
                              _buildSelectedCoordinatorLogo(),
                              const SizedBox(width: 8),
                              Text(
                                _selectedCoordinatorInfo!.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 18),
                              // Right arrow → coordinator detail view. Own tap
                              // handler so it doesn't open the chooser.
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  final pk = _selectedCoordinatorPubkey;
                                  if (pk != null) {
                                    openCoordinatorDetails(context, pk);
                                  }
                                },
                                child: Transform.translate(
                                  offset: const Offset(4, 0),
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      left: 2,
                                      top: 4,
                                      bottom: 4,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ] else
                              Text(
                                t.maker.amountForm.labels.tapToSelect,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Exchange Rate row
                    _buildDetailRow(
                      t.maker.amountForm.labels.exchangeRate,
                      Text(
                        _rate != null
                            ? '${_formatNumber(_rate!.round())} ${_method.currency} / BTC'
                            : '-',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      infoIcon: Icons.info_outline,
                      onInfoTap: () => _showExchangeRateSourcesDialog(context),
                    ),

                    // Fee row
                    if (_selectedCoordinatorInfo == null ||
                        _selectedCoordinatorInfo!.makerFee != 0)
                      _buildDetailRow(
                        t.maker.amountForm.labels.fee,
                        Text(
                          (_selectedCoordinatorInfo != null &&
                                  _satsEquivalent != null)
                              ? _formatBitcoinAmount(
                                _satsEquivalent! *
                                    _selectedCoordinatorInfo!.makerFee /
                                    100,
                                approximate: true,
                              )
                              : '-',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        infoIcon: Icons.info_outline,
                        onInfoTap: () {
                          if (_selectedCoordinatorInfo != null) {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text(t.maker.amountForm.labels.fee),
                                    content: Text(
                                      t.maker.amountForm.tooltips.feeInfo(
                                        feePercent:
                                            _selectedCoordinatorInfo!.makerFee
                                                .toString(),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        child: Text(t.common.buttons.close),
                                      ),
                                    ],
                                  ),
                            );
                          }
                        },
                      ),

                    // Premium row + slider (only when coordinator allows it)
                    if (_premiumEnabled &&
                        _selectedCoordinatorInfo != null &&
                        _selectedCoordinatorInfo!.maxPremiumPercent > 0) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: _showPremiumInfoDialog,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    t.maker.amountForm.labels.premium,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.info_outline,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: const Color(0xFFFF007F),
                                  thumbColor: const Color(0xFFFF007F),
                                  overlayColor: const Color(0x33FF007F),
                                  trackHeight: 2,
                                  overlayShape: SliderComponentShape.noOverlay,
                                ),
                                // Constrain height so the row matches the
                                // other detail rows (overlay disabled above).
                                child: SizedBox(
                                  height: 28,
                                  child: Slider(
                                    value: _premiumPercent.clamp(
                                      0,
                                      _selectedCoordinatorInfo!
                                          .maxPremiumPercent,
                                    ),
                                    min: 0,
                                    max:
                                        _selectedCoordinatorInfo!
                                            .maxPremiumPercent,
                                    divisions:
                                        (_selectedCoordinatorInfo!
                                                    .maxPremiumPercent /
                                                0.5)
                                            .round(),
                                    label:
                                        '${_formatPremium(_premiumPercent)}%',
                                    onChanged: (value) {
                                      setState(() {
                                        // Snap to 0.5 steps.
                                        _premiumPercent =
                                            (value * 2).round() / 2;
                                        _userAdjustedPremium = true;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${_formatPremium(_premiumPercent)}%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    _premiumPercent > 0
                                        ? const Color(0xFFFF007F)
                                        : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const Divider(height: 16),

                    // Satoshis to pay row
                    _selectedCoordinatorInfo != null
                        ? _buildDetailRow(
                          t.maker.amountForm.labels.satoshisToPay,
                          Text(
                            _satsEquivalent != null
                                ? _formatBitcoinAmount(
                                  _satsEquivalent! *
                                          (1 - _premiumPercent / 100) +
                                      (_satsEquivalent! *
                                          _selectedCoordinatorInfo!.makerFee /
                                          100),
                                  approximate: true,
                                )
                                : '-',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          infoIcon: Icons.info_outline,
                          onInfoTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text(
                                      t.maker.amountForm.labels.satoshisToPay,
                                    ),
                                    content: Text(
                                      t.maker.amountForm.tooltips.payInfo,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        child: Text(t.common.buttons.close),
                                      ),
                                    ],
                                  ),
                            );
                          },
                        )
                        : Container(),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Terms of Usage checkbox
              if (_selectedCoordinatorInfo?.termsOfUsageNaddr != null)
                Row(
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      activeColor: Colors.red,
                      fillColor: WidgetStateProperty.resolveWith<Color?>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.red;
                        }
                        return null;
                      }),
                      checkColor: Colors.white,
                      onChanged: (bool? value) async {
                        if (value != null &&
                            _selectedCoordinatorPubkey != null) {
                          final prefs = await SharedPreferences.getInstance();
                          final key =
                              'terms_accepted_$_selectedCoordinatorPubkey';
                          await prefs.setBool(key, value);
                          setState(() {
                            _termsAccepted = value;
                          });
                        }
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          if (_selectedCoordinatorPubkey != null) {
                            final prefs = await SharedPreferences.getInstance();
                            final key =
                                'terms_accepted_$_selectedCoordinatorPubkey';
                            final newValue = !_termsAccepted;
                            await prefs.setBool(key, newValue);
                            setState(() {
                              _termsAccepted = newValue;
                            });
                          }
                        },
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            children: [
                              TextSpan(
                                text: t.coordinator.selector.termsAccept,
                              ),
                              const TextSpan(text: ' '),
                              TextSpan(
                                text: t.coordinator.selector.termsOfUsage,
                                style: const TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () async {
                                        final url =
                                            'https://njump.to/${_selectedCoordinatorInfo!.termsOfUsageNaddr}';
                                        await launchUrl(
                                          Uri.parse(url),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 24),

              // Generate Invoice button with gradient
              _buildGradientButton(
                onPressed:
                    _selectedCoordinatorPubkey == null ||
                            (supportsCategory && _selectedCategory == null) ||
                            isLoading ||
                            _isLoadingInitialData ||
                            publicKeyAsyncValue.isLoading ||
                            _amountErrorText != null ||
                            _fiatController.text.isEmpty ||
                            _rate == null ||
                            (_selectedCategory == OfferCategory.online &&
                                !_ecommerceRiskAccepted) ||
                            (_selectedCoordinatorInfo?.termsOfUsageNaddr !=
                                    null &&
                                !_termsAccepted)
                        ? null
                        : () {
                          _initiateOffer();
                        },
                child:
                    isLoading
                        ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                        : Text(
                          t.maker.amountForm.actions.generateInvoice,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Trim trailing ".0" so 5.0 -> "5" but 2.5 stays "2.5".
  String _formatPremium(double premium) {
    final s = premium.toStringAsFixed(1);
    return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
  }

  void _showPremiumInfoDialog() {
    final t = Translations.of(context);
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(t.maker.amountForm.labels.premium),
            content: Text(t.maker.amountForm.tooltips.premiumInfo),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(t.common.buttons.close),
              ),
            ],
          ),
    );
  }

  /// Formats a number with spaces as thousand separators
  String _formatNumber(int number) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final formatter = NumberFormat.decimalPattern(localeTag);
    return formatter.format(number);
  }

  String _formatBitcoinAmount(double amount, {bool approximate = false}) {
    final prefix = approximate ? '≈' : '';
    final formatted = _formatNumber(amount.round());
    switch (_bitcoinDisplayUnit) {
      case BitcoinDisplayUnit.sats:
        return '$prefix$formatted sats';
      case BitcoinDisplayUnit.bitcoin:
        return '$prefix₿$formatted';
    }
  }
}
