import 'dart:async';
import 'dart:math';

import 'package:ndk/ndk.dart';

import '../constants/kinds.dart';
import 'protocol_codec.dart';
import 'rpc_envelope.dart';

/// Client-side transport for the Bitblik JSON-RPC over Nostr.
///
/// Owns:
///   - the subscription to kind [kKindCoordinatorResponse] events tagged for
///     this client's pubkey,
///   - the id→Completer table that matches incoming responses to outgoing
///     requests,
///   - request id generation and timeout enforcement.
///
/// Does **not** own NDK lifecycle, relay configuration, or the signer — those
/// are supplied by the caller so app, cli, and future agents can plug in their
/// own connection management without forking transport logic.
class BitblikRpcClient {
  final Ndk ndk;
  final Bip340EventSigner signer;
  final List<String> relays;
  final Duration timeout;

  final Map<String, Completer<NostrResponse>> _pending = {};
  final Random _random = Random();
  NdkResponse? _subscription;

  /// Optional name suffix for the relay subscription (helps debugging when
  /// multiple clients share an NDK instance).
  final String subscriptionName;

  BitblikRpcClient({
    required this.ndk,
    required this.signer,
    required this.relays,
    this.timeout = const Duration(seconds: 5),
    this.subscriptionName = 'bitblik-rpc-responses',
  });

  /// Subscribe to incoming responses. Must be called before [send].
  Future<void> start() async {
    final filter = Filter(
      kinds: [kKindCoordinatorResponse],
      pTags: [signer.getPublicKey()],
      since: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
    _subscription = ndk.requests.subscription(
      name: subscriptionName,
      filter: filter,
      explicitRelays: relays,
    );
    _subscription!.stream.listen(_onResponse);
  }

  /// Close the response subscription. Pending request futures will hang until
  /// their timeout fires — callers should ensure no in-flight requests remain.
  Future<void> stop() async {
    if (_subscription != null) {
      await ndk.requests.closeSubscription(_subscription!.requestId);
      _subscription = null;
    }
  }

  /// Send an encrypted request to [coordinatorPubkey] and await the matching
  /// response. Throws [TimeoutException] after [timeout] (or [timeoutOverride]) elapses.
  Future<NostrResponse> send(
    NostrRequest request,
    String coordinatorPubkey, {
    Duration? timeoutOverride,
  }) async {
    final id = request.id ?? _nextId();
    final reqWithId = NostrRequest(
      method: request.method,
      params: request.params,
      id: id,
    );

    final completer = Completer<NostrResponse>();
    _pending[id] = completer;

    try {
      final event = await ProtocolCodec.encryptRequest(
        request: reqWithId,
        senderPrivateKeyHex: signer.privateKey!,
        senderPubkeyHex: signer.getPublicKey(),
        coordinatorPubkey: coordinatorPubkey,
      );
      final broadcastResponse = ndk.broadcast.broadcast(
        nostrEvent: event,
        customSigner: signer,
        specificRelays: relays,
      );
      final relayResults = await broadcastResponse.broadcastDoneFuture;
      final anyRelayAccepted = relayResults.any(
        (response) => response.broadcastSuccessful,
      );
      if (!anyRelayAccepted) {
        final details = relayResults
            .map((response) => '${response.relayUrl}: ${response.msg}')
            .join(', ');
        throw StateError(
          'Failed to broadcast RPC request to relays: $details',
        );
      }

      final effectiveTimeout = timeoutOverride ?? timeout;
      return await completer.future.timeout(
        effectiveTimeout,
        onTimeout: () {
          _pending.remove(id);
          throw TimeoutException(
            'Bitblik RPC request timed out',
            effectiveTimeout,
          );
        },
      );
    } catch (_) {
      _pending.remove(id);
      rethrow;
    }
  }

  Future<void> _onResponse(Nip01Event event) async {
    try {
      final response = await ProtocolCodec.decryptResponse(
        event,
        signer.privateKey!,
      );
      final id = response.id;
      if (id == null) return;
      final completer = _pending.remove(id);
      if (completer != null && !completer.isCompleted) {
        completer.complete(response);
      }
    } catch (_) {
      // Malformed/foreign response — ignore.
    }
  }

  String _nextId() => _random.nextInt(9999999).toString().padLeft(6, '0');
}
