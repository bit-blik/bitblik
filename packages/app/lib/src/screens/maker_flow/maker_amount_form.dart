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
import '../../providers/providers.dart';
import '../../services/api_service_nostr.dart';
// CoordinatorRecord comes from bitblik_core

// Progress indicator widget for maker flow
class MakerProgressIndicator extends StatelessWidget {
  final int activeStep; // 1, 2, or 3

  const MakerProgressIndicator({super.key, this.activeStep = 1});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
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
            t.maker.amountForm.progress.step3,
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

class MakerAmountForm extends ConsumerStatefulWidget {
  const MakerAmountForm({super.key});

  @override
  ConsumerState<MakerAmountForm> createState() => _MakerAmountFormState();
}

class _MakerAmountFormState extends ConsumerState<MakerAmountForm> {
  final _fiatController = TextEditingController();
  final _amountFocusNode = FocusNode(); // Add FocusNode for amount input
  double? _satsEquivalent;
  double? _rate;
  String? _amountErrorText;

  bool _isLoadingInitialData = true;
  String? _coordinatorInfoError;

  String? _selectedCoordinatorPubkey; // Remember selected coordinator pubkey
  CoordinatorInfo? _selectedCoordinatorInfo;
  bool _termsAccepted = false; // Track if terms of usage are accepted
  bool _hasTriedAutoSelect = false; // Track if we've tried to auto-select
  OfferCategory? _selectedCategory = OfferCategory.shop;
  bool _ecommerceRiskAccepted = false;

  @override
  void initState() {
    super.initState();
    _fiatController.addListener(_validateAndRecalculate);
    _loadInitialData();
    _loadEcommerceRiskAccepted();

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
    _fiatController.dispose();
    _amountFocusNode.dispose(); // Dispose the FocusNode
    super.dispose();
  }

  Future<void> _loadEcommerceRiskAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _ecommerceRiskAccepted = prefs.getBool('maker_ecommerce_risk_accepted') ?? false;
    });
  }

  Future<void> _saveEcommerceRiskAccepted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('maker_ecommerce_risk_accepted', value);
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
      final rate = await apiService.getBtcPlnRate();
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
        final firstCoordinator = responsiveCoordinators.first;
        _selectCoordinator(firstCoordinator);
      }
    }
  }

  Future<void> _selectCoordinator(CoordinatorRecord coordinator) async {
    final supportsCategory = _supportsOfferCategory(coordinator.version);
    setState(() {
      _selectedCoordinatorPubkey = coordinator.pubkey;
      _selectedCoordinatorInfo = coordinator.toCoordinatorInfo();
      if (!supportsCategory) {
        _selectedCategory = null;
        _ecommerceRiskAccepted = false;
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
    CoordinatorRecord? fittingCoordinator;
    final enabledAsync = ref.read(enabledCoordinatorsProvider);
    final enabled =
        enabledAsync is AsyncData<List<CoordinatorRecord>>
            ? enabledAsync.value
            : const <CoordinatorRecord>[];

    if (currentError == null && sats != null && enabled.isNotEmpty) {
      final satsInt = sats.round();
      for (final c in enabled) {
        if (c.responsive == true &&
            satsInt >= c.minAmountSats &&
            satsInt <= c.maxAmountSats) {
          fittingCoordinator = c;
          break;
        }
      }
      // Fall back to any (even non-responsive) match for range messaging.
      CoordinatorRecord? anyMatch = fittingCoordinator;
      if (anyMatch == null) {
        for (final c in enabled) {
          if (satsInt >= c.minAmountSats && satsInt <= c.maxAmountSats) {
            anyMatch = c;
            break;
          }
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
            currency: "PLN",
          );
        } else if (parsedFiat > maxFiat) {
          currentError = t.exchange.errors.tooHighFiat(
            maxAmount: maxFiat.toStringAsFixed(0),
            currency: "PLN",
          );
        }
      }
    }

    setState(() {
      _amountErrorText = currentError;
      _satsEquivalent = (currentError == null) ? sats : null;

      // If currently-selected coordinator no longer fits the amount,
      // switch to a fitting one when available (don't just deselect —
      // that surprises users when another coordinator does support it).
      final satsInt = _satsEquivalent?.round();
      final selectedInfo = _selectedCoordinatorInfo;
      if (satsInt != null && selectedInfo != null) {
        final outOfRange =
            satsInt < selectedInfo.minAmountSats ||
            satsInt > selectedInfo.maxAmountSats;
        if (outOfRange) {
          if (fittingCoordinator != null) {
            // Schedule async select; can't await inside setState.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _selectCoordinator(fittingCoordinator!);
            });
          } else {
            _selectedCoordinatorPubkey = null;
            _selectedCoordinatorInfo = null;
            _hasTriedAutoSelect = false;
          }
        }
      }
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
          content: Text(t.maker.amountForm.errors.ecommerceConfirmationRequired),
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
        category: supportsCategory ? _selectedCategory : null,
        coordinatorPubkey: coordinatorPubkey,
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
              fiatCurrency: "PLN", // TODO
              createdAt: DateTime.now(),
              holdInvoicePaymentHash: paymentHash,
              holdInvoice: result['holdInvoice'],
              makerPubkey: makerId,
              coordinatorPubkey: coordinatorPubkey,
              category: supportsCategory ? _selectedCategory : null,
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

  /// Shows a dialog with exchange rate sources
  void _showExchangeRateSourcesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      ApiServiceNostr.exchangeRateSourceNames
                          .map(
                            (source) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Text(
                                source,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
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
      final coordinators = _filterByAmount(coordinatorsAsync.value);
      if (coordinators.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.maker.amountForm.errors.noCoordinatorMatchesAmount),
          ),
        );
        return;
      }
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
                                  color:
                                      (coordinator.responsive == false ||
                                              coordinator.responsive == null)
                                          ? Colors.grey
                                          : null,
                                ),
                              ),
                              if (coordinator.responsive == true)
                                const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 18,
                                  ),
                                ),
                              const Spacer(),
                              if (_selectedCoordinatorPubkey ==
                                  coordinator.pubkey)
                                Icon(
                                  Icons.check,
                                  color: Theme.of(context).primaryColor,
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
                                  currency: 'PLN',
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                t.coordinator.info.feeDisplay(fee: feePct),
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap:
                          (coordinator.responsive == false ||
                                  coordinator.responsive == null)
                              ? null
                              : () {
                                Navigator.of(context).pop();
                                _selectCoordinator(coordinator);
                              },
                      tileColor:
                          (coordinator.responsive == false ||
                                  coordinator.responsive == null)
                              ? Colors.grey.withValues(alpha: 0.15)
                              : null,
                    );
                  }).toList(),
            ),
          );
        },
      );
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

  Widget _categoryIconWidget(OfferCategory category, double size, Color color) {
    final asset = _categoryAsset(category);
    if (asset != null) {
      return Image.asset(asset, width: size, height: size);
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
                          t.maker.amountForm.category.physicalShopHint,
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
                              t.maker.amountForm.category.ecommerceWarningBody,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.4,
                              ),
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
                            setState(() { _ecommerceRiskAccepted = v; });
                            setDialogState(() {});
                            _saveEcommerceRiskAccepted(v);
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              final v = !_ecommerceRiskAccepted;
                              setState(() { _ecommerceRiskAccepted = v; });
                              setDialogState(() {});
                              _saveEcommerceRiskAccepted(v);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                t.maker.amountForm.category.ecommerceConfirmation,
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

  bool _supportsOfferCategory(String? version) {
    if (version == null || version.trim().isEmpty) return false;
    final parsed = _parseVersion(version);
    if (parsed == null) return false;
    const min = [0, 7, 0];
    for (var i = 0; i < 3; i++) {
      if (parsed[i] > min[i]) return true;
      if (parsed[i] < min[i]) return false;
    }
    return true;
  }

  List<int>? _parseVersion(String raw) {
    final match = RegExp(r'^v?(\d+)\.(\d+)\.(\d+)').firstMatch(raw.trim());
    if (match == null) return null;
    return [
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    ];
  }

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

    // Auto-select coordinator when they become available (only once)
    if (coordinatorsAsync is AsyncData<List<CoordinatorRecord>> &&
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

              // Large amount input field
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
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
                    const Text(
                      'PLN',
                      style: TextStyle(
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

              if (supportsCategory) ...[
                Row(
                  children:
                      OfferCategory.values.map((category) {
                        final selected = _selectedCategory == category;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right:
                                  category != OfferCategory.values.last ? 8 : 0,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(999),
                              onTap: () {
                                if (selected) {
                                  _showCategoryInfoDialog(category);
                                } else {
                                  setState(() {
                                    _selectedCategory = category;
                                    if (category !=
                                        OfferCategory.online) {
                                      _ecommerceRiskAccepted = false;
                                    }
                                  });
                                }
                              },
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
                                      selected
                                          ? const Color(0xFFFFF2F6)
                                          : Colors.white,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: selected
                                              ? Colors.red
                                              : Colors.grey.shade400,
                                          width: selected ? 4.5 : 1.5,
                                        ),
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    _categoryIconWidget(
                                      category,
                                      36,
                                      selected
                                          ? Colors.red
                                          : Colors.grey[700]!,
                                    ),
                                    if (selected &&
                                        category ==
                                            OfferCategory.online) ...[
                                      const SizedBox(width: 4),
                                      Checkbox(
                                        value: _ecommerceRiskAccepted,
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        activeColor: Colors.red,
                                        onChanged: (value) {
                                          final v = value ?? false;
                                          setState(() { _ecommerceRiskAccepted = v; });
                                          _saveEcommerceRiskAccepted(v);
                                        },
                                      ),
                                    ],
                                    if (category ==
                                            OfferCategory.atm ||
                                        category ==
                                            OfferCategory.online) ...[
                                      const SizedBox(width: 5),
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        size: 18,
                                        color:
                                            selected
                                                ? Colors.orange
                                                : Colors.grey[400],
                                      ),
                                    ],
                                  ],
                                ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(growable: false),
                ),
                const SizedBox(height: 16),
              ],

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
                            if (_selectedCoordinatorInfo != null) ...[
                              if (_selectedCoordinatorInfo!.icon != null &&
                                  _selectedCoordinatorInfo!.icon!.isNotEmpty)
                                (_selectedCoordinatorInfo!.icon!.startsWith(
                                      'http',
                                    )
                                    ? Image.network(
                                      _selectedCoordinatorInfo!.icon!,
                                      width: 16,
                                      height: 16,
                                    )
                                    : Image.asset(
                                      _selectedCoordinatorInfo!.icon!,
                                      width: 16,
                                      height: 16,
                                    ))
                              else
                                const Icon(Icons.account_circle, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                _selectedCoordinatorInfo!.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.info_outline, size: 20),
                              // IconButton(
                              //   icon: const Icon(Icons.info, size: 20),
                              //   color: Colors.grey,
                              //   padding: EdgeInsets.zero,
                              //   constraints: const BoxConstraints(),
                              //   onPressed: () {
                              //     // Refresh coordinator list
                              //     ref.invalidate(enabledCoordinatorsProvider);
                              //   },
                              // ),
                            ] else
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    t.maker.amountForm.labels.tapToSelect,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                          ],
                        ),
                        infoIcon: Icons.arrow_drop_down_sharp,
                      ),
                    ),

                    // Exchange Rate row
                    _buildDetailRow(
                      t.maker.amountForm.labels.exchangeRate,
                      Text(
                        _rate != null
                            ? '${_formatNumber(_rate!.round())} PLN / BTC'
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
                    _buildDetailRow(
                      t.maker.amountForm.labels.fee,
                      Text(
                        (_selectedCoordinatorInfo != null &&
                                _satsEquivalent != null)
                            ? '≈${(_satsEquivalent! * _selectedCoordinatorInfo!.makerFee / 100).toStringAsFixed(0)} sats'
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

                    const Divider(height: 16),

                    // Satoshis to pay row
                    _selectedCoordinatorInfo != null
                        ? _buildDetailRow(
                          t.maker.amountForm.labels.satoshisToPay,
                          Text(
                            _satsEquivalent != null
                                ? "≈${(_satsEquivalent! + (_satsEquivalent! * _selectedCoordinatorInfo!.makerFee / 100)).toStringAsFixed(0)}"
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

  /// Formats a number with spaces as thousand separators
  String _formatNumber(int number) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final formatter = NumberFormat.decimalPattern(localeTag);
    return formatter.format(number);
  }
}
