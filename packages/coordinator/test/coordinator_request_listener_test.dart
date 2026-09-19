import 'dart:async';

import 'package:bitblik_coordinator/src/services/coordinator_request_listener.dart';
import 'package:bitblik_coordinator/src/services/relay_delivery.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/domain_layer/entities/broadcast_state.dart';
import 'package:test/test.dart';

class TestRequests implements Requests {
  final streams = <String, StreamController<Nip01Event>>{};
  final closed = <String>[];
  Completer<void>? gate;
  var nextId = 0;
  @override
  Future<void> closeSubscription(String id, {String debugLabel = ''}) async {
    closed.add(id);
    await streams.remove(id)?.close();
  }

  @override
  dynamic noSuchMethod(Invocation call) {
    if (call.memberName == #subscription) {
      final id = '${nextId++}';
      final relays = call.namedArguments[#explicitRelays] as Iterable<String>;
      final controller = StreamController<Nip01Event>();
      streams[id] = controller;
      final ready = gate?.future;
      return NdkResponse(id, controller.stream,
          relayOutcomesStream: () =>
              Stream.fromFuture((ready ?? Future<void>.value()).then((_) => {
                    for (final relay in relays)
                      relay: const RelayRequestOutcome(RelayRequestStatus.eose)
                  })));
    }
    return super.noSuchMethod(call);
  }
}

void main() {
  late TestRequests requests;
  late CoordinatorRequestListener listener;
  late List<Object> errors;
  late List<String> handled;
  setUp(() {
    requests = TestRequests();
    errors = [];
    handled = [];
    listener = CoordinatorRequestListener(
        requests: requests,
        pubkey: 'coordinator',
        waitUntilSent: (_, __, timeout) =>
            (requests.gate?.future ?? Future<void>.value()).timeout(timeout),
        readyTimeout: const Duration(seconds: 2),
        retryDelay: const Duration(milliseconds: 10),
        onRequest: (event) async {
          handled.add(event.id);
        },
        onError: errors.add);
  });
  tearDown(() => listener.close());

  test('replacement overlaps old listener and deduplicates requests', () async {
    await listener.replace(['wss://old.example']);
    requests.gate = Completer<void>();
    final replacement = listener.replace(['wss://new.example']);
    await Future<void>.delayed(Duration.zero);
    expect(requests.closed, isEmpty);
    final event =
        Nip01Event(pubKey: 'maker', kind: 25195, tags: [], content: 'request');
    for (final stream in requests.streams.values) {
      stream.add(event);
    }
    await Future<void>.delayed(Duration.zero);
    expect(handled, [event.id]);
    requests.gate!.complete();
    await replacement;
    expect(requests.closed, ['0']);
    expect(listener.isActive, isTrue);
  });

  test('failed replacement preserves working listener', () async {
    await listener.replace(['wss://old.example']);
    requests.gate = Completer<void>();
    await listener.replace(['wss://unavailable.example']);
    expect(errors.single, isA<TimeoutException>());
    expect(requests.streams.keys, ['0']);
    expect(listener.isActive, isTrue);
    requests.gate!.complete();
  });

  test('ended stream recovers and cleans up old request', () async {
    await listener.replace(['wss://relay.example']);
    await requests.streams['0']!.close();
    expect(listener.isActive, isFalse);
    await Future<void>.delayed(const Duration(milliseconds: 40));
    expect(listener.isActive, isTrue);
    expect(requests.streams.keys, ['1']);
    expect(requests.closed, ['0']);
    await listener.close();
    await Future<void>.delayed(const Duration(milliseconds: 40));
    expect(requests.streams, isEmpty);
  });

  test('relay errors are not reported as successful delivery', () {
    final rejected = RelayBroadcastResponse(
        relayUrl: 'wss://reject.example',
        okReceived: true,
        broadcastSuccessful: false,
        msg: 'rate limited');
    expect(() => requireRelayAcceptance([]), throwsStateError);
    expect(() => requireRelayAcceptance([rejected]), throwsStateError);
    requireRelayAcceptance([
      rejected,
      RelayBroadcastResponse(
          relayUrl: 'wss://ok.example',
          okReceived: true,
          broadcastSuccessful: true)
    ]);
  });
}
