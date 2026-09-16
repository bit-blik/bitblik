import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dispute_case_repository.dart';

/// Compact controls keep the conversation visible; full diagnostics scroll in
/// a separate sheet and can be copied without truncating backend errors.
class PaymentDiagnosticsPanel extends StatelessWidget {
  final CoordinatorDisputeCase item;
  final bool busy;
  final VoidCallback onRetry;

  const PaymentDiagnosticsPanel({
    super.key,
    required this.item,
    required this.busy,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final data = item.paymentDiagnostics;
    final attempts = (data['attempts'] as List?) ?? const [];
    final errors = (data['state_errors'] as List?) ?? const [];
    final latest = data['last_error'] is Map
        ? data['last_error'] as Map
        : errors.firstOrNull;
    final message = latest is Map ? latest['message']?.toString() : null;
    final attemptError = attempts.firstOrNull is Map
        ? (attempts.first as Map)['failure_reason']?.toString()
        : null;
    final error = message ?? attemptError ?? data['offer_error']?.toString();
    final refund = const {
      'refundingMaker',
      'payingMaker',
    }.contains(item.offer.statusRaw);
    final missingInstruction = refund && !item.makerRefundInvoiceReady;
    final supported = data['retry_supported'] == true;
    final processing = data['processing'] == true;
    final retryable =
        supported &&
        item.paymentBackendAvailable &&
        !missingInstruction &&
        !busy &&
        !processing;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (error != null && error.isNotEmpty)
            Text(
              'Latest recorded error: $error',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          if (supported)
            Text(
              missingInstruction
                  ? 'Waiting for the maker to submit a refund invoice or offer.'
                  : processing
                  ? 'Payment check running. Refresh for its result.'
                  : 'Retry checks the existing payment first. Pending or unknown payments are not sent again.',
            ),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (supported)
                FilledButton.tonalIcon(
                  onPressed: retryable ? onRetry : null,
                  icon: const Icon(Icons.refresh),
                  label: Text(
                    refund ? 'Retry maker refund' : 'Retry taker payment',
                  ),
                ),
              TextButton.icon(
                onPressed: () => _showDetails(context),
                icon: const Icon(Icons.receipt_long),
                label: Text('Payment details (${attempts.length})'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context) {
    final data = <String, dynamic>{
      'offer_id': item.offer.id,
      'offer_state': item.offer.statusRaw,
      'active_backend': item.paymentBackendType,
      'backend_available': item.paymentBackendAvailable,
      ...item.paymentDiagnostics,
    };
    final json = const JsonEncoder.withIndent('  ').convert(data);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.85,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 16,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Payment diagnostics',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy details'),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: json));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Payment details copied.'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              Text(
                'Backend: ${item.paymentBackendType} · State: ${item.offer.statusRaw}',
              ),
              const SizedBox(height: 12),
              if (item.paymentDiagnostics.isEmpty)
                const Text(
                  'This coordinator does not provide payment diagnostics yet.',
                ),
              Expanded(
                child: SingleChildScrollView(child: SelectableText(json)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
