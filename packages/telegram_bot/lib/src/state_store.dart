import 'dart:convert';
import 'dart:io';

import 'telegram_client.dart';

class OfferNotificationRecord {
  final String coordinatorPubkey;
  final String offerId;
  int latestEventCreatedAt;
  String status;
  String? notificationText;
  bool announced;
  bool suppressed;
  List<TelegramMessageRef> messages;

  OfferNotificationRecord({
    required this.coordinatorPubkey,
    required this.offerId,
    required this.latestEventCreatedAt,
    required this.status,
    this.notificationText,
    this.announced = false,
    this.suppressed = false,
    List<TelegramMessageRef>? messages,
  }) : messages = messages ?? [];

  String get key => '$coordinatorPubkey:$offerId';

  Map<String, Object?> toJson() => {
        'coordinator_pubkey': coordinatorPubkey,
        'offer_id': offerId,
        'latest_event_created_at': latestEventCreatedAt,
        'status': status,
        'notification_text': notificationText,
        'announced': announced,
        'suppressed': suppressed,
        'messages': messages.map((message) => message.toJson()).toList(),
      };

  factory OfferNotificationRecord.fromJson(Map<String, dynamic> json) =>
      OfferNotificationRecord(
        coordinatorPubkey: json['coordinator_pubkey'] as String,
        offerId: json['offer_id'] as String,
        latestEventCreatedAt: json['latest_event_created_at'] as int,
        status: json['status'] as String,
        notificationText: json['notification_text'] as String?,
        announced: json['announced'] as bool? ?? false,
        suppressed: json['suppressed'] as bool? ?? false,
        messages: ((json['messages'] as List<dynamic>?) ?? const [])
            .map((value) => TelegramMessageRef.fromJson(
                  value as Map<String, dynamic>,
                ))
            .toList(),
      );
}

class CoordinatorRateState {
  DateTime? lastAcceptedAt;
  DateTime? blockedUntil;

  CoordinatorRateState({this.lastAcceptedAt, this.blockedUntil});

  Map<String, Object?> toJson() => {
        'last_accepted_at': lastAcceptedAt?.toUtc().toIso8601String(),
        'blocked_until': blockedUntil?.toUtc().toIso8601String(),
      };

  factory CoordinatorRateState.fromJson(Map<String, dynamic> json) =>
      CoordinatorRateState(
        lastAcceptedAt: DateTime.tryParse(json['last_accepted_at'] ?? ''),
        blockedUntil: DateTime.tryParse(json['blocked_until'] ?? ''),
      );
}

class NotificationState {
  final Map<String, OfferNotificationRecord> offers;
  final Map<String, CoordinatorRateState> coordinatorRates;
  final Set<String> mutedCoordinators;

  NotificationState({
    Map<String, OfferNotificationRecord>? offers,
    Map<String, CoordinatorRateState>? coordinatorRates,
    Set<String>? mutedCoordinators,
  })  : offers = offers ?? {},
        coordinatorRates = coordinatorRates ?? {},
        mutedCoordinators = mutedCoordinators ?? {};

  Map<String, Object> toJson() => {
        'version': 1,
        'offers': offers.map((key, value) => MapEntry(key, value.toJson())),
        'coordinator_rates': coordinatorRates.map(
          (key, value) => MapEntry(key, value.toJson()),
        ),
        'muted_coordinators': mutedCoordinators.toList(growable: false),
      };

  factory NotificationState.fromJson(Map<String, dynamic> json) {
    final offerValues =
        (json['offers'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    final rateValues = (json['coordinator_rates'] as Map<String, dynamic>?) ??
        const <String, dynamic>{};
    return NotificationState(
      offers: offerValues.map(
        (key, value) => MapEntry(
          key,
          OfferNotificationRecord.fromJson(value as Map<String, dynamic>),
        ),
      ),
      coordinatorRates: rateValues.map(
        (key, value) => MapEntry(
          key,
          CoordinatorRateState.fromJson(value as Map<String, dynamic>),
        ),
      ),
      mutedCoordinators:
          ((json['muted_coordinators'] as List<dynamic>?) ?? const <dynamic>[])
              .map((value) => value as String)
              .toSet(),
    );
  }
}

abstract interface class NotificationStateStore {
  Future<NotificationState> load();

  Future<void> save(NotificationState state);
}

class JsonNotificationStateStore implements NotificationStateStore {
  final File file;

  JsonNotificationStateStore(String path) : file = File(path);

  @override
  Future<NotificationState> load() async {
    if (!await file.exists()) return NotificationState();
    try {
      final json =
          jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      return NotificationState.fromJson(json);
    } catch (error) {
      throw FormatException('Cannot read state file ${file.path}: $error');
    }
  }

  @override
  Future<void> save(NotificationState state) async {
    try {
      await file.parent.create(recursive: true);
      final temporary = File('${file.path}.tmp');
      await temporary.writeAsString(jsonEncode(state.toJson()), flush: true);
      await temporary.rename(file.path);
    } catch (error) {
      throw FileSystemException(
        'Cannot write Telegram bot state; set STATE_FILE to a writable path '
        'or fix the mounted volume permissions ($error)',
        file.path,
      );
    }
  }
}

class MemoryNotificationStateStore implements NotificationStateStore {
  NotificationState state;

  MemoryNotificationStateStore([NotificationState? state])
      : state = state ?? NotificationState();

  @override
  Future<NotificationState> load() async => state;

  @override
  Future<void> save(NotificationState state) async {
    this.state = state;
  }
}
