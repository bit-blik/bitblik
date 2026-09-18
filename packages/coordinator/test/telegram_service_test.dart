import 'dart:async';
import 'dart:convert';

import 'package:bitblik_coordinator/src/services/telegram_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
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
  test('hung chat does not block healthy chat or erase its message id',
      () async {
    final hanging = Completer<http.Response>();
    var requests = 0;
    final service = TelegramService(
      botToken: 'token',
      chatIds: ['hung', 'healthy'],
      requestTimeout: const Duration(milliseconds: 500),
      httpClient: MockClient((request) {
        requests++;
        return jsonDecode(request.body)['chat_id'] == 'hung'
            ? hanging.future
            : Future.value(http.Response('{"result":{"message_id":42}}', 200));
      }),
    );
    final result = await service
        .sendMessageDetailed('hello')
        .timeout(const Duration(seconds: 1));
    expect(requests, 2);
    expect(result.allSucceeded, isFalse);
    expect(result.sentMessages.single.chatId, 'healthy');
    expect(result.sentMessages.single.messageId, 42);
    // Late client errors must be consumed after our deadline.
    hanging.completeError(StateError('late socket error'));
    await Future<void>.delayed(Duration.zero);
  });

  test('send deadline is shared by all chats, with at most two requests active',
      () async {
    final client = _AbortedClient(stallBody: false);
    final service = TelegramService(
      botToken: 'token',
      chatIds: ['1', '2', '3', '4', '5'],
      requestTimeout: const Duration(milliseconds: 500),
      httpClient: client,
    );
    final result = await service
        .sendMessageDetailed('hello')
        .timeout(const Duration(seconds: 1));
    expect(result.allSucceeded, isFalse);
    await Future<void>.delayed(Duration.zero);
    expect(client.started, greaterThan(0));
    expect(client.peak, lessThanOrEqualTo(2));
    expect(client.aborted, client.started);
  });

  for (final stallBody in [false, true]) {
    test('edit/delete abort stalled ${stallBody ? 'body' : 'headers'}',
        () async {
      final client = _AbortedClient(stallBody: stallBody);
      final service = TelegramService(
          botToken: 'token',
          chatIds: ['chat'],
          requestTimeout: const Duration(milliseconds: 30),
          httpClient: client);
      expect(
          await service
              .editMessage(chatId: 'chat', messageId: 42, text: 'changed')
              .timeout(const Duration(seconds: 1)),
          isFalse);
      expect(
          await service
              .deleteMessage(chatId: 'chat', messageId: 42)
              .timeout(const Duration(seconds: 1)),
          isFalse);
      await Future<void>.delayed(Duration.zero);
      expect(client.aborted, 2);
    });
  }

  test('timeout stops dispatch before asynchronous request abort completes',
      () async {
    final client =
        _AbortedClient(stallBody: false, earlyTimeout: true, delayAbort: true);
    final service = TelegramService(
        botToken: 'token',
        chatIds: ['1', '2', '3', '4', '5'],
        requestTimeout: const Duration(milliseconds: 100),
        httpClient: client);
    final result = await service
        .sendMessageDetailed('hello')
        .timeout(const Duration(seconds: 2));
    await client.waitForAborts().timeout(const Duration(seconds: 1));
    expect(result.allSucceeded, isFalse);
    expect(client.peak, lessThanOrEqualTo(2));
    expect(client.started, 2);
    expect(client.aborted, client.started);
  });

  test('idempotent cleanup recognizes already edited/deleted messages',
      () async {
    final client = _RecordingClient(statusCodes: [
      400,
      400
    ], responseBodies: [
      '{"description":"Bad Request: message is not modified"}',
      '{"description":"Bad Request: message to delete not found"}',
    ]);
    final service = TelegramService(
        botToken: 'token', chatIds: ['chat'], httpClient: client);
    expect(
        await service.editMessage(
            chatId: 'chat', messageId: 42, text: 'changed'),
        isTrue);
    expect(await service.deleteMessage(chatId: 'chat', messageId: 42), isTrue);
  });

  test('permission failures are not successful cleanup', () async {
    final service = TelegramService(
        botToken: 'token',
        chatIds: ['chat'],
        httpClient: _RecordingClient(
            statusCodes: [403],
            responseBodies: ['{"description":"Forbidden: bot was kicked"}']));
    expect(
        await service.editMessage(
            chatId: 'chat', messageId: 42, text: 'changed'),
        isFalse);
    expect(await service.deleteMessage(chatId: 'chat', messageId: 42), isFalse);
  });

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

  test('sendMessageDetailed with explicit chatIds overrides the defaults',
      () async {
    final client = _RecordingClient(
      statusCodes: [200, 200],
      responseBodies: [
        '{"ok": true, "result": {"message_id": 1}}',
        '{"ok": true, "result": {"message_id": 2}}',
      ],
    );
    final service = TelegramService(
      botToken: 'token',
      chatIds: ['@general'],
      httpClient: client,
    );

    // Per-offer routing: general channel ∪ the offer bank's channel.
    final result = await service.sendMessageDetailed(
      'new offer',
      chatIds: ['@general', '@tatra'],
    );

    expect(result.sentMessages.map((m) => m.chatId), ['@general', '@tatra']);
    expect(client.requests, hasLength(2));
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

class _AbortedClient extends http.BaseClient {
  final bool stallBody;
  final bool earlyTimeout;
  final bool delayAbort;
  int aborted = 0;
  int started = 0;
  int active = 0;
  int peak = 0;
  final List<Future<void>> _abortCompletions = [];
  _AbortedClient(
      {required this.stallBody,
      this.earlyTimeout = false,
      this.delayAbort = false});

  Future<void> waitForAborts() async {
    await Future.wait(_abortCompletions);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    started++;
    active++;
    if (active > peak) peak = active;
    final abortable = request as http.AbortableRequest;
    final headers = Completer<http.StreamedResponse>();
    final body = StreamController<List<int>>();
    _abortCompletions.add(abortable.abortTrigger!.then((_) async {
      if (delayAbort) await Future<void>.delayed(Duration.zero);
      aborted++;
      active--;
      if (stallBody) {
        body.addError(http.RequestAbortedException());
        unawaited(body.close());
      } else {
        if (!headers.isCompleted) {
          headers.completeError(http.RequestAbortedException());
        }
      }
    }));
    if (earlyTimeout && started == 1) {
      headers.completeError(TimeoutException('transport deadline fired'));
    }
    return stallBody
        ? Future.value(http.StreamedResponse(body.stream, 200))
        : headers.future;
  }
}
