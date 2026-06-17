import 'dart:io';

import 'package:bitblik_cli/src/cli_app.dart';
import 'package:bitblik_core/core.dart';

/// MB WAY / Portugal market binary. Same commands as `bitblik`, but discovers
/// and filters coordinators + offers for the MB WAY payment system (Bitway
/// discovery identity, EUR, 10-digit codes) and stores its state separately.
Future<void> main(List<String> args) async {
  final code = await runCli(args, kMbway);
  // Force termination: NDK keeps relay sockets and reconnect timers on the
  // event loop, so the process would otherwise hang after the command is done.
  // All persistence is awaited inside runCli before this point.
  exit(code);
}
