import 'package:bitblik_cli/src/cli_app.dart';
import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

void main() {
  test('version line identifies executable and release version', () {
    expect(cliVersionLine(kBlik), 'Bitblik CLI 0.11.0');
    expect(cliVersionLine(kMbway), 'Bitway CLI 0.11.0');
    expect(cliVersionLine(kTwint), 'Bittwint CLI 0.11.0');
    expect(cliVersionLine(kSlovakia), 'Veksli CLI 0.11.0');
  });
}
