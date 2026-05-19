import 'dart:async';

import 'package:flutter/material.dart';
import '../../../i18n/gen/strings.g.dart'; // Correct Slang import
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/logger/logger.dart';

import '../../models/offer.dart'; // For OfferStatus enum
import '../../providers/providers.dart';
import '../../widgets/progress_indicators.dart';
import 'maker_amount_form.dart'; // For MakerProgressIndicator

class MakerWaitTakerScreen extends ConsumerStatefulWidget {
  const MakerWaitTakerScreen({super.key});

  @override
  ConsumerState<MakerWaitTakerScreen> createState() =>
      _MakerWaitTakerScreenState();
}

class _MakerWaitTakerScreenState extends ConsumerState<MakerWaitTakerScreen> {
  bool _isCancelling = false;

  @override
  void initState() {
    super.initState();
    final offer = ref.read(activeOfferProvider);
    _handleStatusUpdate(offer?.statusEnum);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleStatusUpdate(OfferStatus? status) async {
    if (status == null) return;

    final offer = ref.read(activeOfferProvider);
    final makerId = ref.read(publicKeyProvider).value;
    final coordinatorPubkey = offer?.coordinatorPubkey;

    if (offer == null || makerId == null || coordinatorPubkey == null) {
      if (offer == null && mounted) {
        _resetToRoleSelection(t.maker.waitTaker.errorActiveOfferDetailsLost);
      }
      return;
    }

    Logger.log.d(() => "[MakerWaitTaker] Status update received: $status");

    if (status == OfferStatus.reserved) {
      if (mounted) {
        context.go('/wait-blik');
      }
    } else if (status == OfferStatus.funded) {
      // Continue waiting
    } else if (status == OfferStatus.blikReceived ||
        status == OfferStatus.blikSentToMaker) {
      try {
        final apiService = ref.read(apiServiceProvider);
        final blikCode = await apiService.getBlikCodeForMaker(
          offer.id,
          makerId,
          coordinatorPubkey,
        );
        if (blikCode != null && blikCode.isNotEmpty) {
          ref.read(receivedBlikCodeProvider.notifier).state = blikCode;
          if (mounted) {
            context.go('/confirm-blik');
          }
        } else {
          if (mounted) {
            // _resetToRoleSelection(t.maker.waitTaker.errorFailedToRetrieveBlik);
          }
        }
      } catch (e) {
        if (mounted) {
          // _resetToRoleSelection(
          //   t.maker.waitTaker.errorRetrievingBlik(details: e.toString()),
          // );
        }
      }
    } else if (status == OfferStatus.expired) {
      if (mounted) {
        // _resetToRoleSelection(
        //   t.maker.waitTaker.offerNoLongerAvailable(status: status.name),
        // );
      }
    } else {
      if (mounted) {
        // _resetToRoleSelection(
        //   t.maker.waitTaker.offerNoLongerAvailable(status: status.name),
        // );
      }
    }
  }

  Future<void> _resetToRoleSelection(String message) async {
    // await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
    ref.read(holdInvoiceProvider.notifier).state = null;
    ref.read(paymentHashProvider.notifier).state = null;
    ref.read(receivedBlikCodeProvider.notifier).state = null;
    ref.read(errorProvider.notifier).state = null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
        if (scaffoldMessenger != null) {
          scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
        }
        context.go("/");
      }
    });
  }

  Future<void> _cancelOffer() async {
    final offer = ref.read(activeOfferProvider);
    final makerPubKey = ref.read(publicKeyProvider).value;

    if (offer == null || makerPubKey == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.maker.waitTaker.errorCouldNotIdentifyOffer)),
        );
      }
      return;
    }
    if (offer.status != OfferStatus.funded.name) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.maker.waitTaker.offerCannotBeCancelled(status: offer.status),
            ),
          ),
        );
      }
      return;
    }

    setState(() {
      _isCancelling = true;
    });
    ref.read(errorProvider.notifier).state = null;

    try {
      final apiService = ref.read(apiServiceProvider);
      await apiService.cancelOffer(offer.id, offer.coordinatorPubkey);
      _resetToRoleSelection(t.maker.waitTaker.offerCancelledSuccessfully);
    } catch (e) {
      if (mounted) {
        final errorMsg = t.maker.waitTaker.failedToCancelOffer(
          details: e.toString(),
        );
        ref.read(errorProvider.notifier).state = errorMsg;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCancelling = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the active offer provider to get real-time status updates
    final offer = ref.watch(activeOfferProvider);
    final t = Translations.of(context);

    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      if (next != null && mounted) {
        _handleStatusUpdate(next.statusEnum);
      }
    });

    if (offer == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Progress indicator (Step 2: Wait for Taker)
                const MakerProgressIndicator(activeStep: 2),
                const SizedBox(height: 20),
                // Top section: Message with refresh icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        t.maker.waitTaker.message,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Center: Large circular progress bar with time
                Center(
                  child:
                      offer.status == OfferStatus.funded.name
                          ? CircularCountdownTimer(
                            startTime: offer.createdAt,
                            maxDuration: const Duration(minutes: 10),
                            size: 200,
                            strokeWidth: 16,
                            progressColor: Colors.green,
                            backgroundColor: Colors.white,
                            fontSize: 48,
                          )
                          : const CircularProgressIndicator(),
                ),

                const SizedBox(height: 30),

                // Bottom section: Offer details and Cancel button
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
                      t.maker.amountForm.labels.fee,
                      '${offer.makerFees} sats',
                    ),
                    const SizedBox(height: 30),

                    // Error message
                    Consumer(
                      builder: (context, ref, _) {
                        final error = ref.watch(errorProvider);
                        if (error != null &&
                            error.startsWith(
                              t.maker.waitTaker
                                  .failedToCancelOffer(details: '')
                                  .split(' {details}')[0],
                            )) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              error,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    // Cancel Offer button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed:
                            _isCancelling ||
                                    (offer.status != OfferStatus.funded.name)
                                ? null
                                : _cancelOffer,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:
                            _isCancelling
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.red,
                                    ),
                                  ),
                                )
                                : Row(
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
                                    const SizedBox(width: 8),
                                    Text(
                                      t.offers.actions.cancel,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                      ),
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
