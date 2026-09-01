import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';

import 'config.dart';
import 'notification_controller.dart';

class NostrOfferMonitor {
  final TelegramBotConfig config;
  final OfferNotificationController controller;

  late final Ndk _ndk;
  Timer? _refreshTimer;
  NdkResponse? _offerSubscription;
  StreamSubscription<Nip01Event>? _offerListener;
  Set<String> _subscribedAuthors = const {};
  Set<String> _subscribedRelays = const {};
  DateTime? _subscriptionStartedAt;
  Map<String, CoordinatorIdentity> _reportedCoordinators = const {};
  Future<void>? _refreshInFlight;
  late Set<String> _lastMutedPubkeys;

  NostrOfferMonitor({required this.config, required this.controller});

  Future<void> start() async {
    _lastMutedPubkeys = controller.mutedCoordinators;
    _ndk = Ndk(
      NdkConfig(
        cache: MemCacheManager(),
        eventVerifier: RustEventVerifier(),
        bootstrapRelays: config.bootstrapRelays,
        // NDK currently initializes its optional wallet use cases even for a
        // read-only client, which otherwise emits an irrelevant Cashu warning.
        // This service reports its own discovery/subscription failures below.
        logLevel: LogLevel.error,
      ),
    );
    await refresh();
    _refreshTimer = Timer.periodic(
      config.discoveryRefreshInterval,
      (_) => unawaited(refresh()),
    );
  }

  Future<void> refresh() async {
    if (_refreshInFlight != null) return _refreshInFlight;
    final completer = Completer<void>();
    _refreshInFlight = completer.future;
    try {
      final discoveryRelays = await _resolveDiscoveryRelays();
      final muted = await _loadMutedPubkeys(discoveryRelays);
      _lastMutedPubkeys = muted;
      final coordinatorInfo = await _discoverCoordinators(
        discoveryRelays,
        muted,
      );
      final coordinatorPubkeys = coordinatorInfo.keys.toSet();
      final resolvedRelaySets = await Future.wait(
        coordinatorPubkeys.map(
          (pubkey) => _resolveCoordinatorRelays(pubkey, discoveryRelays),
        ),
      );
      final relaysByCoordinator = <String, Set<String>>{};
      for (final (index, pubkey) in coordinatorPubkeys.indexed) {
        relaysByCoordinator[pubkey] = resolvedRelaySets[index];
      }
      final identities = await _resolveCoordinatorIdentities(
        coordinatorInfo,
        relaysByCoordinator,
        discoveryRelays,
      );
      final offerRelays = resolvedRelaySets
          .expand((relays) => relays)
          .map(normalizeRelayUrl)
          .where((relay) => relay.isNotEmpty)
          .toSet();
      if (offerRelays.isEmpty) offerRelays.addAll(discoveryRelays);

      await controller.updateCoordinatorPolicy(
        allowed: coordinatorPubkeys,
        muted: muted,
        coordinatorIdentities: identities,
      );
      await _syncOfferSubscription(coordinatorPubkeys, offerRelays);
      _reportMonitoringCoordinators(identities);
      print(
        'Monitoring ${coordinatorPubkeys.length} ${config.paymentSystem.id} '
        'coordinator(s) on ${offerRelays.length} relay(s); '
        '${muted.length} muted',
      );
    } catch (error, stackTrace) {
      print('Nostr discovery refresh failed: $error\n$stackTrace');
    } finally {
      // Discovery events are re-fetched on every refresh and the verifier
      // cache is only an optimization. Releasing it keeps this daemon's
      // steady-state heap independent of relay history and event volume.
      _ndk.requests.clearVerifiedEventCache();
      _refreshInFlight = null;
      completer.complete();
    }
  }

  Future<Set<String>> _resolveDiscoveryRelays() async {
    final resolved = config.bootstrapRelays.map(normalizeRelayUrl).toSet();
    final newest = await _latestEvent(
      Filter(
        kinds: [kKindRelayList],
        authors: [config.paymentSystem.discoveryPubkeyHex],
        limit: 1,
      ),
      config.bootstrapRelays,
      name: 'tg-discovery',
    );
    if (newest != null) resolved.addAll(_relayTags(newest));
    return resolved;
  }

  Future<Set<String>> _loadMutedPubkeys(Set<String> discoveryRelays) async {
    final newest = await _latestEvent(
      Filter(
        kinds: [Nip51List.kMute],
        // The project identity is canonical in bitblik_core for each payment
        // system; use the same author for discovery and its NIP-51 mute list.
        authors: [config.paymentSystem.discoveryPubkeyHex],
        limit: 1,
      ),
      {...config.bootstrapRelays, ...discoveryRelays},
      name: 'tg-mutes',
    );
    // A relay outage or timeout must never silently unmute a coordinator. An
    // explicit newer empty mute-list event still returns an empty set below.
    if (newest == null) return _lastMutedPubkeys;
    return {
      for (final tag in newest.tags)
        if (tag.length >= 2 && tag[0] == 'p') tag[1].trim().toLowerCase(),
    }..removeWhere((pubkey) => pubkey.isEmpty);
  }

  Future<Map<String, CoordinatorInfo>> _discoverCoordinators(
    Set<String> discoveryRelays,
    Set<String> muted,
  ) async {
    final response = _ndk.requests.query(
      name: 'tg-coordinators',
      // A limit prevents a noisy or malicious relay from making one refresh
      // retain an arbitrarily large response while still leaving ample room
      // for every real coordinator in a market.
      filter: Filter(kinds: [kKindCoordinatorInfo], limit: 500),
      explicitRelays: discoveryRelays.toList(growable: false),
      cacheRead: false,
      cacheWrite: false,
      timeout: config.queryTimeout,
    );
    final coordinators = <String, (int, CoordinatorInfo)>{};
    await for (final event in response.stream) {
      final pubkey = event.pubKey.trim().toLowerCase();
      if (muted.contains(pubkey)) continue;
      try {
        final info = CoordinatorInfo.fromNostrEvent(event);
        if (info.paymentSystem == config.paymentSystem.id) {
          final current = coordinators[pubkey];
          if (current == null || event.createdAt > current.$1) {
            coordinators[pubkey] = (event.createdAt, info);
          }
        }
      } catch (error) {
        print('Ignored malformed coordinator event from $pubkey: $error');
      }
    }
    return {
      for (final entry in coordinators.entries) entry.key: entry.value.$2,
    };
  }

  Future<Map<String, CoordinatorIdentity>> _resolveCoordinatorIdentities(
    Map<String, CoordinatorInfo> coordinators,
    Map<String, Set<String>> relaysByCoordinator,
    Set<String> discoveryRelays,
  ) async {
    final entries = await Future.wait(coordinators.entries.map((entry) async {
      final relays = {
        ...discoveryRelays,
        ...?relaysByCoordinator[entry.key],
      };
      final profile = await _latestEvent(
        Filter(kinds: [Metadata.kKind], authors: [entry.key], limit: 1),
        relays,
        name: 'tg-p-${_shortPubkey(entry.key)}',
      );
      return MapEntry(
        entry.key,
        coordinatorIdentity(profile, entry.value),
      );
    }));
    return Map.fromEntries(entries);
  }

  void _reportMonitoringCoordinators(
    Map<String, CoordinatorIdentity> coordinators,
  ) {
    final changed = coordinators.entries.where((entry) {
      final previous = _reportedCoordinators[entry.key];
      return previous == null || previous.name != entry.value.name;
    }).toList()
      ..sort((left, right) => left.value.name
          .toLowerCase()
          .compareTo(right.value.name.toLowerCase()));
    for (final entry in changed) {
      print(
        'Monitoring coordinator: ${entry.value.name} '
        '(${_shortPubkey(entry.key)}…)',
      );
    }
    _reportedCoordinators = Map.unmodifiable(coordinators);
  }

  Future<Set<String>> _resolveCoordinatorRelays(
    String pubkey,
    Set<String> discoveryRelays,
  ) async {
    final newest = await _latestEvent(
      Filter(kinds: [kKindRelayList], authors: [pubkey], limit: 1),
      discoveryRelays,
      // NDK appends an 11-character random suffix. Keep this comfortably under
      // the 64/100-character subscription-id limits enforced by relays.
      name: 'tg-cr-${_shortPubkey(pubkey)}',
    );
    if (newest == null) return discoveryRelays;
    final relays = _relayTags(newest);
    return relays.isEmpty ? discoveryRelays : relays;
  }

  Future<Nip01Event?> _latestEvent(
    Filter filter,
    Iterable<String> relays, {
    required String name,
  }) async {
    final response = _ndk.requests.query(
      name: name,
      filter: filter,
      explicitRelays: relays.toList(growable: false),
      cacheRead: false,
      cacheWrite: false,
      timeout: config.queryTimeout,
    );
    Nip01Event? newest;
    await for (final event in response.stream) {
      if (newest == null || event.createdAt > newest.createdAt) newest = event;
    }
    return newest;
  }

  Future<void> _syncOfferSubscription(
    Set<String> authors,
    Set<String> relays,
  ) async {
    final startedAt = _subscriptionStartedAt;
    final rotationDue = startedAt == null ||
        DateTime.now().toUtc().difference(startedAt) >=
            config.subscriptionRotationInterval;
    if (!rotationDue &&
        _sameSet(authors, _subscribedAuthors) &&
        _sameSet(relays, _subscribedRelays)) {
      return;
    }
    await _closeOfferSubscription();
    _subscribedAuthors = Set.unmodifiable(authors);
    _subscribedRelays = Set.unmodifiable(relays);
    if (authors.isEmpty) return;

    final since = DateTime.now()
            .toUtc()
            .subtract(config.subscriptionOverlap)
            .millisecondsSinceEpoch ~/
        1000;
    _offerSubscription = _ndk.requests.subscription(
      name: 'tg-offers-${config.paymentSystem.id}',
      filter: Filter(
        kinds: [kKindOffer],
        authors: authors.toList(growable: false),
        tags: {
          '#y': [config.paymentSystem.platformTag],
        },
        since: since,
      ),
      explicitRelays: relays.toList(growable: false),
      cacheRead: false,
      cacheWrite: false,
    );
    _offerListener = _offerSubscription!.stream.listen(
      (event) => unawaited(controller.handleEvent(event)),
      onError: (Object error, StackTrace stackTrace) {
        print('Nostr offer subscription error: $error\n$stackTrace');
      },
      cancelOnError: false,
    );
    _subscriptionStartedAt = DateTime.now().toUtc();
  }

  Set<String> _relayTags(Nip01Event event) => {
        for (final tag in event.tags)
          if (tag.length >= 2 && tag[0] == 'r') normalizeRelayUrl(tag[1]),
      }..removeWhere((relay) => relay.isEmpty);

  Future<void> _closeOfferSubscription() async {
    await _offerListener?.cancel();
    _offerListener = null;
    if (_offerSubscription != null) {
      await _ndk.requests.closeSubscription(_offerSubscription!.requestId);
      _offerSubscription = null;
    }
    _subscriptionStartedAt = null;
  }

  Future<void> stop() async {
    _refreshTimer?.cancel();
    await _closeOfferSubscription();
    await _ndk.destroy();
  }

  static bool _sameSet(Set<String> left, Set<String> right) =>
      left.length == right.length && left.containsAll(right);

  static String _shortPubkey(String pubkey) =>
      pubkey.length <= 12 ? pubkey : pubkey.substring(0, 12);
}

CoordinatorIdentity coordinatorIdentity(
  Nip01Event? profileEvent,
  CoordinatorInfo announced,
) {
  String? profileName;
  if (profileEvent != null) {
    try {
      final metadata = Metadata.fromEvent(profileEvent);
      profileName = _nonEmpty(metadata.displayName) ?? _nonEmpty(metadata.name);
    } catch (_) {
      // Malformed optional profile metadata falls back to kind 15125 below.
    }
  }
  return CoordinatorIdentity(
    name: profileName ?? announced.name,
  );
}

String? _nonEmpty(String? value) {
  final normalized = value?.trim();
  return normalized == null || normalized.isEmpty ? null : normalized;
}
