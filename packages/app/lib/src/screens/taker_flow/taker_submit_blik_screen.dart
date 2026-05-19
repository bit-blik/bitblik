import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ndk/domain_layer/entities/wallet/wallet.dart';
import 'package:ndk/presentation_layer/ndk.dart';
import '../../../i18n/gen/strings.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ndk/shared/logger/logger.dart';

import '../../models/offer.dart';
import '../../models/coordinator_info.dart'; // Added
import '../../providers/providers.dart';
import '../../services/api_service_nostr.dart';
import '../../widgets/progress_indicators.dart'; // Import TakerProgressIndicator
import '../../widgets/lightning_address_widget.dart';

// --- Main Screen Widget ---

class TakerSubmitBlikScreen extends ConsumerStatefulWidget {
  final Offer initialOffer; // Initial offer data (might be incomplete)

  const TakerSubmitBlikScreen({required this.initialOffer, super.key});

  @override
  ConsumerState<TakerSubmitBlikScreen> createState() =>
      _TakerSubmitBlikScreenState();
}

class _TakerSubmitBlikScreenState extends ConsumerState<TakerSubmitBlikScreen> {
  final _blikController = TextEditingController();
  final _blikFocusNode = FocusNode();
  Timer? _blikInputTimer;
  Duration? _maxBlikInputTime; // Will be set from coordinatorInfo
  bool _isLoadingDetails = true; // Flag for initial loading
  CoordinatorInfo? _coordinatorInfo; // Added
  int _previousBlikLength = 0; // Track previous length to detect paste

  @override
  void initState() {
    super.initState();

    // Add listener to rebuild when BLIK code changes
    _blikController.addListener(() {
      final currentLength = _blikController.text.length;

      // Detect paste: if length jumped from <6 to 6, dismiss keyboard
      if (_previousBlikLength < 6 && currentLength == 6) {
        final text = _blikController.text;
        if (int.tryParse(text) != null) {
          // Valid 6-digit code was entered at once (pasted), dismiss keyboard
          _blikFocusNode.unfocus();
        }
      }

      _previousBlikLength = currentLength;

      setState(() {
        // Trigger rebuild to update button state
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _fetchFullOfferDetails();
      }
    });
  }

  Future<void> _fetchFullOfferDetails() async {
    if (!mounted) return;
    setState(() {
      _isLoadingDetails = true;
    });
    ref.read(errorProvider.notifier).state = null;

    try {
      final apiService = ref.read(apiServiceProvider);

      // Fetch CoordinatorInfo first
      try {
        final offer = widget.initialOffer;
        final coordinatorPubkey = offer.coordinatorPubkey;
        _coordinatorInfo = apiService.getCoordinatorInfoByPubkey(
          coordinatorPubkey,
        );
        if (_coordinatorInfo != null) {
          _maxBlikInputTime = Duration(
            seconds: _coordinatorInfo!.reservationSeconds,
          );
        } else {
          // Fallback if coordinator info is somehow null
          _maxBlikInputTime = const Duration(seconds: 20); // Default fallback
          Logger.log.w(
            () =>
                "[TakerSubmitBlikScreen] Warning: CoordinatorInfo was null, using default timeout.",
          );
        }
      } catch (e) {
        Logger.log.e(
          () =>
              "[TakerSubmitBlikScreen] Error fetching coordinator info: $e. Using default timeout.",
        );
        _maxBlikInputTime = const Duration(
          seconds: 20,
        ); // Default fallback on error
        // Optionally, show a non-fatal error to the user or log more verbosely
      }

      final publicKey = ref.read(publicKeyProvider).value;
      if (publicKey == null) {
        throw Exception(t.taker.paymentProcess.errors.noPublicKey);
      }

      final fullOfferData = await apiService.getMyActiveOffer(
        publicKey,
        widget.initialOffer.coordinatorPubkey,
      );

      if (!mounted) return;

      if (fullOfferData == null) {
        throw Exception(t.maker.payInvoice.errors.couldNotFetchActive);
      }

      final fullOffer = Offer.fromJson(fullOfferData);

      // Verify the fetched offer ID matches the initial one
      if (fullOffer.id != widget.initialOffer.id) {
        throw Exception(
          t.taker.submitBlik.errors.fetchedIdMismatch(
            fetchedId: fullOffer.id,
            initialId: widget.initialOffer.id,
          ),
        );
      }
      // --- Validation ---
      if (fullOffer.status != OfferStatus.reserved.name) {
        throw Exception(
          t.reservations.errors.notReserved(status: fullOffer.status),
        );
      }
      if (fullOffer.reservedAt == null) {
        throw Exception(t.reservations.errors.timestampMissing);
      }
      if (fullOffer.holdInvoicePaymentHash == null) {
        throw Exception(t.taker.submitBlik.errors.paymentHashMissing);
      }
      // --- End Validation ---

      // TODO is this really not necessary? then we don't need to getMyActiveOffer
      // await ref.read(activeOfferProvider.notifier).setActiveOffer(fullOffer);
      Logger.log.i(
        () =>
            "[TakerSubmitBlikScreen] Successfully fetched full offer details.",
      );

      // Ensure _maxBlikInputTime is set before starting timer
      if (_maxBlikInputTime == null) {
        Logger.log.e(
          () =>
              "[TakerSubmitBlikScreen] _maxBlikInputTime is null before _startBlikInputTimer. This should not happen.",
        );
        _maxBlikInputTime = Duration(
          seconds: _coordinatorInfo?.reservationSeconds ?? 20,
        );
      }
      _startBlikInputTimer(fullOffer);
      setState(() {
        _isLoadingDetails = false;
      });
      // Focus on BLIK input field after loading completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _blikFocusNode.requestFocus();
        }
      });
    } catch (e) {
      Logger.log.e(
        () => "[TakerSubmitBlikScreen] Error fetching full offer details: $e",
      );
      if (mounted) {
        _resetToOfferList(
          t.offers.errors.loadingDetails(details: e.toString()),
        );
      }
    }
  }

  @override
  void dispose() {
    _blikInputTimer?.cancel();
    _blikController.dispose();
    _blikFocusNode.dispose();
    super.dispose();
  }

  void _startBlikInputTimer(Offer offer) {
    if (_blikInputTimer?.isActive ?? false) return;
    _blikInputTimer?.cancel();
    if (!mounted) return;

    final reservedAt = offer.reservedAt;
    if (reservedAt == null) {
      Logger.log.e(
        () =>
            "[TakerSubmitBlikScreen] Error: reservedAt is null when starting timer. Resetting.",
      );
      _resetToOfferList(t.offers.errors.detailsMissing);
      return;
    }

    final now = DateTime.now();
    // Ensure _maxBlikInputTime is non-null before proceeding
    if (_maxBlikInputTime == null) {
      Logger.log.e(
        () =>
            "[TakerSubmitBlikScreen] Error: _maxBlikInputTime is null in _startBlikInputTimer. Resetting.",
      );
      _resetToOfferList("${t.offers.errors.detailsMissing} (Timeout config)");
      return;
    }

    final expiresAt = reservedAt.add(
      _maxBlikInputTime!,
    ); // Use non-null assertion
    final timeUntilExpiry = expiresAt.difference(now);

    Logger.log.d(
      () =>
          "[TakerSubmitBlikScreen] Starting BLIK input timeout timer for ${_maxBlikInputTime!.inSeconds}s. Expires ~ $expiresAt",
    );

    if (timeUntilExpiry.isNegative) {
      _handleBlikInputTimeout();
    } else {
      _blikInputTimer = Timer(timeUntilExpiry, _handleBlikInputTimeout);
    }
  }

  Future<void> _handleBlikInputTimeout() async {
    _blikInputTimer?.cancel();
    if (mounted) {
      Logger.log.i(() => "[TakerSubmitBlikScreen] BLIK input timer expired.");
      await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
      _resetToOfferList(t.taker.submitBlik.timeExpired);
    }
  }

  Future<void> _resetToOfferList(String message) async {
    _blikInputTimer?.cancel();
    await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
    ref.read(errorProvider.notifier).state = null;
    final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
    Navigator.maybeOf(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.go("/offers");
        if (scaffoldMessenger != null) {
          scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
        }
      }
    });
  }

  Future<void> _submitBlik() async {
    _blikInputTimer?.cancel();

    final offer = widget.initialOffer;
    final blikCode = _blikController.text;
    final takerId = ref.read(publicKeyProvider).value;
    final hasReceivingWallet = await ref.read(
      hasReceivingWalletProvider.future,
    );
    final ndk = ref.read(ndkProvider);

    // --- Validations ---
    if (takerId == null) {
      ref.read(errorProvider.notifier).state =
          t.taker.paymentProcess.errors.noPublicKey;
      _startBlikInputTimer(offer);
      return;
    }
    if (offer.status != OfferStatus.reserved.name || offer.reservedAt == null) {
      ref.read(errorProvider.notifier).state =
          t.taker.submitBlik.errors.stateChanged;
      _resetToOfferList(t.taker.submitBlik.errors.stateNotValid);
      return;
    }
    if (blikCode.isEmpty ||
        blikCode.length != 6 ||
        int.tryParse(blikCode) == null) {
      ref.read(errorProvider.notifier).state =
          t.taker.submitBlik.validation.invalidFormat;
      _startBlikInputTimer(offer);
      return;
    }
    if (!hasReceivingWallet) {
      LightningAddressWidget.showReceivingWalletRequiredDialog(context, ref, t);
      ref.read(errorProvider.notifier).state =
          t.wallet.missingReceiving.message;
      _startBlikInputTimer(offer);
      return;
    }
    if (ndk == null) {
      ref.read(errorProvider.notifier).state = t.system.errors.generic;
      _startBlikInputTimer(offer);
      return;
    }

    final defaultReceivingWallet = ndk.wallets.defaultWalletForReceiving;
    if (defaultReceivingWallet == null || !defaultReceivingWallet.canReceive) {
      LightningAddressWidget.showReceivingWalletRequiredDialog(context, ref, t);
      ref.read(errorProvider.notifier).state =
          t.wallet.missingReceiving.message;
      _startBlikInputTimer(offer);
      return;
    }

    final takerFeeAmount =
        offer.takerFees ??
        (_coordinatorInfo != null
            ? (offer.amountSats * _coordinatorInfo!.takerFee / 100).ceil()
            : 0);
    final amountToInvoiceSats = offer.amountSats - takerFeeAmount;
    if (amountToInvoiceSats <= 0) {
      ref.read(errorProvider.notifier).state = t.system.errors.generic;
      _startBlikInputTimer(offer);
      return;
    }

    late final String takerInvoice;
    try {
      takerInvoice = await _createInvoiceForDefaultReceivingWallet(
        ndk: ndk,
        amountSats: amountToInvoiceSats,
      );
    } catch (e) {
      Logger.log.e(
        () => '[TakerSubmitBlikScreen] Failed to create taker invoice: $e',
      );
      ref.read(errorProvider.notifier).state = t.system.errors.generic;
      _startBlikInputTimer(offer);
      return;
    }
    // --- End Validations ---

    ref.read(isLoadingProvider.notifier).state = true;
    ref.read(errorProvider.notifier).state = null;

    try {
      final apiService = ref.read(apiServiceProvider);
      await apiService.submitBlikCode(
        offerId: offer.id,
        takerId: takerId,
        blikCode: blikCode,
        takerInvoice: takerInvoice,
        coordinatorPubkey: offer.coordinatorPubkey,
      );

      final updatedOffer = offer.copyWith(
        status: OfferStatus.blikReceived.name,
        blikReceivedAt: DateTime.now(),
        blikCode: blikCode,
      );
      await ref.read(activeOfferProvider.notifier).setActiveOffer(updatedOffer);

      Logger.log.i(
        () =>
            "[TakerSubmitBlikScreen] BLIK submitted. Navigating to WaitConfirmation.",
      );
      if (mounted) {
        context.go('/wait-confirmation', extra: updatedOffer);
      }
    } catch (e) {
      ref.read(errorProvider.notifier).state = t.taker.submitBlik.errors
          .submitting(details: e.toString());
      if (mounted) {
        _startBlikInputTimer(offer);
      }
    } finally {
      if (mounted) {
        ref.read(isLoadingProvider.notifier).state = false;
      }
    }
  }

  Future<String> _createInvoiceForDefaultReceivingWallet({
    required Ndk ndk,
    required int amountSats,
  }) async {
    Wallet? wallet = ndk.wallets.defaultWalletForReceiving;
    if (wallet == null) {
      wallet = ndk.wallets
          .getWalletsForUnit('sat')
          .firstWhere(
            (w) => w.canReceive,
            orElse: () => throw Exception('No receiving wallet available'),
          );
      throw Exception('No default receiving wallet configured');
    }
    final result = await ndk.wallets.receive(
      walletId: wallet.id,
      amountSats: amountSats,
    );
    final invoice = _extractBolt11Invoice(result);
    if (invoice != null) {
      return invoice;
    }
    throw Exception('Unable to generate invoice from default receiving wallet');
  }

  String? _extractBolt11Invoice(dynamic value) {
    String? normalize(String? raw) {
      if (raw == null) return null;
      final trimmed = raw.trim();
      final withoutPrefix =
          trimmed.toLowerCase().startsWith('lightning:')
              ? trimmed.substring('lightning:'.length).trim()
              : trimmed;
      if (withoutPrefix.toLowerCase().startsWith('lnbc')) {
        return withoutPrefix;
      }
      return null;
    }

    if (value is String) {
      return normalize(value);
    }

    if (value is Map) {
      final keys = <String>['bolt11', 'invoice', 'payment_request', 'request'];
      for (final key in keys) {
        final candidate = value[key];
        if (candidate is String) {
          final normalized = normalize(candidate);
          if (normalized != null) {
            return normalized;
          }
        }
      }
      return null;
    }

    try {
      final invoice = (value as dynamic).invoice;
      if (invoice is String) {
        return normalize(invoice);
      }
    } catch (_) {}

    try {
      final bolt11 = (value as dynamic).bolt11;
      if (bolt11 is String) {
        return normalize(bolt11);
      }
    } catch (_) {}

    return null;
  }

  Future<void> _pasteFromClipboard() async {
    final textData = await Clipboard.getData(Clipboard.kTextPlain);
    setState(() {
      if (textData != null &&
          textData.text != null &&
          textData.text!.isNotEmpty) {
        Logger.log.d(() => "clipboard.getData:${textData.text}");
        final pastedText = textData.text!;
        final digitsOnly = pastedText.replaceAll(RegExp(r'[^0-9]'), '');
        if (digitsOnly.length == 6) {
          _blikController.text = digitsOnly;
          _blikController.selection = TextSelection.fromPosition(
            TextPosition(offset: _blikController.text.length),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(t.taker.submitBlik.feedback.pasted),
              duration: const Duration(seconds: 1),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.taker.submitBlik.errors.clipboardInvalid)),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final isLoadingDetails = _isLoadingDetails;
    final errorMessage = ref.watch(errorProvider);
    final activeOffer = ref.watch(activeOfferProvider);
    final t = Translations.of(context);

    // if (isLoadingDetails) {
    //   return const Scaffold(
    //     body: Center(
    //       child: CircularProgressIndicator(key: Key("loading_details")),
    //     ),
    //   );
    // }

    // If activeOffer is null after loading, it means fetch failed/reset was called
    if (activeOffer == null) {
      return Scaffold(
        body: Center(child: Text(t.offers.errors.detailsNotLoaded)),
      );
    }

    // Get coordinator info for taker fee calculation
    final coordinatorInfoAsync = ref.watch(
      coordinatorInfoByPubkeyProvider(activeOffer.coordinatorPubkey),
    );

    // Calculate exchange rate and amounts (PLN per BTC) - same as offer details
    final exchangeRate =
        activeOffer.amountSats > 0
            ? ((activeOffer.fiatAmount / activeOffer.amountSats) * 100000000)
                .round()
            : 0;

    // Calculate taker fee from coordinator's percentage - same as offer details
    final takerFeeAmount = coordinatorInfoAsync.maybeWhen(
      data:
          (coordInfo) =>
              coordInfo != null
                  ? (activeOffer.amountSats * coordInfo.takerFee / 100).ceil()
                  : 0,
      orElse: () => 0,
    );

    final youllReceive = activeOffer.amountSats - takerFeeAmount;

    // Format number with spaces as thousand separators - same as offer details
    String formatNumber(int number) {
      final formatter = NumberFormat('#,###', 'en_US');
      return formatter.format(number).replaceAll(',', ' ');
    }

    final blikCode = _blikController.text;

    final validBlik =
        !(blikCode.isEmpty ||
            blikCode.length != 6 ||
            int.tryParse(blikCode) == null);

    // --- Main UI Build ---
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside of text field
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // 3-Step Progress Indicator
              const TakerProgressIndicator(activeStep: 1),
              const SizedBox(height: 10),

              // Instructional text
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      t.taker.submitBlik.instruction,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Circular Countdown Timer
              if (activeOffer.reservedAt != null && _maxBlikInputTime != null)
                CircularCountdownTimer(
                  size: 200,
                  key: ValueKey('blik_timer_${activeOffer.id}'),
                  startTime: activeOffer.reservedAt!,
                  maxDuration: _maxBlikInputTime!,
                  strokeWidth: 16,
                  progressColor: Colors.green,
                  backgroundColor: Colors.white,
                  fontSize: 48,
                )
              else
                const SizedBox(height: 200),
              const SizedBox(height: 20),
              // Large BLIK Input Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                child: TextField(
                  controller: _blikController,
                  focusNode: _blikFocusNode,
                  autofocus: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  // keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 16,
                  ),

                  decoration: InputDecoration(
                    hintText: t.taker.submitBlik.title,
                    hintStyle: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2,
                      color: Colors.grey[400],
                    ),
                    border: InputBorder.none,
                    counterText: "",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.content_paste, size: 32),
                      color: Colors.grey,
                      onPressed: _pasteFromClipboard,
                    ),
                  ),
                ),
              ),

              if (errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 20),

              // Transaction Details Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      t.taker.submitBlik.details.requestedAmount,
                      '${formatDouble(activeOffer.fiatAmount)} ${activeOffer.fiatCurrency}',
                    ),
                    // const SizedBox(height: 12),
                    // // Exchange Rate row with tooltip - same as offer details
                    // _buildInfoRow(
                    //   t.taker.submitBlik.details.exchangeRate,
                    //   '${formatNumber(exchangeRate)} ${activeOffer.fiatCurrency}/BTC',
                    //   hasInfoIcon: true,
                    //   onInfoTap: () => _showExchangeRateSourcesDialog(context),
                    // ),
                    // const SizedBox(height: 12),
                    // // Taker fee row - same as offer details
                    // _buildInfoRow(
                    //   t.offers.details.takerFeeLabel,
                    //   '$takerFeeAmount sats',
                    // ),
                    // const SizedBox(height: 12),
                    // Divider(),
                    // // You'll receive row (highlighted) - same as offer details
                    // _buildInfoRow(
                    //   t.taker.submitBlik.details.youllReceive,
                    //   '$youllReceive sats',
                    //   isHighlighted: true,
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Submit BLIK Button (Gradient with green checkmark)
              Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient:
                      isLoading
                          ? null
                          : LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              validBlik
                                  ? Color(0xFFFF0000)
                                  : Color(0x55FF0000), // Bright red/pink
                              validBlik
                                  ? Color(0xFFFF007F)
                                  : Color(0x55FF007F), // Bright magenta/pink
                            ],
                          ),
                  color: isLoading ? Colors.grey[300] : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: isLoading || !validBlik ? null : _submitBlik,
                    borderRadius: BorderRadius.circular(24),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isLoading) ...[
                            const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ] else ...[
                            const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            t.taker.submitBlik.actions.submit,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isLoading ? Colors.black : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Cancel Reservation Button (Red with border and X)
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed:
                      isLoading
                          ? null
                          : () async {
                            final offer = ref.read(activeOfferProvider);
                            final takerId = ref.read(publicKeyProvider).value;
                            if (offer == null || takerId == null) return;
                            ref.read(isLoadingProvider.notifier).state = true;
                            ref.read(errorProvider.notifier).state = null;
                            try {
                              final apiService = ref.read(apiServiceProvider);
                              await apiService.cancelReservation(
                                offer.id,
                                takerId,
                                offer.coordinatorPubkey,
                              );
                              if (mounted) {
                                _resetToOfferList(
                                  t.reservations.feedback.cancelled,
                                );
                              }
                            } catch (e) {
                              ref.read(errorProvider.notifier).state = t
                                  .reservations
                                  .errors
                                  .cancelling(error: e.toString());
                              if (mounted && offer.reservedAt != null) {
                                _startBlikInputTimer(offer);
                              }
                            } finally {
                              if (mounted) {
                                ref.read(isLoadingProvider.notifier).state =
                                    false;
                              }
                            }
                          },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),

                      // const Icon(Icons.close, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        t.reservations.actions.cancel,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Builds an info row similar to offer details screen
  Widget _buildInfoRow(
    String label,
    String value, {
    bool hasInfoIcon = false,
    bool isHighlighted = false,
    VoidCallback? onInfoTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
            if (hasInfoIcon) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onInfoTap,
                child: Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Shows a dialog with exchange rate sources - same as offer details screen
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
