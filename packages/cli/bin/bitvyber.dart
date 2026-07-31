import 'dart:io';

import 'package:bitblik_cli/src/cli_app.dart';
import 'package:bitblik_core/core.dart';

/// Slovak cardless-ATM market binary (Bitvýber). Same commands as `bitblik`,
/// but discovers and filters coordinators + offers for the `sk` market (EUR,
/// 6-digit codes) and stores its state separately. Offers are bank-scoped: the
/// maker picks `--bank <tatrabanka|slsp|vub>` on `offer create`.
Future<void> main(List<String> args) async {
  final code = await runCli(args, kSlovakia);
  // Force termination: NDK keeps relay sockets and reconnect timers on the
  // event loop, so the process would otherwise hang after the command is done.
  // All persistence is awaited inside runCli before this point.
  exit(code);
}
