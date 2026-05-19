import 'package:bitblik_coordinator/src/logging/app_logger.dart';
import 'package:test/test.dart';

void main() {
  group('AppLogger offer id normalization', () {
    test('does not infer non-uuid token after offer keyword', () {
      final inferred = AppLogger.inferOfferIdFromMessage(
        'Expired funded offer check complete. Marked 0 offers as expired.',
      );
      expect(inferred, isNull);
    });

    test('infers uuid-like offer id from message', () {
      const offerId = '123e4567-e89b-12d3-a456-426614174000';
      final inferred = AppLogger.inferOfferIdFromMessage(
        'Offer $offerId status updated to funded.',
      );
      expect(inferred, offerId);
    });

    test('normalizes invalid explicit offer id to null', () {
      expect(AppLogger.normalizeOfferId('check'), isNull);
      expect(AppLogger.normalizeOfferId(''), isNull);
      expect(AppLogger.normalizeOfferId('   '), isNull);
    });
  });
}
