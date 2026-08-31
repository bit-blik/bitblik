import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

const _formerGeneratedDmInboxRelays = [
  'wss://nip17.com',
  'wss://relay.primal.net',
  'wss://nos.lol',
];

// Amethyst commonly uses these relays as NIP-17 inboxes. Keep authenticated
// console connections to them because an Amethyst sender may still have an
// older coordinator kind-10050 cached. This is receive/auth compatibility
// only; these relays are deliberately not part of the coordinator's published
// kind-10050 unless the operator explicitly configured them.
const _amethystCompatibilityDmInboxRelays = ['wss://auth.nostr1.com'];

@visibleForTesting
List<String> coordinatorDmInboxSubscriptionRelays({
  required Iterable<String> configuredRelays,
  required Iterable<String> observedHistoricalRelays,
  required Iterable<String> defaultRelays,
  required Iterable<String> discoveryRelays,
  required Iterable<String> coordinatorRelays,
}) =>
    {
          ...configuredRelays,
          ...observedHistoricalRelays,
          ...defaultRelays,
          ..._formerGeneratedDmInboxRelays,
          ..._amethystCompatibilityDmInboxRelays,
          ...discoveryRelays,
          ...coordinatorRelays,
        }
        .map(normalizeRelayUrl)
        .where((relay) => relay.isNotEmpty)
        .toList(growable: false);

@visibleForTesting
bool isGeneratedCoordinatorDmRelayList({
  required Iterable<String> configuredRelays,
  required Iterable<String> coordinatorRelays,
}) {
  final configured = configuredRelays.map(normalizeRelayUrl).toSet();
  if (configured.isEmpty) return false;
  final former = _formerGeneratedDmInboxRelays.map(normalizeRelayUrl).toSet();
  if (configured.length == former.length && configured.containsAll(former)) {
    return true;
  }
  final working = coordinatorRelays
      .map(normalizeRelayUrl)
      .where((relay) => relay.isNotEmpty)
      .toSet();
  return working.isNotEmpty &&
      configured.length == working.length &&
      configured.containsAll(working);
}

class CoordinatorSession extends ChangeNotifier {
  final NdkFlutter ndkFlutter;
  final Future<List<String>> Function(String pubkey)? relayLoader;
  final Future<void> Function()? accountStateSaver;

  String? _expectedCoordinatorPubkey;
  BitblikRpcClient? _rpc;
  List<String> _coordinatorRelays = const [];
  final Map<String, NdkResponse> _dmInboxSubscriptions = {};
  final Map<String, StreamSubscription<Nip01Event>> _dmInboxEvents = {};
  List<String> _dmInboxRelays = const [];
  Nip01Event? _publishedDmInboxEvent;
  final Set<String> _observedDmInboxRelays = {};
  bool _dmInboxPollInFlight = false;
  bool _dmInboxReadyReported = false;
  bool _liveDmReceiptReported = false;
  final Set<String> _receivedDmWrapIds = {};
  final Set<String> _rejectedDmWrapIds = {};
  final Set<String> _reportedDmRejectionReasons = {};
  int _acceptedDmWrapCount = 0;
  String? _lastDmInboxRejection;
  String? _diagnosticLiveRumorId;
  final _dmInboxEventController = StreamController<Nip17Message>.broadcast();
  final Map<String, Nip17Message> _dmMessagesByRumorId = {};
  final Map<String, NdkResponse> _legacyInboxSubscriptions = {};
  final Map<String, StreamSubscription<Nip01Event>> _legacyInboxEvents = {};
  final _legacyInboxEventController =
      StreamController<LegacyNip04Message>.broadcast();
  final Map<String, LegacyNip04Message> _legacyMessagesByEventId = {};
  bool _closed = false;

  CoordinatorSession({
    required this.ndkFlutter,
    this.relayLoader,
    this.accountStateSaver,
  });

  Ndk get ndk => ndkFlutter.ndk;
  String? get expectedCoordinatorPubkey => _expectedCoordinatorPubkey;
  Account? get activeAccount => ndk.accounts.getLoggedAccount();
  List<Account> get accounts {
    final result = ndk.accounts.accounts.values.toList(growable: false);
    result.sort((a, b) => a.pubkey.compareTo(b.pubkey));
    return result;
  }

  EventSigner? get signer => activeAccount?.signer;
  BitblikRpcClient? get rpc => _rpc;
  List<String> get coordinatorRelays => List.unmodifiable(_coordinatorRelays);
  List<String> get dmRelayDiscoveryRelays =>
      List.unmodifiable({...kDiscoveryRelays, ..._coordinatorRelays});
  Stream<Nip17Message> get dmInboxEvents => _dmInboxEventController.stream;
  List<Nip17Message> get dmInboxSnapshot =>
      List.unmodifiable(_dmMessagesByRumorId.values);
  int get receivedDmWrapCount => _receivedDmWrapIds.length;
  int get acceptedDmWrapCount => _acceptedDmWrapCount;
  int get rejectedDmWrapCount => _rejectedDmWrapIds.length;
  String? get lastDmInboxRejection => _lastDmInboxRejection;
  String? get diagnosticLiveRumorId => _diagnosticLiveRumorId;
  Stream<LegacyNip04Message> get legacyInboxEvents =>
      _legacyInboxEventController.stream;
  List<LegacyNip04Message> get legacyInboxSnapshot =>
      List.unmodifiable(_legacyMessagesByEventId.values);
  bool get isAuthenticated =>
      _rpc != null &&
      activeAccount?.pubkey.toLowerCase() == _expectedCoordinatorPubkey &&
      activeAccount?.signer.canSign() == true;

  /// Adopts the account created by [NLogin]. Signer-specific login and account
  /// persistence stay in NDK Flutter. Its signing pubkey is the coordinator
  /// identity: there is no separately entered coordinator key to trust.
  Future<void> activateLoggedInAccount() async {
    final account = ndk.accounts.getLoggedAccount();
    if (account == null || !account.signer.canSign()) {
      throw StateError('The active NDK account cannot sign.');
    }
    await _activateLoggedAccount();
  }

  Future<void> restoreActiveCoordinator() async {
    final account = ndk.accounts.getLoggedAccount();
    if (account == null || !account.signer.canSign()) return;
    await _activateLoggedAccount();
  }

  /// Preloads kind-0 profiles on explicit relays. NDK Flutter's profile
  /// widgets otherwise have no relay to query because this console deliberately
  /// starts NDK without bootstrap relays until account restoration is complete.
  Future<void> refreshCoordinatorProfiles() async {
    final pubkeys = accounts.map((account) => account.pubkey).toList();
    if (pubkeys.isEmpty) return;
    try {
      final response = ndk.requests.query(
        name: 'console-coordinator-profiles',
        filter: Filter(kinds: [Metadata.kKind], authors: pubkeys),
        explicitRelays: {...kDiscoveryRelays, ..._coordinatorRelays}.toList(),
        cacheRead: false,
        cacheWrite: true,
        timeout: const Duration(seconds: 6),
      );
      await response.future;
    } catch (_) {
      // Profile metadata is cosmetic; cached/fallback npubs remain usable.
    } finally {
      notifyListeners();
    }
  }

  Future<void> prepareAddCoordinator() async {
    await _stopRpc();
    await _stopDmInboxListener();
    _expectedCoordinatorPubkey = null;
    _coordinatorRelays = const [];
    notifyListeners();
  }

  Future<void> switchCoordinator(String pubkey) async {
    await _stopRpc();
    ndk.accounts.switchAccount(pubkey: pubkey);
    await _activateLoggedAccount();
  }

  Future<void> _activateLoggedAccount() async {
    final account = ndk.accounts.getLoggedAccount();
    if (account == null || !account.signer.canSign()) {
      throw StateError('The active NDK account cannot sign.');
    }
    await _stopRpc();
    await _stopDmInboxListener();
    final coordinatorPubkey = account.pubkey.toLowerCase();
    _expectedCoordinatorPubkey = coordinatorPubkey;
    _coordinatorRelays = await _loadCoordinatorRelays(coordinatorPubkey);
    final relays = _coordinatorRelays.isEmpty
        ? kDiscoveryRelays
        : _coordinatorRelays;
    final rpc = BitblikRpcClient(
      ndk: ndk,
      signer: account.signer,
      relays: relays,
      timeout: const Duration(seconds: 12),
      subscriptionName: 'coordinator-console-rpc',
      clientId: 'coordinator-console/0.1.0',
    );
    await rpc.start();
    _rpc = rpc;
    _startLegacyInboxListener(account);
    await _startDmInboxListener(account, kDefaultDmInboxRelays);
    notifyListeners();
  }

  Future<void> _stopRpc() async {
    await _rpc?.stop();
    _rpc = null;
  }

  /// Keeps one logical authenticated kind-1059 inbox listener for the active
  /// coordinator, backed by an independent subscription per relay. Conversation
  /// widgets read the cached, decrypted lane after a stream reports a wrapper.
  Future<void> _startDmInboxListener(
    Account account,
    List<String> defaultRelays,
  ) async {
    if (defaultRelays.isEmpty) return;
    var configuredRelays = await _loadPublishedDmInboxRelays(account.pubkey);
    final replaceGeneratedList = isGeneratedCoordinatorDmRelayList(
      configuredRelays: configuredRelays,
      coordinatorRelays: _coordinatorRelays,
    );
    final needsNewRelayList = configuredRelays.isEmpty || replaceGeneratedList;
    if (needsNewRelayList) {
      final responses = await ndk.dms.publishDmRelays(
        relayUrlsOrdered: defaultRelays,
        broadcastRelays: {
          ...kDiscoveryRelays,
          ..._coordinatorRelays,
          ...defaultRelays,
        },
      );
      if (!responses.any((response) => response.broadcastSuccessful)) {
        throw StateError(
          'No relay accepted the coordinator NIP-17 relay list: '
          '${responses.map((response) => '${response.relayUrl}: ${response.msg}').join('; ')}',
        );
      }
      if (responses.any((response) => response.broadcastSuccessful)) {
        configuredRelays = List.of(defaultRelays);
      }
    } else {
      // NIP-65-aware clients such as Amethyst discover another user's DM
      // inbox list through that user's outbox relays. Preserve the operator's
      // existing kind-10050 verbatim, but replicate the same signed event to
      // every discovery/outbox/inbox relay so clients do not fall back to an
      // empty or stale local route.
      final existing = _publishedDmInboxEvent;
      if (existing != null) {
        final targets = {
          ...kDiscoveryRelays,
          ..._coordinatorRelays,
          ...configuredRelays,
        };
        try {
          await ndk.broadcast
              .broadcast(nostrEvent: existing, specificRelays: targets)
              .broadcastDoneFuture
              .timeout(const Duration(seconds: 8));
        } catch (_) {
          // The inbox listener still starts on every target below. A later
          // activation retries propagation without replacing the event.
        }
      }
    }

    // Amethyst and other clients cache kind-10050. Keep receiving on the
    // former BitBlik defaults as well as the operator's current list so a
    // cached sender cannot strand a valid gift wrap during list propagation.
    // Also cover the coordinator's NIP-65 relays: clients that have not loaded
    // kind-10050 yet use those as their recipient-relay fallback.
    final inboxRelays = coordinatorDmInboxSubscriptionRelays(
      configuredRelays: configuredRelays,
      observedHistoricalRelays: _observedDmInboxRelays,
      defaultRelays: defaultRelays,
      discoveryRelays: kDiscoveryRelays,
      coordinatorRelays: _coordinatorRelays,
    );
    _dmInboxRelays = List.unmodifiable(inboxRelays);
    // Finish history before opening the live streams. NDK deduplicates
    // identical filters, so overlapping a one-shot query with a subscription
    // can let the query's EOSE close the stream intended to remain live.
    await _pollDmInbox(account);
    // Keep every relay in an independent request so authentication, CLOSED,
    // EOSE, or connection lifecycle on one relay cannot terminate another.
    for (final relay in inboxRelays) {
      final subscription = ndk.requests.subscription(
        name: 'coordinator-console-dm-inbox',
        explicitRelays: [relay],
        // NIP-17 inbox relays may protect kind-1059 delivery with NIP-42 and
        // serve wrappers only to their p-tagged recipient. Match NDK's regular
        // DM loader by authenticating this live subscription as coordinator.
        authenticateAs: [account],
        cacheRead: false,
        cacheWrite: true,
        filter: Filter(
          kinds: [GiftWrap.kGiftWrapEventkind],
          pTags: [account.pubkey],
          since:
              Nip01Event.secondsSinceEpoch() -
              const Duration(days: 3).inSeconds,
          limit: 200,
        ),
      );
      _dmInboxSubscriptions[relay] = subscription;
      _dmInboxEvents[relay] = subscription.stream.listen((wrappedEvent) {
        // A request subscription caches the encrypted kind-1059 wrapper but
        // does not decrypt it. Conversation snapshots deliberately use only
        // cached plaintext sidecars, so decrypt before notifying lanes.
        unawaited(_cacheAndForwardDmInboxEvent(wrappedEvent, account.pubkey));
      }, onError: _dmInboxEventController.addError);
    }
  }

  Future<List<String>> _loadPublishedDmInboxRelays(String pubkey) async {
    _publishedDmInboxEvent = null;
    final account = activeAccount;
    final canAuthenticate =
        account?.pubkey.toLowerCase() == pubkey.toLowerCase();
    final publicRelays = {
      ...kDiscoveryRelays,
      ..._coordinatorRelays,
    }.map(normalizeRelayUrl).toSet();
    final historicalRelays = {
      ..._formerGeneratedDmInboxRelays,
      ..._amethystCompatibilityDmInboxRelays,
    }.map(normalizeRelayUrl).where((relay) => !publicRelays.contains(relay));
    final filter = Filter(
      kinds: const [Nip51List.kDmRelays],
      authors: [pubkey],
      limit: 1,
    );

    Future<List<Nip01Event>> queryRelaySet(
      Iterable<String> relays, {
      required bool authenticate,
    }) async {
      if (relays.isEmpty) return const [];
      try {
        return await ndk.requests
            .query(
              name: 'coordinator-console-dm-relay-list',
              explicitRelays: relays,
              authenticateAs: authenticate && canAuthenticate
                  ? [account!]
                  : null,
              cacheRead: false,
              cacheWrite: true,
              timeout: const Duration(seconds: 6),
              filter: filter,
            )
            .future;
      } catch (_) {
        return const [];
      }
    }

    // Keep authenticated historical inboxes in separate requests. A fast EOSE
    // from a public relay must not close the request before the NIP-42 relay
    // finishes its challenge and returns its older replaceable event.
    final results = await Future.wait([
      queryRelaySet(publicRelays, authenticate: false),
      for (final relay in historicalRelays)
        queryRelaySet([relay], authenticate: true),
    ]);
    final events = results.expand((events) => events).toList();
    if (events.isEmpty) return const [];
    for (final event in events) {
      _observedDmInboxRelays.addAll(
        event.tags
            .where((tag) => tag.length >= 2 && tag.first == Nip51List.kRelay)
            .map((tag) => normalizeRelayUrl(tag[1]))
            .where((relay) => relay.isNotEmpty),
      );
    }
    events.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _publishedDmInboxEvent = events.first;
    return events.first.tags
        .where((tag) => tag.length >= 2 && tag.first == Nip51List.kRelay)
        .map((tag) => normalizeRelayUrl(tag[1]))
        .where((relay) => relay.isNotEmpty)
        .toSet()
        .toList(growable: false);
  }

  Future<void> _pollDmInbox(Account account) async {
    if (_closed ||
        _dmInboxPollInFlight ||
        _dmInboxRelays.isEmpty ||
        activeAccount?.pubkey != account.pubkey) {
      return;
    }
    _dmInboxPollInFlight = true;
    try {
      await Future.wait(
        _dmInboxRelays.map((relay) async {
          final response = ndk.requests.query(
            name: 'coordinator-console-dm-inbox-catchup',
            explicitRelays: [relay],
            authenticateAs: [account],
            cacheRead: false,
            cacheWrite: true,
            timeout: const Duration(seconds: 8),
            filter: Filter(
              kinds: const [GiftWrap.kGiftWrapEventkind],
              pTags: [account.pubkey],
              since:
                  Nip01Event.secondsSinceEpoch() -
                  const Duration(days: 3).inSeconds,
              limit: 500,
            ),
          );
          await for (final wrappedEvent in response.stream) {
            await _cacheAndForwardDmInboxEvent(wrappedEvent, account.pubkey);
          }
        }),
      );
    } catch (error, stackTrace) {
      if (!_closed && activeAccount?.pubkey == account.pubkey) {
        _dmInboxEventController.addError(error, stackTrace);
      }
    } finally {
      _dmInboxPollInFlight = false;
      if (!_dmInboxReadyReported &&
          !_closed &&
          activeAccount?.pubkey == account.pubkey) {
        _dmInboxReadyReported = true;
        debugPrint(
          '[DisputeChat] NIP-17 inbox catch-up complete: '
          'received=${_receivedDmWrapIds.length}, '
          'accepted=$_acceptedDmWrapCount, '
          'rejected=${_rejectedDmWrapIds.length}',
        );
      }
    }
  }

  void _startLegacyInboxListener(Account account) {
    ensureLegacyInboxRelays(dmRelayDiscoveryRelays);
  }

  /// Resolves a participant's NIP-65 relay list on the console's explicit
  /// discovery/rendezvous set. The console intentionally has no bootstrap
  /// relays, so a generic NDK lookup can otherwise have nowhere to query.
  Future<Set<String>> loadUserRelayUrls(String pubkey) async {
    final response = ndk.requests.query(
      name: 'console-participant-relays',
      explicitRelays: dmRelayDiscoveryRelays,
      cacheRead: true,
      cacheWrite: true,
      timeout: const Duration(seconds: 5),
      filter: Filter(kinds: [kKindRelayList], authors: [pubkey], limit: 1),
    );
    final events = await response.future;
    if (events.isEmpty) return <String>{};
    events.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return events.first.tags
        .where((tag) => tag.length >= 2 && tag.first == 'r')
        .map((tag) => normalizeRelayUrl(tag[1]))
        .where((relay) => relay.isNotEmpty)
        .toSet();
  }

  /// Expands the live kind-4 inbox onto participant NIP-65 relays as lanes
  /// discover them. One subscription per relay keeps additions idempotent and
  /// lets account switching close every exact request cleanly.
  void ensureLegacyInboxRelays(Iterable<String> relays) {
    final account = activeAccount;
    if (account == null || !account.signer.canSign()) return;
    for (final rawRelay in relays) {
      final relay = normalizeRelayUrl(rawRelay);
      if (relay.isEmpty || _legacyInboxSubscriptions.containsKey(relay)) {
        continue;
      }
      final subscription = ndk.requests.subscription(
        name: 'coordinator-console-legacy-dm-inbox',
        explicitRelays: [relay],
        cacheRead: false,
        cacheWrite: true,
        authenticateAs: [account],
        filter: Filter(
          kinds: const [Dms.kLegacyNip04MessageKind],
          pTags: [account.pubkey],
          since:
              Nip01Event.secondsSinceEpoch() -
              const Duration(days: 3).inSeconds,
          limit: 200,
        ),
      );
      _legacyInboxSubscriptions[relay] = subscription;
      _legacyInboxEvents[relay] = subscription.stream.listen(
        (event) =>
            unawaited(_cacheAndForwardLegacyInboxEvent(event, account.pubkey)),
        onError: _legacyInboxEventController.addError,
      );
    }
  }

  Future<void> _cacheAndForwardLegacyInboxEvent(
    Nip01Event event,
    String accountPubkey,
  ) async {
    try {
      if (_closed || activeAccount?.pubkey != accountPubkey) return;
      final message = await DisputeCommunicationService(
        ndk: ndk,
      ).parseLegacyNip04Event(event);
      if (message == null) return;
      if (_closed || activeAccount?.pubkey != accountPubkey) return;
      if (_legacyMessagesByEventId.containsKey(message.id)) return;
      _legacyMessagesByEventId[message.id] = message;
      _legacyInboxEventController.add(message);
    } catch (error, stackTrace) {
      if (!_closed && activeAccount?.pubkey == accountPubkey) {
        _legacyInboxEventController.addError(error, stackTrace);
      }
    }
  }

  Future<void> _cacheAndForwardDmInboxEvent(
    Nip01Event wrappedEvent,
    String accountPubkey,
  ) async {
    try {
      // Ignore a queued callback from an account that was switched away while
      // its subscription was being cancelled.
      if (_closed || activeAccount?.pubkey != accountPubkey) return;
      final firstObservation = _receivedDmWrapIds.add(wrappedEvent.id);
      final reportLiveReceipt =
          _dmInboxReadyReported && firstObservation && !_liveDmReceiptReported;
      if (reportLiveReceipt) {
        _liveDmReceiptReported = true;
      }
      final parsed = await DisputeCommunicationService(
        ndk: ndk,
      ).parseNip17MessageWithDiagnostics(wrappedEvent);
      final message = parsed.message;
      if (message == null) {
        final reason = parsed.rejectionReason ?? 'unknown rejection';
        _lastDmInboxRejection = reason;
        _rejectedDmWrapIds.add(wrappedEvent.id);
        if (_reportedDmRejectionReasons.add(reason)) {
          debugPrint(
            '[DisputeChat] NIP-17 wrap rejected: $reason '
            '(example ${wrappedEvent.id})',
          );
        }
        return;
      }
      if (_closed || activeAccount?.pubkey != accountPubkey) {
        return;
      }
      if (reportLiveReceipt) {
        _diagnosticLiveRumorId = message.id;
        debugPrint(
          '[DisputeChat] NIP-17 live wrapper decrypted: '
          'event=${wrappedEvent.id}, rumor=${message.id}, '
          'peer=${message.peerPubKey}, outgoing=${message.isOutgoing}',
        );
      }
      if (_dmMessagesByRumorId.containsKey(message.id)) return;
      _dmMessagesByRumorId[message.id] = message;
      _acceptedDmWrapCount++;
      _dmInboxEventController.add(message);
    } catch (error, stackTrace) {
      if (!_closed && activeAccount?.pubkey == accountPubkey) {
        _dmInboxEventController.addError(error, stackTrace);
      }
    }
  }

  Future<void> _stopDmInboxListener() async {
    _dmInboxRelays = const [];
    _observedDmInboxRelays.clear();
    _dmInboxReadyReported = false;
    _liveDmReceiptReported = false;
    _receivedDmWrapIds.clear();
    _rejectedDmWrapIds.clear();
    _reportedDmRejectionReasons.clear();
    _acceptedDmWrapCount = 0;
    _lastDmInboxRejection = null;
    _diagnosticLiveRumorId = null;
    await Future.wait(_dmInboxEvents.values.map((events) => events.cancel()));
    _dmInboxEvents.clear();
    _dmMessagesByRumorId.clear();
    await Future.wait(
      _legacyInboxEvents.values.map((events) => events.cancel()),
    );
    _legacyInboxEvents.clear();
    _legacyMessagesByEventId.clear();
    final subscriptions = _dmInboxSubscriptions.values.toList();
    _dmInboxSubscriptions.clear();
    for (final subscription in subscriptions) {
      await ndk.requests.closeSubscription(
        subscription.requestId,
        debugLabel: 'coordinator console DM inbox',
      );
    }
    final legacySubscriptions = _legacyInboxSubscriptions.values.toList();
    _legacyInboxSubscriptions.clear();
    for (final legacySubscription in legacySubscriptions) {
      await ndk.requests.closeSubscription(
        legacySubscription.requestId,
        debugLabel: 'coordinator console legacy DM inbox',
      );
    }
  }

  Future<List<String>> _loadCoordinatorRelays(String pubkey) async {
    final injected = relayLoader;
    if (injected != null) return injected(pubkey);
    final response = ndk.requests.query(
      name: 'console-coordinator-relays',
      filter: Filter(kinds: [kKindRelayList], authors: [pubkey], limit: 1),
      explicitRelays: kDiscoveryRelays,
      cacheRead: false,
      timeout: const Duration(seconds: 6),
    );
    final events = await response.future;
    if (events.isEmpty) return List.of(kDiscoveryRelays);
    events.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return events.first.tags
        .where((tag) => tag.length >= 2 && tag.first == 'r')
        .map((tag) => normalizeRelayUrl(tag[1]))
        .where((url) => url.isNotEmpty)
        .toSet()
        .toList(growable: false);
  }

  Future<void> _saveAccountsState() =>
      accountStateSaver?.call() ?? ndkFlutter.saveAccountsState();

  /// Called after [NSwitchAccount] removes an inactive account. NDK Flutter
  /// owns the collection mutation/persistence; the console disposes its signer.
  Future<void> accountRemoved(Account account) async {
    if (account.pubkey == _expectedCoordinatorPubkey) {
      await _stopRpc();
      await _stopDmInboxListener();
    }
    await account.dispose();
    notifyListeners();
  }

  Future<void> logout() async {
    await _stopRpc();
    await _stopDmInboxListener();
    final account = ndk.accounts.getLoggedAccount();
    if (account != null) {
      ndk.accounts.removeAccount(pubkey: account.pubkey);
      await account.dispose();
      await _saveAccountsState();
    }
    notifyListeners();
  }

  /// Stops every coordinator-owned network operation before the NDK instance
  /// backing this session is destroyed.
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await _stopRpc();
    await _stopDmInboxListener();
    await _dmInboxEventController.close();
    await _legacyInboxEventController.close();
  }
}
