import 'dart:async';
import 'dart:io' show Platform;

import 'package:bip340/bip340.dart' as bip340;
import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/domain_layer/entities/cashu/cashu_user_seedphrase.dart';

import 'cli_context.dart';
import 'coordinator_file_store.dart';
import 'secrets_store.dart';

/// CLI version, stamped onto every RPC request so the coordinator knows which
/// client build issued it. Keep in sync with `version:` in cli/pubspec.yaml.
const String kCliVersion = '0.1.0';

class BitblikProtocolClient {
  /// Discovery relays — used only to find coordinators and bootstrap NDK.
  /// Per-coordinator communication is routed to each coordinator's own relays.
  static const List<String> defaultRelays = kDiscoveryRelays;

  final List<String> relays;
  final Duration timeout;
  final BitblikSecrets secrets;
  final CoordinatorStore coordinatorStore;

  /// The market this client operates in. Drives discovery (which project
  /// identity's NIP-65 yields the discovery relays + coordinator set) and the
  /// default offer-listing filter (currency + platform tag), so a client only
  /// ever sees coordinators and offers belonging to its own payment system.
  final PaymentSystem paymentSystem;

  late final Ndk _ndk;
  late final Bip340EventSigner _signer;
  late final BitblikRpcClient _rpc;
  late final CoordinatorRegistry _registry;

  BitblikProtocolClient({
    required this.secrets,
    List<String>? relays,
    this.timeout = const Duration(seconds: 5),
    CoordinatorStore? coordinatorStore,
    PaymentSystem? paymentSystem,
  })  : relays = relays == null || relays.isEmpty ? defaultRelays : relays,
        paymentSystem = paymentSystem ?? activePaymentSystem,
        coordinatorStore = coordinatorStore ??
            CoordinatorFileStore(
                paymentSystem: paymentSystem ?? activePaymentSystem);

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

    final brand = paymentSystem.brandName.toLowerCase();
    _rpc = BitblikRpcClient(
      ndk: _ndk,
      signer: _signer,
      relays: relays,
      timeout: timeout,
      subscriptionName: 'cli-client-responses',
      clientId: 'cli-$brand-${_platformSlug()}/$kCliVersion',
    );
    await _rpc.start();

    _registry = CoordinatorRegistry(
      ndk: _ndk,
      rpcClient: _rpc,
      store: coordinatorStore,
      relays: relays,
      // Discover this market's relays + coordinators from its own project
      // identity (Bitblik for BLIK, Bitway for MB WAY).
      discoveryPubkeyHex: paymentSystem.discoveryPubkeyHex,
    );
    await _registry.init();
  }

  CoordinatorRegistry get coordinatorRegistry => _registry;

  /// The payment system id a coordinator advertises in its kind
  /// [kKindCoordinatorInfo] event, or null when no info event can be fetched.
  ///
  /// Prefers the registry's cached info; otherwise queries the coordinator's
  /// own relays (NIP-65 / discovery fallback) for its info event. Used to
  /// refuse cross-market interactions (e.g. a `bitway` client talking to a BLIK
  /// coordinator).
  Future<String?> coordinatorPaymentSystemId(String coordinatorPubkey) async {
    final cached = _registry.infoFor(coordinatorPubkey)?.paymentSystem;
    if (cached != null) return cached;

    final response = _ndk.requests.query(
      name: 'coordinator-info-check',
      filter: Filter(
        kinds: [kKindCoordinatorInfo],
        authors: [coordinatorPubkey],
      ),
      explicitRelays: _registry.relaysFor(coordinatorPubkey),
      cacheRead: false,
    );
    Nip01Event? newest;
    await for (final e in response.stream.timeout(
      timeout + kRelayRequestGrace,
      onTimeout: (sink) => sink.close(),
    )) {
      if (e.pubKey != coordinatorPubkey) continue;
      if (newest == null || e.createdAt > newest.createdAt) newest = e;
    }
    if (newest == null) return null;
    return CoordinatorInfo.fromNostrEvent(newest).paymentSystem;
  }

  /// Relays of all enabled coordinators (NIP-65 / fallback), falling back to
  /// discovery relays when none are known yet.
  List<String> _enabledRelays() {
    final r = _registry.relaysForEnabled().toList();
    return r.isEmpty ? relays : r;
  }

  Future<List<CoordinatorRecord>> discoverCoordinators() async {
    final effectiveTimeout = timeout + kRelayRequestGrace;
    await _registry.discover().timeout(
          effectiveTimeout,
          onTimeout: () => throw TimeoutException(
            'Coordinator discovery timed out',
            effectiveTimeout,
          ),
        );
    await _rpc.updateResponseRelays(_registry.relaysForEnabled());
    return _registry.all;
  }

  Future<void> checkCoordinatorHealth(
      List<CoordinatorRecord> coordinators) async {
    await Future.wait(
      coordinators.map(
        (c) => _registry.probeHealth(
          c.pubkeyHex,
          timeoutOverride: timeout,
        ),
      ),
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
  ) {
    final effectiveTimeout = timeout + kRelayRequestGrace;
    return _rpc
        .send(
          request,
          coordinatorPubkey,
          relays: _registry.relaysFor(coordinatorPubkey),
        )
        .timeout(
          effectiveTimeout,
          onTimeout: () => throw TimeoutException(
            'Relay request timed out',
            effectiveTimeout,
          ),
        );
  }

  /// Query live public offers (kind 38383 NIP-69-ish events).
  ///
  /// Returns the latest event per offer id (`d` tag), deduplicating across
  /// coordinator re-broadcasts. Optional filters narrow the result.
  /// Query live public offers. [fiatCurrency] and [platform] default to the
  /// client's [paymentSystem] (currency + platform tag), so a market only lists
  /// offers belonging to its own payment system.
  Future<List<Offer>> listOffers({
    String? fiatCurrency,
    String? platform,
    String? coordinatorPubkey,
    Duration window = const Duration(hours: 2),
  }) async {
    final filter = Filter(
      kinds: [kKindOffer],
      tags: {
        '#f': [fiatCurrency ?? paymentSystem.currency],
        '#y': [platform ?? paymentSystem.platformTag],
      },
      authors: coordinatorPubkey == null ? null : [coordinatorPubkey],
      since: DateTime.now().subtract(window).millisecondsSinceEpoch ~/ 1000,
    );

    final response = _ndk.requests.query(
      name: 'cli-offer-list',
      filter: filter,
      explicitRelays: coordinatorPubkey == null
          ? _enabledRelays()
          : _registry.relaysFor(coordinatorPubkey),
    );

    final latestById = <String, Nip01Event>{};
    await for (final event in response.stream.timeout(
      timeout + kRelayRequestGrace,
      onTimeout: (sink) => sink.close(),
    )) {
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
    // Persist any pending coordinator changes before tearing down: the binary
    // forces process exit right after dispose, so the registry's 200ms
    // debounced save would otherwise be dropped.
    await _registry.flushPersist();
    await _registry.dispose();
    await _rpc.stop();
    await _ndk.destroy();
  }
}

String _platformSlug() {
  if (Platform.isLinux) return 'linux';
  if (Platform.isMacOS) return 'macos';
  if (Platform.isWindows) return 'windows';
  if (Platform.isAndroid) return 'android';
  if (Platform.isIOS) return 'ios';
  if (Platform.isFuchsia) return 'fuchsia';
  return 'unknown';
}
