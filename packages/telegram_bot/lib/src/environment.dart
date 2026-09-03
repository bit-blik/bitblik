import 'dart:io';

import 'package:dotenv/dotenv.dart';

const _telegramBotEnvironmentKeys = {
  'TELEGRAM_BOT_TOKEN',
  'TELEGRAM_CHAT_IDS',
  'TELEGRAM_CHAT_ID',
  'TG_CHAT_ID',
  'PAYMENT_SYSTEM',
  'FRONTEND_DOMAIN',
  'NOSTR_RELAYS',
  'STATE_FILE',
  'COORDINATOR_MIN_OFFER_INTERVAL_SECONDS',
  'COORDINATOR_RATE_LIMIT_SECONDS',
  'DISCOVERY_REFRESH_SECONDS',
  'NOSTR_QUERY_TIMEOUT_SECONDS',
  'SUBSCRIPTION_OVERLAP_SECONDS',
};

/// Loads [filename] first, then overlays the process environment so Docker and
/// CI variables retain precedence over local development defaults.
Map<String, String> loadTelegramBotEnvironment({
  String filename = '.env',
  Map<String, String>? platformEnvironment,
}) {
  final fileEnvironment = DotEnv(quiet: true)..load([filename]);
  final processEnvironment = platformEnvironment ?? Platform.environment;
  return {
    for (final key in _telegramBotEnvironmentKeys)
      if (processEnvironment[key] ?? fileEnvironment[key] case final value?)
        key: value,
  };
}
