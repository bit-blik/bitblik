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

  TelegramService({
    String? botToken,
    String? chatId,
    List<String>? chatIds,
    http.Client? httpClient,
  })  : _botToken = botToken,
        _chatIds = _normalizeChatIds(chatId: chatId, chatIds: chatIds),
        _httpClient = httpClient ?? http.Client();

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
  Future<TelegramSendResult> sendMessageDetailed(String message) async {
    if (!isConfigured) {
      AppLogger.info(
          'Telegram not configured: botToken or chatIds missing. Skipping notification.');
      return const TelegramSendResult(allSucceeded: false, sentMessages: []);
    }

    try {
      final url =
          Uri.parse('https://api.telegram.org/bot$_botToken/sendMessage');
      var allSucceeded = true;
      final sentMessages = <TelegramSentMessage>[];

      for (final chatId in _chatIds) {
        final response = await _httpClient.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'chat_id': chatId,
            'text': message,
            'parse_mode': 'HTML',
          }),
        );

        if (response.statusCode == 200) {
          AppLogger.info('Telegram notification sent successfully to $chatId.');
          final messageId = _extractMessageId(response.body);
          if (messageId != null) {
            sentMessages
                .add(TelegramSentMessage(chatId: chatId, messageId: messageId));
          }
        } else {
          allSucceeded = false;
          AppLogger.info(
              'Error sending Telegram notification to $chatId: ${response.statusCode} ${response.body}');
        }
      }

      return TelegramSendResult(
          allSucceeded: allSucceeded, sentMessages: sentMessages);
    } catch (e) {
      AppLogger.info('Exception sending Telegram notification: $e');
      return const TelegramSendResult(allSucceeded: false, sentMessages: []);
    }
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
      final url =
          Uri.parse('https://api.telegram.org/bot$_botToken/editMessageText');
      final response = await _httpClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'chat_id': chatId,
          'message_id': messageId,
          'text': text,
          'parse_mode': 'HTML',
        }),
      );

      if (response.statusCode == 200) {
        AppLogger.info(
            'Telegram message $messageId in $chatId edited successfully.');
        return true;
      }
      AppLogger.info(
          'Error editing Telegram message $messageId in $chatId: ${response.statusCode} ${response.body}');
      return false;
    } catch (e) {
      AppLogger.info('Exception editing Telegram message: $e');
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
      final url =
          Uri.parse('https://api.telegram.org/bot$_botToken/deleteMessage');
      final response = await _httpClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'chat_id': chatId,
          'message_id': messageId,
        }),
      );

      if (response.statusCode == 200) {
        AppLogger.info(
            'Telegram message $messageId in $chatId deleted successfully.');
        return true;
      }
      AppLogger.info(
          'Error deleting Telegram message $messageId in $chatId: ${response.statusCode} ${response.body}');
      return false;
    } catch (e) {
      AppLogger.info('Exception deleting Telegram message: $e');
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
}
