import 'dart:async';

import 'package:bip340/bip340.dart' as bip340;
import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/domain_layer/entities/cashu/cashu_user_seedphrase.dart';

import 'coordinator_file_store.dart';
import 'secrets_store.dart';


class BitblikProtocolClient {
  /// Discovery relays — used only to find coordinators and bootstrap NDK.
  /// Per-coordinator communication is routed to each coordinator's own relays.
  static const List<String> defaultRelays = kDiscoveryRelays;

  final List<String> relays;
  final Duration timeout;
  final BitblikSecrets secrets;
  final CoordinatorStore coordinatorStore;

  late final Ndk _ndk;
  late final Bip340EventSigner _signer;
  late final BitblikRpcClient _rpc;
  late final CoordinatorRegistry _registry;

  BitblikProtocolClient({
    required this.secrets,
    List<String>? relays,
    this.timeout = const Duration(seconds: 5),
    CoordinatorStore? coordinatorStore,
  })  : relays = relays == null || relays.isEmpty ? defaultRelays : relays,
        coordinatorStore = coordinatorStore ?? CoordinatorFileStore();

  Future<void> init() async {
    _ndk = Ndk(
      NdkConfig(
        cache: MemCacheManager(),
        eventVerifier: RustEventVerifier(),
        bootstrapRelays: relays,
        cashuUserSeedphrase:
            CashuUserSeedphrase(seedPhrase: secrets.cashuSeedPhrase),
        logLevel: LogLevel.warning,
      ),
    );

    final privateKey = secrets.privateKeyHex;
    _signer = Bip340EventSigner(
      privateKey: privateKey,
      publicKey: bip340.getPublicKey(privateKey),
    );

    _rpc = BitblikRpcClient(
      ndk: _ndk,
      signer: _signer,
      relays: relays,
      timeout: timeout,
      subscriptionName: 'cli-client-responses',
    );
    await _rpc.start();

    _registry = CoordinatorRegistry(
      ndk: _ndk,
      rpcClient: _rpc,
      store: coordinatorStore,
      relays: relays,
    );
    await _registry.init();
  }

  CoordinatorRegistry get coordinatorRegistry => _registry;

  /// Relays of all enabled coordinators (NIP-65 / fallback), falling back to
  /// discovery relays when none are known yet.
  List<String> _enabledRelays() {
    final r = _registry.relaysForEnabled().toList();
    return r.isEmpty ? relays : r;
  }

  Future<List<CoordinatorRecord>> discoverCoordinators() async {
    await _registry.discover();
    await _rpc.updateResponseRelays(_registry.relaysForEnabled());
    return _registry.all;
  }

  Future<void> checkCoordinatorHealth(
      List<CoordinatorRecord> coordinators) async {
    await Future.wait(
      coordinators.map((c) => _registry.probeHealth(c.pubkeyHex)),
    );
    await _rpc.updateResponseRelays(_registry.relaysForEnabled());
    await _registry.flushPersist();
  }

  /// Send any [NostrRequest] to [coordinatorPubkey] and await its response.
  /// Thin wrapper around [BitblikRpcClient.send] for CLI command modules.
  /// Routes to the coordinator's own relays (NIP-65 / fallback).
  Future<NostrResponse> sendRequest(
    NostrRequest request,
    String coordinatorPubkey,
  ) =>
      _rpc.send(
        request,
        coordinatorPubkey,
        relays: _registry.relaysFor(coordinatorPubkey),
      );

  /// Query live public offers (kind 38383 NIP-69-ish events).
  ///
  /// Returns the latest event per offer id (`d` tag), deduplicating across
  /// coordinator re-broadcasts. Optional filters narrow the result.
  Future<List<Offer>> listOffers({
    String fiatCurrency = 'PLN',
    String platform = 'Bitblik',
    String? coordinatorPubkey,
    Duration window = const Duration(hours: 2),
  }) async {
    final filter = Filter(
      kinds: [kKindOffer],
      tags: {
        '#f': [fiatCurrency],
        '#y': [platform],
      },
      authors: coordinatorPubkey == null ? null : [coordinatorPubkey],
      since:
          DateTime.now().subtract(window).millisecondsSinceEpoch ~/ 1000,
    );

    final response = _ndk.requests.query(
      name: 'cli-offer-list',
      filter: filter,
      explicitRelays: coordinatorPubkey == null
          ? _enabledRelays()
          : _registry.relaysFor(coordinatorPubkey),
    );

    final latestById = <String, Nip01Event>{};
    await for (final event in response.stream) {
      final id = _offerId(event);
      final current = latestById[id];
      if (current == null || event.createdAt > current.createdAt) {
        latestById[id] = event;
      }
    }

    return latestById.values.map(Offer.fromNostrEvent).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static String _offerId(Nip01Event event) {
    for (final tag in event.tags) {
      if (tag.length >= 2 && tag[0] == 'd') return tag[1];
    }
    return event.id;
  }

  String get pubkeyHex => _signer.getPublicKey();

  /// Subscribe to kind [kKindOfferStatusUpdate] events sent to this client.
  ///
  /// Decrypts each event and emits parsed [OfferStatusUpdate]s. Optionally
  /// filters by [paymentHash]. Malformed/undecryptable events are silently
  /// skipped. The returned stream stays open until [dispose] is called or the
  /// subscriber cancels; there is no separate close handle.
  Stream<OfferStatusUpdate> watchOfferStatus({String? paymentHash}) {
    final filter = Filter(
      kinds: [kKindOfferStatusUpdate],
      pTags: [_signer.getPublicKey()],
      since: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
    final sub = _ndk.requests.subscription(
      name: 'cli-status-${DateTime.now().millisecondsSinceEpoch}',
      filter: filter,
      explicitRelays: _enabledRelays(),
    );

    final controller = StreamController<OfferStatusUpdate>();
    sub.stream.listen(
      (event) async {
        try {
          final payload = await ProtocolCodec.decryptStatusUpdate(
            event,
            secrets.privateKeyHex,
          );
          final update = OfferStatusUpdate.fromJson(payload, event.pubKey);
          if (paymentHash == null || update.paymentHash == paymentHash) {
            controller.add(update);
          }
        } catch (_) {
          // Skip undecryptable / foreign events.
        }
      },
      onDone: controller.close,
      onError: (Object e, StackTrace s) => controller.addError(e, s),
    );

    return controller.stream;
  }

  Future<void> dispose() async {
    await _registry.dispose();
    await _rpc.stop();
    await _ndk.destroy();
  }
}
