import 'dart:convert';
import 'dart:io';

import 'package:bip340/bip340.dart' as bip340;
import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';

import 'cli_context.dart';
import 'flow_cli.dart';
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
  final currency = parsed['currency'] ?? activePaymentSystem.currency;
  final coordinatorArg = parsed['coordinator'];
  // Optional bank filter (bank-scoped markets): only show offers for this bank.
  final bankFilter = parsed['bank']?.trim();

  List<Offer> applyBankFilter(List<Offer> offers) => bankFilter == null ||
          bankFilter.isEmpty
      ? offers
      : offers.where((o) => o.bankId == bankFilter).toList();

  // ---- Local path (default) ----
  if (coordinatorArg == null) {
    final showAll = parsed.containsKey('finished');
    final flow = await MakerFlow.load();
    final store = await OfferStore.open();
    try {
      final all = await store.all();
      final offers = applyBankFilter(showAll
          ? all
          : all.where((o) => flow.isInProgress(MakerFlow.stateOf(o))).toList());
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
    final mismatch = await _ensureSameMarket(client, coordinatorPubkey);
    if (mismatch != null) return mismatch;
    final offers = applyBankFilter(await client.listOffers(
      fiatCurrency: currency,
      coordinatorPubkey: coordinatorPubkey,
    ));

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
  // Only show the BANK column when at least one offer is bank-scoped (SK), so
  // BLIK / MB WAY / TWINT listings stay unchanged.
  final showBank = offers.any((o) => bankForOffer(o) != null);
  stdout.writeln('ID | STATUS | FIAT | SATS |${showBank ? ' BANK |' : ''} '
      'CREATED | COORDINATOR');
  for (final o in offers) {
    final coord = o.coordinatorPubkey.length > 12
        ? '${o.coordinatorPubkey}'
        : o.coordinatorPubkey;
    final bankCol = showBank
        ? ' ${bankForOffer(o)?.label ?? '-'} |'
        : '';
    // statusRaw, not status.name: generic flows (TWINT) carry states with no
    // OfferStatus enum value that would otherwise print as "unknown".
    stdout.writeln(
      '${o.id} | ${o.statusRaw} | ${o.fiatAmount} ${o.fiatCurrency} | '
      '${o.amountSats} |$bankCol ${o.createdAt.toIso8601String()} | $coord',
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
  final exe = activePaymentSystem.brandName.toLowerCase();

  // Flows where the maker supplies the payment code up front (TWINT) require
  // it at creation; flows where the taker submits it (BLIK / MB WAY) reject it.
  final providesCode = activePaymentSystem.makerProvidesCodeAtOfferCreation;
  final codeArg = parsed['code'];

  // Bank-scoped markets (SK cardless ATM) require the maker to pick the bank
  // whose ATM they can reach; bank-agnostic markets have no --bank.
  final atmInstrument = activePaymentSystem.instrumentFor(OfferCategory.atm);
  final needsBank = atmInstrument?.hasBanks ?? false;

  if (fiatStr == null || coordinatorArg == null) {
    final codeUsage = providesCode ? '--code <${activePaymentSystem.codeLabel}> ' : '';
    final bankUsage = needsBank
        ? '--bank <${atmInstrument!.banks.map((b) => b.id).join('|')}> '
        : '';
    stderr.writeln(
        'usage: $exe offer create '
        '--fiat <amount> --coordinator <npub|hex> $codeUsage$bankUsage'
        '[--currency ${activePaymentSystem.currency}] [--json] [--relay <url>]');
    return 64;
  }

  final fiat = double.tryParse(fiatStr);
  if (fiat == null || fiat <= 0) {
    stderr.writeln('Invalid --fiat value: $fiatStr');
    return 64;
  }

  String? code;
  if (providesCode) {
    code = codeArg?.trim();
    if (code == null || code.isEmpty) {
      stderr.writeln(
          '${activePaymentSystem.brandName} requires the maker to provide the '
          '${activePaymentSystem.codeLabel} code up front. Pass --code <code>.');
      return 64;
    }
    final want = activePaymentSystem.codeLength;
    final digits = code.replaceAll(RegExp(r'\s'), '');
    if (!RegExp(r'^\d+$').hasMatch(digits) || digits.length != want) {
      stderr.writeln('Invalid --code: expected a $want-digit '
          '${activePaymentSystem.codeLabel} code.');
      return 64;
    }
    code = digits;
  } else if (codeArg != null) {
    stderr.writeln(
        '--code is not used by ${activePaymentSystem.brandName}; the taker '
        'submits the ${activePaymentSystem.codeLabel} code.');
    return 64;
  }

  // Resolve + validate the maker-chosen bank.
  String? bank;
  if (needsBank) {
    final banks = atmInstrument!.banks;
    final ids = banks.map((b) => b.id).join(', ');
    bank = parsed['bank']?.trim();
    if (bank == null || bank.isEmpty) {
      stderr.writeln('${activePaymentSystem.brandName} requires --bank '
          '(one of: $ids) — you withdraw at that bank\'s ATM.');
      return 64;
    }
    final bankSpec = atmInstrument.bankById(bank);
    if (bankSpec == null) {
      stderr.writeln('Unknown --bank "$bank" (one of: $ids).');
      return 64;
    }
    if (!atmInstrument.canDispenseAtmAmount(fiat, bank: bankSpec)) {
      stderr.writeln('Amount $fiat is not dispensable at ${bankSpec.label} '
          'ATMs (notes: ${atmInstrument.denominationsFor(bankSpec).join(', ')}).');
      return 64;
    }
  } else if (parsed['bank'] != null) {
    stderr.writeln('--bank is not used by ${activePaymentSystem.brandName}.');
    return 64;
  }

  final String coordinatorPubkey;
  try {
    coordinatorPubkey = _resolvePubkey(coordinatorArg);
  } on FormatException catch (e) {
    stderr.writeln('Invalid --coordinator: ${e.message}');
    return 64;
  }

  final flow = await MakerFlow.load();

  // Guard: reject if there's already an active offer for this coordinator.
  {
    final store = await OfferStore.open();
    try {
      final all = await store.all();
      final active = all
          .where((o) =>
              o.coordinatorPubkey == coordinatorPubkey &&
              flow.isInProgress(MakerFlow.stateOf(o)))
          .toList();
      if (active.isNotEmpty) {
        stderr.writeln(
            'Active offer already exists for this coordinator:\n'
            '  ${active.first.id}  status=${active.first.statusRaw}  '
            '${active.first.fiatAmount} ${active.first.fiatCurrency}\n'
            'Cancel or finish it first, or run: $exe offer cancel');
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
    final mismatch = await _ensureSameMarket(client, coordinatorPubkey);
    if (mismatch != null) return mismatch;
    final currency = parsed['currency'] ?? activePaymentSystem.currency;
    final response = await client.sendRequest(
      NostrRequest(
        method: kRpcInitiateOffer,
        params: {
          'fiat_amount': fiat,
          'fiat_currency': currency,
          // The maker's code (TWINT) rides the same `blik_code` param the app
          // and coordinator use across every payment system.
          if (code != null) 'blik_code': code,
          if (bank != null) 'bank': bank,
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
      fiatCurrency: result['fiatCurrency']?.toString() ?? currency,
      status: OfferStatus.created,
      createdAt: DateTime.now(),
      makerPubkey: bip340.getPublicKey(secrets.privateKeyHex),
      coordinatorPubkey: coordinatorPubkey,
      holdInvoicePaymentHash: result['paymentHash']?.toString(),
      holdInvoice: result['holdInvoice']?.toString(),
      category: category,
      paymentSystemId: activePaymentSystem.id,
      bankId: bank,
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

  final flow = await MakerFlow.load();
  if (!flow.supportsGetCode) {
    final code = activePaymentSystem.codeLabel;
    stderr.writeln(
        '${activePaymentSystem.brandName} makers do not fetch a $code code — '
        'the maker supplies it at offer creation and the taker enters it.\n'
        'Nothing to get. Wait for the taker, then: '
        '${activePaymentSystem.brandName.toLowerCase()} offer confirm-payment');
    return 64;
  }
  final exe = activePaymentSystem.brandName.toLowerCase();
  final code = activePaymentSystem.codeLabel;

  // ---- Fast path: offer id + coordinator supplied, skip local store ----
  if (offerIdArg != null && coordinatorPubkey != null) {
    final secrets = await SecretsStore.loadOrCreate();
    final client = BitblikProtocolClient(
      secrets: secrets,
      relays: relays.isEmpty ? null : relays,
    );
    try {
      await client.init();
      final mismatch = await _ensureSameMarket(client, coordinatorPubkey);
      if (mismatch != null) return mismatch;
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
      final active =
          all.where((o) => flow.canAwaitCode(MakerFlow.stateOf(o))).toList();

      if (active.isEmpty) {
        stderr.writeln(
            'No active offers found locally. '
            'Create one with: $exe offer create\n'
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
              '  ${o.id}  status=${o.statusRaw}  '
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

    bool codeReady(String state) => flow.makerCan(state, kRpcGetBlik) ||
        state == 'blikSentToMaker';

    if (!codeReady(MakerFlow.stateOf(offer))) {
      // --no-wait: don't block, return 2 so the caller can poll.
      if (noWait) {
        if (jsonOutput) {
          stdout.writeln(const JsonEncoder.withIndent('  ').convert({
            'ready': false,
            'status': offer.statusRaw,
            'offer_id': offer.id,
            'payment_hash': offer.holdInvoicePaymentHash,
          }));
        } else {
          stdout.writeln(
              'Not ready yet: ${flow.waitMessage(MakerFlow.stateOf(offer))}');
        }
        return 2;
      }

      stdout.writeln(
          'Offer ${offer.holdInvoicePaymentHash}: '
          '${flow.waitMessage(MakerFlow.stateOf(offer))} (Ctrl+C to abort)');

      final updates = client.watchOfferStatus(paymentHash: paymentHash);
      await for (final update in updates) {
        final state = update.status;
        stdout.writeln('  → ${flow.waitMessage(state)}');

        // Update id to coordinator UUID; store key (paymentHash) unchanged.
        currentOffer = currentOffer.copyWith(
            id: update.offerId,
            status: _statusEnum(state),
            statusRaw: state);
        final s2 = await OfferStore.open();
        try {
          await s2.upsert(currentOffer);
        } finally {
          await s2.close();
        }

        if (codeReady(state)) break;
        if (flow.isTerminal(state)) {
          stderr.writeln('Offer ended: $state. $code no longer available.');
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

/// Parse a wire/flow status string into an [OfferStatus]. Generic-flow states
/// with no enum value (e.g. `invalidTwint`) fall back to [OfferStatus.unknown];
/// the verbatim string is preserved separately in [Offer.statusRaw].
OfferStatus _statusEnum(String raw) {
  try {
    return OfferStatus.values.byName(raw);
  } catch (_) {
    return OfferStatus.unknown;
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
    final ps = activePaymentSystem;
    final where = ps.requiresCodeConfirmation ? 'your banking app' : 'the ATM';
    // Resolve validity (and bank name) per offer when we have it — SK banks
    // differ (Tatra 20 / SLSP 15 / VÚB 3 min); else the market default.
    final bank = localOffer != null ? bankForOffer(localOffer) : null;
    final mins = localOffer != null
        ? validityForOffer(localOffer).inMinutes
        : ps.instruments.values.first.validity.inMinutes;
    final atName = bank != null ? '${bank.label} ATM' : where;
    stdout.writeln('\n${ps.codeLabel} code : $blikCode');
    stdout.writeln(
        'Enter this code at $atName within $mins minute${mins == 1 ? '' : 's'}.');
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
      final mismatch = await _ensureSameMarket(client, coordinatorPubkey);
      if (mismatch != null) return mismatch;
      return await _callCancelOfferRpc(client, offerIdArg, coordinatorPubkey);
    } finally {
      await client.dispose();
    }
  }

  // ---- Normal path: load from local store ----
  final flow = await MakerFlow.load();
  final store = await OfferStore.open();
  final Offer offer;
  try {
    final all = await store.all();
    final cancellable =
        all.where((o) => _isCancellable(flow, MakerFlow.stateOf(o))).toList();

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
            '  ${o.id}  status=${o.statusRaw}  '
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
    // Resolve the coordinator's UUID + status by payment hash. Mirrors the
    // app: `get_offer_details` is scoped to the requester pubkey and returns
    // the offer (or {} if none), so no dedicated `get_my_active_offer` needed.
    final response = await client.sendRequest(
      NostrRequest(
        method: kRpcGetOfferDetails,
        params: {'payment_hash': paymentHash},
      ),
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
    final remoteStatusStr = result['status']?.toString() ?? offer.statusRaw;

    // Persist updated UUID + status before we do anything else.
    var updatedOffer = offer;
    if (remoteId != null) {
      updatedOffer = offer.copyWith(
          id: remoteId,
          status: _statusEnum(remoteStatusStr),
          statusRaw: remoteStatusStr);
      final s2 = await OfferStore.open();
      try {
        await s2.upsert(updatedOffer);
      } finally {
        await s2.close();
      }
      stdout.writeln(
          'Synced: ${offer.id} → id=$remoteId  status=$remoteStatusStr');
    }

    if (!_isCancellable(flow, remoteStatusStr)) {
      stderr.writeln(
          'Coordinator reports offer in "$remoteStatusStr" — cannot cancel.');
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

/// A maker may cancel from the flow's `cancel_offer` states, plus the local
/// pre-funding [MakerFlow.localCreated] state (no coordinator RPC yet).
bool _isCancellable(MakerFlow flow, String state) =>
    state == MakerFlow.localCreated ||
    flow.makerStatesFor(kRpcCancelOffer).contains(state);

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

  final flow = await MakerFlow.load();
  if (!flow.supportsMarkInvalid) {
    stderr.writeln(
        '${activePaymentSystem.brandName} has no maker "mark invalid" action; '
        'the maker supplies the ${activePaymentSystem.codeLabel} code.');
    return 64;
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
      final mismatch = await _ensureSameMarket(client, coordinatorPubkey);
      if (mismatch != null) return mismatch;
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
    // States from which the flow permits the maker's mark_blik_invalid action —
    // the coordinator is the final authority.
    final eligibleStates = flow.makerStatesFor(kRpcMarkBlikInvalid);
    final eligible = all
        .where((o) => eligibleStates.contains(MakerFlow.stateOf(o)))
        .toList();

    if (eligible.isEmpty) {
      stderr.writeln(
          'No offers in a state where the code can be marked invalid.\n'
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
            '  ${o.id}  status=${o.statusRaw}  '
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

/// CLI command: `bitblik offer open-dispute` (a.k.a. `dispute`).
///
/// Opens a formal dispute. The driving flow event depends on the payment
/// system: BLIK / MB WAY use `open_dispute` (after a taker conflict), TWINT uses
/// `start_dispute` (from `takerCharged`). The coordinator then mediates.
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

  final flow = await MakerFlow.load();
  final disputeEvent = flow.disputeEvent;
  if (disputeEvent == null) {
    stderr.writeln(
        '${activePaymentSystem.brandName} gives the maker no dispute action.');
    return 64;
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
      final mismatch = await _ensureSameMarket(client, coordinatorPubkey);
      if (mismatch != null) return mismatch;
      return await _callOpenDisputeRpc(
          client, offerIdArg, coordinatorPubkey, disputeEvent);
    } finally {
      await client.dispose();
    }
  }

  // ---- Normal path: load from local store ----
  final store = await OfferStore.open();
  final Offer offer;
  try {
    final all = await store.all();
    final eligibleStates = flow.makerStatesFor(disputeEvent);
    final eligible = all
        .where((o) => eligibleStates.contains(MakerFlow.stateOf(o)))
        .toList();

    if (eligible.isEmpty) {
      stderr.writeln(
          'No offers in a disputable status found locally.\n'
          'Or pass --offer <id> --coordinator <npub|hex> to skip local lookup.');
      return 1;
    }

    if (offerIdArg != null) {
      final found = eligible.where((o) => o.id == offerIdArg).firstOrNull;
      if (found == null) {
        stderr.writeln(
            'Offer "$offerIdArg" not found or not in a disputable status.');
        return 64;
      }
      offer = found;
    } else if (eligible.length > 1) {
      stderr.writeln('Multiple disputable offers. Pass --offer <id>:');
      for (final o in eligible) {
        stderr.writeln(
            '  ${o.id}  status=${o.statusRaw}  '
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
        client, offer.id, offer.coordinatorPubkey, disputeEvent,
        localOffer: offer);
  } finally {
    await client.dispose();
  }
}

Future<int> _callOpenDisputeRpc(
  BitblikProtocolClient client,
  String offerId,
  String coordinatorPubkey,
  String disputeEvent, {
  Offer? localOffer,
}) async {
  stdout.writeln('Opening dispute…');
  final response = await client.sendRequest(
    NostrRequest(
      method: disputeEvent,
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
      final mismatch = await _ensureSameMarket(client, coordinatorPubkey);
      if (mismatch != null) return mismatch;
      return await _callConfirmPaymentRpc(client, offerIdArg, coordinatorPubkey);
    } finally {
      await client.dispose();
    }
  }

  // ---- Normal path: load from local store ----
  final flow = await MakerFlow.load();
  final store = await OfferStore.open();
  final Offer offer;
  try {
    final all = await store.all();
    final eligibleStates = flow.makerStatesFor(kRpcConfirmPayment);
    final eligible = all
        .where((o) => eligibleStates.contains(MakerFlow.stateOf(o)))
        .toList();

    if (eligible.isEmpty) {
      stderr.writeln(
          'No offers in a state where payment can be confirmed locally.\n'
          'Or pass --offer <id> --coordinator <npub|hex> to skip local lookup.');
      return 1;
    }

    if (offerIdArg != null) {
      final found = eligible.where((o) => o.id == offerIdArg).firstOrNull;
      if (found == null) {
        stderr.writeln(
            'Offer "$offerIdArg" not found or not in a confirmable state.');
        return 64;
      }
      offer = found;
    } else if (eligible.length > 1) {
      stderr.writeln('Multiple confirmable offers. Pass --offer <id>:');
      for (final o in eligible) {
        stderr.writeln(
            '  ${o.id}  status=${o.statusRaw}  '
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
// CLI command: `bitblik offer new-code`
// ---------------------------------------------------------------------------

/// CLI command: `<brand> offer new-code --code <code>`.
///
/// Supplies a fresh maker code after the previous one expired — the flow's
/// `enter_new_twint` action, which re-lists the offer (TWINT only). Only
/// available for payment systems whose maker provides the code up front.
Future<int> runOfferNewCode(List<String> args) async {
  final parsed = _parseFlags(args);
  final offerIdArg = parsed['offer'];
  final coordinatorArg = parsed['coordinator'];
  final relays = _collectMultiFlag(args, '--relay');
  final exe = activePaymentSystem.brandName.toLowerCase();

  final flow = await MakerFlow.load();
  final event = flow.newCodeEvent;
  if (event == null) {
    stderr.writeln(
        '${activePaymentSystem.brandName} has no "new code" action.');
    return 64;
  }

  final want = activePaymentSystem.codeLength;
  final code = parsed['code']?.replaceAll(RegExp(r'\s'), '');
  if (code == null || code.isEmpty) {
    stderr.writeln('usage: $exe offer new-code --code <$want-digit code> '
        '[--offer <id>] [--coordinator <npub|hex>] [--relay <url>]');
    return 64;
  }
  if (!RegExp(r'^\d+$').hasMatch(code) || code.length != want) {
    stderr.writeln('Invalid --code: expected a $want-digit '
        '${activePaymentSystem.codeLabel} code.');
    return 64;
  }

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
      final mismatch = await _ensureSameMarket(client, coordinatorPubkey);
      if (mismatch != null) return mismatch;
      return await _callNewCodeRpc(client, event, offerIdArg, coordinatorPubkey,
          code: code);
    } finally {
      await client.dispose();
    }
  }

  // ---- Normal path: load from local store ----
  final store = await OfferStore.open();
  final Offer offer;
  try {
    final all = await store.all();
    final eligibleStates = flow.makerStatesFor(event);
    final eligible = all
        .where((o) => eligibleStates.contains(MakerFlow.stateOf(o)))
        .toList();

    if (eligible.isEmpty) {
      stderr.writeln(
          'No offers awaiting a new code locally.\n'
          'Or pass --offer <id> --coordinator <npub|hex> to skip local lookup.');
      return 1;
    }

    if (offerIdArg != null) {
      final found = eligible.where((o) => o.id == offerIdArg).firstOrNull;
      if (found == null) {
        stderr.writeln('Offer "$offerIdArg" not found or not awaiting a code.');
        return 64;
      }
      offer = found;
    } else if (eligible.length > 1) {
      stderr.writeln('Multiple eligible offers. Pass --offer <id>:');
      for (final o in eligible) {
        stderr.writeln(
            '  ${o.id}  status=${o.statusRaw}  '
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
    return await _callNewCodeRpc(
        client, event, offer.id, offer.coordinatorPubkey,
        code: code, localOffer: offer);
  } finally {
    await client.dispose();
  }
}

Future<int> _callNewCodeRpc(
  BitblikProtocolClient client,
  String event,
  String offerId,
  String coordinatorPubkey, {
  required String code,
  Offer? localOffer,
}) async {
  stdout.writeln('Submitting new ${activePaymentSystem.codeLabel} code…');
  final response = await client.sendRequest(
    NostrRequest(
      method: event,
      params: {'offer_id': offerId, 'blik_code': code},
    ),
    coordinatorPubkey,
  );

  if (!response.isSuccess) {
    stderr.writeln(
        'Coordinator error: ${response.error?['message'] ?? response.error}');
    return 1;
  }

  // Re-listed: the offer returns to the funded state.
  if (localOffer != null) {
    final store = await OfferStore.open();
    try {
      await store.upsert(localOffer.copyWith(
          status: OfferStatus.funded, statusRaw: 'funded'));
    } finally {
      await store.close();
    }
  }

  stdout.writeln('New code submitted. Offer re-listed for takers.');
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

  final flow = await MakerFlow.load();
  final store = await OfferStore.open();
  final List<Offer> localActive;
  try {
    final all = await store.all();
    localActive =
        all.where((o) => flow.isInProgress(MakerFlow.stateOf(o))).toList();
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
  final flow = await MakerFlow.load();
  final store = await OfferStore.open();
  final List<Offer> localActive;
  try {
    final all = await store.all();
    localActive =
        all.where((o) => flow.isInProgress(MakerFlow.stateOf(o))).toList();
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
        stdout.writeln('  $identifier: unchanged (${local.statusRaw})');
      }
      return 0;
    }
    return _persistSyncedOffer(
      local,
      remoteId: local.id,
      remoteStatusRaw: OfferStatus.expired.name,
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

  return _persistSyncedOffer(
    local,
    remoteId: remoteId,
    remoteStatusRaw: remoteStatusStr,
    reason: null,
    verbose: verbose,
  );
}

Future<int> _persistSyncedOffer(
  Offer local, {
  required String remoteId,
  required String remoteStatusRaw,
  required String? reason,
  required bool verbose,
}) async {
  if (local.id == remoteId && local.statusRaw == remoteStatusRaw) {
    if (verbose) {
      stdout.writeln('  ${_syncIdentifier(local)}: unchanged ($remoteStatusRaw)');
    }
    return 0;
  }

  final store = await OfferStore.open();
  try {
    await store.upsert(local.copyWith(
        id: remoteId,
        status: _statusEnum(remoteStatusRaw),
        statusRaw: remoteStatusRaw));
  } finally {
    await store.close();
  }

  if (verbose) {
    final suffix = reason == null ? '' : ' ($reason)';
    stdout.writeln(
        '  ${_syncIdentifier(local)}: ${local.statusRaw} → $remoteStatusRaw '
        '(id: $remoteId)$suffix');
  }
  return 1;
}

String _syncIdentifier(Offer offer) {
  return _looksLikeUuid(offer.id)
      ? offer.id
      : (offer.holdInvoicePaymentHash ?? offer.id);
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

/// Verify a coordinator serves this binary's payment system before sending it
/// any offer RPC. Returns null when OK; otherwise prints an error and returns
/// the exit code to use. A coordinator on a different market settles in a
/// different currency with different code rules, so cross-market RPCs are
/// refused rather than silently mishandled.
Future<int?> _ensureSameMarket(
  BitblikProtocolClient client,
  String coordinatorPubkey,
) async {
  final mine = activePaymentSystem;
  final theirId = await client.coordinatorPaymentSystemId(coordinatorPubkey);
  if (theirId == null) {
    stderr.writeln(
        'Could not verify coordinator payment system (offline or not '
        'advertising info). Refusing to proceed.');
    return 1;
  }
  if (theirId == mine.id) return null;
  final theirs = paymentSystemById(theirId);
  stderr.writeln(
      'Coordinator serves ${theirs.label} (${theirs.currency}), but this is the '
      '${mine.label} (${mine.currency}) client.\n'
      'Use the ${theirs.brandName.toLowerCase()} binary for this coordinator.');
  return 1;
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
  stdout.writeln('  Rate         : ${get('rate')} ${activePaymentSystem.currency}/BTC');
  stdout.writeln('');
  stdout.writeln('Hold invoice (pay this to fund the offer):');
  stdout.writeln(get('holdInvoice') ?? '');
}
