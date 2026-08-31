import 'dart:convert';

import 'package:http/http.dart' as http;

class TelegramMessageRef {
  final String chatId;
  final int messageId;

  const TelegramMessageRef({required this.chatId, required this.messageId});

  Map<String, Object> toJson() => {
        'chat_id': chatId,
        'message_id': messageId,
      };

  factory TelegramMessageRef.fromJson(Map<String, dynamic> json) =>
      TelegramMessageRef(
        chatId: json['chat_id'] as String,
        messageId: json['message_id'] as int,
      );
}

abstract interface class TelegramClient {
  Future<List<TelegramMessageRef>> sendMessage(String text);

  Future<bool> editMessage(TelegramMessageRef message, String text);

  Future<bool> deleteMessage(TelegramMessageRef message);
}

class TelegramHttpClient implements TelegramClient {
  final String botToken;
  final List<String> chatIds;
  final http.Client _client;

  TelegramHttpClient({
    required this.botToken,
    required this.chatIds,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Uri _endpoint(String method) =>
      Uri.parse('https://api.telegram.org/bot$botToken/$method');

  @override
  Future<List<TelegramMessageRef>> sendMessage(String text) async {
    final sent = <TelegramMessageRef>[];
    for (final chatId in chatIds) {
      try {
        final response = await _post('sendMessage', {
          'chat_id': chatId,
          'text': text,
          'parse_mode': 'HTML',
        });
        if (response.statusCode != 200) {
          _logFailure('sendMessage', response);
          continue;
        }
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final messageId =
            (body['result'] as Map<String, dynamic>?)?['message_id'];
        if (messageId is int) {
          sent.add(TelegramMessageRef(chatId: chatId, messageId: messageId));
        }
      } catch (error) {
        print('Telegram sendMessage failed for $chatId: $error');
      }
    }
    return sent;
  }

  @override
  Future<bool> editMessage(TelegramMessageRef message, String text) async {
    try {
      final response = await _post('editMessageText', {
        'chat_id': message.chatId,
        'message_id': message.messageId,
        'text': text,
        'parse_mode': 'HTML',
      });
      if (response.statusCode == 200) return true;
      _logFailure('editMessageText', response);
    } catch (error) {
      print('Telegram editMessageText failed: $error');
    }
    return false;
  }

  @override
  Future<bool> deleteMessage(TelegramMessageRef message) async {
    try {
      final response = await _post('deleteMessage', {
        'chat_id': message.chatId,
        'message_id': message.messageId,
      });
      if (response.statusCode == 200) return true;
      _logFailure('deleteMessage', response);
    } catch (error) {
      print('Telegram deleteMessage failed: $error');
    }
    return false;
  }

  Future<http.Response> _post(String method, Map<String, Object> body) =>
      _client.post(
        _endpoint(method),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

  void _logFailure(String method, http.Response response) {
    print(
      'Telegram $method failed: ${response.statusCode} ${response.body}',
    );
  }

  void close() => _client.close();
}
