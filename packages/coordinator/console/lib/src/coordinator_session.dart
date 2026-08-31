import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

class CoordinatorSession extends ChangeNotifier {
  final NdkFlutter ndkFlutter;
  final Future<List<String>> Function(String pubkey)? relayLoader;
  final Future<void> Function()? accountStateSaver;

  String? _expectedCoordinatorPubkey;
  BitblikRpcClient? _rpc;
  List<String> _coordinatorRelays = const [];
  NdkResponse? _dmInboxSubscription;
  StreamSubscription<Nip01Event>? _dmInboxEvents;
  final _dmInboxEventController = StreamController<Nip17Message>.broadcast();
  final Map<String, Nip17Message> _dmMessagesByRumorId = {};
  final Map<String, NdkResponse> _legacyInboxSubscriptions = {};
  final Map<String, StreamSubscription<Nip01Event>> _legacyInboxEvents = {};
  final _legacyInboxEventController =
      StreamController<LegacyNip04Message>.broadcast();
  final Map<String, LegacyNip04Message> _legacyMessagesByEventId = {};

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
    await _startDmInboxListener(account, kDiscoveryRelays);
    notifyListeners();
  }

  Future<void> _stopRpc() async {
    await _rpc?.stop();
    _rpc = null;
  }

  /// Keeps exactly one authenticated kind-1059 inbox subscription for the
  /// active coordinator. Conversation widgets read the cached, decrypted lane
  /// after this stream reports a new wrapper.
  Future<void> _startDmInboxListener(
    Account account,
    List<String> relays,
  ) async {
    if (relays.isEmpty) return;
    final responses = await ndk.dms.publishDmRelays(
      relayUrlsOrdered: relays,
      broadcastRelays: {...kDiscoveryRelays, ...relays},
    );
    if (!responses.any((response) => response.broadcastSuccessful)) {
      throw StateError(
        'No relay accepted the coordinator NIP-17 relay list: '
        '${responses.map((response) => '${response.relayUrl}: ${response.msg}').join('; ')}',
      );
    }

    List<String>? inboxRelays;
    for (var attempt = 0; attempt < 3; attempt++) {
      inboxRelays = await ndk.userRelayLists.getDmRelays(
        account.pubkey,
        forceRefresh: true,
        discoveryRelays: kDiscoveryRelays,
      );
      if (inboxRelays != null && inboxRelays.isNotEmpty) break;
      await Future<void>.delayed(const Duration(milliseconds: 400));
    }
    if (inboxRelays == null || inboxRelays.isEmpty) {
      throw StateError(
        'The coordinator NIP-17 relay list was published but could not be read back.',
      );
    }
    final subscription = ndk.requests.subscription(
      name: 'coordinator-console-dm-inbox',
      explicitRelays: inboxRelays,
      cacheRead: false,
      cacheWrite: true,
      filter: Filter(
        kinds: [GiftWrap.kGiftWrapEventkind],
        pTags: [account.pubkey],
        since:
            Nip01Event.secondsSinceEpoch() - const Duration(days: 3).inSeconds,
        limit: 200,
      ),
    );
    _dmInboxSubscription = subscription;
    _dmInboxEvents = subscription.stream.listen((wrappedEvent) {
      // A request subscription caches the encrypted kind-1059 wrapper but
      // does not decrypt it. Conversation snapshots deliberately use only
      // cached plaintext sidecars, so decrypt before notifying lanes; this
      // makes a live participant message visible without re-querying every
      // relay or redrawing the other lane.
      unawaited(_cacheAndForwardDmInboxEvent(wrappedEvent, account.pubkey));
    }, onError: _dmInboxEventController.addError);
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
      if (activeAccount?.pubkey != accountPubkey) return;
      final message = await DisputeCommunicationService(
        ndk: ndk,
      ).parseLegacyNip04Event(event);
      if (message == null) return;
      if (activeAccount?.pubkey != accountPubkey) return;
      if (_legacyMessagesByEventId.containsKey(message.id)) return;
      _legacyMessagesByEventId[message.id] = message;
      _legacyInboxEventController.add(message);
    } catch (error, stackTrace) {
      if (activeAccount?.pubkey == accountPubkey) {
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
      if (activeAccount?.pubkey != accountPubkey) return;
      final message = await DisputeCommunicationService(
        ndk: ndk,
      ).parseNip17Message(wrappedEvent);
      if (message == null || activeAccount?.pubkey != accountPubkey) return;
      if (_dmMessagesByRumorId.containsKey(message.id)) return;
      _dmMessagesByRumorId[message.id] = message;
      _dmInboxEventController.add(message);
    } catch (error, stackTrace) {
      if (activeAccount?.pubkey == accountPubkey) {
        _dmInboxEventController.addError(error, stackTrace);
      }
    }
  }

  Future<void> _stopDmInboxListener() async {
    await _dmInboxEvents?.cancel();
    _dmInboxEvents = null;
    _dmMessagesByRumorId.clear();
    await Future.wait(
      _legacyInboxEvents.values.map((events) => events.cancel()),
    );
    _legacyInboxEvents.clear();
    _legacyMessagesByEventId.clear();
    final subscription = _dmInboxSubscription;
    _dmInboxSubscription = null;
    if (subscription != null) {
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
}
