import 'package:bitblik_coordinator/src/services/bolt12_offer_parser.dart';
import 'package:test/test.dart';

void main() {
  const minimal =
      'lno1zcss9mk8y3wkklfvevcrszlmu23kfrxh49px20665dqwmn4p72pksese';
  const amount10Sats =
      'lno1pqpzwyq2p32x2um5ypmx2cm5dae8x93pqthvwfzadd7jejes8q9lhc4rvjxd022zv5l44g6qah82ru5rdpnpj';
  const testnet =
      'lno1qgsyxjtl6luzd9t3pr62xr7eemp6awnejusgf6gw45q75vcfqqqqqqq2p32x2um5ypmx2cm5dae8x93pqthvwfzadd7jejes8q9lhc4rvjxd022zv5l44g6qah82ru5rdpnpj';
  const fiat =
      'lno1qcp4256ypqpzwyq2p32x2um5ypmx2cm5dae8x93pqthvwfzadd7jejes8q9lhc4rvjxd022zv5l44g6qah82ru5rdpnpj';
  const quantityFive =
      'lno1pgx9getnwss8vetrw3hhyuc5qyz3vggzamrjghtt05kvkvpcp0a79gmy3nt6jsn98ad2xs8de6sl9qmgvcvs';
  const unknownRequiredField =
      'lno1pgz5znzfgdz3vggzqgpqyqszqgpqyqszqgpqyqszqgpqyqszqgpqyqszqgpqyqszqgpysgr0u2xq4dh3kdevrf4zg6hx8a60jv0gxe0ptgyfc6xkryqqqqqqqq';

  test('decodes official variable and fixed-amount vectors', () {
    final parser = Bolt12OfferParser();
    final variable = parser.decode(minimal);
    expect(variable.isVariableAmount, isTrue);
    expect(variable.amountMsat, isNull);
    expect(variable.offerId, hasLength(64));

    final fixed = parser.decode(amount10Sats);
    expect(fixed.isVariableAmount, isFalse);
    expect(fixed.amountMsat, 10000);
  });

  test('normalizes BIP-321, uppercase, and continuation form', () {
    final parser = Bolt12OfferParser();
    expect(
      parser.decode('bitcoin:?lno=${minimal.toUpperCase()}').normalized,
      minimal,
    );
    final continued = '${minimal.substring(0, 20)}+\n ${minimal.substring(20)}';
    expect(parser.decode(continued).normalized, minimal);
  });

  test('validates chain against the configured NWC network', () {
    expect(
        Bolt12OfferParser(expectedNetwork: 'testnet').decode(testnet).network,
        'testnet');
    expect(
      () => Bolt12OfferParser().decode(testnet),
      throwsFormatException,
    );
  });

  test('rejects unsupported payout semantics and malformed encodings', () {
    final parser = Bolt12OfferParser();
    expect(() => parser.decode(fiat), throwsFormatException);
    expect(() => parser.decode(quantityFive), throwsFormatException);
    expect(() => parser.decode(unknownRequiredField), throwsFormatException);
    expect(() => parser.decode('${minimal}q'), throwsFormatException);
    expect(
      () => parser.decode(
          '${minimal.substring(0, 5).toUpperCase()}${minimal.substring(5)}'),
      throwsFormatException,
    );
  });
}
