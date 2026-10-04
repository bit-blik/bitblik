import 'package:bitblik_cli/src/cli_app.dart';
import 'package:bitblik_cli/src/version.dart';
import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

void main() {
  test('version line identifies executable and release version', () {
    expect(cliVersionLine(kBlik), 'Bitblik CLI $cliVersion');
    expect(cliVersionLine(kMbway), 'Bitway CLI $cliVersion');
    expect(cliVersionLine(kTwint), 'Bittwint CLI $cliVersion');
    expect(cliVersionLine(kSlovakia), 'veks.li CLI $cliVersion');
  });
}
