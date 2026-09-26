import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:fake_async/fake_async.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

const _coordinator =
    '0000000000000000000000000000000000000000000000000000000000000001';
const _offerRelay = 'wss://offers.example';
const _profileRelay = 'wss://profile.example';

class _Store extends CoordinatorStore {
  @override
  Future<List<CoordinatorRecord>> load() async => [];
  @override
  Future<void> save(List<CoordinatorRecord> records) async {}
  @override
  Future<bool> loadBootstrapCompleted(String paymentSystemId) async => true;
}

class _Requests implements Requests {
  final active = <String, Set<String>>{};
  final controllers = <String, StreamController<Nip01Event>>{};
  final warmRelays = <String>{_offerRelay};
  final closed = <String>[];
  String? profileId;
  int nextId = 0;

  Future<void> closeIdleConnections() async {
    final needed = {_offerRelay, ...active.values.expand((relays) => relays)};
    warmRelays.retainAll(needed);
  }

  @override
  Future<void> closeSubscription(String id, {String debugLabel = ''}) async {
    closed.add(id);
    active.remove(id);
    final controller = controllers.remove(id);
    if (controller != null && !controller.isClosed) await controller.close();
  }

  @override
  dynamic noSuchMethod(Invocation call) {
    if (call.memberName != #query) return super.noSuchMethod(call);
    final name = call.namedArguments[#name] as String;
    final id = '$name-${nextId++}';
    final relays =
        (call.namedArguments[#explicitRelays] as Iterable<String>).toSet();
    final controller = StreamController<Nip01Event>();
    controllers[id] = controller;
    active[id] = relays;
    warmRelays.addAll(relays);
    if (name == 'coordinator-profiles') {
      profileId = id;
    } else {
      scheduleMicrotask(() {
        if (name == 'coordinator-discovery') {
          controller.add(Nip01Event(
            pubKey: _coordinator,
            kind: kKindCoordinatorInfo,
            tags: [
              ['name', 'Test coordinator'],
              ['currencies', 'PLN'],
              ['payment_system', 'blik'],
            ],
            content: '',
          ));
        } else if (name == 'coordinator-batch-nip65') {
          controller.add(Nip01Event(
            pubKey: _coordinator,
            kind: kKindRelayList,
            tags: [
              ['r', _profileRelay],
            ],
            content: '',
          ));
        }
        unawaited(controller.close());
      });
    }
    return NdkResponse(id, controller.stream);
  }
}

class _Ndk extends Ndk {
  @override
  final _Requests requests = _Requests();
  _Ndk()
      : super(NdkConfig(
          cache: MemCacheManager(),
          eventVerifier: Bip340EventVerifier(),
          bootstrapRelays: const [],
        ));
}

Future<void> _advance(FakeAsync clock, Duration duration) async {
  clock.elapse(duration);
  // Stream cancellation may complete in the real zone between query phases.
  for (var i = 0; i < 12; i++) {
    await pumpEventQueue(times: 2);
    clock.flushMicrotasks();
    clock.elapse(Duration.zero);
  }
}

void main() {
  for (final backgrounded in [true, false]) {
    test(
        'late discovery completion prunes only when backgrounded=$backgrounded',
        () async {
      final clock = FakeAsync();
      final ndk = _Ndk();
      final rpc = BitblikRpcClient(
        ndk: ndk,
        signer: Bip340EventSigner(privateKey: null, publicKey: _coordinator),
        relays: const [],
      );
      var completed = false;
      var cleanupCalls = 0;
      Set<String>? activeAtCleanup;
      final registry = CoordinatorRegistry(
        ndk: ndk,
        rpcClient: rpc,
        store: _Store(),
        relays: const ['wss://discovery.example'],
        onNetworkWorkCompleted: () async {
          // All query ownership must be gone before pruning their sockets.
          activeAtCleanup = ndk.requests.active.keys.toSet();
          cleanupCalls++;
          if (backgrounded) await ndk.requests.closeIdleConnections();
        },
      );
      clock.run((_) => unawaited(registry.discover().then((_) {
            completed = true;
          })));
      await _advance(clock, Duration.zero);
      final profileId = ndk.requests.profileId!;
      final profile = ndk.requests.controllers[profileId]!;
      // Keep this legitimate startup query busy beyond the app's former
      // one-shot 30s cleanup window without waiting in real time.
      for (var i = 0; i < 7; i++) {
        clock.run((_) => profile.add(Nip01Event(
              pubKey: _coordinator,
              kind: Metadata.kKind,
              tags: const [],
              content: '{"display_name":"Fresh profile"}',
            )));
        await _advance(clock, const Duration(seconds: 5));
      }
      expect(completed, isFalse);
      expect(cleanupCalls, 0);
      expect(ndk.requests.warmRelays, contains(_profileRelay));
      clock.run((_) => unawaited(profile.close()));
      await _advance(clock, Duration.zero);
      expect(completed, isTrue);
      expect(cleanupCalls, 1);
      expect(activeAtCleanup, isEmpty);
      expect(registry.recordFor(_coordinator)?.profileName, 'Fresh profile');
      expect(ndk.requests.closed, contains(profileId));
      expect(ndk.requests.active, isEmpty);
      expect(
        ndk.requests.warmRelays,
        backgrounded
            ? equals({_offerRelay})
            : containsAll(
                {_offerRelay, _profileRelay, 'wss://discovery.example'}),
      );
      await registry.dispose();
      await ndk.destroy();
    });
  }

  test('profile timeout closes NDK request and contains idle callback failure',
      () async {
    final clock = FakeAsync();
    final ndk = _Ndk();
    final rpc = BitblikRpcClient(
      ndk: ndk,
      signer: Bip340EventSigner(privateKey: null, publicKey: _coordinator),
      relays: const [],
    );
    var completed = false;
    var cleanupCalls = 0;
    Set<String>? activeAtCleanup;
    final registry = CoordinatorRegistry(
      ndk: ndk,
      rpcClient: rpc,
      store: _Store(),
      relays: const ['wss://discovery.example'],
      onNetworkWorkCompleted: () async {
        cleanupCalls++;
        activeAtCleanup = ndk.requests.active.keys.toSet();
        throw StateError('optional cleanup failed');
      },
    );
    clock.run((_) => unawaited(registry.discover().then((_) {
          completed = true;
        })));
    await _advance(clock, Duration.zero);
    final profileId = ndk.requests.profileId!;
    expect(ndk.requests.active.keys, contains(profileId));
    await _advance(clock, const Duration(seconds: 9));
    expect(completed, isTrue);
    expect(cleanupCalls, 1);
    expect(activeAtCleanup, isEmpty);
    expect(ndk.requests.active, isEmpty);
    expect(ndk.requests.closed, contains(profileId));
    expect(registry.recordFor(_coordinator), isNotNull);
    await registry.dispose();
    await ndk.destroy();
  });
}
