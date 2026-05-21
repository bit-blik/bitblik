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
Future<int> runOfferGetBlik(List<String> args) async {
  final parsed = _parseFlags(args);
  final offerIdArg = parsed['offer'];
  final coordinatorArg = parsed['coordinator'];
  final relays = _collectMultiFlag(args, '--relay');

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
      return await _callGetBlikRpc(client, offerIdArg, coordinatorPubkey);
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
        client, currentOffer.id, offer.coordinatorPubkey, localOffer: currentOffer);
  } finally {
    await client.dispose();
  }
}

Future<int> _callGetBlikRpc(
  BitblikProtocolClient client,
  String offerId,
  String coordinatorPubkey, {
  Offer? localOffer,
}) async {
  stdout.writeln('Requesting BLIK code…');
  final response = await client.sendRequest(
    NostrRequest(
      method: kRpcGetBlik,
      params: {'offer_id': offerId},
    ),
    coordinatorPubkey,
  );

  if (!response.isSuccess) {
    stderr.writeln(
        'Coordinator error: ${response.error?['message'] ?? response.error}');
    return 1;
  }

  final result = response.result!;
  final blikCode =
      result['blik_code']?.toString() ?? result['blikCode']?.toString();

  if (blikCode != null) {
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
/// For each unique coordinator in non-terminal local offers, calls
/// [kRpcGetMyActiveOffer] and upserts the returned status + UUID.
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

  // Group by coordinator so we make one RPC call per coordinator.
  final byCoordinator = <String, List<Offer>>{};
  for (final o in localActive) {
    (byCoordinator[o.coordinatorPubkey] ??= []).add(o);
  }

  final secrets = await SecretsStore.loadOrCreate();
  final client = BitblikProtocolClient(
    secrets: secrets,
    relays: relays.isEmpty ? null : relays,
  );

  var changed = 0;
  try {
    await client.init();

    for (final entry in byCoordinator.entries) {
      final coordinatorPubkey = entry.key;
      final offers = entry.value;

      final response = await client.sendRequest(
        const NostrRequest(method: kRpcGetMyActiveOffer, params: {}),
        coordinatorPubkey,
      );

      if (!response.isSuccess) {
        stderr.writeln(
            'Coordinator ${coordinatorPubkey.substring(0, 12)}… error: '
            '${response.error?['message'] ?? response.error}');
        continue;
      }

      final result = response.result;
      if (result == null || result.isEmpty) {
        stdout.writeln(
            'Coordinator ${coordinatorPubkey.substring(0, 12)}…: no active offer.');
        continue;
      }

      final remoteId =
          result['id']?.toString() ?? result['offer_id']?.toString();
      final remoteStatusStr = result['status']?.toString();
      final remoteHash = result['hold_invoice_payment_hash']?.toString() ??
          result['paymentHash']?.toString();

      if (remoteId == null || remoteStatusStr == null) {
        stderr.writeln(
            'Coordinator ${coordinatorPubkey.substring(0, 12)}…: malformed response.');
        continue;
      }

      // Match by payment hash only — UUID alone is unsafe (coordinator may
      // return a stale/different offer if no funded offer exists yet).
      if (remoteHash == null) {
        stderr.writeln(
            'Coordinator ${coordinatorPubkey.substring(0, 12)}…: '
            'response missing payment hash, skipping.');
        continue;
      }
      final local = offers
          .where((o) => o.holdInvoicePaymentHash == remoteHash)
          .firstOrNull;

      if (local == null) {
        // Remote offer doesn't match any local record — ignore.
        continue;
      }

      OfferStatus status;
      try {
        status = OfferStatus.values.byName(remoteStatusStr);
      } catch (_) {
        status = OfferStatus.unknown;
      }

      if (local.id == remoteId && local.status == status) {
        stdout.writeln('  ${local.holdInvoicePaymentHash}: unchanged (${status.name})');
        continue;
      }

      final prevStatus = local.status;
      // Store key (paymentHash) never changes — just upsert with updated id+status.
      final s2 = await OfferStore.open();
      try {
        await s2.upsert(local.copyWith(id: remoteId, status: status));
      } finally {
        await s2.close();
      }

      stdout.writeln(
          '  ${local.holdInvoicePaymentHash}: ${prevStatus.name} → ${status.name} (id: $remoteId)');
      changed++;
    }
  } finally {
    await client.dispose();
  }

  stdout.writeln('Sync complete. $changed offer(s) updated.');
  return 0;
}

/// Silently syncs non-terminal local offers against each coordinator via
/// [kRpcGetMyActiveOffer]. Errors are printed to stderr but never throw.
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

  final byCoordinator = <String, List<Offer>>{};
  for (final o in localActive) {
    (byCoordinator[o.coordinatorPubkey] ??= []).add(o);
  }

  for (final entry in byCoordinator.entries) {
    final coordinatorPubkey = entry.key;
    final offers = entry.value;

    NostrResponse response;
    try {
      response = await client.sendRequest(
        const NostrRequest(method: kRpcGetMyActiveOffer, params: {}),
        coordinatorPubkey,
      );
    } catch (e) {
      stderr.writeln('Sync: coordinator ${coordinatorPubkey.substring(0, 12)}… unreachable: $e');
      continue;
    }

    if (!response.isSuccess || response.result == null || response.result!.isEmpty) {
      continue;
    }

    final result = response.result!;
    final remoteId = result['id']?.toString() ?? result['offer_id']?.toString();
    final remoteStatusStr = result['status']?.toString();
    final remoteHash = result['hold_invoice_payment_hash']?.toString() ??
        result['paymentHash']?.toString();

    if (remoteId == null || remoteStatusStr == null) continue;

    if (remoteHash == null) continue;
    final local = offers
        .where((o) => o.holdInvoicePaymentHash == remoteHash)
        .firstOrNull;
    if (local == null) continue;

    OfferStatus status;
    try {
      status = OfferStatus.values.byName(remoteStatusStr);
    } catch (_) {
      status = OfferStatus.unknown;
    }

    if (local.id == remoteId && local.status == status) continue;

    // Store key (paymentHash) never changes — just upsert.
    final s2 = await OfferStore.open();
    try {
      await s2.upsert(local.copyWith(id: remoteId, status: status));
    } finally {
      await s2.close();
    }
  }
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
