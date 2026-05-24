import 'dart:convert';
import 'dart:io';

import 'package:bitblik_cli/src/offer_commands.dart';
import 'package:bitblik_cli/src/protocol_client.dart';
import 'package:bitblik_cli/src/secrets_store.dart';
import 'package:bitblik_core/core.dart';

Future<void> main(List<String> args) async {
  if (args.isEmpty || args.contains('--help') || args.contains('-h')) {
    _printHelp();
    return;
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'create') {
    exitCode = await runOfferCreate(args.sublist(2));
    return;
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'list') {
    exitCode = await runOfferList(args.sublist(2));
    return;
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'get-blik') {
    exitCode = await runOfferGetBlik(args.sublist(2));
    return;
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'confirm-payment') {
    exitCode = await runOfferConfirmPayment(args.sublist(2));
    return;
  }

  if (args.length >= 2 && args[0] == 'offer' && args[1] == 'sync') {
    exitCode = await runOfferSync(args.sublist(2));
    return;
  }

  if (args.length >= 2 && args[0] == 'coordinators' && args[1] == 'list') {
    final jsonOutput = args.contains('--json');
    final withHealth = args.contains('--health');
    final relays = _parseRelayArgs(args);

    final secrets = await SecretsStore.loadOrCreate();
    final client = BitblikProtocolClient(secrets: secrets, relays: relays);
    try {
      await client.init();
      var coordinators = await client.discoverCoordinators();

      if (withHealth && coordinators.isNotEmpty) {
        await client.checkCoordinatorHealth(coordinators);
        // Re-snapshot after probing: records were replaced in-memory via copyWith
        // and the pre-probe list still holds the old (responsive == null) objects.
        coordinators = client.coordinatorRegistry.all;
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
    } finally {
      await client.dispose();
    }
    return;
  }

  stderr.writeln('Unknown command: ${args.join(' ')}');
  _printHelp();
  exitCode = 64;
}

// ANSI helpers — no-op when stdout is not a terminal.
final _ansi = stdout.hasTerminal;
String _bold(String s)   => _ansi ? '\x1B[1m$s\x1B[0m' : s;
String _cmd(String s)    => _ansi ? '\x1B[1;36m$s\x1B[0m' : s;   // bold cyan
String _sub(String s)    => _ansi ? '\x1B[1;32m$s\x1B[0m' : s;   // bold green
String _param(String s)  => _ansi ? '\x1B[90m$s\x1B[0m' : s;     // gray
String _yellow(String s) => _ansi ? '\x1B[33m$s\x1B[0m' : s;
String _dim(String s)    => _ansi ? '\x1B[2m$s\x1B[0m' : s;

void _printHelp() {
  stdout.writeln('${_bold('BitBlik CLI')} ${_dim('—')} peer-to-peer BLIK/Lightning exchange');
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

  cmd('${_cmd('coordinators')} ${_sub('list')} ${p('[--health] [--json] [--relay <url>]')}', [
    'Discover coordinators broadcasting on Nostr.',
    '--health probes each coordinator for liveness.',
  ]);

  cmd(
    '${_cmd('offer')} ${_sub('create')} ${p('--fiat <amount> --coordinator <npub|hex>')}\n'
    '               ${p('[--currency PLN] [--json] [--relay <url>]')}',
    [
      'Create a maker offer. Prints the hold invoice to pay.',
      'Offer is saved locally; coordinator activates it after invoice is paid.',
    ],
  );

  cmd('${_cmd('offer')} ${_sub('list')} ${p('[--finished] [--json]')}', [
    'List locally stored offers. Active offers only by default.',
    '--finished includes cancelled/expired/completed offers.',
  ]);

  cmd('${_cmd('offer')} ${_sub('list')} ${p('--coordinator <npub|hex> [--currency PLN] [--json] [--relay <url>]')}', [
    'List live public offers fetched from relays for a given coordinator.',
  ]);

  cmd('${_cmd('offer')} ${_sub('sync')} ${p('[--relay <url>]')}', [
    'Refresh status of active local offers from each coordinator via RPC.',
    'Matched by payment hash; unmatched coordinator responses are ignored.',
  ]);

  cmd('${_cmd('offer')} ${_sub('get-blik')} ${p('[--offer <id>] [--coordinator <npub|hex>] [--no-wait] [--json] [--relay <url>]')}', [
    'Wait for a taker to submit a BLIK code, then retrieve it via RPC.',
    'Syncs local state first. Uses the single active local offer automatically;',
    '--offer required when multiple active offers exist.',
    '--no-wait: return immediately. Exit 0 = BLIK code in output.',
    '          Exit 2 = not ready yet (poll again later).',
  ]);

  cmd('${_cmd('offer')} ${_sub('confirm-payment')} ${p('[--offer <id>] [--coordinator <npub|hex>] [--relay <url>]')}', [
    'Confirm to the coordinator that the BLIK payment succeeded.',
    'Coordinator settles the hold invoice and pays the taker.',
    'Uses the single active local offer automatically; --offer required if multiple.',
  ]);

  stdout.writeln(_bold('Options:'));
  flag('--health', 'Probe each coordinator for liveness');
  flag('--finished', 'Include terminal offers in list output');
  flag('--json', 'Print JSON output');
  flag('--relay <url>', 'Override relay URL (repeatable)');
  flag('--fiat <amt>', 'Fiat amount for the offer');
  flag('--coordinator', 'Coordinator pubkey (hex or npub1...)');
  flag('--currency <c>', 'Fiat currency (default PLN)');
  flag('--offer <id>', 'Offer payment hash or coordinator UUID');
  flag('-h, --help', 'Show this help');
  stdout.writeln('');
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
    final versionStr =
        version == null || version.isEmpty ? '-' : version;
    final range = info == null
        ? '-'
        : '${info.minAmountSats}-${info.maxAmountSats}';
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
