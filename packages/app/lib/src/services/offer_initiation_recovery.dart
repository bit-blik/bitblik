import 'dart:convert';
import 'dart:math';

import 'offer_initiation_store.dart';

class UncertainOfferInitiation implements Exception {
  final String message;
  const UncertainOfferInitiation(this.message);
  @override
  String toString() => message;
}

/// One mutation at most per durable local attempt. Subsequent calls only read
/// the coordinator receipt, regardless of current capability advertisements.
class OfferInitiationRecovery {
  final OfferInitiationStore store;
  final Future<Map<String, dynamic>> Function(
    String coordinator,
    String operationId,
  )
  lookup;
  final DateTime Function() now;
  final Map<String, Future<Map<String, dynamic>>> _inFlight = {};
  OfferInitiationRecovery({
    required this.store,
    required this.lookup,
    DateTime Function()? now,
  }) : now = now ?? DateTime.now;

  /// An attempt whose invoice never reached this device cannot have been paid,
  /// so it only has to be kept while the coordinator could still create that
  /// invoice. RPC requests are ephemeral events, the coordinator accepts them
  /// only from 30 s before it (re)subscribes, and initiate_offer stops calling
  /// the wallet 20 s after receipt. Ten minutes later a lookup that still says
  /// not_found or pending means no invoice for the attempt will ever be shown,
  /// and the attempt is released.
  static const abandonAfter = Duration(minutes: 10);

  /// Past the longest pre-funding window (26 h on LND) the coordinator has
  /// cancelled any invoice it made for the attempt, so the attempt is released
  /// even when its coordinator cannot be reached.
  static const forgetAfter = Duration(hours: 27);

  static String _operationId() {
    final random = Random.secure();
    return List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }

  static String _canonical(Map<String, dynamic> value) => jsonEncode({
    for (final key in value.keys.toList()..sort()) key: value[key],
  });

  Future<Map<String, dynamic>> initiate({
    required String maker,
    required String coordinator,
    required Map<String, dynamic> params,
    required bool supportsRecovery,
    Map<String, dynamic>? estimate,
    required Future<Map<String, dynamic>> Function(String? operationId) send,
  }) {
    // Coalesce only identical calls. Different inputs still go through the
    // durable one-at-a-time guard rather than receiving the wrong invoice.
    final key = jsonEncode([maker, coordinator, _canonical(params)]);
    final existing = _inFlight[key];
    if (existing != null) return existing;
    final future = _initiate(
      maker: maker,
      coordinator: coordinator,
      params: params,
      supportsRecovery: supportsRecovery,
      estimate: estimate,
      send: send,
    );
    _inFlight[key] = future;
    return future.whenComplete(() => _inFlight.remove(key));
  }

  Future<Map<String, dynamic>> _initiate({
    required String maker,
    required String coordinator,
    required Map<String, dynamic> params,
    required bool supportsRecovery,
    required Map<String, dynamic>? estimate,
    required Future<Map<String, dynamic>> Function(String? operationId) send,
  }) async {
    // Read before the compatibility fallback: a server rollback must never
    // turn an uncertain, protected attempt into a fresh legacy mutation.
    var old = await store.read(maker);
    // A lookup made while deciding whether [old] is stale, reused below so the
    // same attempt is not looked up twice in one call.
    Map<String, dynamic>? staleLookup;
    var staleLookupFailed = false;
    if (old != null && old.result == null) {
      final nowMs = now().millisecondsSinceEpoch;
      final age = Duration(
        milliseconds: nowMs - await store.createdAtOrStamp(old, nowMs),
      );
      var release = age >= forgetAfter;
      if (!release && age >= abandonAfter) {
        try {
          staleLookup = await lookup(old.coordinator, old.operationId);
        } catch (_) {
          // Unknown is not proof of absence; keep the attempt.
          staleLookupFailed = true;
        }
        final status = staleLookup?['status'];
        release = status == 'not_found' || status == 'pending';
      }
      if (release) {
        final operationId = old.operationId;
        await store.abandonUnanswered(old);
        // Re-read even after a successful release: another isolate may
        // already have claimed a fresh attempt for this maker.
        old = await store.read(maker);
        if (old?.operationId != operationId) staleLookup = null;
      }
    }
    if (old == null && !supportsRecovery) {
      final result = await send(null);
      return {...result, '_clientFundingEstimate': estimate};
    }
    final claim = old == null
        ? await store.claim(
            LocalOfferInitiation(
              maker: maker,
              coordinator: coordinator,
              operationId: _operationId(),
              params: params,
              estimate: estimate,
              createdAt: now().millisecondsSinceEpoch,
            ),
          )
        : (attempt: old, inserted: false);
    final attempt = claim.attempt;
    if (attempt.coordinator != coordinator ||
        _canonical(attempt.params) != _canonical(params)) {
      throw UncertainOfferInitiation(
        'An earlier offer attempt is unresolved (${attempt.params['fiat_amount']} '
        '${attempt.params['fiat_currency']}, coordinator ${attempt.coordinator}). '
        'Restore the original offer details and press Create to check it. '
        'If its coordinator never made an invoice for it, the app releases it '
        '10 minutes after the attempt. No new invoice was requested.',
      );
    }
    Map<String, dynamic> result;
    if (attempt.result != null) {
      result = attempt.result!;
    } else if (claim.inserted) {
      try {
        result = await send(attempt.operationId);
      } catch (_) {
        // All transport/server errors can hide a committed wallet request.
        // Preserve the row; another click performs only read-only lookup.
        throw const UncertainOfferInitiation(
          'Offer creation could not be confirmed. Keep the same offer details '
          'and press Create again to check the existing request. '
          'Do not create another offer or switch coordinators yet.',
        );
      }
      await store.saveResult(attempt, result);
    } else {
      Map<String, dynamic> response;
      try {
        if (staleLookupFailed) throw StateError('stale lookup failed');
        response =
            staleLookup ??
            await lookup(attempt.coordinator, attempt.operationId);
      } catch (_) {
        throw const UncertainOfferInitiation(
          'The earlier offer request could not be checked. Try checking again later; '
          'no new invoice was requested.',
        );
      }
      if (response['status'] != 'ready' || response['result'] is! Map) {
        // Within [abandonAfter], not_found does not prove that the earlier
        // relay event cannot still arrive.
        throw const UncertainOfferInitiation(
          'The earlier offer request is still pending or unknown. '
          'Check again in a few minutes: if the coordinator still has no '
          'invoice for it 10 minutes after the attempt, the app releases it. '
          'No new invoice was requested.',
        );
      }
      result = Map<String, dynamic>.from(response['result'] as Map);
      await store.saveResult(attempt, result);
    }
    // Reserved client-only value always wins over untrusted RPC fields.
    return {...result, '_clientFundingEstimate': attempt.estimate};
  }
}
