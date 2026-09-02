import 'dart:async';
import 'dart:convert';

import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip04/nip04.dart';
import 'package:ndk/shared/nips/nip44/nip44.dart';

class Nwc321PayResult {
  final String transactionId;
  final String state;
  final String instructionType;
  final int amountMsat;
  final int? feesPaidMsat;
  final String? paymentHash;
  final String? preimage;
  final String? payerProof;
  final String? failureReason;
  final int createdAt;
  final int? settledAt;

  const Nwc321PayResult({
    required this.transactionId,
    required this.state,
    required this.instructionType,
    required this.amountMsat,
    required this.createdAt,
    this.feesPaidMsat,
    this.paymentHash,
    this.preimage,
    this.payerProof,
    this.failureReason,
    this.settledAt,
  });

  factory Nwc321PayResult.fromJson(Map<String, dynamic> result) {
    return Nwc321PayResult(
      transactionId: result['transaction_id'] as String,
      state: result['state'] as String,
      instructionType: result['instruction_type'] as String,
      amountMsat: (result['amount'] as num).toInt(),
      feesPaidMsat: (result['fees_paid'] as num?)?.toInt(),
      paymentHash: result['payment_hash'] as String?,
      preimage: result['preimage'] as String?,
      payerProof: result['payer_proof'] as String?,
      failureReason: result['failure_reason'] as String?,
      createdAt: (result['created_at'] as num).toInt(),
      settledAt: (result['settled_at'] as num?)?.toInt(),
    );
  }
}

class Nwc321ReceiveResult {
  final String bip321;
  final String? transactionId;

  const Nwc321ReceiveResult({required this.bip321, this.transactionId});
}

class Nwc321Exception implements Exception {
  final String code;
  final String message;

  const Nwc321Exception(this.code, this.message);

  @override
  String toString() => 'NWC $code: $message';
}

/// Compatibility adapter for the draft NWC-321 methods. It deliberately uses
/// a per-request e-tag subscription so the currently pinned NDK can coexist
/// with result types it does not yet deserialize itself.
class Nwc321Client {
  final Ndk _ndk;

  const Nwc321Client(this._ndk);

  Future<Nwc321PayResult> pay(
    NwcConnection connection, {
    required String payment,
    int? amountMsat,
    int? maxFeeMsat,
    String? payerNote,
    Map<String, dynamic>? metadata,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    final response = await _request(
      connection,
      method: 'pay',
      params: {
        'payment': payment,
        if (amountMsat != null) 'amount': amountMsat,
        if (maxFeeMsat != null) 'max_fee': maxFeeMsat,
        if (payerNote != null) 'payer_note': payerNote,
        if (metadata != null) 'metadata': metadata,
      },
      timeout: timeout,
    );
    return Nwc321PayResult.fromJson(response);
  }

  Future<Nwc321ReceiveResult> receive(
    NwcConnection connection, {
    int? amountMsat,
    String? description,
    Map<String, dynamic>? metadata,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final response = await _request(
      connection,
      method: 'receive',
      params: {
        if (amountMsat != null) 'amount': amountMsat,
        if (description != null) 'description': description,
        if (metadata != null) 'metadata': metadata,
      },
      timeout: timeout,
    );
    return Nwc321ReceiveResult(
      bip321: response['bip321'] as String,
      transactionId: response['transaction_id'] as String?,
    );
  }

  Future<List<Map<String, dynamic>>> listTransactions(
    NwcConnection connection, {
    int? from,
    int? until,
    int limit = 20,
    int offset = 0,
    bool unpaid = true,
    String type = 'outgoing',
    Duration timeout = const Duration(seconds: 20),
  }) async {
    final response = await _request(
      connection,
      method: 'list_transactions',
      params: {
        if (from != null) 'from': from,
        if (until != null) 'until': until,
        'limit': limit,
        'offset': offset,
        'unpaid': unpaid,
        'type': type,
      },
      timeout: timeout,
    );
    final transactions = response['transactions'];
    if (transactions is! List) {
      throw const Nwc321Exception('INTERNAL', 'Malformed transaction history');
    }
    return [
      for (final transaction in transactions)
        if (transaction is Map) Map<String, dynamic>.from(transaction),
    ];
  }

  Future<Map<String, dynamic>> _request(
    NwcConnection connection, {
    required String method,
    required Map<String, dynamic> params,
    required Duration timeout,
  }) async {
    final advertised = connection.permissions.contains(method) ||
        (connection.info?.methods.contains(method) ?? false);
    if (!advertised) {
      throw Nwc321Exception('NOT_IMPLEMENTED', '$method is not advertised');
    }

    final content = jsonEncode({'method': method, 'params': params});
    final encrypted = Nip04.encrypt(
      connection.uri.secret,
      connection.uri.walletPubkey,
      content,
    );
    final request = Nip01Event(
      pubKey: connection.signer.getPublicKey(),
      kind: 23194,
      tags: [
        ['p', connection.uri.walletPubkey],
      ],
      content: encrypted,
    );
    final relays = connection.uri.relays.map(Uri.decodeFull).toList();
    final response = _ndk.requests.subscription(
      name: 'nwc-321-$method',
      explicitRelays: relays,
      filters: [
        Filter(
          kinds: const [23195],
          authors: [connection.uri.walletPubkey],
          pTags: [connection.signer.getPublicKey()],
          eTags: [request.id],
        ),
      ],
      cacheRead: false,
      cacheWrite: false,
    );

    try {
      final responseFuture = response.stream.first.timeout(timeout);
      final broadcast = _ndk.broadcast.broadcast(
        nostrEvent: request,
        specificRelays: relays,
        customSigner: connection.signer,
      );
      await broadcast.broadcastDoneFuture.timeout(timeout);
      final event = await responseFuture;
      var decrypted = Nip04.decrypt(
        connection.uri.secret,
        connection.uri.walletPubkey,
        event.content,
      );
      if (decrypted.isEmpty) {
        decrypted = await Nip44.decryptMessage(
          event.content,
          connection.uri.secret,
          connection.uri.walletPubkey,
        );
      }
      final payload = jsonDecode(decrypted) as Map<String, dynamic>;
      final error = payload['error'];
      if (error is Map) {
        throw Nwc321Exception(
          error['code']?.toString() ?? 'INTERNAL',
          error['message']?.toString() ?? 'Unknown wallet error',
        );
      }
      if (payload['result_type'] != method || payload['result'] is! Map) {
        throw const Nwc321Exception('INTERNAL', 'Malformed NWC response');
      }
      return Map<String, dynamic>.from(payload['result'] as Map);
    } finally {
      await _ndk.requests.closeSubscription(response.requestId);
    }
  }
}
