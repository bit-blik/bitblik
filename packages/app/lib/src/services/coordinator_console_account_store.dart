import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

/// Persists coordinator signer references independently from NDK Flutter's
/// default account key, which may be used by the trader side of the app.
class CoordinatorConsoleAccountStore {
  static const storageKey = 'bitblik_coordinator_console_accounts_v1';

  final FlutterSecureStorage _storage;

  const CoordinatorConsoleAccountStore({
    FlutterSecureStorage storage = const FlutterSecureStorage(),
  }) : _storage = storage;

  Future<void> restore(Ndk ndk) async {
    final raw = await _storage.read(key: storageKey);
    if (raw == null || raw.isEmpty) return;

    final decoded = jsonDecode(raw);
    if (decoded is! Map) return;
    final data = Map<String, dynamic>.from(decoded);
    final accounts = data['accounts'];
    if (accounts is! List) return;

    for (final rawAccount in accounts.whereType<Map>()) {
      final account = Map<String, dynamic>.from(rawAccount);
      final pubkey = account['pubkey']?.toString().toLowerCase();
      final type = account['type']?.toString();
      if (pubkey == null ||
          pubkey.length != 64 ||
          ndk.accounts.hasAccount(pubkey)) {
        continue;
      }
      switch (type) {
        case 'nsec':
          final privateKey = account['private_key']?.toString().toLowerCase();
          if (privateKey == null ||
              !RegExp(r'^[0-9a-f]{64}$').hasMatch(privateKey)) {
            continue;
          }
          late final String derivedPubkey;
          try {
            derivedPubkey = ndk.config.eventSignerFactory.derivePublicKey(
              privateKey,
            );
          } catch (_) {
            continue;
          }
          if (derivedPubkey != pubkey) continue;
          ndk.accounts.loginPrivateKey(pubkey: pubkey, privkey: privateKey);
        case 'nip07':
          ndk.accounts.loginExternalSigner(
            signer: Nip07EventSigner(cachedPublicKey: pubkey),
          );
        case 'nip55':
          ndk.accounts.loginExternalSigner(
            signer: Nip55EventSigner(
              publicKey: pubkey,
              nip55Signer: Nip55Signer(package: account['package']?.toString()),
            ),
          );
      }
    }

    final activePubkey = data['active_pubkey']?.toString().toLowerCase();
    if (activePubkey != null && ndk.accounts.hasAccount(activePubkey)) {
      ndk.accounts.switchAccount(pubkey: activePubkey);
    }
  }

  Future<void> save(Ndk ndk) async {
    final accounts = <Map<String, dynamic>>[];
    for (final account in ndk.accounts.accounts.values) {
      final signer = account.signer;
      if (signer is Bip340EventSigner && signer.privateKey != null) {
        accounts.add({
          'type': 'nsec',
          'pubkey': account.pubkey,
          'private_key': signer.privateKey,
        });
      } else if (signer is Nip07EventSigner) {
        accounts.add({'type': 'nip07', 'pubkey': account.pubkey});
      } else if (signer is Nip55EventSigner) {
        accounts.add({
          'type': 'nip55',
          'pubkey': account.pubkey,
          'package': signer.nip55Signer.package,
        });
      }
    }

    if (accounts.isEmpty) {
      await _storage.delete(key: storageKey);
      return;
    }
    await _storage.write(
      key: storageKey,
      value: jsonEncode({
        'active_pubkey': ndk.accounts.getPublicKey(),
        'accounts': accounts,
      }),
    );
  }
}
