import 'package:bitblik/src/utils/code_label_ext.dart';
import '../../../i18n/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/logger/logger.dart';

import 'package:bitblik_core/core.dart';
import '../../flow/flow_provider.dart' show flowRoute;
import '../../providers/providers.dart';
import '../../services/nostr_service.dart' show reservedOfferFromResult;
import '../../widgets/progress_indicators.dart'; // Import providers

class TakerInvalidBlikScreen extends ConsumerStatefulWidget {
  final Offer offer;

  const TakerInvalidBlikScreen({required this.offer, super.key});

  @override
  ConsumerState<TakerInvalidBlikScreen> createState() =>
      _TakerInvalidBlikScreenState();
}

class _TakerInvalidBlikScreenState
    extends ConsumerState<TakerInvalidBlikScreen> {
  bool _isLoading = false; // State variable for loading indicator

  /// Shows an irreversible-action warning. Returns true only if the user
  /// explicitly confirms they were NOT charged and want to proceed.
  Future<bool> _confirmNotCharged() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 48,
          ),
          title: Text(t.taker.invalidBlik.confirmDialog.title),
          content: Text(t.taker.invalidBlik.confirmDialog.content),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(t.taker.invalidBlik.confirmDialog.actions.cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(t.taker.invalidBlik.confirmDialog.actions.proceed),
            ),
          ],
        );
      },
    );
    return confirmed ?? false;
  }

  /// Confirms the user really was charged before opening a dispute.
  Future<bool> _confirmDispute() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(Icons.gavel_rounded, color: Colors.orange, size: 48),
          title: Text(t.taker.invalidBlik.disputeConfirmDialog.title),
          content: Text(t.taker.invalidBlik.disputeConfirmDialog.content),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                t.taker.invalidBlik.disputeConfirmDialog.actions.cancel,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                t.taker.invalidBlik.disputeConfirmDialog.actions.proceed,
              ),
            ),
          ],
        );
      },
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(t.taker.invalidBlik.title),
      //   automaticallyImplyLeading: false, // Prevent back navigation
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // 3-Step Progress Indicator
            const TakerProgressIndicator(activeStep: 2),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      t.taker.invalidBlik.message(
                        code:
                            ref
                                .read(selectedPaymentSystemProvider)
                                .localizedCodeLabel,
                      ),
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                      size: 120,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t.taker.invalidBlik.explanation(
                        code:
                            ref
                                .read(selectedPaymentSystemProvider)
                                .localizedCodeLabel,
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      t.taker.invalidBlik.werentCharged,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (!await _confirmNotCharged()) {
                          return;
                        }
                        Logger.log.d(
                          () =>
                              "[TakerInvalidBlikScreen] Retry selected for offer ${offer.id}",
                        );

                        final userPublicKey = await ref.read(
                          publicKeyProvider.future,
                        );

                        final takerId = userPublicKey;
                        final apiService = ref.read(apiServiceProvider);
                        final reservation = await apiService.reserveOffer(
                          offer.id,
                          takerId!,
                          offer.coordinatorPubkey,
                        );

                        if (reservation.reservedAt != null ||
                            reservation.offer != null) {
                          final Offer updatedOffer = reservedOfferFromResult(
                            offer,
                            takerId,
                            reservation,
                          );

                          await ref
                              .read(activeOfferProvider.notifier)
                              .setActiveOffer(updatedOffer);

                          context.go(flowRoute, extra: updatedOffer);
                        } else {
                          // Handle reservation failure
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                t.taker.invalidBlik.errors.reservationFailed,
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          t.taker.invalidBlik.actions.retry(
                            code:
                                ref
                                    .read(selectedPaymentSystemProvider)
                                    .localizedCodeLabel,
                          ),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed:
                          _isLoading
                              ? null
                              : () async {
                                if (!await _confirmNotCharged()) {
                                  return;
                                }
                                setState(() {
                                  _isLoading = true;
                                });
                                final apiService = ref.read(apiServiceProvider);
                                final userPublicKey = await ref.read(
                                  publicKeyProvider.future,
                                );

                                if (userPublicKey == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t
                                            .maker
                                            .confirmPayment
                                            .errors
                                            .missingHashOrKey,
                                      ),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  return;
                                }

                                try {
                                  Logger.log.d(
                                    () =>
                                        "[TakerInvalidBlikScreen] Canceling reservation for offer ${offer.id} by taker $userPublicKey",
                                  );
                                  await apiService.cancelReservation(
                                    offer.id,
                                    userPublicKey,
                                    offer.coordinatorPubkey,
                                  );

                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          t.reservations.feedback.cancelled,
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    await ref
                                        .read(activeOfferProvider.notifier)
                                        .setActiveOffer(null);
                                    context.go('/offers');
                                  }
                                } catch (e) {
                                  Logger.log.d(
                                    () =>
                                        "[TakerInvalidBlikScreen] Error canceling reservation: $e",
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t.reservations.errors.cancelling(
                                          error: e.toString(),
                                        ),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                }
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfff5f5f5),
                        foregroundColor: Colors.black,
                      ),
                      child:
                          _isLoading
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Text(
                                  t.taker.invalidBlik.actions.cancelReservation,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      t.taker.invalidBlik.wereCharged,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed:
                          _isLoading
                              ? null
                              : () async {
                                if (!await _confirmDispute()) {
                                  return;
                                }
                                setState(() {
                                  _isLoading = true;
                                });
                                final apiService = ref.read(apiServiceProvider);
                                final userPublicKey = await ref.read(
                                  publicKeyProvider.future,
                                );

                                if (userPublicKey == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t
                                            .maker
                                            .confirmPayment
                                            .errors
                                            .missingHashOrKey,
                                      ),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  return;
                                }

                                try {
                                  Logger.log.d(
                                    () =>
                                        "[TakerInvalidBlikScreen] Reporting conflict for offer ${offer.id} by taker $userPublicKey",
                                  );
                                  await apiService.markBlikCharged(
                                    offer.id,
                                    offer.coordinatorPubkey,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t
                                            .taker
                                            .invalidBlik
                                            .feedback
                                            .conflictReportedSuccess,
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  if (mounted) {
                                    context.go(flowRoute, extra: offer.id);
                                  }
                                } catch (e) {
                                  Logger.log.d(
                                    () =>
                                        "[TakerInvalidBlikScreen] Error reporting conflict: $e",
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t.taker.invalidBlik.errors
                                            .conflictReport(
                                              details: e.toString(),
                                            ),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                }
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        foregroundColor: Colors.white,
                      ),
                      child:
                          _isLoading
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : Text(
                                t.taker.invalidBlik.actions.reportConflict,
                              ),
                    ),
                    // const SizedBox(height: 20),
                    // TextButton(
                    //   onPressed: () async {
                    //     // PILA no no no, we should cancel the reservation and go back to funded, TODO!!!!
                    //     // await ref
                    //     //     .read(activeOfferProvider.notifier)
                    //     //     .setActiveOffer(null);
                    //     context.go('/offers');
                    //   },
                    //   child: Text(t.common.actions.cancelAndReturnToOffers),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
