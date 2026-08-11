import '../../i18n/gen/strings.g.dart';
import 'package:flutter/material.dart';

/// Requires an explicit acknowledgement before abandoning/replacing a code
/// which may already have charged the taker's bank account.
Future<bool> showCriticalCodeDecisionDialog(
  BuildContext context, {
  required String code,
}) async {
  final strings = Translations.of(context).taker.criticalCodeDecision;
  final colors = Theme.of(context).colorScheme;
  final confirmed = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder:
        (dialogContext) => AlertDialog(
          icon: Icon(Icons.dangerous_outlined, color: colors.error, size: 52),
          title: Text(strings.title, textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(strings.explanation(code: code)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.error, width: 2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.warning_rounded, color: colors.error),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              strings.warningTitle,
                              style: TextStyle(
                                color: colors.onErrorContainer,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              strings.warningBody(code: code),
                              style: TextStyle(
                                color: colors.onErrorContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actionsOverflowDirection: VerticalDirection.up,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(strings.actions.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colors.error,
                foregroundColor: colors.onError,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(strings.actions.proceed),
            ),
          ],
        ),
  );
  return confirmed ?? false;
}

/// A safe-area action footer that keeps the taker's charged/dispute action
/// visible even on short mobile screens.
class CriticalChargedActionBar extends StatelessWidget {
  final String label;
  final String? prompt;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Key? actionKey;

  const CriticalChargedActionBar({
    super.key,
    required this.label,
    required this.onPressed,
    this.prompt,
    this.isLoading = false,
    this.actionKey,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      elevation: 12,
      color: colors.surface,
      child: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (prompt != null) ...[
              Text(
                prompt!,
                style: const TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            FilledButton.icon(
              key: actionKey,
              style: FilledButton.styleFrom(
                backgroundColor: colors.error,
                foregroundColor: colors.onError,
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: onPressed,
              icon:
                  isLoading
                      ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Icon(Icons.report_problem_outlined),
              label: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
