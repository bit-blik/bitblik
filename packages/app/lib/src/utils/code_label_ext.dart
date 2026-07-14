import 'package:bitblik_core/core.dart';

import '../../i18n/gen/strings.g.dart';

/// Localized payment-code term for UI text.
///
/// Uses the payment system's branded [PaymentSystem.codeName] (e.g. "BLIK",
/// "MB WAY") when present, otherwise a translated generic word ("code" / "kód"
/// / …) from `common.code`, so bank markets — which have no branded code name —
/// read naturally in the active language instead of showing the English "code".
///
/// Resolves against the current locale via slang's global `t`; screens rebuild
/// on locale change (via their context translations + the app locale switch),
/// so the value follows the selected language.
extension LocalizedCodeLabel on PaymentSystem {
  String get localizedCodeLabel => codeName ?? t.common.code;
}
