import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'all seven taker locales resolve native charge-report feedback',
    () async {
      final english = await AppLocale.en.build();
      expect(AppLocale.values, hasLength(7));
      final pendingMessages = <String>{};
      final acknowledgments = <String>{};
      final recoveryLabels = <String>{};
      for (final locale in AppLocale.values) {
        final strings = await locale.build();
        final wait = strings.taker.waitConfirmation;
        final pending = wait.errors.reportingConflictUnconfirmed;
        final acknowledgment = wait.feedback.chargeReported;
        final recovery = wait.expiredActions.checkReportStatus;
        expect(pending, isNotEmpty, reason: locale.languageCode);
        expect(acknowledgment, isNotEmpty, reason: locale.languageCode);
        expect(recovery, isNotEmpty, reason: locale.languageCode);
        if (locale != AppLocale.en) {
          expect(
            pending,
            isNot(
              english
                  .taker
                  .waitConfirmation
                  .errors
                  .reportingConflictUnconfirmed,
            ),
            reason: '${locale.languageCode} must not fall back to English',
          );
        }
        pendingMessages.add(pending);
        acknowledgments.add(acknowledgment);
        recoveryLabels.add(recovery);
      }
      expect(pendingMessages, hasLength(7));
      expect(acknowledgments, hasLength(7));
      expect(recoveryLabels, hasLength(7));
    },
  );
}
