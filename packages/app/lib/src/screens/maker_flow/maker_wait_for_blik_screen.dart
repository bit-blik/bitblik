import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/logger/logger.dart';
import '../../providers/providers.dart';
import '../../models/offer.dart';
import '../../widgets/progress_indicators.dart';
import '../../../i18n/gen/strings.g.dart';
import 'maker_amount_form.dart'; // For MakerProgressIndicator

class MakerWaitForBlikScreen extends ConsumerStatefulWidget {
  const MakerWaitForBlikScreen({super.key});

  @override
  ConsumerState<MakerWaitForBlikScreen> createState() =>
      _MakerWaitForBlikScreenState();
}

class _MakerWaitForBlikScreenState
    extends ConsumerState<MakerWaitForBlikScreen> {
  Duration? _reservationDuration;
  bool _isLoadingConfig = true;
  String? _configError;

  @override
  void initState() {
    super.initState();
    _loadInitialData(); // Correct: Call _loadInitialData here
  }

  Future<void> _loadInitialData() async {
    if (!mounted) return;
    setState(() {
      _isLoadingConfig = true;
      _configError = null;
    });
    try {
      final apiService = ref.read(apiServiceProvider);
      final offer = ref.read(activeOfferProvider);
      final coordinatorPubkey = offer?.coordinatorPubkey;
      if (coordinatorPubkey == null)
        throw Exception('No coordinator pubkey for active offer');
      final coordinatorInfo = apiService.getCoordinatorInfoByPubkey(
        coordinatorPubkey,
      );
      if (coordinatorInfo == null)
        throw Exception('No coordinator info found for pubkey');
      if (!mounted) return;
      setState(() {
        _reservationDuration = Duration(
          seconds: coordinatorInfo.reservationSeconds,
        );
        _isLoadingConfig = false;
      });
      // Start polling only after config is loaded successfully
      _startStatusCheckTimer();
    } catch (e) {
      if (!mounted) return;
      Logger.log.e(
        () =>
            "[MakerWaitForBlikScreen] Error loading coordinator info:  [1m${e.toString()} [0m",
      );
      setState(() {
        _isLoadingConfig = false;
        _configError = t.system.errors.loadingCoordinatorConfig;
      });
      // Do not start status check timer if config loading failed
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startStatusCheckTimer() {
    // Ensure this is called only after _reservationDuration is set
    if (_reservationDuration == null) {
      Logger.log.w(
        () =>
            "[MakerWaitForBlikScreen] _startStatusCheckTimer called before _reservationDuration is set. Aborting timer start.",
      );
      if (mounted && _configError == null && !_isLoadingConfig) {
        setState(() {
          _configError = t.system.errors.loadingTimeoutConfig;
        });
      }
      return;
    }
    // No longer need timer - will use subscription instead
  }

  void _handleStatusUpdate(OfferStatus? status) async {
    if (status == null) return;

    final offer = ref.read(activeOfferProvider);
    final makerId = ref.read(publicKeyProvider).value;
    final coordinatorPubkey = offer?.coordinatorPubkey;

    if (offer == null || makerId == null || coordinatorPubkey == null) {
      Logger.log.e(
        () =>
            "[MakerWaitForBlik] Error: Missing offer, public key or coordinator pubkey.",
      );
      return;
    }

    Logger.log.d(() => "[MakerWaitForBlik] Status update received: $status");

    if (status == OfferStatus.blikReceived) {
      Logger.log.i(
        () => "[MakerWaitForBlik] BLIK received/sent. Fetching code via API...",
      );

      try {
        final apiService = ref.read(apiServiceProvider);
        final blikCode = await apiService.getBlikCodeForMaker(
          offer.id,
          makerId,
          coordinatorPubkey,
        );
        Logger.log.d(
          () => "[MakerWaitForBlik] API returned blikCode: $blikCode",
        );

        if (blikCode != null && blikCode.isNotEmpty) {
          Logger.log.d(
            () =>
                "[MakerWaitForBlik] BLIK code is valid. Storing in provider...",
          );
          ref.read(receivedBlikCodeProvider.notifier).state = blikCode;
          Logger.log.i(
            () => "[MakerWaitForBlik] Stored BLIK code from API: $blikCode",
          );

          if (mounted) {
            Logger.log.d(
              () =>
                  "[MakerWaitForBlik] Navigating to MakerConfirmPaymentScreen...",
            );
            context.go('/confirm-blik');
          }
        } else {
          Logger.log.e(
            () =>
                "[MakerWaitForBlik] Error: Status is $status but API returned no BLIK code. Resetting.",
          );
          if (mounted) {
            // _resetToRoleSelection(t.system.errors.generic);
          }
        }
      } catch (e) {
        Logger.log.e(
          () => "[MakerWaitForBlik] Error calling getBlikCodeForMaker: $e",
        );
        if (mounted) {
          // _resetToRoleSelection(t.system.errors.generic);
        }
      }
    } else if (status == OfferStatus.funded) {
      Logger.log.i(
        () =>
            "[MakerWaitForBlik] Offer reverted to FUNDED (Taker likely timed out). Popping back.",
      );
      if (mounted) {
        context.go('/wait-taker');
      }
    } else if (status == OfferStatus.reserved) {
      Logger.log.d(
        () => "[MakerWaitForBlik] Still waiting for BLIK (Status: $status).",
      );
    } else {
      Logger.log.w(
        () =>
            "[MakerWaitForBlik] Offer in unexpected state ($status). Resetting.",
      );
      if (mounted) {
        // _resetToRoleSelection(t.system.errors.generic);
      }
    }
  }

  // Future<void> _resetToRoleSelection(String message) async {
  //   await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
  //   ref.read(holdInvoiceProvider.notifier).state = null;
  //   ref.read(paymentHashProvider.notifier).state = null;
  //   ref.read(receivedBlikCodeProvider.notifier).state = null;
  //   ref.read(errorProvider.notifier).state = null;
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (mounted) {
  //       final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
  //       if (scaffoldMessenger != null) {
  //         scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
  //       }
  //       Navigator.of(context).popUntil((route) => route.isFirst);
  //     }
  //   });
  // }

  void _goHome() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    // Watch the active offer to get the latest data
    final offer = ref.watch(activeOfferProvider);

    // Listen to the active offer provider for status changes
    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      if (next != null) {
        // Handle status update only if the status has actually changed
        if (previous == null || previous.status != next.status) {
          _handleStatusUpdate(next.statusEnum);
        }
      }
    });

    if (_isLoadingConfig) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_configError != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_configError!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadInitialData,
                child: Text(t.common.buttons.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (offer == null ||
        offer.reservedAt == null ||
        _reservationDuration == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(t.offers.errors.detailsMissing),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _goHome,
                child: Text(t.common.buttons.goHome),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const MakerProgressIndicator(activeStep: 2),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          t.maker.waitForBlik.messageInfo,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Top section: Message with refresh icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        t.maker.waitForBlik.messageWaiting,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Center: Large circular progress bar with time
                Center(
                  child: CircularCountdownTimer(
                    startTime: offer.reservedAt!,
                    maxDuration: _reservationDuration!,
                    size: 200,
                    strokeWidth: 16,
                    progressColor: Colors.green,
                    backgroundColor: Colors.white,
                    fontSize: 48,
                  ),
                ),

                const SizedBox(height: 30),

                // Bottom section: Offer details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Offer details (bottom left)
                    _buildDetailRow(
                      context,
                      t.offers.details.amountLabel,
                      '${(offer.fiatAmount * 100).round() % 100 == 0 ? offer.fiatAmount.toStringAsFixed(0) : offer.fiatAmount.toStringAsFixed(2)} ${offer.fiatCurrency}',
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      context,
                      t.offers.details.makerFeeLabel,
                      '${offer.makerFees} sats',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
