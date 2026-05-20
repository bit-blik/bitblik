import 'dart:async';

import 'package:bip340/bip340.dart' as bip340;
import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/domain_layer/entities/cashu/cashu_user_seedphrase.dart';

import 'models.dart';
import 'secrets_store.dart';

class BitblikProtocolClient {
  static const List<String> defaultRelays = [
    'wss://relay.mostro.network',
    'wss://relay.primal.net',
  ];

  final List<String> relays;
  final Duration timeout;
  final BitblikSecrets secrets;

  late final Ndk _ndk;
  late final Bip340EventSigner _signer;
  late final BitblikRpcClient _rpc;

  BitblikProtocolClient({
    required this.secrets,
    List<String>? relays,
    this.timeout = const Duration(seconds: 5),
  }) : relays = relays == null || relays.isEmpty ? defaultRelays : relays;

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
  }

  Future<List<CoordinatorListItem>> discoverCoordinators() async {
    final filter = Filter(kinds: [kKindCoordinatorInfo]);
    final response = _ndk.requests.query(
      name: 'cli-coordinator-discovery',
      filter: filter,
      explicitRelays: relays,
    );

    final byPubkey = <String, CoordinatorListItem>{};

    await for (final event in response.stream) {
      final record = _fromEvent(event);
      final current = byPubkey[record.pubkeyHex];
      if (current == null || current.lastSeen.isBefore(record.lastSeen)) {
        byPubkey[record.pubkeyHex] = record;
      }
    }

    final values = byPubkey.values.toList();
    values.sort((a, b) => a.info.name.compareTo(b.info.name));
    return values;
  }

  Future<void> checkCoordinatorHealth(
      List<CoordinatorListItem> coordinators) async {
    await Future.wait(coordinators.map((c) async {
      c.responsive = await _probeCoordinator(c.pubkeyHex);
    }));
  }

  /// Send any [NostrRequest] to [coordinatorPubkey] and await its response.
  /// Thin wrapper around [BitblikRpcClient.send] for CLI command modules.
  Future<NostrResponse> sendRequest(
    NostrRequest request,
    String coordinatorPubkey,
  ) =>
      _rpc.send(request, coordinatorPubkey);

  Future<void> dispose() async {
    await _rpc.stop();
    await _ndk.destroy();
  }

  CoordinatorListItem _fromEvent(Nip01Event event) {
    return CoordinatorListItem(
      pubkeyHex: event.pubKey,
      info: CoordinatorInfo.fromNostrEvent(event),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(event.createdAt * 1000),
      responsive: null,
    );
  }

  Future<bool> _probeCoordinator(String coordinatorPubkey) async {
    try {
      await _rpc.send(
        const NostrRequest(method: kRpcGetInfo, params: {}),
        coordinatorPubkey,
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}
