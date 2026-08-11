import 'dart:convert';
import 'dart:io';

import 'package:bitblik_core/core.dart'
    show generateSecp256k1PrivateKeyHex, requireValidSecp256k1PrivateKeyHex;
import 'package:ndk/ndk.dart' show CashuSeed;

class BitblikSecrets {
  final String privateKeyHex;
  final String cashuSeedPhrase;

  const BitblikSecrets({
    required this.privateKeyHex,
    required this.cashuSeedPhrase,
  });
}

class SecretsStore {
  static const _envPrivateKey = 'BITBLIK_PRIVATE_KEY';
  static const _envCashuSeed = 'BITBLIK_CASHU_SEED';

  static File get _secretsFile {
    final home =
        Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
    if (home == null) throw StateError('Cannot determine home directory');
    return File('$home/.config/bitblik/secrets.json');
  }

  static Future<BitblikSecrets> loadOrCreate() async {
    final envKey = Platform.environment[_envPrivateKey];
    final envSeed = Platform.environment[_envCashuSeed];
    if (envKey != null && envSeed != null) {
      // Fail fast on a malformed/out-of-range key instead of signing with a
      // silently reduced one.
      return BitblikSecrets(
          privateKeyHex: requireValidSecp256k1PrivateKeyHex(envKey),
          cashuSeedPhrase: envSeed);
    }

    final file = _secretsFile;
    if (await file.exists()) {
      final raw = jsonDecode(await file.readAsString());
      return BitblikSecrets(
        privateKeyHex:
            requireValidSecp256k1PrivateKeyHex(raw['private_key'] as String),
        cashuSeedPhrase: raw['cashu_seed'] as String,
      );
    }

    final secrets = _generate();
    await _save(secrets);
    stderr.writeln('Generated new identity. Saved to ${file.path}');
    return secrets;
  }

  static BitblikSecrets _generate() {
    // OS-CSPRNG entropy, rejection-sampled into the valid secp256k1 scalar
    // range (see core's secure_keys.dart).
    final privateKey = generateSecp256k1PrivateKeyHex();
    final seed = CashuSeed.generateSeedPhrase();
    return BitblikSecrets(privateKeyHex: privateKey, cashuSeedPhrase: seed);
  }

  static Future<void> _save(BitblikSecrets secrets) async {
    final file = _secretsFile;
    await file.parent.create(recursive: true);
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert({
        'private_key': secrets.privateKeyHex,
        'cashu_seed': secrets.cashuSeedPhrase,
      }),
    );
    if (!Platform.isWindows) {
      await Process.run('chmod', ['600', file.path]);
    }
  }
}
