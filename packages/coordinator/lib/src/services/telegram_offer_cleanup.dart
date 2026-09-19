import 'dart:async';

import 'database_service.dart';
import 'telegram_service.dart';

/// Reconcile persisted Telegram message references with committed offer state.
/// No RPC waits for Telegram. Existing rows survive failed calls and restarts;
/// only the exact successfully reconciled message reference is removed.
class TelegramOfferCleanup {
  final DatabaseService database;
  final TelegramService telegram;
  final void Function(Object) onError;
  final Duration interval;
  static const pageSize = 100;
  Timer? _timer;
  Future<void>? _running;
  String? _cursor;
  bool _closed = false;
  bool _requested = false;

  TelegramOfferCleanup({
    required this.database,
    required this.telegram,
    required this.onError,
    this.interval = const Duration(seconds: 30),
  });

  void start() {
    if (_closed || _timer != null) return;
    _timer = Timer.periodic(interval, (_) => wake());
    wake();
  }

  void wake() => unawaited(reconcile());

  Future<void> reconcile() {
    if (_closed) return Future.value();
    _requested = true;
    return _running ??= _drain().whenComplete(() => _running = null);
  }

  Future<void> _drain() async {
    while (_requested && !_closed) {
      _requested = false;
      try {
        final ids = await database.getTelegramCleanupOfferIds(
            afterId: _cursor, limit: pageSize);
        // Cursor advances past failed rows too, so one broken chat cannot
        // starve later offers. Wrap after the final page on the next tick.
        _cursor = ids.length == pageSize ? ids.last : null;
        for (var index = 0; index < ids.length && !_closed; index += 2) {
          await Future.wait(ids.skip(index).take(2).map(_cleanupOffer));
        }
      } catch (error) {
        onError(error);
      }
    }
  }

  Future<void> _cleanupOffer(String id) async {
    try {
      final offer = await database.getOfferById(id);
      if (_closed || offer == null) return;
      final strike = const {'cancelled', 'expired'}.contains(offer.statusRaw);
      final remove =
          const {'takerPaid', 'refundedMaker'}.contains(offer.statusRaw);
      if (!strike && !remove) return;
      final messages = await database.getTelegramOfferMessages(id);
      // Sequential within each offer; at most two network requests globally.
      for (final message in messages) {
        if (_closed) return;
        final success = strike
            ? await telegram.editMessage(
                chatId: message.chatId,
                messageId: message.messageId,
                text: '<s>${message.messageText}</s>')
            : await telegram.deleteMessage(
                chatId: message.chatId, messageId: message.messageId);
        if (success) await database.deleteTelegramOfferMessage(message);
      }
    } catch (error) {
      onError(error);
    }
  }

  Future<void> close() async {
    _closed = true;
    _timer?.cancel();
    await _running;
  }
}
