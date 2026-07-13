import 'dart:convert';
import 'dart:typed_data';

import 'package:nfc_manager/ndef_record.dart';

String? extractLightningAddressFromNdefMessage(NdefMessage message) {
  for (final record in message.records) {
    final candidate = extractLightningAddressFromNdefRecord(record);
    if (candidate != null) {
      return candidate;
    }
  }

  return null;
}

String? extractLightningAddressFromNdefRecord(NdefRecord record) {
  final type = ascii.decode(record.type, allowInvalid: true);

  if (record.typeNameFormat == TypeNameFormat.wellKnown) {
    if (type == 'U') {
      return normalizeLightningAddressPayload(
        _decodeUriPayload(record.payload),
      );
    }

    if (type == 'T') {
      return normalizeLightningAddressPayload(
        _decodeTextPayload(record.payload),
      );
    }
  }

  if (record.typeNameFormat == TypeNameFormat.absoluteUri ||
      record.typeNameFormat == TypeNameFormat.media ||
      record.typeNameFormat == TypeNameFormat.external ||
      record.typeNameFormat == TypeNameFormat.unknown) {
    return normalizeLightningAddressPayload(
      utf8.decode(record.payload, allowMalformed: true),
    );
  }

  return null;
}

String? normalizeLightningAddressPayload(String? raw) {
  if (raw == null) return null;

  var value = raw.trim();
  if (value.isEmpty) return null;

  final lowerValue = value.toLowerCase();
  if (lowerValue.startsWith('lightning:')) {
    value = value.substring('lightning:'.length).trim();
  }

  if (value.startsWith('//')) {
    value = value.substring(2).trim();
  }

  if (value.startsWith('/')) {
    return null;
  }

  final queryIndex = value.indexOf('?');
  if (queryIndex >= 0) {
    value = value.substring(0, queryIndex).trim();
  }

  final fragmentIndex = value.indexOf('#');
  if (fragmentIndex >= 0) {
    value = value.substring(0, fragmentIndex).trim();
  }

  if (!RegExp(
    r"^[A-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Z0-9-]+(?:\.[A-Z0-9-]+)+$",
    caseSensitive: false,
  ).hasMatch(value)) {
    return null;
  }

  return value.toLowerCase();
}

String _decodeUriPayload(Uint8List payload) {
  if (payload.isEmpty) return '';

  const prefixes = <String>[
    '',
    'http://www.',
    'https://www.',
    'http://',
    'https://',
    'tel:',
    'mailto:',
    'ftp://anonymous:anonymous@',
    'ftp://ftp.',
    'ftps://',
    'sftp://',
    'smb://',
    'nfs://',
    'ftp://',
    'dav://',
    'news:',
    'telnet://',
    'imap:',
    'rtsp://',
    'urn:',
    'pop:',
    'sip:',
    'sips:',
    'tftp:',
    'btspp://',
    'btl2cap://',
    'btgoep://',
    'tcpobex://',
    'irdaobex://',
    'file://',
    'urn:epc:id:',
    'urn:epc:tag:',
    'urn:epc:pat:',
    'urn:epc:raw:',
    'urn:epc:',
    'urn:nfc:',
  ];

  final prefixIndex = payload.first;
  final prefix =
      prefixIndex < prefixes.length ? prefixes[prefixIndex] : prefixes.first;
  final remainder = utf8.decode(payload.sublist(1), allowMalformed: true);
  return '$prefix$remainder';
}

String _decodeTextPayload(Uint8List payload) {
  if (payload.isEmpty) return '';

  final status = payload.first;
  final languageCodeLength = status & 0x3F;
  if (payload.length <= languageCodeLength + 1) {
    return '';
  }

  final textBytes = payload.sublist(languageCodeLength + 1);
  final usesUtf16 = (status & 0x80) != 0;
  if (!usesUtf16) {
    return utf8.decode(textBytes, allowMalformed: true);
  }

  if (textBytes.length < 2) {
    return '';
  }

  final codeUnits = <int>[];
  for (var index = 0; index + 1 < textBytes.length; index += 2) {
    codeUnits.add((textBytes[index] << 8) | textBytes[index + 1]);
  }
  return String.fromCharCodes(codeUnits);
}
