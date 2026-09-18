import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

const info = CoordinatorInfo(
    name: 'test',
    reservationSeconds: 60,
    makerFee: 1,
    takerFee: 1,
    minAmountSats: 1,
    maxAmountSats: 100000,
    currencies: ['PLN'],
    paymentSystem: 'blik',
    nostrNpub: null);

class MemoryStore extends CoordinatorStore {
  List<CoordinatorRecord> records;
  MemoryStore(this.records);
  @override
  Future<List<CoordinatorRecord>> load() async => records;
  @override
  Future<void> save(List<CoordinatorRecord> values) async {
    records = values;
  }
}

class TestRequests implements Requests {
  final pending = <Completer<void>>[];
  int statsQueries = 0;
  int active = 0;
  int peak = 0;
  bool hold = false;
  bool fail = false;
  @override
  dynamic noSuchMethod(Invocation call) {
    if (call.memberName == #query) {
      final filter = call.namedArguments[#filter] as Filter?;
      final isStats = filter?.kinds?.contains(kKindOffer) == true;
      Stream<Nip01Event> events() async* {
        if (isStats) {
          statsQueries++;
          active++;
          if (active > peak) peak = active;
          if (hold) {
            final gate = Completer<void>();
            pending.add(gate);
            await gate.future;
          }
          active--;
        }
      }

      return NdkResponse('query', events(),
          relayOutcomes: () => {
                'wss://test.example': RelayRequestOutcome(isStats && fail
                    ? RelayRequestStatus.disconnected
                    : RelayRequestStatus.eose),
              });
    }
    if (call.memberName == #closeSubscription) return Future<void>.value();
    return super.noSuchMethod(call);
  }
}

class TestNdk extends Ndk {
  @override
  final TestRequests requests = TestRequests();
  TestNdk()
      : super(NdkConfig(
            cache: MemCacheManager(),
            eventVerifier: Bip340EventVerifier(),
            bootstrapRelays: []));
}

class TestRpc extends BitblikRpcClient {
  int calls = 0;
  Object? error;
  NostrResponse? reply;
  Completer<void>? gate;
  TestRpc(Ndk ndk)
      : super(
            ndk: ndk,
            signer: Bip340EventSigner(privateKey: null, publicKey: 'a' * 64),
            relays: []);
  @override
  Future<NostrResponse> send(NostrRequest request, String coordinatorPubkey,
      {Duration? timeoutOverride, List<String>? relays}) async {
    calls++;
    await gate?.future;
    if (error != null) throw error!;
    return reply ?? NostrResponse(result: info.toJson());
  }
}

void main() {
  late TestNdk ndk;
  late TestRpc rpc;
  late CoordinatorRegistry registry;
  setUp(() async {
    ndk = TestNdk();
    rpc = TestRpc(ndk);
    registry = CoordinatorRegistry(
        ndk: ndk,
        rpcClient: rpc,
        store: MemoryStore(List.generate(
            5,
            (i) => CoordinatorRecord(
                pubkeyHex: '$i'.padLeft(64, '0'),
                info: info,
                relays: const ['wss://test.example'],
                networkFinishedCount: 7))),
        relays: const []);
    await registry.init();
  });
  tearDown(() async {
    await registry.dispose();
    await ndk.destroy();
  });

  test('one failure is uncertain, two offline, success restores health',
      () async {
    final key = registry.all.first.pubkeyHex;
    rpc.error = RpcTimeoutException(
        method: kRpcGetInfo,
        stage: 'coordinator response',
        relayAccepted: true,
        responsePathAvailable: true,
        duration: const Duration(seconds: 5));
    await registry.probeHealth(key, refreshRelayList: false);
    expect(
        registry.all.firstWhere((r) => r.pubkeyHex == key).responsive, isNull);
    await registry.probeHealth(key, refreshRelayList: false);
    expect(
        registry.all.firstWhere((r) => r.pubkeyHex == key).responsive, isFalse);
    rpc.error = null;
    await registry.probeHealth(key, refreshRelayList: false);
    expect(
        registry.all.firstWhere((r) => r.pubkeyHex == key).responsive, isTrue);
  });

  test(
      'relay/setup failures never label both coordinators offline or penalize rank',
      () async {
    rpc.error = TimeoutException('relay unavailable, no delivery evidence');
    final keys =
        registry.all.take(2).map((record) => record.pubkeyHex).toList();
    for (var attempt = 0; attempt < 3; attempt++) {
      await Future.wait(keys.map(registry.probeHealth));
    }
    for (final key in keys) {
      final record =
          registry.all.firstWhere((record) => record.pubkeyHex == key);
      expect(record.responsive, isNull);
      expect(record.failedProbes, 0);
    }
  });

  test('newer offer reply outranks an older health timeout', () async {
    final key = registry.all.first.pubkeyHex;
    rpc.error = RpcTimeoutException(
        method: kRpcGetInfo,
        stage: 'coordinator response',
        relayAccepted: true,
        responsePathAvailable: true,
        duration: const Duration(seconds: 5));
    rpc.gate = Completer<void>();
    final probe = registry.probeHealth(key);
    registry.recordRpcResponse(key);
    rpc.gate!.complete();
    await probe;
    final record = registry.all.firstWhere((record) => record.pubkeyHex == key);
    expect(record.responsive, isTrue);
    expect(record.failedProbes, 0);
  });

  test('recent authenticated offer reply survives temporary health failures',
      () async {
    final key = registry.all.first.pubkeyHex;
    registry.recordRpcResponse(key);
    rpc.error = RpcTimeoutException(
        method: kRpcGetInfo,
        stage: 'coordinator response',
        relayAccepted: true,
        responsePathAvailable: true,
        duration: const Duration(seconds: 5));
    await registry.probeHealth(key);
    await registry.probeHealth(key);
    expect(
        registry.all.firstWhere((record) => record.pubkeyHex == key).responsive,
        isTrue);
  });

  test('get_info RPC errors prove reachability and preserve known metadata',
      () async {
    final key = registry.all.first.pubkeyHex;
    rpc.reply = const NostrResponse(error: {'code': 'INTERNAL_ERROR'});
    await registry.probeHealth(key);
    final record = registry.all.firstWhere((record) => record.pubkeyHex == key);
    expect(record.responsive, isTrue);
    expect(record.info?.name, 'test');
    expect(record.failedProbes, 0);
  });

  test('concurrent health probes share work and preserve changed preference',
      () async {
    final key = registry.all.first.pubkeyHex;
    rpc.gate = Completer<void>();
    final first = registry.probeHealth(key, refreshRelayList: false);
    final second = registry.probeHealth(key, refreshRelayList: false);
    await registry.setEnabled(key, false);
    rpc.gate!.complete();
    await Future.wait([first, second]);
    expect(rpc.calls, 1);
    expect(registry.all.firstWhere((r) => r.pubkeyHex == key).enabled, isFalse);
  });

  test('transient health failure retries without manual refresh', () async {
    final key = registry.all.first.pubkeyHex;
    rpc.error = TimeoutException('temporary transport failure');
    await registry.probeHealth(key, refreshRelayList: false);
    rpc.error = null;
    await Future<void>.delayed(const Duration(milliseconds: 2600));
    expect(rpc.calls, 2);
    expect(
        registry.all.firstWhere((record) => record.pubkeyHex == key).responsive,
        isTrue);
  });

  test('history concurrency capped, refreshes coalesced, unchanged stats fresh',
      () async {
    ndk.requests.hold = true;
    final first = registry.fetchNetworkFinishedCounts();
    await Future<void>.delayed(Duration.zero);
    final second = registry.fetchNetworkFinishedCounts();
    expect(ndk.requests.peak, 2);
    ndk.requests.hold = false;
    for (final gate in ndk.requests.pending) {
      gate.complete();
    }
    await Future.wait([first, second]);
    expect(ndk.requests.statsQueries, 5);
    await registry.fetchNetworkFinishedCounts();
    expect(ndk.requests.statsQueries, 5);
    await registry.fetchNetworkFinishedCounts(
        force: true, pubkeys: {registry.all.first.pubkeyHex});
    expect(ndk.requests.statsQueries, 6);
  });

  test('failed history query preserves cached count', () async {
    ndk.requests.fail = true;
    await registry.fetchNetworkFinishedCounts();
    expect(registry.all.map((r) => r.networkFinishedCount), everyElement(7));
    expect(registry.all.map((r) => r.lastFinishedCountUpdate),
        everyElement(isNull));
  });
}
