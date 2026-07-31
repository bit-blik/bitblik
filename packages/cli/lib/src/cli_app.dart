import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bitblik_core/core.dart';

import 'cli_context.dart';
import 'flow_cli.dart';
import 'offer_commands.dart';
import 'protocol_client.dart';
import 'secrets_store.dart';

/// Entry point shared by every market binary. [paymentSystem] selects the
/// market (`bitblik` → [kBlik], `bitway` → [kMbway]); it is published to
/// [activePaymentSystem] so all stores, discovery, and offer filtering scope to
/// that system. Returns the process exit code.
Future<int> runCli(List<String> args, PaymentSystem paymentSystem) async {
  activePaymentSystem = paymentSystem;
  final exe = paymentSystem.brandName.toLowerCase();

  if (args.isEmpty || args.contains('--help') || args.contains('-h')) {
    await _printHelp(paymentSystem);
    return 0;
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'create') {
    return runOfferCreate(args.sublist(2));
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'list') {
    return runOfferList(args.sublist(2));
  }

  // `get-code` is the current name; `get-blik` kept as a backward-compat alias.
  if (args.length >= 2 &&
      args[0] == 'offer' &&
      (args[1] == 'get-code' || args[1] == 'get-blik')) {
    return runOfferGetBlik(args.sublist(2));
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'cancel') {
    return runOfferCancel(args.sublist(2));
  }

  // `mark-code-invalid` is the current name; `mark-blik-invalid` kept as alias.
  if (args.length >= 2 &&
      args[0] == 'offer' &&
      (args[1] == 'mark-code-invalid' || args[1] == 'mark-blik-invalid')) {
    return runOfferMarkBlikInvalid(args.sublist(2));
  }

  if (args.length >= 2 &&
      args[0] == 'offer' &&
      (args[1] == 'open-dispute' || args[1] == 'dispute')) {
    return runOfferOpenDispute(args.sublist(2));
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'new-code') {
    return runOfferNewCode(args.sublist(2));
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'confirm-payment') {
    return runOfferConfirmPayment(args.sublist(2));
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'sync') {
    return runOfferSync(args.sublist(2));
  }

  if (args.length >= 2 && args[0] == 'coordinators' && args[1] == 'list') {
    final jsonOutput = args.contains('--json');
    final withHealth = args.contains('--health');
    final relays = _parseRelayArgs(args);

    final secrets = await SecretsStore.loadOrCreate();
    final client = BitblikProtocolClient(secrets: secrets, relays: relays);
    try {
      try {
        await client.init();
        var coordinators = _forThisMarket(await client.discoverCoordinators());

        if (withHealth && coordinators.isNotEmpty) {
          await client.checkCoordinatorHealth(coordinators);
          // Re-snapshot after probing: records were replaced in-memory via copyWith
          // and the pre-probe list still holds the old (responsive == null) objects.
          coordinators = _forThisMarket(client.coordinatorRegistry.all);
        }

        if (jsonOutput) {
          stdout.writeln(
            const JsonEncoder.withIndent('  ').convert(
              coordinators.map(_coordinatorToCliJson).toList(),
            ),
          );
        } else {
          _printCoordinatorTable(coordinators, showHealth: withHealth);
        }
      } on TimeoutException catch (e) {
        stderr.writeln(e.message ?? 'Relay request timed out.');
        return 1;
      }
    } finally {
      await client.dispose();
    }
    return 0;
  }

  stderr.writeln('Unknown command: ${args.join(' ')}');
  stderr.writeln('Run `$exe --help` for usage.');
  await _printHelp(paymentSystem);
  return 64;
}

// ANSI helpers — no-op when stdout is not a terminal.
final _ansi = stdout.hasTerminal;
String _bold(String s) => _ansi ? '\x1B[1m$s\x1B[0m' : s;
String _cmd(String s) => _ansi ? '\x1B[1;36m$s\x1B[0m' : s; // bold cyan
String _sub(String s) => _ansi ? '\x1B[1;32m$s\x1B[0m' : s; // bold green
String _param(String s) => _ansi ? '\x1B[90m$s\x1B[0m' : s; // gray
String _yellow(String s) => _ansi ? '\x1B[33m$s\x1B[0m' : s;
String _dim(String s) => _ansi ? '\x1B[2m$s\x1B[0m' : s;

Future<void> _printHelp(PaymentSystem ps) async {
  final title = '${ps.brandName} CLI';
  final code = ps.codeLabel;
  final cur = ps.currency;

  // The command set is derived from this market's flow, so only the maker
  // actions the flow actually offers are shown. Best-effort: if the flow can't
  // load, fall back to showing every command.
  MakerFlow? flow;
  try {
    flow = await MakerFlow.load();
  } catch (_) {
    flow = null;
  }
  final providesCode = ps.makerProvidesCodeAtOfferCreation;
  final showGetCode = flow?.supportsGetCode ?? true;
  final showMarkInvalid = flow?.supportsMarkInvalid ?? true;
  final showNewCode = flow?.newCodeEvent != null;

  stdout.writeln(
      '${_bold(title)} ${_dim('—')} peer-to-peer $code/Lightning exchange (${ps.flag} $cur)');
  stdout.writeln('');
  stdout.writeln(_bold('Commands:'));
  stdout.writeln('');

  void cmd(String usage, List<String> lines) {
    stdout.writeln('  $usage');
    for (final l in lines) {
      stdout.writeln('    $l');
    }
    stdout.writeln('');
  }

  void flag(String f, String desc) =>
      stdout.writeln('  ${_yellow(f.padRight(18))} $desc');

  final p = _param;

  cmd(
      '${_cmd('coordinators')} ${_sub('list')} ${p('[--health] [--json] [--relay <url>]')}',
      [
        'Discover coordinators broadcasting on Nostr.',
        '--health probes each coordinator for liveness.',
      ]);

  final createCode = providesCode ? '--code <$code> ' : '';
  cmd(
    '${_cmd('offer')} ${_sub('create')} ${p('--fiat <amount> --coordinator <npub|hex> $createCode')}\n'
    '               ${p('[--currency $cur] [--json] [--relay <url>]')}',
    [
      'Create a maker offer. Prints the hold invoice to pay.',
      if (providesCode)
        'Requires --code: you supply the $code code up front for the taker.',
      'Offer is saved locally; coordinator activates it after invoice is paid.',
    ],
  );

  cmd('${_cmd('offer')} ${_sub('list')} ${p('[--finished] [--json]')}', [
    'List locally stored offers. Active offers only by default.',
    '--finished includes cancelled/expired/completed offers.',
  ]);

  cmd(
      '${_cmd('offer')} ${_sub('list')} ${p('--coordinator <npub|hex> [--currency $cur] [--json] [--relay <url>]')}',
      [
        'List live public offers fetched from relays for a given coordinator.',
      ]);

  cmd(
      '${_cmd('offer')} ${_sub('cancel')} ${p('[--offer <id>] [--coordinator <npub|hex>] [--relay <url>]')}',
      [
        'Cancel an active offer. Coordinator voids the hold invoice.',
        'Uses the single cancellable local offer automatically; --offer required if multiple.',
      ]);

  if (showGetCode) {
    cmd(
        '${_cmd('offer')} ${_sub('get-code')} ${p('[--offer <id>] [--coordinator <npub|hex>] [--no-wait] [--json] [--relay <url>]')}',
        [
          'Wait for a taker to submit a $code code, then retrieve it via RPC.',
          'Syncs local state first. Uses the single active local offer automatically;',
          '--offer required when multiple active offers exist.',
          '--no-wait: return immediately. Exit 0 = $code code in output.',
          '          Exit 2 = not ready yet (poll again later).',
        ]);
  }

  if (showMarkInvalid) {
    cmd(
        '${_cmd('offer')} ${_sub('mark-code-invalid')} ${p('[--offer <id>] [--coordinator <npub|hex>] [--relay <url>]')}',
        [
          'Report that the received $code code was invalid / did not charge.',
          'Coordinator notifies the taker and relists the offer for a new taker.',
          'Use after get-code when the code fails at the bank terminal.',
        ]);
  }

  if (showNewCode) {
    cmd(
        '${_cmd('offer')} ${_sub('new-code')} ${p('--code <$code> [--offer <id>] [--coordinator <npub|hex>] [--relay <url>]')}',
        [
          'Supply a fresh $code code after the previous one expired.',
          'Re-lists the offer for takers.',
        ]);
  }

  cmd(
      '${_cmd('offer')} ${_sub('confirm-payment')} ${p('[--offer <id>] [--coordinator <npub|hex>] [--relay <url>]')}',
      [
        'Confirm to the coordinator that the $code payment succeeded.',
        'Coordinator settles the hold invoice and pays the taker.',
        'Uses the single active local offer automatically; --offer required if multiple.',
      ]);

  cmd(
      '${_cmd('offer')} ${_sub('dispute')} ${p('[--offer <id>] [--coordinator <npub|hex>] [--relay <url>]')}',
      [
        'Open a formal dispute; the coordinator mediates and contacts both peers.',
        if (showMarkInvalid)
          'For a taker conflict after you marked the $code invalid. (alias: open-dispute)'
        else
          'Use when the taker reported payment you did not receive.',
      ]);

  cmd('${_cmd('offer')} ${_sub('sync')} ${p('[--relay <url>]')}', [
    'Refresh status of active local offers from each coordinator via RPC.',
    'Matched by payment hash; unmatched coordinator responses are ignored.',
  ]);

  stdout.writeln(_bold('Options:'));
  flag('--health', 'Probe each coordinator for liveness');
  flag('--finished', 'Include terminal offers in list output');
  flag('--json', 'Print JSON output');
  flag('--relay <url>', 'Override relay URL (repeatable)');
  flag('--fiat <amt>', 'Fiat amount for the offer');
  flag('--coordinator', 'Coordinator pubkey (hex or npub1...)');
  flag('--currency <c>', 'Fiat currency (default $cur)');
  if (providesCode) flag('--code <code>', '$code code you provide to the taker');
  flag('--offer <id>', 'Offer payment hash or coordinator UUID');
  flag('-h, --help', 'Show this help');
  stdout.writeln('');
}

/// Keep only coordinators advertising the active market's payment system.
/// Discovery resolves this market's relays (via its project identity's NIP-65),
/// but a single relay can carry coordinators from multiple markets, so the
/// kind-15125 query returns all of them. Mirror the app, which filters
/// discovered records by [CoordinatorRecord.paymentSystem]. Records whose info
/// is not yet loaded are dropped — they can't be confirmed as this market's.
List<CoordinatorRecord> _forThisMarket(List<CoordinatorRecord> records) {
  final id = activePaymentSystem.id;
  return records.where((r) => r.paymentSystem == id).toList(growable: false);
}

List<String>? _parseRelayArgs(List<String> args) {
  final relays = <String>[];
  for (var i = 0; i < args.length; i++) {
    if (args[i] == '--relay' && i + 1 < args.length) {
      relays.add(args[i + 1]);
      i++;
    }
  }
  return relays.isEmpty ? null : relays;
}

Map<String, Object?> _coordinatorToCliJson(CoordinatorRecord r) {
  final info = r.info;
  return {
    'pubkey': r.pubkeyHex,
    if (info != null) ...info.toJson(),
    'last_seen': r.lastSeen?.toUtc().toIso8601String(),
    'first_seen_at': r.firstSeenAt?.toUtc().toIso8601String(),
    'enabled': r.enabled,
    'manual_added': r.manualAdded,
    'responsive': r.responsive,
  };
}

void _printCoordinatorTable(List<CoordinatorRecord> coordinators,
    {required bool showHealth}) {
  if (coordinators.isEmpty) {
    stdout.writeln('No coordinators discovered.');
    return;
  }

  final header = showHealth
      ? 'NAME | PUBKEY | CUR | MIN-MAX SATS | FEES M/T | VER | RESP'
      : 'NAME | PUBKEY | CUR | MIN-MAX SATS | FEES M/T | VER';
  stdout.writeln(header);

  for (final c in coordinators) {
    final info = c.info;
    final curr = info == null || info.currencies.isEmpty
        ? '-'
        : info.currencies.join(',');
    final fees = info == null
        ? '-'
        : '${info.makerFee.toStringAsFixed(2)}/${info.takerFee.toStringAsFixed(2)}';
    final version = info?.version;
    final versionStr = version == null || version.isEmpty ? '-' : version;
    final range =
        info == null ? '-' : '${info.minAmountSats}-${info.maxAmountSats}';
    final base =
        '${c.name} | ${c.pubkeyHex} | $curr | $range | $fees | $versionStr';
    if (!showHealth) {
      stdout.writeln(base);
      continue;
    }

    final resp = c.responsive == null ? '?' : (c.responsive! ? 'up' : 'down');
    stdout.writeln('$base | $resp');
  }
}
