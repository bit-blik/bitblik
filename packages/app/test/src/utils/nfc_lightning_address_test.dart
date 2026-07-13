import 'dart:convert';
import 'dart:typed_data';

import 'package:bitblik/src/utils/nfc_lightning_address.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nfc_manager/ndef_record.dart';

void main() {
  group('normalizeLightningAddressPayload', () {
    test('accepts lightning scheme payload', () {
      expect(
        normalizeLightningAddressPayload('lightning:Alice@Example.com'),
        'alice@example.com',
      );
    });

    test('rejects non address payloads', () {
      expect(
        normalizeLightningAddressPayload('https://example.com/.well-known'),
        isNull,
      );
    });
  });

  group('extractLightningAddressFromNdefMessage', () {
    test('reads URI records with lightning prefix', () {
      final message = NdefMessage(
        records: [
          NdefRecord(
            typeNameFormat: TypeNameFormat.wellKnown,
            type: Uint8List.fromList(ascii.encode('U')),
            identifier: Uint8List(0),
            payload: Uint8List.fromList([
              0x00,
              ...utf8.encode('lightning:alice@example.com'),
            ]),
          ),
        ],
      );

      expect(
        extractLightningAddressFromNdefMessage(message),
        'alice@example.com',
      );
    });

    test('reads text records', () {
      final message = NdefMessage(
        records: [
          NdefRecord(
            typeNameFormat: TypeNameFormat.wellKnown,
            type: Uint8List.fromList(ascii.encode('T')),
            identifier: Uint8List(0),
            payload: Uint8List.fromList([
              0x02,
              ...ascii.encode('en'),
              ...utf8.encode('lightning:bob@example.com'),
            ]),
          ),
        ],
      );

      expect(
        extractLightningAddressFromNdefMessage(message),
        'bob@example.com',
      );
    });
  });
}
