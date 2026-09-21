import 'dart:io';

import 'package:bitblik_cli/src/cli_app.dart';
import 'package:bitblik_core/core.dart';

/// Veksli / Slovakia cardless-ATM market binary.
Future<void> main(List<String> args) async {
  final code = await runCli(args, kSlovakia);
  // Force termination: NDK keeps relay sockets and reconnect timers alive.
  exit(code);
}
