import 'dart:async'; // Import async for Timer
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../i18n/gen/strings.g.dart'; // Import Slang's generated file

// Add LNURL validation function
Future<String?> validateLightningAddress(
  String address,
  Translations strings,
) async {
  if (!address.contains('@')) {
    return strings.lightningAddress.prompts.invalid;
  }

  final parts = address.split('@');
  final username = parts[0];
  final domain = parts[1];

  try {
    final lnurlpUrl = Uri.https(domain, '/.well-known/lnurlp/$username');
    final response = await http.get(lnurlpUrl);

    if (response.statusCode != 200) {
      return strings.lightningAddress.prompts.invalid;
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    if (data['status'] == 'ERROR') {
      return strings.lightningAddress.prompts.invalid;
    }

    if (data['tag'] != 'payRequest') {
      return strings.lightningAddress.prompts.invalid;
    }

    if (data['callback'] == null ||
        data['minSendable'] == null ||
        data['maxSendable'] == null) {
      return strings.lightningAddress.prompts.invalid;
    }

    return null; // Validation passed
  } catch (e) {
    return strings.lightningAddress.prompts.invalid;
  }
}
