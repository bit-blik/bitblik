import 'dart:convert';
import 'package:http/http.dart' as http;
import '../logging/app_logger.dart';

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
      _botToken != null && _botToken!.isNotEmpty && _chatIds.isNotEmpty;

  Future<bool> sendMessage(String message) async {
    if (!isConfigured) {
      AppLogger.info(
          'Telegram not configured: botToken or chatIds missing. Skipping notification.');
      return false;
    }

    try {
      final url =
          Uri.parse('https://api.telegram.org/bot$_botToken/sendMessage');
      var allSucceeded = true;

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
        } else {
          allSucceeded = false;
          AppLogger.info(
              'Error sending Telegram notification to $chatId: ${response.statusCode} ${response.body}');
        }
      }

      return allSucceeded;
    } catch (e) {
      AppLogger.info('Exception sending Telegram notification: $e');
      return false;
    }
  }
}
