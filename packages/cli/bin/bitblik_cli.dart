import 'dart:convert';
import 'dart:io';

import 'package:bitblik_cli/src/models.dart';
import 'package:bitblik_cli/src/protocol_client.dart';

Future<void> main(List<String> args) async {
  if (args.isEmpty || args.contains('--help') || args.contains('-h')) {
    _printHelp();
    return;
  }

  if (args.length >= 2 && args[0] == 'coordinators' && args[1] == 'list') {
    final jsonOutput = args.contains('--json');
    final withHealth = args.contains('--health');
    final relays = _parseRelayArgs(args);

    final client = BitblikProtocolClient(relays: relays);
    try {
      await client.init();
      final coordinators = await client.discoverCoordinators();

      if (withHealth && coordinators.isNotEmpty) {
        await client.checkCoordinatorHealth(coordinators);
      }

      if (jsonOutput) {
        stdout.writeln(
          const JsonEncoder.withIndent('  ')
              .convert(coordinators.map((c) => c.toJson()).toList()),
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

void _printHelp() {
  stdout.writeln('BitBlik CLI');
  stdout.writeln('');
  stdout.writeln('Usage:');
  stdout.writeln(
      '  bitblik coordinators list [--health] [--json] [--relay <url>]');
  stdout.writeln('');
  stdout.writeln('Options:');
  stdout.writeln(
      '  --health       Probe each coordinator with get_info over Nostr');
  stdout.writeln('  --json         Print JSON output');
  stdout.writeln('  --relay <url>  Add relay URL (repeatable)');
  stdout.writeln('  -h, --help     Show this help message');
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

void _printCoordinatorTable(List<CoordinatorListItem> coordinators,
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
    final curr = c.info.currencies.isEmpty ? '-' : c.info.currencies.join(',');
    final fees =
        '${c.info.makerFee.toStringAsFixed(2)}/${c.info.takerFee.toStringAsFixed(2)}';
    final pub = c.pubkeyHex.length > 16
        ? '${c.pubkeyHex.substring(0, 8)}...${c.pubkeyHex.substring(c.pubkeyHex.length - 8)}'
        : c.pubkeyHex;
    final base =
        '${c.info.name} | $pub | $curr | ${c.info.minAmountSats}-${c.info.maxAmountSats} | $fees | ${c.info.version == null || c.info.version!.isEmpty ? '-' : c.info.version}';
    if (!showHealth) {
      stdout.writeln(base);
      continue;
    }

    final resp = c.responsive == null ? '?' : (c.responsive! ? 'up' : 'down');
    stdout.writeln('$base | $resp');
  }
}
