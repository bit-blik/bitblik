import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:ndk/data_layer/repositories/wallets/mem_wallets_repo.dart';
import 'package:ndk/domain_layer/entities/cashu/cashu_user_seedphrase.dart';
import 'package:ndk/ndk.dart';

import 'coordinator_file_store.dart';

/// Fetch coordinator advertisements for the CLI without starting RPC,
/// enriching profiles, collecting offer statistics, or probing health.
Future<List<CoordinatorRecord>> listCoordinatorAdvertisements({
  required PaymentSystem paymentSystem,
  required List<String> bootstrapRelays,
  Duration deadline = const Duration(seconds: 3),
}) async {
  final ndk = Ndk(NdkConfig(
    cache: MemCacheManager(),
    walletsRepo: MemWalletsRepo(),
    eventVerifier: RustEventVerifier(),
    bootstrapRelays: bootstrapRelays,
    cashuUserSeedphrase:
        CashuUserSeedphrase(seedPhrase: CashuSeed.generateSeedPhrase()),
    logLevel: LogLevel.error,
  ));
  final clock = Stopwatch()..start();
  try {
    final saved = {
      for (final record
          in await CoordinatorFileStore(paymentSystem: paymentSystem).load())
        record.pubkeyHex: record,
    };

    // Start the advertisement query immediately. Resolve optional project
    // relays at the same time, then query only relays absent from bootstrap.
    final advertisements = _queryEvents(
      ndk,
      Filter(kinds: [kKindCoordinatorInfo]),
      bootstrapRelays,
      deadline,
    );
    final relayList = _queryEvents(
      ndk,
      Filter(
        kinds: [kKindRelayList],
        authors: [paymentSystem.discoveryPubkeyHex],
      ),
      bootstrapRelays,
      const Duration(seconds: 1),
    );
    final muteList = _queryEvents(
      ndk,
      Filter(
        kinds: [Nip51List.kMute],
        authors: [paymentSystem.discoveryPubkeyHex],
      ),
      bootstrapRelays,
      const Duration(seconds: 1),
    );

    final extraAdvertisements = () async {
      final projectEvents = await relayList;
      final bootstrapSet = bootstrapRelays.map(normalizeRelayUrl).toSet();
      Nip01Event? newestProjectList;
      for (final event in projectEvents) {
        if (event.pubKey == paymentSystem.discoveryPubkeyHex &&
            (newestProjectList == null ||
                event.createdAt > newestProjectList.createdAt)) {
          newestProjectList = event;
        }
      }
      final additionalRelays = <String>{};
      if (newestProjectList != null) {
        for (final tag in newestProjectList.tags) {
          if (tag.length < 2 || tag[0] != 'r') continue;
          final relay = normalizeRelayUrl(tag[1]);
          if (relay.isNotEmpty && !bootstrapSet.contains(relay)) {
            additionalRelays.add(relay);
          }
        }
      }
      final remaining = deadline - clock.elapsed;
      if (additionalRelays.isEmpty || remaining <= Duration.zero) {
        return <Nip01Event>[];
      }
      return _queryEvents(
        ndk,
        Filter(kinds: [kKindCoordinatorInfo]),
        additionalRelays.toList(),
        remaining,
      );
    }();

    final initial = await advertisements;
    final extra = await extraAdvertisements;
    final muteEvents = await muteList;
    Nip01Event? newestMuteList;
    for (final event in muteEvents) {
      if (event.pubKey == paymentSystem.discoveryPubkeyHex &&
          (newestMuteList == null ||
              event.createdAt > newestMuteList.createdAt)) {
        newestMuteList = event;
      }
    }
    final muted = <String>{
      for (final tag in newestMuteList?.tags ?? const <List<String>>[])
        if (tag.length >= 2 && tag[0] == 'p') tag[1],
    };

    final latest = <String, Nip01Event>{};
    for (final event in [...initial, ...extra]) {
      if (muted.contains(event.pubKey)) continue;
      final info = CoordinatorInfo.fromNostrEvent(event);
      if (info.paymentSystem != paymentSystem.id) continue;
      final previous = latest[event.pubKey];
      if (previous == null || event.createdAt > previous.createdAt) {
        latest[event.pubKey] = event;
      }
    }

    final now = DateTime.now();
    final records = latest.values.map((event) {
      final previous = saved[event.pubKey];
      final eventTime =
          DateTime.fromMillisecondsSinceEpoch(event.createdAt * 1000);
      return CoordinatorRecord(
        pubkeyHex: event.pubKey,
        info: CoordinatorInfo.fromNostrEvent(event),
        lastSeen: eventTime,
        firstSeenAt: previous?.firstSeenAt ?? now,
        enabled: previous?.enabled ?? false,
        manualAdded: previous?.manualAdded ?? false,
        responsive: previous?.responsive,
      );
    }).toList();
    records.sort((a, b) => a.compareForRanking(b));
    return records;
  } finally {
    await ndk.destroy();
  }
}

/// Collect until relay EOSE or a fixed wall-clock limit, even if events keep
/// arriving. A stream inactivity timeout alone cannot cap total CLI latency.
Future<List<Nip01Event>> _queryEvents(
  Ndk ndk,
  Filter filter,
  List<String> relays,
  Duration maxWait,
) async {
  if (maxWait <= Duration.zero) return [];
  final response = ndk.requests.query(
    name: 'cli-coordinator-advertisements',
    filter: filter,
    explicitRelays: relays,
    cacheRead: false,
  );
  final events = <Nip01Event>[];
  final done = Completer<void>();
  var timedOut = false;
  final timer = Timer(maxWait, () {
    timedOut = true;
    if (!done.isCompleted) done.complete();
  });
  final subscription = response.stream.listen(
    events.add,
    onError: (Object _) {
      if (!done.isCompleted) done.complete();
    },
    onDone: () {
      if (!done.isCompleted) done.complete();
    },
  );
  try {
    await done.future;
  } finally {
    timer.cancel();
    await subscription.cancel();
    if (timedOut) {
      await ndk.requests.closeSubscription(response.requestId);
    }
  }
  return events;
}
