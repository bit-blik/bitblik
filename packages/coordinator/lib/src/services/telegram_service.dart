import 'dart:convert';
import 'package:http/http.dart' as http;
import '../logging/app_logger.dart';

class TelegramService {
  final String? _botToken;
  final String? _chatId;
  final http.Client _httpClient;

  TelegramService({String? botToken, String? chatId, http.Client? httpClient})
      : _botToken = botToken,
        _chatId = chatId,
        _httpClient = httpClient ?? http.Client();

  bool get isConfigured =>
      _botToken != null &&
      _botToken!.isNotEmpty &&
      _chatId != null &&
      _chatId!.isNotEmpty;

  Future<bool> sendMessage(String message) async {
    if (!isConfigured) {
      AppLogger.info(
          'Telegram not configured: botToken or chatId missing. Skipping notification.');
      return false;
    }

    try {
      final url =
          Uri.parse('https://api.telegram.org/bot$_botToken/sendMessage');
      final response = await _httpClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'chat_id': _chatId,
          'text': message,
          'parse_mode': 'HTML',
        }),
      );

      if (response.statusCode == 200) {
        AppLogger.info('Telegram notification sent successfully.');
        return true;
      } else {
        AppLogger.info(
            'Error sending Telegram notification: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      AppLogger.info('Exception sending Telegram notification: $e');
      return false;
    }
  }
}
