import 'package:bitblik/src/utils/code_label_ext.dart';
import '../../../i18n/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/logger/logger.dart';

import 'package:bitblik_core/core.dart';
import '../../flow/flow_provider.dart' show flowEngineProvider, flowRoute;
import '../../flow/flow_timeout.dart';
import '../../providers/providers.dart';

class TakerConflictScreen extends ConsumerStatefulWidget {
  final Offer? offer;

  final FlowEngine? engine;
  final String? offerId;

  const TakerConflictScreen({
    super.key,
    this.offer,
    this.engine,
    this.offerId,
  });

  @override
  ConsumerState<TakerConflictScreen> createState() =>
      _TakerConflictScreenState();
}

class _TakerConflictScreenState extends ConsumerState<TakerConflictScreen> {
  @override
  Widget build(BuildContext context) {
    final activeOffer = ref.watch(activeOfferProvider);
    final offer = widget.offer ?? activeOffer;
    final engine = widget.engine ?? ref.watch(flowEngineProvider).valueOrNull;

    // Listen to active offer provider for status changes
    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      final expectedOfferId = widget.offer?.id ?? widget.offerId;
      if (next != null &&
          (expectedOfferId == null || next.id == expectedOfferId)) {
        // Handle status update only if the status has actually changed
        if (previous == null || previous.status != next.status) {
          _handleStatusUpdate(next.statusEnum, context);
        }
      }
    });

    if (offer == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.taker.conflict.title),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Icon(
              Icons.warning_amber_rounded,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            Text(
              t.taker.conflict.headline,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              t.taker.conflict.body(
                code:
                    paymentSystemForOffer(offer).localizedCodeLabel,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.hourglass_top_rounded),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.taker.conflict.instructions),
                          const SizedBox(height: 12),
                          if (engine != null)
                            FlowCountdown(
                              deadline: flowStateDeadline(
                                engine,
                                offer.statusRaw,
                                offer,
                              ),
                              label:
                                  (time) => t.taker.conflict.timeoutLabel(
                                    time: time,
                                  ),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: Text(t.taker.conflict.actions.back),
            ),
          ],
        ),
      ),
    );
  }

  void _handleStatusUpdate(OfferStatus statusEnum, BuildContext context) {
    Logger.log.i(
      () => "[TakerConflictScreen] Offer status updated to ${statusEnum.name}",
    );

    // Navigate to payment process screen for successful payment statuses
    if (statusEnum == OfferStatus.makerConfirmed ||
        statusEnum == OfferStatus.settled ||
        statusEnum == OfferStatus.payingTaker ||
        statusEnum == OfferStatus.takerPaid) {
      Logger.log.d(
        () =>
            "[TakerConflictScreen] Status is ${statusEnum.name}. Navigating to payment process screen.",
      );
      if (mounted) {
        context.go(flowRoute);
      }
    }
    // Navigate to payment failed screen
    else if (statusEnum == OfferStatus.takerPaymentFailed) {
      Logger.log.d(
        () =>
            "[TakerConflictScreen] Status is takerPaymentFailed. Navigating to payment failed screen.",
      );
      if (mounted) {
        final offer = ref.read(activeOfferProvider);
        if (offer != null) {
          context.go(flowRoute, extra: offer);
        }
      }
    }
  }
}
