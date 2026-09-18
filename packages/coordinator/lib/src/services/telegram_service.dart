import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../logging/app_logger.dart';

/// A message successfully sent to a Telegram chat.
class TelegramSentMessage {
  final String chatId;
  final int messageId;

  const TelegramSentMessage({required this.chatId, required this.messageId});
}

/// Result of broadcasting a message to all configured chats.
class TelegramSendResult {
  final bool allSucceeded;
  final List<TelegramSentMessage> sentMessages;

  const TelegramSendResult({
    required this.allSucceeded,
    required this.sentMessages,
  });
}

class TelegramService {
  final String? _botToken;
  final List<String> _chatIds;
  final http.Client _httpClient;
  final Duration _requestTimeout;

  TelegramService({
    String? botToken,
    String? chatId,
    List<String>? chatIds,
    http.Client? httpClient,
    Duration requestTimeout = const Duration(seconds: 3),
  })  : _botToken = botToken,
        _chatIds = _normalizeChatIds(chatId: chatId, chatIds: chatIds),
        _httpClient = httpClient ?? http.Client(),
        _requestTimeout = requestTimeout;

  /// Bound headers and body together, and abort the underlying request. A
  /// Future.timeout alone would leave a stalled socket running in background.
  Future<http.Response> _post(String method, Map<String, dynamic> body,
      {Duration? timeout}) async {
    final budget = timeout ?? _requestTimeout;
    if (budget <= Duration.zero) {
      throw TimeoutException('Telegram delivery budget exhausted');
    }
    final abort = Completer<void>();
    final request = http.AbortableRequest(
      'POST',
      Uri.parse('https://api.telegram.org/bot$_botToken/$method'),
      abortTrigger: abort.future,
    )
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode(body);
    try {
      return await (() async =>
              http.Response.fromStream(await _httpClient.send(request)))()
          .timeout(budget, onTimeout: () {
        if (!abort.isCompleted) abort.complete();
        throw TimeoutException('Telegram $method timed out', budget);
      });
    } finally {
      if (!abort.isCompleted) abort.complete();
    }
  }

  static List<String> _normalizeChatIds({
    String? chatId,
    List<String>? chatIds,
  }) {
    final normalized = <String>[];

    if (chatId != null && chatId.trim().isNotEmpty) {
      normalized.add(chatId.trim());
    }

    if (chatIds != null) {
      for (final id in chatIds) {
        final trimmed = id.trim();
        if (trimmed.isNotEmpty && !normalized.contains(trimmed)) {
          normalized.add(trimmed);
        }
      }
    }

    return normalized;
  }

  bool get isConfigured =>
      _botToken != null && _botToken.isNotEmpty && _chatIds.isNotEmpty;

  Future<bool> sendMessage(String message) async {
    final result = await sendMessageDetailed(message);
    return result.allSucceeded;
  }

  /// Sends [message] to all configured chats and returns the Telegram
  /// message ids of the successfully delivered copies, so they can be
  /// edited later (e.g. struck out when an offer is cancelled or expires).
  ///
  /// [chatIds] overrides the default configured chats — used for per-offer
  /// routing (general channel ∪ the offer's bank-specific channel).
  Future<TelegramSendResult> sendMessageDetailed(
    String message, {
    List<String>? chatIds,
  }) async {
    final targets = <String>{...?chatIds, if (chatIds == null) ..._chatIds}
        .where((c) => c.isNotEmpty)
        .toList();
    if (_botToken == null || _botToken.isEmpty || targets.isEmpty) {
      AppLogger.info(
          'Telegram not configured: botToken or chatIds missing. Skipping notification.');
      return const TelegramSendResult(allSucceeded: false, sentMessages: []);
    }

    final clock = Stopwatch()..start();
    var next = 0;
    var allSucceeded = true;
    final sentMessages =
        List<TelegramSentMessage?>.filled(targets.length, null);
    Future<void> worker() async {
      while (next < targets.length) {
        final index = next++;
        final chatId = targets[index];
        try {
          final response = await _post(
              'sendMessage',
              {
                'chat_id': chatId,
                'text': message,
                'parse_mode': 'HTML',
              },
              timeout: _requestTimeout - clock.elapsed);

          if (response.statusCode == 200) {
            AppLogger.info(
                'Telegram notification sent successfully to $chatId.');
            final messageId = _extractMessageId(response.body);
            if (messageId != null) {
              sentMessages[index] =
                  TelegramSentMessage(chatId: chatId, messageId: messageId);
            }
          } else {
            allSucceeded = false;
            AppLogger.info(
                'Error sending Telegram notification to $chatId: ${response.statusCode}');
          }
        } catch (error) {
          allSucceeded = false;
          // Client exceptions can embed the URL, which contains the bot token.
          AppLogger.info(
              'Exception sending Telegram notification to $chatId: ${error.runtimeType}');
        }
      }
    }

    // One bad chat must not block a healthy chat, nor multiply the deadline by
    // the number of configured destinations. Preserve all known message IDs.
    await Future.wait([worker(), if (targets.length > 1) worker()]);
    return TelegramSendResult(
        allSucceeded: allSucceeded,
        sentMessages: sentMessages.whereType<TelegramSentMessage>().toList());
  }

  /// Replaces the content of a previously sent message.
  Future<bool> editMessage({
    required String chatId,
    required int messageId,
    required String text,
  }) async {
    if (!isConfigured) {
      AppLogger.info(
          'Telegram not configured: botToken or chatIds missing. Skipping message edit.');
      return false;
    }

    try {
      final response = await _post('editMessageText', {
        'chat_id': chatId,
        'message_id': messageId,
        'text': text,
        'parse_mode': 'HTML',
      });

      if (response.statusCode == 200 ||
          _alreadyApplied(response, 'message is not modified')) {
        AppLogger.info(
            'Telegram message $messageId in $chatId edited successfully.');
        return true;
      }
      AppLogger.info(
          'Error editing Telegram message $messageId in $chatId: ${response.statusCode}');
      return false;
    } catch (e) {
      AppLogger.info('Exception editing Telegram message: ${e.runtimeType}');
      return false;
    }
  }

  /// Deletes a previously sent message.
  Future<bool> deleteMessage({
    required String chatId,
    required int messageId,
  }) async {
    if (!isConfigured) {
      AppLogger.info(
          'Telegram not configured: botToken or chatIds missing. Skipping message deletion.');
      return false;
    }

    try {
      final response = await _post('deleteMessage', {
        'chat_id': chatId,
        'message_id': messageId,
      });

      if (response.statusCode == 200 ||
          _alreadyApplied(response, 'message to delete not found')) {
        AppLogger.info(
            'Telegram message $messageId in $chatId deleted successfully.');
        return true;
      }
      AppLogger.info(
          'Error deleting Telegram message $messageId in $chatId: ${response.statusCode}');
      return false;
    } catch (e) {
      AppLogger.info('Exception deleting Telegram message: ${e.runtimeType}');
      return false;
    }
  }

  static int? _extractMessageId(String responseBody) {
    try {
      final decoded = jsonDecode(responseBody);
      final messageId = decoded['result']?['message_id'];
      return messageId is int ? messageId : null;
    } catch (_) {
      return null;
    }
  }

  static bool _alreadyApplied(http.Response response, String description) {
    if (response.statusCode != 400) return false;
    try {
      final decoded = jsonDecode(response.body);
      return decoded['description'] is String &&
          (decoded['description'] as String)
              .toLowerCase()
              .contains(description);
    } catch (_) {
      return false;
    }
  }
}
