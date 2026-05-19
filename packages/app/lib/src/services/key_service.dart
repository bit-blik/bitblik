import 'dart:math'; // For Random.secure()
import 'dart:typed_data'; // For Uint8List

import 'package:bip340/bip340.dart' as bip340;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ndk/entities.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/logger/logger.dart';

import 'wallet_ids.dart';

// Helper function for hex encoding
String bytesToHex(List<int> bytes) {
  return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
}

// Helper function for hex decoding
Uint8List hexToBytes(String hex) {
  hex = hex.replaceAll(RegExp(r'\s+'), ''); // Remove spaces if any
  if (hex.length % 2 != 0) {
    hex = '0$hex'; // Pad with leading zero if odd length
  }
  final bytes = <int>[];
  for (int i = 0; i < hex.length; i += 2) {
    final hexPair = hex.substring(i, i + 2);
    bytes.add(int.parse(hexPair, radix: 16));
  }
  // Ensure the output is Uint8List, often required by crypto libs
  return Uint8List.fromList(bytes);
}

class KeyService {
  final _storage = const FlutterSecureStorage();
  final _privateKeyStorageKey = 'bitblik_private_key_hex';
  final _legacyLightningAddressStorageKey = 'bitblik_lightning_address';
  final _legacyNwcConnectionStringStorageKey = 'bitblik_nwc_connection_string';
  final _lnurlWalletName = 'Lightning Address';
  final _nwcWalletName = 'NWC Wallet';

  String? _publicKeyHex;
  String? _privateKeyHex; // Store keys as hex strings
  Ndk? _ndk;
  bool _didMigrateLegacyWalletStorage = false;

  // Public getter for the public key (hex format)
  String? get publicKeyHex => _publicKeyHex;

  // Public getter for the private key (hex format) - Use with caution!
  String? get privateKeyHex => _privateKeyHex;

  void attachNdk(Ndk ndk) {
    _ndk = ndk;
  }

  // Initializes the service: loads existing key or generates a new one.
  Future<void> init() async {
    if (_publicKeyHex != null) return; // Already initialized

    try {
      final storedPrivateKeyHex = await _storage.read(
        key: _privateKeyStorageKey,
      );

      if (storedPrivateKeyHex != null && storedPrivateKeyHex.isNotEmpty) {
        // Basic validation: check length (should be 64 hex chars for 32 bytes)
        if (storedPrivateKeyHex.length == 64 &&
            RegExp(r'^[0-9a-fA-F]+$').hasMatch(storedPrivateKeyHex)) {
          _privateKeyHex = storedPrivateKeyHex;
          // Derive public key from private key hex string
          _publicKeyHex = bip340.getPublicKey(
            _privateKeyHex!,
          ); // Pass hex string
          Logger.log.i(
            () => '✅ Loaded existing key pair. Public key: $_publicKeyHex',
          );
        } else {
          Logger.log.w(
            () =>
                '⚠️ Stored private key hex is invalid ($storedPrivateKeyHex). Generating new key pair.',
          );
          await generateNewKeyPair();
        }
      } else {
        // Generate new key pair
        await generateNewKeyPair();
        Logger.log.i(
          () =>
              '🔑 Generated and stored new key pair. Public key: $_publicKeyHex',
        );
      }
    } catch (e) {
      Logger.log.e(() => '❌ Error initializing KeyService: $e');
      _publicKeyHex = null;
      _privateKeyHex = null;
      // Consider attempting to generate fresh keys on error?
      // await _generateAndStoreKeyPair();
    }
  }

  // Generates a new key pair and stores the private key
  Future<void> generateNewKeyPair() async {
    // Generate 32 random bytes for the private key
    final random = Random.secure();
    final privateKeyBytes = Uint8List.fromList(
      List<int>.generate(32, (_) => random.nextInt(256)),
    );

    // Convert bytes to hex for bip340 functions and storage
    _privateKeyHex = bytesToHex(privateKeyBytes);
    // Derive public key from the hex private key
    _publicKeyHex = bip340.getPublicKey(_privateKeyHex!);

    // Store the new private key securely
    await _storage.write(key: _privateKeyStorageKey, value: _privateKeyHex);
  }

  // Saves a provided private key, replacing the existing one.
  Future<void> savePrivateKey(String privateKeyHex) async {
    // Basic validation
    if (privateKeyHex.length != 64 ||
        !RegExp(r'^[0-9a-fA-F]+$').hasMatch(privateKeyHex)) {
      throw ArgumentError(
        'Invalid private key format. It must be a 64-character hex string.',
      );
    }

    // Update the in-memory keys
    _privateKeyHex = privateKeyHex;
    _publicKeyHex = bip340.getPublicKey(_privateKeyHex!);

    // Store the new private key securely, overwriting the old one
    await _storage.write(key: _privateKeyStorageKey, value: _privateKeyHex);
    Logger.log.i(
      () => '✅ Restored and saved new key pair. Public key: $_publicKeyHex',
    );
  }

  // Optional: Method to delete keys (for testing or user request)
  Future<void> deleteKeys() async {
    await _storage.delete(key: _privateKeyStorageKey);
    _publicKeyHex = null;
    _privateKeyHex = null;
    Logger.log.i(() => '🔑 Deleted stored key pair.');
    await _storage.delete(key: _legacyLightningAddressStorageKey);
    await _storage.delete(key: _legacyNwcConnectionStringStorageKey);

    if (_ndk != null) {
      try {
        await _ndk!.wallets.removeWallet(kLnurlWalletId);
      } catch (_) {}
      try {
        await _ndk!.wallets.removeWallet(kNwcWalletId);
      } catch (_) {}
    }

    Logger.log.i(() => '🧹 Deleted legacy wallet storage keys.');
  }

  // --- Lightning Address Methods ---

  // Saves the Lightning Address in wallet storage (LNURL wallet)
  Future<void> saveLightningAddress(String address) async {
    try {
      final normalizedAddress = address.trim();

      if (_ndk == null) {
        await _storage.write(
          key: _legacyLightningAddressStorageKey,
          value: normalizedAddress,
        );
        Logger.log.w(
          () =>
              '⚠️ NDK not attached yet. Stored Lightning Address in legacy storage.',
        );
        return;
      }

      if (normalizedAddress.isEmpty) {
        try {
          await _ndk!.wallets.removeWallet(kLnurlWalletId);
        } catch (_) {}
        await _storage.delete(key: _legacyLightningAddressStorageKey);
        Logger.log.i(() => '⚡️ Removed LNURL wallet for Lightning Address.');
        return;
      }

      final lnurlWallet = _ndk!.wallets.createWallet(
        id: kLnurlWalletId,
        name: _lnurlWalletName,
        type: WalletType.LNURL,
        supportedUnits: {'sat'},
        metadata: {'identifier': normalizedAddress},
      );

      await _ndk!.wallets.addWallet(lnurlWallet);
      // _ndk!.wallets.setDefaultWallet(kLnurlWalletId);

      await _storage.delete(key: _legacyLightningAddressStorageKey);
      Logger.log.i(
        () => '⚡️ Saved Lightning Address in LNURL wallet and set as default.',
      );
    } catch (e) {
      Logger.log.e(() => '❌ Error saving Lightning Address: $e');
      rethrow; // Allow calling code to handle error
    }
  }

  // Retrieves the Lightning Address from default wallet
  Future<String?> getLightningAddress() async {
    try {
      if (_ndk != null) {
        final defaultWallet = _ndk!.wallets.defaultWalletForReceiving;
        final identifierFromDefault = _identifierFromWallet(defaultWallet);
        if (identifierFromDefault != null) {
          Logger.log.i(
            () => '⚡️ Retrieved Lightning Address from default wallet.',
          );
          return identifierFromDefault;
        }

        final wallets = _ndk!.wallets.getWalletsForUnit('sat');
        for (final wallet in wallets) {
          if (wallet.id == kLnurlWalletId) {
            final identifierFromLnurlWallet = _identifierFromWallet(wallet);
            if (identifierFromLnurlWallet != null) {
              Logger.log.i(
                () =>
                    '⚡️ Retrieved Lightning Address from LNURL wallet fallback.',
              );
              return identifierFromLnurlWallet;
            }
          }
        }

        return null;
      }

      final legacyAddress = await _storage.read(
        key: _legacyLightningAddressStorageKey,
      );
      Logger.log.i(
        () =>
            '⚡️ NDK not attached yet. Returning legacy Lightning Address value.',
      );
      return legacyAddress;
    } catch (e) {
      Logger.log.e(() => '❌ Error retrieving Lightning Address: $e');
      return null; // Return null on error
    }
  }

  String? _identifierFromWallet(Wallet? wallet) {
    if (wallet?.type != WalletType.LNURL) {
      return null;
    }

    final identifier = wallet?.metadata['identifier'];
    if (identifier is String && identifier.isNotEmpty) {
      return identifier;
    }

    return null;
  }

  Future<void> migrateLegacyWalletStorage() async {
    if (_didMigrateLegacyWalletStorage || _ndk == null) {
      return;
    }

    _didMigrateLegacyWalletStorage = true;

    await _migrateLegacyLnurlWallet();
    await _migrateLegacyNwcWallet();
  }

  Future<void> _migrateLegacyNwcWallet() async {
    try {
      final nwcUrl = await _storage.read(
        key: _legacyNwcConnectionStringStorageKey,
      );
      if (nwcUrl == null || nwcUrl.trim().isEmpty) {
        return;
      }

      final nwcWallet = _ndk!.wallets.createWallet(
        id: kNwcWalletId,
        name: _nwcWalletName,
        type: WalletType.NWC,
        supportedUnits: {'sat'},
        metadata: {'nwcUrl': nwcUrl.trim()},
      );

      await _ndk!.wallets.addWallet(nwcWallet);
      await _storage.delete(key: _legacyNwcConnectionStringStorageKey);
      Logger.log.i(() => '✅ Migrated legacy NWC connection to wallet storage.');
    } catch (e) {
      Logger.log.w(() => '⚠️ Failed migrating legacy NWC wallet: $e');
    }
  }

  Future<void> _migrateLegacyLnurlWallet() async {
    try {
      final lightningAddress = await _storage.read(
        key: _legacyLightningAddressStorageKey,
      );
      if (lightningAddress == null || lightningAddress.trim().isEmpty) {
        return;
      }

      final lnurlWallet = _ndk!.wallets.createWallet(
        id: kLnurlWalletId,
        name: _lnurlWalletName,
        type: WalletType.LNURL,
        supportedUnits: {'sat'},
        metadata: {'identifier': lightningAddress.trim()},
      );

      await _ndk!.wallets.addWallet(lnurlWallet);
      // _ndk!.wallets.setDefaultWallet(kLnurlWalletId);
      await _storage.delete(key: _legacyLightningAddressStorageKey);
      Logger.log.i(
        () => '✅ Migrated legacy Lightning Address to LNURL wallet storage.',
      );
    } catch (e) {
      Logger.log.w(() => '⚠️ Failed migrating legacy LNURL wallet: $e');
    }
  }
}
