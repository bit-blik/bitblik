import 'package:bitblik/src/flow/taker_receive_invoice.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('extracts BOLT11 invoices for every supported Bitcoin network', () {
    expect(extractBolt11Invoice('lnbc1mainnet'), 'lnbc1mainnet');
    expect(
      extractBolt11Invoice({'invoice': 'lightning:LNTB1TESTNET'}),
      'LNTB1TESTNET',
    );
    expect(
      extractBolt11Invoice({'payment_request': 'lnbcrt1regtest'}),
      'lnbcrt1regtest',
    );
    expect(extractBolt11Invoice('not-an-invoice'), isNull);
  });
}
