import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';

import 'state_store.dart';
import 'telegram_client.dart';

typedef BotClock = DateTime Function();
typedef BotLogger = void Function(String message);

class CoordinatorIdentity {
  final String name;

  const CoordinatorIdentity({required this.name});
}

class OfferNotificationController {
  final TelegramClient telegram;
  final NotificationStateStore store;
  final PaymentSystem paymentSystem;
  final String frontendDomain;
  final Duration coordinatorMinInterval;
  final Duration coordinatorCooldown;
  final Duration initialOfferMaxAge;
  final Duration offerStateRetention;
  final int maxTrackedOffers;
  final BotClock _clock;
  final BotLogger _log;

  late NotificationState _state;
  Set<String> _allowedCoordinators = const {};
  Set<String> _mutedCoordinators = const {};
  Map<String, CoordinatorIdentity> _coordinatorIdentities = const {};
  Future<void> _queue = Future.value();
  late final DateTime _startedAt;

  OfferNotificationController({
    required this.telegram,
    required this.store,
    required this.paymentSystem,
    required this.frontendDomain,
    required this.coordinatorMinInterval,
    required this.coordinatorCooldown,
    this.initialOfferMaxAge = const Duration(seconds: 30),
    this.offerStateRetention = const Duration(hours: 48),
    this.maxTrackedOffers = 2000,
    BotClock? clock,
    BotLogger? logger,
  })  : _clock = clock ?? DateTime.now,
        _log = logger ?? print;

  Future<void> init() async {
    _state = await store.load();
    _mutedCoordinators = Set.unmodifiable(_state.mutedCoordinators);
    _startedAt = _clock().toUtc();
    for (final record in _state.offers.values) {
      if (record.messages.isEmpty) continue;
      if (_mutedCoordinators.contains(record.coordinatorPubkey) ||
          record.status == 'success') {
        final remaining = await _deleteMessages(record.messages);
        record.messages = remaining;
      } else if (record.status == 'canceled') {
        await _strikeMessages(record);
      }
    }
    _compactState();
    // Preflight persistence before connecting to relays or sending Telegram
    // messages. Running without durable message ids would make later
    // strike/delete operations impossible after a restart.
    await store.save(_state);
  }

  Set<String> get mutedCoordinators => Set.unmodifiable(_mutedCoordinators);

  Future<void> updateCoordinatorPolicy({
    required Set<String> allowed,
    required Set<String> muted,
    Map<String, CoordinatorIdentity> coordinatorIdentities = const {},
  }) {
    return _enqueue(() async {
      final normalizedMuted = muted.map(_normalize).toSet();
      final newlyMuted = normalizedMuted.difference(_mutedCoordinators);
      _allowedCoordinators = allowed.map(_normalize).toSet();
      _mutedCoordinators = normalizedMuted;
      _coordinatorIdentities = {
        for (final entry in coordinatorIdentities.entries)
          _normalize(entry.key): entry.value,
      };
      _state.mutedCoordinators
        ..clear()
        ..addAll(normalizedMuted);

      if (newlyMuted.isNotEmpty) {
        for (final record in _state.offers.values.where(
          (record) => newlyMuted.contains(record.coordinatorPubkey),
        )) {
          record.messages = await _deleteMessages(record.messages);
        }
      }
      await _retryTerminalActions();
      _compactState();
      await store.save(_state);
    });
  }

  Future<void> handleEvent(Nip01Event event) => _enqueue(() async {
        final coordinator = _normalize(event.pubKey);
        if (!_allowedCoordinators.contains(coordinator) ||
            _mutedCoordinators.contains(coordinator)) {
          return;
        }
        if (_tag(event, 'y') != paymentSystem.platformTag) return;

        final offerId = _tag(event, 'd');
        final status = _tag(event, 's');
        if (offerId == null || offerId.isEmpty || status == null) return;
        if (!const {
          'pending',
          'in-progress',
          'success',
          'canceled',
          'dispute',
        }.contains(status)) {
          return;
        }

        final key = '$coordinator:$offerId';
        final existing = _state.offers[key];
        if (existing != null &&
            event.createdAt <= existing.latestEventCreatedAt) {
          return;
        }

        final offer = Offer.fromNostrEvent(event);
        final previousStatus = existing?.status;
        final record = existing ??
            OfferNotificationRecord(
              coordinatorPubkey: coordinator,
              offerId: offerId,
              latestEventCreatedAt: event.createdAt,
              status: status,
            );
        record.latestEventCreatedAt = event.createdAt;
        record.status = status;
        _state.offers[key] = record;

        switch (status) {
          case 'pending':
            await _handleFundedOffer(record, offer, existing == null);
            if (previousStatus != 'pending' &&
                !(existing == null && _isInitialBacklog(offer))) {
              _logOfferLifecycle('funded', offer, coordinator);
            }
            break;
          case 'canceled':
            await _strikeMessages(record);
            if (previousStatus != 'canceled') {
              _logOfferLifecycle('cancelled/expired', offer, coordinator);
            }
            break;
          case 'success':
            record.messages = await _deleteMessages(record.messages);
            if (previousStatus != 'success') {
              _logOfferLifecycle('finished', offer, coordinator);
            }
            break;
          case 'in-progress':
          case 'dispute':
            break;
        }
        _compactState();
        await store.save(_state);
      });

  /// Bounds deduplication and pending Telegram lifecycle state. Recent terminal
  /// records remain as tombstones so an overlapping subscription replay cannot
  /// re-announce an older pending event. Even failed Telegram operations are
  /// eventually evicted so an unavailable API cannot grow memory indefinitely.
  void _compactState() {
    final cutoff =
        _clock().toUtc().subtract(offerStateRetention).millisecondsSinceEpoch ~/
            1000;
    _state.offers.removeWhere(
      (_, record) => record.latestEventCreatedAt < cutoff,
    );

    final overflow = _state.offers.length - maxTrackedOffers;
    if (overflow <= 0) return;
    final removable = _state.offers.entries.toList()
      ..sort((left, right) => left.value.latestEventCreatedAt
          .compareTo(right.value.latestEventCreatedAt));
    for (final entry in removable.take(overflow)) {
      _state.offers.remove(entry.key);
    }
  }

  Future<void> _retryTerminalActions() async {
    for (final record in _state.offers.values) {
      if (record.messages.isEmpty) continue;
      if (record.status == 'success' ||
          _mutedCoordinators.contains(record.coordinatorPubkey)) {
        record.messages = await _deleteMessages(record.messages);
      } else if (record.status == 'canceled') {
        await _strikeMessages(record);
      }
    }
  }

  Future<void> _handleFundedOffer(
    OfferNotificationRecord record,
    Offer offer,
    bool firstObservation,
  ) async {
    if (record.announced || record.suppressed || record.messages.isNotEmpty) {
      return;
    }
    if (firstObservation && _isInitialBacklog(offer)) {
      record.suppressed = true;
      return;
    }
    if (!_rateLimitAllows(record.coordinatorPubkey)) {
      record.suppressed = true;
      _log(
        'Rate-limited coordinator ${record.coordinatorPubkey}; '
        'suppressed offer ${record.offerId}',
      );
      return;
    }

    final identity = _coordinatorIdentities[record.coordinatorPubkey];
    final offerText = formatFundedOfferNotification(
      offer,
      frontendDomain: frontendDomain,
    );
    final text = identity == null
        ? _escapeHtml(offerText)
        : '<b>${_escapeHtml(identity.name)}</b>\n${_escapeHtml(offerText)}';
    final messages = await telegram.sendMessage(text);
    if (messages.isNotEmpty) {
      record
        ..notificationText = text
        ..announced = true
        ..messages = messages;
    }
  }

  bool _rateLimitAllows(String coordinator) {
    final now = _clock().toUtc();
    final rate = _state.coordinatorRates.putIfAbsent(
      coordinator,
      CoordinatorRateState.new,
    );
    final blockedUntil = rate.blockedUntil;
    if (blockedUntil != null && now.isBefore(blockedUntil)) return false;

    final last = rate.lastAcceptedAt;
    if (last != null && now.difference(last) < coordinatorMinInterval) {
      rate.blockedUntil = now.add(coordinatorCooldown);
      return false;
    }
    rate
      ..lastAcceptedAt = now
      ..blockedUntil = null;
    return true;
  }

  Future<void> _strikeMessages(OfferNotificationRecord record) async {
    final text = record.notificationText;
    if (text == null || record.messages.isEmpty) return;
    final failed = <TelegramMessageRef>[];
    for (final message in record.messages) {
      if (!await telegram.editMessage(message, '<s>$text</s>')) {
        failed.add(message);
      }
    }
    record.messages = failed;
  }

  Future<List<TelegramMessageRef>> _deleteMessages(
    List<TelegramMessageRef> messages,
  ) async {
    final failed = <TelegramMessageRef>[];
    for (final message in messages) {
      if (!await telegram.deleteMessage(message)) failed.add(message);
    }
    return failed;
  }

  Future<void> _enqueue(Future<void> Function() operation) {
    final result = _queue.then((_) => operation());
    _queue = result.catchError((Object error, StackTrace stackTrace) {
      _log('Offer notification processing failed: $error\n$stackTrace');
    });
    return _queue;
  }

  static String _normalize(String value) => value.trim().toLowerCase();

  static String? _tag(Nip01Event event, String name) {
    for (final tag in event.tags) {
      if (tag.length >= 2 && tag[0] == name) return tag[1];
    }
    return null;
  }

  bool _isInitialBacklog(Offer offer) =>
      offer.createdAt.toUtc().isBefore(_startedAt.subtract(initialOfferMaxAge));

  void _logOfferLifecycle(
    String lifecycle,
    Offer offer,
    String coordinatorPubkey,
  ) {
    final name = _coordinatorIdentities[coordinatorPubkey]?.name ?? 'unknown';
    _log(
      'Offer $lifecycle: ${offer.id} from $name '
      '(${_shortPubkey(coordinatorPubkey)}), ${offer.amountSats} sats',
    );
  }

  static String _shortPubkey(String pubkey) =>
      pubkey.length <= 12 ? pubkey : '${pubkey.substring(0, 12)}…';

  static String _escapeHtml(String value) => value
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;');
}
