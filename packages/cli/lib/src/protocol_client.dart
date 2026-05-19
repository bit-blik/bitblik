import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bip340/bip340.dart' as bip340;
import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/domain_layer/entities/cashu/cashu_user_seedphrase.dart';
import 'package:ndk/shared/nips/nip44/nip44.dart';

import 'models.dart';

class BitblikProtocolClient {
  static const int kindCoordinatorInfo = 15125;
  static const int kindCoordinatorRequest = 25195;
  static const int kindCoordinatorResponse = 25196;

  static const List<String> defaultRelays = [
    'wss://relay.mostro.network',
    'wss://relay.primal.net',
  ];

  final List<String> relays;
  final Duration timeout;

  late final Ndk _ndk;
  late final Bip340EventSigner _signer;
  NdkResponse? _responseSubscription;
  final Map<String, Completer<void>> _pendingHealthChecks = {};
  final Random _random = Random();

  BitblikProtocolClient({
    List<String>? relays,
    this.timeout = const Duration(seconds: 5),
  }) : relays = relays == null || relays.isEmpty ? defaultRelays : relays;

  Future<void> init() async {
    final cashuSeedPhrase = CashuSeed.generateSeedPhrase();
    _ndk = Ndk(
      NdkConfig(
        cache: MemCacheManager(),
        eventVerifier: RustEventVerifier(),
        bootstrapRelays: relays,
        cashuUserSeedphrase: CashuUserSeedphrase(seedPhrase: cashuSeedPhrase),
        logLevel: LogLevel.warning,
      ),
    );

    final privateKey = _generatePrivateKeyHex();
    _signer = Bip340EventSigner(
      privateKey: privateKey,
      publicKey: bip340.getPublicKey(privateKey),
    );

    final responseFilter = Filter(
      kinds: [kindCoordinatorResponse],
      pTags: [_signer.getPublicKey()],
      since: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );

    _responseSubscription = _ndk.requests.subscription(
      name: 'cli-client-responses',
      filter: responseFilter,
      explicitRelays: relays,
    );

    _responseSubscription!.stream.listen(_handleResponseEvent);
  }

  Future<List<CoordinatorListItem>> discoverCoordinators() async {
    final filter = Filter(kinds: [kindCoordinatorInfo]);
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

  Future<void> dispose() async {
    if (_responseSubscription != null) {
      await _ndk.requests.closeSubscription(_responseSubscription!.requestId);
      _responseSubscription = null;
    }
    await _ndk.destroy();
  }

  CoordinatorListItem _fromEvent(Nip01Event event) {
    final tags = Map<String, String>.fromEntries(
      event.tags
          .where((tag) => tag.length >= 2)
          .map((tag) => MapEntry(tag[0], tag[1])),
    );

    return CoordinatorListItem(
      pubkeyHex: event.pubKey,
      info: CoordinatorInfo(
        name: tags['name'] ?? 'Unknown Coordinator',
        icon: tags['icon'],
        minAmountSats: int.tryParse(tags['min_amount_sats'] ?? '0') ?? 0,
        maxAmountSats: int.tryParse(tags['max_amount_sats'] ?? '0') ?? 0,
        makerFee: double.tryParse(tags['maker_fee'] ?? '0') ?? 0,
        takerFee: double.tryParse(tags['taker_fee'] ?? '0') ?? 0,
        reservationSeconds:
            int.tryParse(tags['reservation_seconds'] ?? '0') ?? 0,
        currencies: (tags['currencies'] ?? '')
            .split(',')
            .map((x) => x.trim())
            .where((x) => x.isNotEmpty)
            .toList(),
        version: tags['version'],
        nostrNpub: Nip19.encodePubKey(event.pubKey),
        termsOfUsageNaddr: tags['terms_of_usage_naddr'],
      ),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(event.createdAt * 1000),
      responsive: null,
    );
  }

  Future<bool> _probeCoordinator(String coordinatorPubkey) async {
    final requestId = _nextRequestId();
    final completer = Completer<void>();
    _pendingHealthChecks[requestId] = completer;

    try {
      // ignore: experimental_member_use
      final encrypted = await Nip44.encryptMessage(
        jsonEncode({
          'id': requestId,
          'method': 'get_info',
          'params': <String, Object?>{},
        }),
        _signer.privateKey!,
        coordinatorPubkey,
      );

      final event = Nip01Event(
        kind: kindCoordinatorRequest,
        pubKey: _signer.getPublicKey(),
        content: encrypted,
        tags: [
          ['p', coordinatorPubkey],
        ],
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );

      _ndk.broadcast.broadcast(
        nostrEvent: event,
        customSigner: _signer,
        specificRelays: relays,
      );

      await completer.future.timeout(timeout);
      return true;
    } catch (_) {
      return false;
    } finally {
      _pendingHealthChecks.remove(requestId);
    }
  }

  Future<void> _handleResponseEvent(Nip01Event event) async {
    try {
      // ignore: experimental_member_use
      final decrypted = await Nip44.decryptMessage(
        event.content,
        _signer.privateKey!,
        event.pubKey,
      );
      final json = jsonDecode(decrypted);
      if (json is! Map<String, dynamic>) {
        return;
      }
      final id = json['id'];
      if (id is! String) {
        return;
      }
      final pending = _pendingHealthChecks[id];
      if (pending != null && !pending.isCompleted) {
        pending.complete();
      }
    } catch (_) {
      // Ignore malformed responses.
    }
  }

  String _nextRequestId() =>
      _random.nextInt(9999999).toString().padLeft(6, '0');

  String _generatePrivateKeyHex() {
    final bytes = List<int>.generate(32, (_) => _random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
