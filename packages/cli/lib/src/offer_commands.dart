import 'dart:convert';
import 'dart:io';

import 'package:bip340/bip340.dart' as bip340;
import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';

import 'offer_store.dart';
import 'protocol_client.dart';
import 'secrets_store.dart';

/// CLI command: `bitblik offer list`.
///
/// Default: reads locally persisted offers from [OfferStore].
/// With `--coordinator`: queries kind [kKindOffer] events from relays instead.
Future<int> runOfferList(List<String> args) async {
  final parsed = _parseFlags(args);
  final jsonOutput = parsed.containsKey('json');
  final relays = _collectMultiFlag(args, '--relay');
  final currency = parsed['currency'] ?? 'PLN';
  final coordinatorArg = parsed['coordinator'];

  // ---- Local path (default) ----
  if (coordinatorArg == null) {
    final showAll = parsed.containsKey('finished');
    final store = await OfferStore.open();
    try {
      final all = await store.all();
      final offers = showAll ? all : all.where((o) => _isInProgress(o.status)).toList();
      if (jsonOutput) {
        stdout.writeln(
          const JsonEncoder.withIndent('  ')
              .convert(offers.map((o) => o.toJson()).toList()),
        );
      } else {
        _printOfferTable(offers);
      }
      return 0;
    } finally {
      await store.close();
    }
  }

  // ---- Remote path: --coordinator supplied ----
  final String coordinatorPubkey;
  try {
    coordinatorPubkey = _resolvePubkey(coordinatorArg);
  } on FormatException catch (e) {
    stderr.writeln('Invalid --coordinator: ${e.message}');
    return 64;
  }

  final secrets = await SecretsStore.loadOrCreate();
  final client = BitblikProtocolClient(
    secrets: secrets,
    relays: relays.isEmpty ? null : relays,
  );

  try {
    await client.init();
    final offers = await client.listOffers(
      fiatCurrency: currency,
      coordinatorPubkey: coordinatorPubkey,
    );

    if (jsonOutput) {
      stdout.writeln(
        const JsonEncoder.withIndent('  ')
            .convert(offers.map((o) => o.toJson()).toList()),
      );
    } else {
      _printOfferTable(offers);
    }
    return 0;
  } finally {
    await client.dispose();
  }
}

void _printOfferTable(List<Offer> offers) {
  if (offers.isEmpty) {
    stdout.writeln('No offers found.');
    return;
  }
  stdout.writeln('ID | STATUS | FIAT | SATS | CREATED | COORDINATOR');
  for (final o in offers) {
    final coord = o.coordinatorPubkey.length > 12
        ? '${o.coordinatorPubkey}'
        : o.coordinatorPubkey;
    stdout.writeln(
      '${o.id} | ${o.status.name} | ${o.fiatAmount} ${o.fiatCurrency} | '
      '${o.amountSats} | ${o.createdAt.toIso8601String()} | $coord',
    );
  }
}

/// CLI command: `bitblik offer create`.
///
/// Initiates a fiat-denominated offer via the coordinator's `initiate_offer`
/// RPC and prints the returned hold invoice + amounts for the maker to pay.
Future<int> runOfferCreate(List<String> args) async {
  final parsed = _parseFlags(args);
  final fiatStr = parsed['fiat'];
  final coordinatorArg = parsed['coordinator'];
  final jsonOutput = parsed.containsKey('json');
  final relays = _collectMultiFlag(args, '--relay');

  if (fiatStr == null || coordinatorArg == null) {
    stderr.writeln(
        'usage: bitblik offer create --fiat <amount> --coordinator <npub|hex> '
        '[--currency PLN] [--json] [--relay <url>]');
    return 64;
  }

  final fiat = double.tryParse(fiatStr);
  if (fiat == null || fiat <= 0) {
    stderr.writeln('Invalid --fiat value: $fiatStr');
    return 64;
  }

  final String coordinatorPubkey;
  try {
    coordinatorPubkey = _resolvePubkey(coordinatorArg);
  } on FormatException catch (e) {
    stderr.writeln('Invalid --coordinator: ${e.message}');
    return 64;
  }

  // Guard: reject if there's already an active offer for this coordinator.
  {
    final store = await OfferStore.open();
    try {
      final all = await store.all();
      final active = all
          .where((o) =>
              o.coordinatorPubkey == coordinatorPubkey &&
              _isInProgress(o.status))
          .toList();
      if (active.isNotEmpty) {
        stderr.writeln(
            'Active offer already exists for this coordinator:\n'
            '  ${active.first.id}  status=${active.first.status.name}  '
            '${active.first.fiatAmount} ${active.first.fiatCurrency}\n'
            'Cancel or finish it first, or run: bitblik offer cancel');
        return 1;
      }
    } finally {
      await store.close();
    }
  }

  final secrets = await SecretsStore.loadOrCreate();
  final client = BitblikProtocolClient(
    secrets: secrets,
    relays: relays.isEmpty ? null : relays,
  );

  try {
    await client.init();
    final response = await client.sendRequest(
      NostrRequest(
        method: kRpcInitiateOffer,
        params: {
          'fiat_amount': fiat,
          if (parsed['currency'] != null) 'fiat_currency': parsed['currency']!,
        },
      ),
      coordinatorPubkey,
    );

    if (!response.isSuccess) {
      stderr.writeln(
          'Coordinator error: ${response.error?['message'] ?? response.error}');
      return 1;
    }

    final result = response.result!;
    OfferCategory? category;
    final categoryRaw = result['category']?.toString();
    if (categoryRaw != null && categoryRaw.isNotEmpty) {
      try {
        category = OfferCategory.values.byName(categoryRaw);
      } catch (_) {
        category = null;
      }
    }
    final offer = Offer(
      id: result['id']?.toString() ??
          result['offer_id']?.toString() ??
          result['paymentHash']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      amountSats: (result['amountSats'] as num?)?.toInt() ?? 0,
      makerFees: (result['makerFees'] as num?)?.toInt() ?? 0,
      fiatAmount: (result['fiatAmount'] as num?)?.toDouble() ?? fiat,
      fiatCurrency:
          result['fiatCurrency']?.toString() ?? parsed['currency'] ?? 'PLN',
      status: OfferStatus.created,
      createdAt: DateTime.now(),
      makerPubkey: bip340.getPublicKey(secrets.privateKeyHex),
      coordinatorPubkey: coordinatorPubkey,
      holdInvoicePaymentHash: result['paymentHash']?.toString(),
      holdInvoice: result['holdInvoice']?.toString(),
      category: category,
    );

    final store = await OfferStore.open();
    try {
      await store.upsert(offer);
    } finally {
      await store.close();
    }

    if (jsonOutput) {
      stdout.writeln(
        const JsonEncoder.withIndent('  ').convert(result),
      );
    } else {
      _printOfferReceipt(result);
    }
    return 0;
  } finally {
    await client.dispose();
  }
}

// ---------------------------------------------------------------------------
// Helper sets
// ---------------------------------------------------------------------------

const _getblikWaitStatuses = {
  OfferStatus.created,
  OfferStatus.funded,
  OfferStatus.reserved,
};

const _terminalStatuses = {
  OfferStatus.cancelled,
  OfferStatus.expired,
  OfferStatus.takerPaid,
};

bool _canGetBlik(OfferStatus s) =>
    _getblikWaitStatuses.contains(s) ||
    s == OfferStatus.blikReceived ||
    s == OfferStatus.blikSentToMaker;

bool _isInProgress(OfferStatus s) =>
    !_terminalStatuses.contains(s) && s != OfferStatus.unknown;

// ---------------------------------------------------------------------------
// CLI command: `bitblik offer get-blik`
// ---------------------------------------------------------------------------

/// CLI command: `bitblik offer get-blik`.
///
/// Fast path: `--offer <id> --coordinator <npub|hex>` — skips local store,
/// calls `get_blik` RPC directly.
///
/// Normal path: loads persisted offers, picks the single active one (or the
/// one selected via `--offer <id>`), waits for [OfferStatus.blikReceived] via
/// kind 25197 subscription, then calls `get_blik` and prints the BLIK code.
///
/// With `--no-wait`: syncs once, returns immediately. Exit 0 = BLIK code
/// retrieved. Exit 2 = not ready yet (use for polling loops / MCP agents).
Future<int> runOfferGetBlik(List<String> args) async {
  final parsed = _parseFlags(args);
  final offerIdArg = parsed['offer'];
  final coordinatorArg = parsed['coordinator'];
  final relays = _collectMultiFlag(args, '--relay');
  final noWait = parsed.containsKey('no-wait');
  final jsonOutput = parsed.containsKey('json');

  // Resolve coordinator pubkey if provided.
  String? coordinatorPubkey;
  if (coordinatorArg != null) {
    try {
      coordinatorPubkey = _resolvePubkey(coordinatorArg);
    } on FormatException catch (e) {
      stderr.writeln('Invalid --coordinator: ${e.message}');
      return 64;
    }
  }

  // ---- Fast path: offer id + coordinator supplied, skip local store ----
  if (offerIdArg != null && coordinatorPubkey != null) {
    final secrets = await SecretsStore.loadOrCreate();
    final client = BitblikProtocolClient(
      secrets: secrets,
      relays: relays.isEmpty ? null : relays,
    );
    try {
      await client.init();
      return await _callGetBlikRpc(client, offerIdArg, coordinatorPubkey,
          jsonOutput: jsonOutput);
    } finally {
      await client.dispose();
    }
  }

  // ---- Normal path ----
  // Init client first so we can sync before picking offer.
  final secrets = await SecretsStore.loadOrCreate();
  final client = BitblikProtocolClient(
    secrets: secrets,
    relays: relays.isEmpty ? null : relays,
  );

  try {
    await client.init();
    await _syncActiveOffers(client);

    // Load from store with refreshed statuses.
    final store = await OfferStore.open();
    final Offer offer;
    try {
      final all = await store.all();
      final active = all.where((o) => _canGetBlik(o.status)).toList();

      if (active.isEmpty) {
        stderr.writeln(
            'No active offers found locally. '
            'Create one with: bitblik offer create\n'
            'Or pass --offer <id> --coordinator <npub|hex> to skip local lookup.');
        return 1;
      }

      if (offerIdArg != null) {
        final found = active.where((o) => o.id == offerIdArg).firstOrNull;
        if (found == null) {
          stderr.writeln('Offer "$offerIdArg" not found or not in an actionable status.');
          return 64;
        }
        offer = found;
      } else if (active.length > 1) {
        stderr.writeln('Multiple active offers. Pass --offer <id> to select one:');
        for (final o in active) {
          stderr.writeln(
              '  ${o.id}  status=${o.status.name}  '
              '${o.fiatAmount} ${o.fiatCurrency}');
        }
        return 64;
      } else {
        offer = active.first;
      }
    } finally {
      await store.close();
    }

    final paymentHash = offer.holdInvoicePaymentHash;
    if (paymentHash == null || paymentHash.isEmpty) {
      stderr.writeln('Offer ${offer.id} has no payment hash — cannot proceed.');
      return 1;
    }

    var currentOffer = offer;

    if (offer.status != OfferStatus.blikReceived &&
        offer.status != OfferStatus.blikSentToMaker) {
      // --no-wait: don't block, return 2 so the caller can poll.
      if (noWait) {
        if (jsonOutput) {
          stdout.writeln(const JsonEncoder.withIndent('  ').convert({
            'ready': false,
            'status': offer.status.name,
            'offer_id': offer.id,
            'payment_hash': offer.holdInvoicePaymentHash,
          }));
        } else {
          stdout.writeln('Not ready yet: ${_waitMessage(offer.status)}');
        }
        return 2;
      }

      stdout.writeln(
          'Offer ${offer.holdInvoicePaymentHash}: ${_waitMessage(offer.status)} (Ctrl+C to abort)');

      final updates = client.watchOfferStatus(paymentHash: paymentHash);
      await for (final update in updates) {
        OfferStatus status;
        try {
          status = OfferStatus.values.byName(update.status);
        } catch (_) {
          status = OfferStatus.unknown;
        }

        stdout.writeln('  → ${_waitMessage(status)}');

        // Update id to coordinator UUID; store key (paymentHash) unchanged.
        currentOffer = currentOffer.copyWith(id: update.offerId, status: status);
        final s2 = await OfferStore.open();
        try {
          await s2.upsert(currentOffer);
        } finally {
          await s2.close();
        }

        if (status == OfferStatus.blikReceived ||
            status == OfferStatus.blikSentToMaker) {
          break;
        }
        if (_terminalStatuses.contains(status)) {
          stderr.writeln('Offer ended: ${status.name}. BLIK no longer available.');
          return 1;
        }
      }
    }

    return await _callGetBlikRpc(
        client, currentOffer.id, offer.coordinatorPubkey,
        localOffer: currentOffer, jsonOutput: jsonOutput);
  } finally {
    await client.dispose();
  }
}

Future<int> _callGetBlikRpc(
  BitblikProtocolClient client,
  String offerId,
  String coordinatorPubkey, {
  Offer? localOffer,
  bool jsonOutput = false,
}) async {
  if (!jsonOutput) stdout.writeln('Requesting BLIK code…');
  final response = await client.sendRequest(
    NostrRequest(
      method: kRpcGetBlik,
      params: {'offer_id': offerId},
    ),
    coordinatorPubkey,
  );

  if (!response.isSuccess) {
    final msg = response.error?['message'] ?? response.error;
    if (jsonOutput) {
      stdout.writeln(const JsonEncoder.withIndent('  ')
          .convert({'error': msg.toString()}));
    } else {
      stderr.writeln('Coordinator error: $msg');
    }
    return 1;
  }

  final result = response.result!;
  final blikCode =
      result['blik_code']?.toString() ?? result['blikCode']?.toString();

  if (jsonOutput) {
    stdout.writeln(const JsonEncoder.withIndent('  ').convert({
      'ready': true,
      'blik_code': blikCode,
      ...result,
    }));
  } else if (blikCode != null) {
    stdout.writeln('\nBLIK code : $blikCode');
    stdout.writeln('Enter this code in your banking app within 120 seconds.');
  } else {
    stdout.writeln(const JsonEncoder.withIndent('  ').convert(result));
  }

  // Persist status change locally.
  final toUpdate = localOffer;
  if (toUpdate != null) {
    final store = await OfferStore.open();
    try {
      await store.upsert(toUpdate.copyWith(status: OfferStatus.blikSentToMaker));
    } finally {
      await store.close();
    }
  } else {
    // Fast path: try to find by offerId as paymentHash (best effort).
    final store = await OfferStore.open();
    try {
      final stored = await store.get(offerId);
      if (stored != null) {
        await store.upsert(stored.copyWith(status: OfferStatus.blikSentToMaker));
      }
    } finally {
      await store.close();
    }
  }

  return 0;
}

// ---------------------------------------------------------------------------
// CLI command: `bitblik offer cancel`
// ---------------------------------------------------------------------------

/// CLI command: `bitblik offer cancel`.
///
/// Cancels an active (created/funded) offer. Coordinator voids the hold invoice.
/// Fast path: `--offer <id> --coordinator <npub|hex>` skips local store.
Future<int> runOfferCancel(List<String> args) async {
  final parsed = _parseFlags(args);
  final offerIdArg = parsed['offer'];
  final coordinatorArg = parsed['coordinator'];
  final relays = _collectMultiFlag(args, '--relay');

  String? coordinatorPubkey;
  if (coordinatorArg != null) {
    try {
      coordinatorPubkey = _resolvePubkey(coordinatorArg);
    } on FormatException catch (e) {
      stderr.writeln('Invalid --coordinator: ${e.message}');
      return 64;
    }
  }

  // ---- Fast path ----
  if (offerIdArg != null && coordinatorPubkey != null) {
    final secrets = await SecretsStore.loadOrCreate();
    final client = BitblikProtocolClient(
      secrets: secrets,
      relays: relays.isEmpty ? null : relays,
    );
    try {
      await client.init();
      return await _callCancelOfferRpc(client, offerIdArg, coordinatorPubkey);
    } finally {
      await client.dispose();
    }
  }

  // ---- Normal path: load from local store ----
  final store = await OfferStore.open();
  final Offer offer;
  try {
    final all = await store.all();
    final cancellable = all.where((o) => _isCancellable(o.status)).toList();

    if (cancellable.isEmpty) {
      stderr.writeln(
          'No cancellable offers found locally.\n'
          'Or pass --offer <id> --coordinator <npub|hex> to skip local lookup.');
      return 1;
    }

    if (offerIdArg != null) {
      final found = cancellable.where((o) => o.id == offerIdArg).firstOrNull;
      if (found == null) {
        stderr.writeln(
            'Offer "$offerIdArg" not found or not in a cancellable status.');
        return 64;
      }
      offer = found;
    } else if (cancellable.length > 1) {
      stderr.writeln('Multiple cancellable offers. Pass --offer <id>:');
      for (final o in cancellable) {
        stderr.writeln(
            '  ${o.id}  status=${o.status.name}  '
            '${o.fiatAmount} ${o.fiatCurrency}');
      }
      return 64;
    } else {
      offer = cancellable.first;
    }
  } finally {
    await store.close();
  }

  final secrets = await SecretsStore.loadOrCreate();
  final client = BitblikProtocolClient(
    secrets: secrets,
    relays: relays.isEmpty ? null : relays,
  );
  try {
    await client.init();

    // Offer already has a coordinator UUID — RPC cancel directly.
    if (_looksLikeUuid(offer.id)) {
      return await _callCancelOfferRpc(
          client, offer.id, offer.coordinatorPubkey,
          localOffer: offer);
    }

    // Offer is local-only (ID is a payment hash, not a coordinator UUID).
    // Sync with coordinator first: get its current view and real UUID.
    final paymentHash = offer.holdInvoicePaymentHash;
    if (paymentHash == null) {
      stdout.writeln('No payment hash — cancelling locally only.');
      return await _cancelLocalOnly(offer);
    }

    stdout.writeln('Offer has no coordinator UUID — syncing before cancel…');
    final response = await client.sendRequest(
      const NostrRequest(method: kRpcGetMyActiveOffer, params: {}),
      offer.coordinatorPubkey,
    );

    if (!response.isSuccess ||
        response.result == null ||
        response.result!.isEmpty) {
      // Coordinator has no active offer for our key — safe local-only cancel.
      stdout.writeln('Coordinator reports no active offer — cancelling locally.');
      return await _cancelLocalOnly(offer);
    }

    final result = response.result!;
    final remoteHash = result['hold_invoice_payment_hash']?.toString() ??
        result['paymentHash']?.toString();

    if (remoteHash != paymentHash) {
      // Coordinator's active offer is a different one — not ours.
      stdout.writeln('No matching offer on coordinator — cancelling locally.');
      return await _cancelLocalOnly(offer);
    }

    // Coordinator matched. Extract UUID and current status.
    final remoteId =
        result['id']?.toString() ?? result['offer_id']?.toString();
    final remoteStatusStr = result['status']?.toString();

    OfferStatus remoteStatus = offer.status;
    if (remoteStatusStr != null) {
      try {
        remoteStatus = OfferStatus.values.byName(remoteStatusStr);
      } catch (_) {
        remoteStatus = OfferStatus.unknown;
      }
    }

    // Persist updated UUID + status before we do anything else.
    var updatedOffer = offer;
    if (remoteId != null) {
      updatedOffer = offer.copyWith(id: remoteId, status: remoteStatus);
      final s2 = await OfferStore.open();
      try {
        await s2.upsert(updatedOffer);
      } finally {
        await s2.close();
      }
      stdout.writeln(
          'Synced: ${offer.id} → id=$remoteId  status=${remoteStatus.name}');
    }

    if (!_isCancellable(remoteStatus)) {
      stderr.writeln(
          'Coordinator reports offer in "${remoteStatus.name}" — cannot cancel.');
      return 1;
    }

    // RPC cancel with the real coordinator UUID.
    return await _callCancelOfferRpc(
        client, updatedOffer.id, updatedOffer.coordinatorPubkey,
        localOffer: updatedOffer);
  } finally {
    await client.dispose();
  }
}

/// Mark an offer as cancelled in the local store only — no coordinator RPC.
Future<int> _cancelLocalOnly(Offer offer) async {
  final store = await OfferStore.open();
  try {
    await store.upsert(offer.copyWith(status: OfferStatus.cancelled));
  } finally {
    await store.close();
  }
  stdout.writeln('Offer marked as cancelled locally (no coordinator RPC sent).');
  return 0;
}

bool _isCancellable(OfferStatus s) =>
    s == OfferStatus.created || s == OfferStatus.funded;

/// True when [s] looks like a coordinator UUID (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx).
/// False = still a payment hash — offer has not been correlated with the coordinator yet.
bool _looksLikeUuid(String s) => RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      caseSensitive: false,
    ).hasMatch(s);

Future<int> _callCancelOfferRpc(
  BitblikProtocolClient client,
  String offerId,
  String coordinatorPubkey, {
  Offer? localOffer,
}) async {
  stdout.writeln('Cancelling offer…');
  final response = await client.sendRequest(
    NostrRequest(
      method: kRpcCancelOffer,
      params: {'offer_id': offerId},
    ),
    coordinatorPubkey,
  );

  if (!response.isSuccess) {
    stderr.writeln(
        'Coordinator error: ${response.error?['message'] ?? response.error}');
    return 1;
  }

  final store = await OfferStore.open();
  try {
    if (localOffer != null) {
      await store.upsert(localOffer.copyWith(status: OfferStatus.cancelled));
    } else {
      // Fast path: no localOffer supplied. Store is keyed by payment hash, so
      // store.get(offerId) only works when offerId IS the payment hash.
      // Also search by coordinator UUID (the id field) to cover the UUID case.
      final stored = await store.get(offerId) ??
          (await store.all())
              .where((o) => o.id == offerId)
              .firstOrNull;
      if (stored != null) {
        await store.upsert(stored.copyWith(status: OfferStatus.cancelled));
      }
    }
  } finally {
    await store.close();
  }

  stdout.writeln('Offer cancelled. Hold invoice will be voided by coordinator.');
  return 0;
}

// ---------------------------------------------------------------------------
// CLI command: `bitblik offer mark-blik-invalid`
// ---------------------------------------------------------------------------

/// CLI command: `bitblik offer mark-blik-invalid`.
///
/// Tells the coordinator the BLIK code was invalid / did not charge.
/// Coordinator puts the offer back so a new taker can reserve it.
/// Fast path: `--offer <id> --coordinator <npub|hex>` skips local store.
Future<int> runOfferMarkBlikInvalid(List<String> args) async {
  final parsed = _parseFlags(args);
  final offerIdArg = parsed['offer'];
  final coordinatorArg = parsed['coordinator'];
  final relays = _collectMultiFlag(args, '--relay');

  String? coordinatorPubkey;
  if (coordinatorArg != null) {
    try {
      coordinatorPubkey = _resolvePubkey(coordinatorArg);
    } on FormatException catch (e) {
      stderr.writeln('Invalid --coordinator: ${e.message}');
      return 64;
    }
  }

  // ---- Fast path ----
  if (offerIdArg != null && coordinatorPubkey != null) {
    final secrets = await SecretsStore.loadOrCreate();
    final client = BitblikProtocolClient(
      secrets: secrets,
      relays: relays.isEmpty ? null : relays,
    );
    try {
      await client.init();
      return await _callMarkBlikInvalidRpc(
          client, offerIdArg, coordinatorPubkey);
    } finally {
      await client.dispose();
    }
  }

  // ---- Normal path: load from local store ----
  final store = await OfferStore.open();
  final Offer offer;
  try {
    final all = await store.all();
    // Maker can mark invalid after receiving the BLIK code.
    // Allow all BLIK-related and expired-BLIK states — coordinator is the
    // final authority on whether mark_blik_invalid is accepted.
    final eligible = all
        .where((o) =>
            o.status == OfferStatus.blikSentToMaker ||
            o.status == OfferStatus.blikReceived ||
            o.status == OfferStatus.expiredSentBlik ||
            o.status == OfferStatus.expiredBlik)
        .toList();

    if (eligible.isEmpty) {
      stderr.writeln(
          'No offers in a state where BLIK can be marked invalid.\n'
          'Or pass --offer <id> --coordinator <npub|hex> to skip local lookup.');
      return 1;
    }

    if (offerIdArg != null) {
      final found = eligible.where((o) => o.id == offerIdArg).firstOrNull;
      if (found == null) {
        stderr.writeln(
            'Offer "$offerIdArg" not found or not in an eligible status.');
        return 64;
      }
      offer = found;
    } else if (eligible.length > 1) {
      stderr.writeln('Multiple eligible offers. Pass --offer <id>:');
      for (final o in eligible) {
        stderr.writeln(
            '  ${o.id}  status=${o.status.name}  '
            '${o.fiatAmount} ${o.fiatCurrency}');
      }
      return 64;
    } else {
      offer = eligible.first;
    }
  } finally {
    await store.close();
  }

  final secrets = await SecretsStore.loadOrCreate();
  final client = BitblikProtocolClient(
    secrets: secrets,
    relays: relays.isEmpty ? null : relays,
  );
  try {
    await client.init();
    return await _callMarkBlikInvalidRpc(
        client, offer.id, offer.coordinatorPubkey,
        localOffer: offer);
  } finally {
    await client.dispose();
  }
}

Future<int> _callMarkBlikInvalidRpc(
  BitblikProtocolClient client,
  String offerId,
  String coordinatorPubkey, {
  Offer? localOffer,
}) async {
  stdout.writeln('Marking BLIK code as invalid…');
  final response = await client.sendRequest(
    NostrRequest(
      method: kRpcMarkBlikInvalid,
      params: {'offer_id': offerId},
    ),
    coordinatorPubkey,
  );

  if (!response.isSuccess) {
    stderr.writeln(
        'Coordinator error: ${response.error?['message'] ?? response.error}');
    return 1;
  }

  if (localOffer != null) {
    final store = await OfferStore.open();
    try {
      await store.upsert(localOffer.copyWith(status: OfferStatus.invalidBlik));
    } finally {
      await store.close();
    }
  } else {
    final store = await OfferStore.open();
    try {
      final stored = await store.get(offerId);
      if (stored != null) {
        await store.upsert(stored.copyWith(status: OfferStatus.invalidBlik));
      }
    } finally {
      await store.close();
    }
  }

  stdout.writeln(
      'BLIK marked invalid. Taker notified; offer will be listed for a new taker.');
  return 0;
}

// ---------------------------------------------------------------------------
// CLI command: `bitblik offer open-dispute`
// ---------------------------------------------------------------------------

/// CLI command: `bitblik offer open-dispute`.
///
/// Opens a dispute after the taker raised a conflict (taker claims BLIK charged
/// but maker reported it invalid). Coordinator mediates.
/// Fast path: `--offer <id> --coordinator <npub|hex>` skips local store.
Future<int> runOfferOpenDispute(List<String> args) async {
  final parsed = _parseFlags(args);
  final offerIdArg = parsed['offer'];
  final coordinatorArg = parsed['coordinator'];
  final relays = _collectMultiFlag(args, '--relay');

  String? coordinatorPubkey;
  if (coordinatorArg != null) {
    try {
      coordinatorPubkey = _resolvePubkey(coordinatorArg);
    } on FormatException catch (e) {
      stderr.writeln('Invalid --coordinator: ${e.message}');
      return 64;
    }
  }

  // ---- Fast path ----
  if (offerIdArg != null && coordinatorPubkey != null) {
    final secrets = await SecretsStore.loadOrCreate();
    final client = BitblikProtocolClient(
      secrets: secrets,
      relays: relays.isEmpty ? null : relays,
    );
    try {
      await client.init();
      return await _callOpenDisputeRpc(client, offerIdArg, coordinatorPubkey);
    } finally {
      await client.dispose();
    }
  }

  // ---- Normal path: load from local store ----
  final store = await OfferStore.open();
  final Offer offer;
  try {
    final all = await store.all();
    final eligible = all
        .where((o) => o.status == OfferStatus.conflict)
        .toList();

    if (eligible.isEmpty) {
      stderr.writeln(
          'No offers in conflict status found locally.\n'
          'Or pass --offer <id> --coordinator <npub|hex> to skip local lookup.');
      return 1;
    }

    if (offerIdArg != null) {
      final found = eligible.where((o) => o.id == offerIdArg).firstOrNull;
      if (found == null) {
        stderr.writeln(
            'Offer "$offerIdArg" not found or not in conflict status.');
        return 64;
      }
      offer = found;
    } else if (eligible.length > 1) {
      stderr.writeln('Multiple offers in conflict. Pass --offer <id>:');
      for (final o in eligible) {
        stderr.writeln(
            '  ${o.id}  status=${o.status.name}  '
            '${o.fiatAmount} ${o.fiatCurrency}');
      }
      return 64;
    } else {
      offer = eligible.first;
    }
  } finally {
    await store.close();
  }

  final secrets = await SecretsStore.loadOrCreate();
  final client = BitblikProtocolClient(
    secrets: secrets,
    relays: relays.isEmpty ? null : relays,
  );
  try {
    await client.init();
    return await _callOpenDisputeRpc(
        client, offer.id, offer.coordinatorPubkey,
        localOffer: offer);
  } finally {
    await client.dispose();
  }
}

Future<int> _callOpenDisputeRpc(
  BitblikProtocolClient client,
  String offerId,
  String coordinatorPubkey, {
  Offer? localOffer,
}) async {
  stdout.writeln('Opening dispute…');
  final response = await client.sendRequest(
    NostrRequest(
      method: kRpcOpenDispute,
      params: {'offer_id': offerId},
    ),
    coordinatorPubkey,
  );

  if (!response.isSuccess) {
    stderr.writeln(
        'Coordinator error: ${response.error?['message'] ?? response.error}');
    return 1;
  }

  if (localOffer != null) {
    final store = await OfferStore.open();
    try {
      await store.upsert(localOffer.copyWith(status: OfferStatus.dispute));
    } finally {
      await store.close();
    }
  } else {
    final store = await OfferStore.open();
    try {
      final stored = await store.get(offerId);
      if (stored != null) {
        await store.upsert(stored.copyWith(status: OfferStatus.dispute));
      }
    } finally {
      await store.close();
    }
  }

  stdout.writeln('Dispute opened. Contact the coordinator to resolve.');
  return 0;
}

// ---------------------------------------------------------------------------
// CLI command: `bitblik offer confirm-payment`
// ---------------------------------------------------------------------------

/// CLI command: `bitblik offer confirm-payment`.
///
/// Tells the coordinator the BLIK payment succeeded.
/// Fast path: `--offer <id> --coordinator <npub|hex>` skips local store.
/// Normal path: picks the single in-progress offer or requires `--offer <id>`.
Future<int> runOfferConfirmPayment(List<String> args) async {
  final parsed = _parseFlags(args);
  final offerIdArg = parsed['offer'];
  final coordinatorArg = parsed['coordinator'];
  final relays = _collectMultiFlag(args, '--relay');

  String? coordinatorPubkey;
  if (coordinatorArg != null) {
    try {
      coordinatorPubkey = _resolvePubkey(coordinatorArg);
    } on FormatException catch (e) {
      stderr.writeln('Invalid --coordinator: ${e.message}');
      return 64;
    }
  }

  // ---- Fast path ----
  if (offerIdArg != null && coordinatorPubkey != null) {
    final secrets = await SecretsStore.loadOrCreate();
    final client = BitblikProtocolClient(
      secrets: secrets,
      relays: relays.isEmpty ? null : relays,
    );
    try {
      await client.init();
      return await _callConfirmPaymentRpc(client, offerIdArg, coordinatorPubkey);
    } finally {
      await client.dispose();
    }
  }

  // ---- Normal path: load from local store ----
  final store = await OfferStore.open();
  final Offer offer;
  try {
    final all = await store.all();
    final active = all.where((o) => _isInProgress(o.status)).toList();

    if (active.isEmpty) {
      stderr.writeln(
          'No in-progress offers found locally.\n'
          'Or pass --offer <id> --coordinator <npub|hex> to skip local lookup.');
      return 1;
    }

    if (offerIdArg != null) {
      final found = active.where((o) => o.id == offerIdArg).firstOrNull;
      if (found == null) {
        stderr.writeln('Offer "$offerIdArg" not found or already finished.');
        return 64;
      }
      offer = found;
    } else if (active.length > 1) {
      stderr.writeln('Multiple in-progress offers. Pass --offer <id>:');
      for (final o in active) {
        stderr.writeln(
            '  ${o.id}  status=${o.status.name}  '
            '${o.fiatAmount} ${o.fiatCurrency}');
      }
      return 64;
    } else {
      offer = active.first;
    }
  } finally {
    await store.close();
  }

  final secrets = await SecretsStore.loadOrCreate();
  final client = BitblikProtocolClient(
    secrets: secrets,
    relays: relays.isEmpty ? null : relays,
  );
  try {
    await client.init();
    return await _callConfirmPaymentRpc(
        client, offer.id, offer.coordinatorPubkey, localOffer: offer);
  } finally {
    await client.dispose();
  }
}

Future<int> _callConfirmPaymentRpc(
  BitblikProtocolClient client,
  String offerId,
  String coordinatorPubkey, {
  Offer? localOffer,
}) async {
  stdout.writeln('Confirming payment…');
  final response = await client.sendRequest(
    NostrRequest(
      method: kRpcConfirmPayment,
      params: {'offer_id': offerId},
    ),
    coordinatorPubkey,
  );

  if (!response.isSuccess) {
    stderr.writeln(
        'Coordinator error: ${response.error?['message'] ?? response.error}');
    return 1;
  }

  // Persist status change locally.
  final toUpdate = localOffer;
  if (toUpdate != null) {
    final store = await OfferStore.open();
    try {
      await store.upsert(
          toUpdate.copyWith(status: OfferStatus.makerConfirmed));
    } finally {
      await store.close();
    }
  }
  // Fast path: no local offer — cannot update store (key is paymentHash, not coordinator UUID).

  stdout.writeln('Payment confirmed. Coordinator will settle the hold invoice.');
  return 0;
}

// ---------------------------------------------------------------------------
// CLI command: `bitblik offer sync`
// ---------------------------------------------------------------------------

/// CLI command: `bitblik offer sync`.
///
/// For each non-terminal local offer, queries the coordinator for that
/// specific offer and reconciles the local cached status.
Future<int> runOfferSync(List<String> args) async {
  final relays = _collectMultiFlag(args, '--relay');

  final store = await OfferStore.open();
  final List<Offer> localActive;
  try {
    final all = await store.all();
    localActive = all.where((o) => _isInProgress(o.status)).toList();
  } finally {
    await store.close();
  }

  if (localActive.isEmpty) {
    stdout.writeln('No active local offers to sync.');
    return 0;
  }

  final secrets = await SecretsStore.loadOrCreate();
  final client = BitblikProtocolClient(
    secrets: secrets,
    relays: relays.isEmpty ? null : relays,
  );

  var changed = 0;
  try {
    await client.init();

    for (final offer in localActive) {
      changed += await _syncOfferWithCoordinator(
        client,
        offer,
        verbose: true,
      );
    }
  } finally {
    await client.dispose();
  }

  stdout.writeln('Sync complete. $changed offer(s) updated.');
  return 0;
}

/// Silently syncs non-terminal local offers against each coordinator via
/// [kRpcGetOfferDetails]. Errors are printed to stderr but never throw.
Future<void> _syncActiveOffers(BitblikProtocolClient client) async {
  final store = await OfferStore.open();
  final List<Offer> localActive;
  try {
    final all = await store.all();
    localActive = all.where((o) => _isInProgress(o.status)).toList();
  } finally {
    await store.close();
  }

  if (localActive.isEmpty) return;

  for (final offer in localActive) {
    await _syncOfferWithCoordinator(client, offer, verbose: false);
  }
}

Future<int> _syncOfferWithCoordinator(
  BitblikProtocolClient client,
  Offer local, {
  required bool verbose,
}) async {
  final identifier = _syncIdentifier(local);
  final params = {
    if (_looksLikeUuid(local.id)) 'offer_id': local.id,
    if (!_looksLikeUuid(local.id) &&
        local.holdInvoicePaymentHash != null &&
        local.holdInvoicePaymentHash!.isNotEmpty)
      'payment_hash': local.holdInvoicePaymentHash!,
  };

  if (params.isEmpty) {
    if (verbose) {
      stderr.writeln('  $identifier: missing offer identifier for sync.');
    }
    return 0;
  }

  late final NostrResponse response;
  try {
    response = await client.sendRequest(
      NostrRequest(method: kRpcGetOfferDetails, params: params),
      local.coordinatorPubkey,
    );
  } catch (e) {
    stderr.writeln(
        'Sync: coordinator ${local.coordinatorPubkey.substring(0, 12)}… '
        'unreachable for $identifier: $e');
    return 0;
  }

  if (!response.isSuccess) {
    stderr.writeln(
        'Coordinator ${local.coordinatorPubkey.substring(0, 12)}… error for '
        '$identifier: ${response.error?['message'] ?? response.error}');
    return 0;
  }

  final result = response.result;
  if (result == null || result.isEmpty) {
    if (!_looksLikeUuid(local.id)) {
      if (verbose) {
        stdout.writeln('  $identifier: unchanged (${local.status.name})');
      }
      return 0;
    }
    return _persistSyncedOffer(
      local,
      remoteId: local.id,
      remoteStatus: OfferStatus.expired,
      reason: 'not found on coordinator',
      verbose: verbose,
    );
  }

  final remoteId = result['id']?.toString() ?? result['offer_id']?.toString();
  final remoteStatusStr = result['status']?.toString();
  if (remoteId == null || remoteStatusStr == null) {
    stderr.writeln(
        'Coordinator ${local.coordinatorPubkey.substring(0, 12)}… malformed '
        'response for $identifier.');
    return 0;
  }

  OfferStatus remoteStatus;
  try {
    remoteStatus = OfferStatus.values.byName(remoteStatusStr);
  } catch (_) {
    remoteStatus = OfferStatus.unknown;
  }

  return _persistSyncedOffer(
    local,
    remoteId: remoteId,
    remoteStatus: remoteStatus,
    reason: null,
    verbose: verbose,
  );
}

Future<int> _persistSyncedOffer(
  Offer local, {
  required String remoteId,
  required OfferStatus remoteStatus,
  required String? reason,
  required bool verbose,
}) async {
  if (local.id == remoteId && local.status == remoteStatus) {
    if (verbose) {
      stdout.writeln('  ${_syncIdentifier(local)}: unchanged (${remoteStatus.name})');
    }
    return 0;
  }

  final store = await OfferStore.open();
  try {
    await store.upsert(local.copyWith(id: remoteId, status: remoteStatus));
  } finally {
    await store.close();
  }

  if (verbose) {
    final suffix = reason == null ? '' : ' ($reason)';
    stdout.writeln(
        '  ${_syncIdentifier(local)}: ${local.status.name} → ${remoteStatus.name} '
        '(id: $remoteId)$suffix');
  }
  return 1;
}

String _syncIdentifier(Offer offer) {
  return _looksLikeUuid(offer.id)
      ? offer.id
      : (offer.holdInvoicePaymentHash ?? offer.id);
}

String _waitMessage(OfferStatus s) {
  switch (s) {
    case OfferStatus.created:
      return 'Waiting for hold invoice to be funded…';
    case OfferStatus.funded:
      return 'Funded. Waiting for taker to reserve offer…';
    case OfferStatus.reserved:
      return 'Reserved. Waiting for taker to submit BLIK…';
    case OfferStatus.blikReceived:
    case OfferStatus.blikSentToMaker:
      return 'BLIK received.';
    default:
      return 'Status: ${s.name}';
  }
}

/// Parse `--key value` pairs. Boolean flags (e.g. `--json`) are stored with an
/// empty-string value.
Map<String, String> _parseFlags(List<String> args) {
  final out = <String, String>{};
  for (var i = 0; i < args.length; i++) {
    final a = args[i];
    if (!a.startsWith('--')) continue;
    final key = a.substring(2);
    final hasValue = i + 1 < args.length && !args[i + 1].startsWith('--');
    if (hasValue) {
      out[key] = args[i + 1];
      i++;
    } else {
      out[key] = '';
    }
  }
  return out;
}

/// Repeating `--flag value`. Returns every occurrence in order.
List<String> _collectMultiFlag(List<String> args, String flag) {
  final out = <String>[];
  for (var i = 0; i < args.length; i++) {
    if (args[i] == flag && i + 1 < args.length) {
      out.add(args[i + 1]);
      i++;
    }
  }
  return out;
}

/// Accept either 64-char hex pubkey or `npub1...` bech32. Returns hex.
String _resolvePubkey(String input) {
  if (input.startsWith('npub1')) {
    final hex = Nip19.decode(input);
    if (hex.isEmpty) {
      throw const FormatException('npub failed to decode');
    }
    return hex;
  }
  if (input.length != 64 ||
      !RegExp(r'^[0-9a-fA-F]+$').hasMatch(input)) {
    throw const FormatException(
        'expected 64-char hex pubkey or npub1 bech32');
  }
  return input.toLowerCase();
}

void _printOfferReceipt(Map<String, dynamic> result) {
  String? get(String key) => result[key]?.toString();
  stdout.writeln('Offer created.');
  stdout.writeln('  Payment hash : ${get('paymentHash')}');
  stdout.writeln('  Fiat         : ${get('fiatAmount')} ${get('fiatCurrency')}');
  stdout.writeln('  Amount sats  : ${get('amountSats')}');
  stdout.writeln('  Maker fees   : ${get('makerFees')} sats');
  stdout.writeln('  Total to pay : ${get('totalAmountSats')} sats');
  stdout.writeln('  Rate         : ${get('rate')} PLN/BTC');
  stdout.writeln('');
  stdout.writeln('Hold invoice (pay this to fund the offer):');
  stdout.writeln(get('holdInvoice') ?? '');
}
