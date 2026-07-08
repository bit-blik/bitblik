import 'dart:io';

import 'package:bitblik_cli/src/cli_app.dart';
import 'package:bitblik_core/core.dart';

/// TWINT / Switzerland market binary. Same commands as `bitblik`, but discovers
/// and filters coordinators + offers for the TWINT payment system (Bittwint
/// discovery identity, CHF, 5-digit codes) and stores its state separately.
Future<void> main(List<String> args) async {
  final code = await runCli(args, kTwint);
  // Force termination: NDK keeps relay sockets and reconnect timers on the
  // event loop, so the process would otherwise hang after the command is done.
  // All persistence is awaited inside runCli before this point.
  exit(code);
}
