import 'package:bitblik_coordinator/src/services/nwc_service.dart';
import 'package:test/test.dart';

void main() {
  const complete = {'pay', 'list_transactions'};

  test('recovery defaults on and supports an explicit opt-out', () {
    expect(nwcBolt12RecoveryEnabled(null), isTrue);
    expect(nwcBolt12RecoveryEnabled(''), isTrue);
    expect(nwcBolt12RecoveryEnabled('true'), isTrue);
    expect(nwcBolt12RecoveryEnabled('false'), isFalse);
    expect(nwcBolt12RecoveryEnabled('0'), isFalse);
    expect(nwcBolt12RecoveryEnabled('NO'), isFalse);
  });

  test('requires safe recovery and both NWC methods', () {
    expect(
      hasSafeNwcBolt12Capability(
        recoveryEnabled: true,
        network: 'mainnet',
        advertisedMethods: complete,
      ),
      isTrue,
    );
    for (final methods in [
      const {'pay'},
      const {'list_transactions'},
      const <String>{},
    ]) {
      expect(
        hasSafeNwcBolt12Capability(
          recoveryEnabled: true,
          network: 'mainnet',
          advertisedMethods: methods,
        ),
        isFalse,
      );
    }
    expect(
      hasSafeNwcBolt12Capability(
        recoveryEnabled: false,
        network: 'mainnet',
        advertisedMethods: complete,
      ),
      isFalse,
    );
  });

  test('rejects unsupported wallet networks', () {
    expect(
      hasSafeNwcBolt12Capability(
        recoveryEnabled: true,
        network: 'mutinynet',
        advertisedMethods: complete,
      ),
      isFalse,
    );
  });
}
