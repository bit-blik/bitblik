import 'package:bitblik_core/core.dart';

import '../../i18n/gen/strings.g.dart';

/// Localized payment-code term for UI text.
///
/// Uses `common.sk_atms` for the Slovak ATM flow, the payment system's branded
/// [PaymentSystem.codeName] (e.g. "BLIK", "MB WAY") for branded codes, and
/// `common.code` as the generic fallback.
///
/// Resolves against the current locale via slang's global `t`; screens rebuild
/// on locale change (via their context translations + the app locale switch),
/// so the value follows the selected language.
extension LocalizedCodeLabel on PaymentSystem {
  String get localizedCodeLabel =>
      flowId == 'sk_atm' ? t.common.sk_atms : codeName ?? t.common.code;
}
