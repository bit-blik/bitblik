import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import 'package:ndk/shared/logger/logger.dart';

import '../utils/nfc_lightning_address.dart';

enum NfcScanStartResult { started, alreadyRunning, disabled, unsupported }

class NfcLnurlService {
  final _lightningAddressController = StreamController<String>.broadcast();

  Stream<String> get lightningAddresses => _lightningAddressController.stream;

  bool _sessionActive = false;
  String? _lastAddress;
  DateTime? _lastAddressAt;

  bool get supportsAutoForegroundScanning => !kIsWeb && Platform.isAndroid;

  bool get supportsManualScanning =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  Future<NfcScanStartResult> ensureForegroundScanning() async {
    if (!supportsAutoForegroundScanning) {
      return NfcScanStartResult.unsupported;
    }

    if (_sessionActive) {
      return NfcScanStartResult.alreadyRunning;
    }

    final availability = await _availability();
    if (availability != NfcAvailability.enabled) {
      return availability == NfcAvailability.disabled
          ? NfcScanStartResult.disabled
          : NfcScanStartResult.unsupported;
    }

    await _startSession(
      invalidateAfterFirstReadIos: false,
      stopAfterDiscovery: false,
    );
    return NfcScanStartResult.started;
  }

  Future<NfcScanStartResult> startManualScan() async {
    if (!supportsManualScanning) {
      return NfcScanStartResult.unsupported;
    }

    if (_sessionActive) {
      return NfcScanStartResult.alreadyRunning;
    }

    final availability = await _availability();
    if (availability != NfcAvailability.enabled) {
      return availability == NfcAvailability.disabled
          ? NfcScanStartResult.disabled
          : NfcScanStartResult.unsupported;
    }

    await _startSession(
      invalidateAfterFirstReadIos: true,
      stopAfterDiscovery: true,
    );
    return NfcScanStartResult.started;
  }

  Future<void> stopScanning() async {
    if (!_sessionActive || kIsWeb) return;

    try {
      await NfcManager.instance.stopSession();
    } catch (error) {
      Logger.log.w(
        () => '[NfcLnurlService] Failed to stop NFC session: $error',
      );
    } finally {
      _sessionActive = false;
    }
  }

  void dispose() {
    unawaited(stopScanning());
    _lightningAddressController.close();
  }

  Future<NfcAvailability> _availability() async {
    try {
      return await NfcManager.instance.checkAvailability();
    } catch (error) {
      Logger.log.w(
        () => '[NfcLnurlService] Failed checking NFC availability: $error',
      );
      return NfcAvailability.unsupported;
    }
  }

  Future<void> _startSession({
    required bool invalidateAfterFirstReadIos,
    required bool stopAfterDiscovery,
  }) async {
    _sessionActive = true;

    try {
      await NfcManager.instance.startSession(
        pollingOptions: const {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
          NfcPollingOption.iso18092,
        },
        alertMessageIos: 'Hold your iPhone near the NFC tag',
        invalidateAfterFirstReadIos: invalidateAfterFirstReadIos,
        onSessionErrorIos: (error) {
          _sessionActive = false;
          Logger.log.w(
            () => '[NfcLnurlService] iOS NFC session error: ${error.message}',
          );
        },
        onDiscovered: (tag) async {
          await _handleTag(tag, stopAfterDiscovery: stopAfterDiscovery);
        },
      );
    } catch (error) {
      _sessionActive = false;
      rethrow;
    }
  }

  Future<void> _handleTag(
    NfcTag tag, {
    required bool stopAfterDiscovery,
  }) async {
    try {
      final ndef = Ndef.from(tag);
      final message = ndef?.cachedMessage ?? await ndef?.read();
      if (message == null) {
        return;
      }

      final address = extractLightningAddressFromNdefMessage(message);
      if (address != null && !_isDuplicate(address)) {
        _lightningAddressController.add(address);
      }
    } catch (error) {
      Logger.log.w(() => '[NfcLnurlService] Failed reading NFC tag: $error');
    } finally {
      if (stopAfterDiscovery) {
        await stopScanning();
      }
    }
  }

  bool _isDuplicate(String address) {
    final now = DateTime.now();
    final lastAddress = _lastAddress;
    final lastAddressAt = _lastAddressAt;
    _lastAddress = address;
    _lastAddressAt = now;

    return lastAddress == address &&
        lastAddressAt != null &&
        now.difference(lastAddressAt) < const Duration(seconds: 5);
  }
}
