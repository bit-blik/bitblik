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

class WatchRequests implements Requests {
  final subscriptions = <Filter>[];
  final controllers = <StreamController<Nip01Event>>[];
  int closed = 0;

  @override
  dynamic noSuchMethod(Invocation call) {
    if (call.memberName == #query) {
      return NdkResponse('query', const Stream<Nip01Event>.empty());
    }
    if (call.memberName == #subscription) {
      subscriptions.add(call.namedArguments[#filter] as Filter);
      final controller = StreamController<Nip01Event>();
      controllers.add(controller);
      return NdkResponse('sub-${controllers.length}', controller.stream);
    }
    if (call.memberName == #closeSubscription) {
      final id = call.positionalArguments.first as String;
      if (id.startsWith('sub-')) closed++;
      return Future<void>.value();
    }
    return super.noSuchMethod(call);
  }
}

class WatchNdk extends Ndk {
  @override
  final WatchRequests requests = WatchRequests();
  WatchNdk()
      : super(NdkConfig(
            cache: MemCacheManager(),
            eventVerifier: Bip340EventVerifier(),
            bootstrapRelays: []));
}

void main() {
  final enabledKey = '1'.padLeft(64, '0');
  final disabledKey = '2'.padLeft(64, '0');
  late WatchNdk ndk;
  late CoordinatorRegistry registry;

  setUp(() async {
    ndk = WatchNdk();
    registry = CoordinatorRegistry(
        ndk: ndk,
        rpcClient: BitblikRpcClient(
            ndk: ndk,
            signer: Bip340EventSigner(privateKey: null, publicKey: 'a' * 64),
            relays: []),
        store: MemoryStore([
          CoordinatorRecord(
              pubkeyHex: enabledKey,
              info: info,
              enabled: true,
              lastSeen: DateTime.fromMillisecondsSinceEpoch(1000 * 1000)),
          CoordinatorRecord(pubkeyHex: disabledKey, info: info, enabled: false),
        ]),
        relays: const ['wss://discovery.example']);
    await registry.init();
  });
  tearDown(() async {
    await registry.dispose();
    await ndk.destroy();
  });

  test('CoordinatorInfo has value equality', () {
    expect(CoordinatorInfo.fromJson(info.toJson()), info);
    expect(
        CoordinatorInfo.fromJson({...info.toJson(), 'maker_fee': 2.0}) == info,
        isFalse);
  });

  test('live watch targets all known authors and applies newer info', () async {
    registry.startInfoWatch();
    expect(ndk.requests.subscriptions, hasLength(1));
    final filter = ndk.requests.subscriptions.single;
    expect(filter.kinds, [kKindCoordinatorInfo]);
    expect(filter.authors, unorderedEquals([enabledKey, disabledKey]));
    // No `since`: relays must replay the stored current copy so a stale
    // persisted record is repaired even if startup discovery missed it.
    expect(filter.since, isNull);

    final updated = CoordinatorInfo.fromJson({
      ...info.toJson(),
      'maker_fee': 0.25,
      'taker_fee': 0.75,
    });
    final emitted = registry.changes.first;
    ndk.requests.controllers.single.add(Nip01Event(
        pubKey: enabledKey,
        kind: kKindCoordinatorInfo,
        tags: updated.toNostrTags(),
        content: '',
        createdAt: 2000 * 1000));
    await emitted;
    expect(registry.infoFor(enabledKey)?.makerFee, 0.25);
    expect(registry.infoFor(enabledKey)?.takerFee, 0.75);
  });

  test('re-targets when the known set changes and closes on stop', () async {
    registry.startInfoWatch();
    // Same author/relay set: no resubscribe.
    registry.startInfoWatch();
    expect(ndk.requests.subscriptions, hasLength(1));

    // Enable/disable alone does not change the author set.
    await registry.setEnabled(disabledKey, true);
    expect(ndk.requests.subscriptions, hasLength(1));

    await registry.remove(disabledKey);
    await Future<void>.delayed(Duration.zero);
    expect(ndk.requests.subscriptions, hasLength(2));
    expect(ndk.requests.subscriptions.last.authors, [enabledKey]);
    expect(ndk.requests.closed, 1);

    await registry.stopInfoWatch();
    expect(ndk.requests.closed, 2);
    await registry.setEnabled(enabledKey, false);
    expect(ndk.requests.subscriptions, hasLength(2));
  });
}
