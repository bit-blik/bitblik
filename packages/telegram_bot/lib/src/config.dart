import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart' show Nip19;

class TelegramBotConfig {
  final String botToken;
  final List<String> chatIds;
  final PaymentSystem paymentSystem;
  final String frontendDomain;
  final List<String> bootstrapRelays;
  final Set<String> excludedCoordinatorPubkeys;
  final String stateFile;
  final Duration coordinatorMinInterval;
  final Duration coordinatorCooldown;
  final Duration discoveryRefreshInterval;
  final Duration queryTimeout;
  final Duration subscriptionOverlap;
  final Duration subscriptionRotationInterval;
  final Duration offerStateRetention;
  final int maxTrackedOffers;

  const TelegramBotConfig({
    required this.botToken,
    required this.chatIds,
    required this.paymentSystem,
    required this.frontendDomain,
    required this.bootstrapRelays,
    required this.excludedCoordinatorPubkeys,
    required this.stateFile,
    required this.coordinatorMinInterval,
    required this.coordinatorCooldown,
    required this.discoveryRefreshInterval,
    required this.queryTimeout,
    required this.subscriptionOverlap,
    required this.subscriptionRotationInterval,
    required this.offerStateRetention,
    required this.maxTrackedOffers,
  });

  factory TelegramBotConfig.fromEnvironment(Map<String, String> env) {
    String requiredValue(String key) {
      final value = env[key]?.trim() ?? '';
      if (value.isEmpty) throw FormatException('$key is required');
      return value;
    }

    int positiveInt(String key, int fallback) {
      final raw = env[key]?.trim();
      if (raw == null || raw.isEmpty) return fallback;
      final value = int.tryParse(raw);
      if (value == null || value <= 0) {
        throw FormatException('$key must be a positive integer');
      }
      return value;
    }

    final paymentSystemId = env['PAYMENT_SYSTEM']?.trim() ?? 'blik';
    final matchingSystems = kPaymentSystems.where(
      (system) => system.id == paymentSystemId,
    );
    if (matchingSystems.isEmpty) {
      throw FormatException(
        'Unknown PAYMENT_SYSTEM "$paymentSystemId"; expected one of '
        '${kPaymentSystems.map((system) => system.id).join(', ')}',
      );
    }
    final paymentSystem = matchingSystems.first;

    final chatsRaw = env['TELEGRAM_CHAT_IDS'] ??
        env['TELEGRAM_CHAT_ID'] ??
        env['TG_CHAT_ID'] ??
        '';
    final chatIds = chatsRaw
        .split(',')
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList(growable: false);
    if (chatIds.isEmpty) {
      throw const FormatException(
        'TELEGRAM_CHAT_IDS (or TELEGRAM_CHAT_ID) is required',
      );
    }

    final relayValues = (env['NOSTR_RELAYS'] ?? '')
        .split(',')
        .map(normalizeRelayUrl)
        .where((value) => value.isNotEmpty)
        .toSet();

    final excludedCoordinatorPubkeys = <String>{};
    for (final rawValue
        in (env['EXCLUDED_COORDINATOR_PUBKEYS'] ?? '').split(',')) {
      final value = rawValue.trim().toLowerCase();
      if (value.isEmpty) continue;
      String pubkey;
      try {
        pubkey = value.startsWith('npub') ? Nip19.decode(value) : value;
      } catch (_) {
        throw FormatException(
          'EXCLUDED_COORDINATOR_PUBKEYS contains invalid pubkey "$value"',
        );
      }
      pubkey = pubkey.toLowerCase();
      if (!RegExp(r'^[0-9a-f]{64}$').hasMatch(pubkey)) {
        throw FormatException(
          'EXCLUDED_COORDINATOR_PUBKEYS contains invalid pubkey "$value"',
        );
      }
      excludedCoordinatorPubkeys.add(pubkey);
    }

    return TelegramBotConfig(
      botToken: requiredValue('TELEGRAM_BOT_TOKEN'),
      chatIds: chatIds,
      paymentSystem: paymentSystem,
      frontendDomain: env['FRONTEND_DOMAIN']?.trim().isNotEmpty == true
          ? env['FRONTEND_DOMAIN']!.trim()
          : 'bitblik.app',
      bootstrapRelays: relayValues.isEmpty
          ? kDiscoveryRelays
          : relayValues.toList(growable: false),
      excludedCoordinatorPubkeys: Set.unmodifiable(excludedCoordinatorPubkeys),
      stateFile: env['STATE_FILE']?.trim().isNotEmpty == true
          ? env['STATE_FILE']!.trim()
          : 'telegram_bot_state.json',
      coordinatorMinInterval: Duration(
        seconds: positiveInt('COORDINATOR_MIN_OFFER_INTERVAL_SECONDS', 10),
      ),
      coordinatorCooldown: Duration(
        seconds: positiveInt('COORDINATOR_RATE_LIMIT_SECONDS', 600),
      ),
      discoveryRefreshInterval: Duration(
        seconds: positiveInt('DISCOVERY_REFRESH_SECONDS', 300),
      ),
      queryTimeout: Duration(
        seconds: positiveInt('NOSTR_QUERY_TIMEOUT_SECONDS', 8),
      ),
      subscriptionOverlap: Duration(
        seconds: positiveInt('SUBSCRIPTION_OVERLAP_SECONDS', 15),
      ),
      subscriptionRotationInterval: Duration(
        seconds: positiveInt('SUBSCRIPTION_ROTATION_SECONDS', 900),
      ),
      offerStateRetention: Duration(
        seconds: positiveInt('OFFER_STATE_RETENTION_SECONDS', 172800),
      ),
      maxTrackedOffers: positiveInt('MAX_TRACKED_OFFERS', 2000),
    );
  }
}
