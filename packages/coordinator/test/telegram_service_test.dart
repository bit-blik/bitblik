import 'dart:convert';

import 'package:bitblik_coordinator/src/services/telegram_service.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

class _RecordingClient extends http.BaseClient {
  final List<Map<String, dynamic>> requests = [];
  final List<int> statusCodes;
  final List<String> responseBodies;
  int _requestIndex = 0;

  _RecordingClient({
    this.statusCodes = const [200],
    this.responseBodies = const ['{}'],
  });

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final streamedRequest = request as http.Request;
    requests.add({
      'url': streamedRequest.url.toString(),
      'headers': Map<String, String>.from(streamedRequest.headers),
      'body': jsonDecode(streamedRequest.body) as Map<String, dynamic>,
    });

    final statusCode = _requestIndex < statusCodes.length
        ? statusCodes[_requestIndex]
        : statusCodes.last;
    final responseBody = _requestIndex < responseBodies.length
        ? responseBodies[_requestIndex]
        : responseBodies.last;
    _requestIndex++;

    return http.StreamedResponse(
      Stream.value(utf8.encode(responseBody)),
      statusCode,
      request: request,
    );
  }
}

void main() {
  test('sendMessage sends the same message to all configured chat ids',
      () async {
    final client = _RecordingClient();
    final service = TelegramService(
      botToken: 'token',
      chatIds: ['-100123', '@bitblik_channel'],
      httpClient: client,
    );

    final result = await service.sendMessage('hello');

    expect(result, isTrue);
    expect(client.requests, hasLength(2));
    expect(client.requests[0]['body']['chat_id'], '-100123');
    expect(client.requests[1]['body']['chat_id'], '@bitblik_channel');
    expect(client.requests[0]['body']['text'], 'hello');
    expect(client.requests[1]['body']['text'], 'hello');
  });

  test('sendMessage deduplicates chat ids provided through both inputs',
      () async {
    final client = _RecordingClient();
    final service = TelegramService(
      botToken: 'token',
      chatId: '-100123',
      chatIds: ['-100123', '@bitblik_channel'],
      httpClient: client,
    );

    final result = await service.sendMessage('hello');

    expect(result, isTrue);
    expect(client.requests, hasLength(2));
    expect(client.requests[0]['body']['chat_id'], '-100123');
    expect(client.requests[1]['body']['chat_id'], '@bitblik_channel');
  });

  test('sendMessage returns false if any destination fails', () async {
    final client = _RecordingClient(statusCodes: [200, 500]);
    final service = TelegramService(
      botToken: 'token',
      chatIds: ['-100123', '@bitblik_channel'],
      httpClient: client,
    );

    final result = await service.sendMessage('hello');

    expect(result, isFalse);
    expect(client.requests, hasLength(2));
  });

  test('sendMessageDetailed returns message ids of delivered messages',
      () async {
    final client = _RecordingClient(
      statusCodes: [200, 500],
      responseBodies: [
        '{"ok": true, "result": {"message_id": 42}}',
        '{"ok": false}',
      ],
    );
    final service = TelegramService(
      botToken: 'token',
      chatIds: ['-100123', '@bitblik_channel'],
      httpClient: client,
    );

    final result = await service.sendMessageDetailed('hello');

    expect(result.allSucceeded, isFalse);
    expect(result.sentMessages, hasLength(1));
    expect(result.sentMessages.first.chatId, '-100123');
    expect(result.sentMessages.first.messageId, 42);
  });

  test('editMessage posts to editMessageText with chat and message id',
      () async {
    final client = _RecordingClient(
      responseBodies: ['{"ok": true, "result": {"message_id": 42}}'],
    );
    final service = TelegramService(
      botToken: 'token',
      chatIds: ['-100123'],
      httpClient: client,
    );

    final result = await service.editMessage(
      chatId: '-100123',
      messageId: 42,
      text: '<s>hello</s>',
    );

    expect(result, isTrue);
    expect(client.requests, hasLength(1));
    expect(client.requests[0]['url'], contains('/editMessageText'));
    expect(client.requests[0]['body']['chat_id'], '-100123');
    expect(client.requests[0]['body']['message_id'], 42);
    expect(client.requests[0]['body']['text'], '<s>hello</s>');
    expect(client.requests[0]['body']['parse_mode'], 'HTML');
  });

  test('deleteMessage posts to deleteMessage with chat and message id',
      () async {
    final client = _RecordingClient(
      responseBodies: ['{"ok": true, "result": true}'],
    );
    final service = TelegramService(
      botToken: 'token',
      chatIds: ['-100123'],
      httpClient: client,
    );

    final result = await service.deleteMessage(
      chatId: '-100123',
      messageId: 42,
    );

    expect(result, isTrue);
    expect(client.requests, hasLength(1));
    expect(client.requests[0]['url'], contains('/deleteMessage'));
    expect(client.requests[0]['body']['chat_id'], '-100123');
    expect(client.requests[0]['body']['message_id'], 42);
  });

  test('deleteMessage returns false when telegram rejects the deletion',
      () async {
    final client = _RecordingClient(statusCodes: [400]);
    final service = TelegramService(
      botToken: 'token',
      chatIds: ['-100123'],
      httpClient: client,
    );

    final result = await service.deleteMessage(
      chatId: '-100123',
      messageId: 42,
    );

    expect(result, isFalse);
  });

  test('editMessage returns false when telegram rejects the edit', () async {
    final client = _RecordingClient(statusCodes: [400]);
    final service = TelegramService(
      botToken: 'token',
      chatIds: ['-100123'],
      httpClient: client,
    );

    final result = await service.editMessage(
      chatId: '-100123',
      messageId: 42,
      text: '<s>hello</s>',
    );

    expect(result, isFalse);
  });
}
