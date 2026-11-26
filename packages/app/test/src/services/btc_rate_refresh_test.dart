import 'dart:convert';

import 'package:bitblik/src/services/api_service_nostr.dart';
import 'package:bitblik/src/services/key_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:memory_cache/memory_cache.dart';

void main() {
  setUp(MemoryCache.instance.invalidate);
  tearDown(MemoryCache.instance.invalidate);

  test('a refreshed rate bypasses the five-minute cache', () async {
    var price = 70000.0;
    final client = MockClient((request) async {
      final body = switch (request.url.host) {
        'api.coingecko.com' => {
          'bitcoin': {'eur': price},
        },
        'api.yadio.io' => {'BTC': price},
        _ => {
          'EUR': {'last': price},
        },
      };
      return http.Response(jsonEncode(body), 200);
    });

    await http.runWithClient(() async {
      final api = ApiServiceNostr(KeyService());
      expect(await api.getBtcRate('EUR'), 70000);

      price = 71000;
      expect(await api.getBtcRate('EUR'), 70000, reason: 'still cached');
      expect(await api.getBtcRate('EUR', refresh: true), 71000);
      expect(await api.getBtcRate('EUR'), 71000, reason: 'cache updated');
    }, () => client);
  });
}
