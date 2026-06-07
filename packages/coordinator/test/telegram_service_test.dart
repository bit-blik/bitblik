import 'dart:convert';

import 'package:bitblik_coordinator/src/services/telegram_service.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

class _RecordingClient extends http.BaseClient {
  final List<Map<String, dynamic>> requests = [];
  final List<int> statusCodes;
  int _requestIndex = 0;

  _RecordingClient({this.statusCodes = const [200]});

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
    _requestIndex++;

    return http.StreamedResponse(
      Stream.value(utf8.encode('{}')),
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
}
