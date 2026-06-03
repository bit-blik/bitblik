import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../settings/app_preferences.dart';

String formatBitcoinAmountForLocale(
  String localeTag,
  BitcoinDisplayUnit unit,
  num amount, {
  bool approximate = false,
}) {
  final prefix = approximate ? '≈' : '';
  final formatted = NumberFormat.decimalPattern(
    localeTag,
  ).format(amount.round());
  switch (unit) {
    case BitcoinDisplayUnit.sats:
      return '$prefix$formatted sats';
    case BitcoinDisplayUnit.bitcoin:
      return '$prefix₿$formatted';
  }
}

String formatBitcoinAmount(
  BuildContext context,
  BitcoinDisplayUnit unit,
  num amount, {
  bool approximate = false,
}) {
  final localeTag = Localizations.localeOf(context).toLanguageTag();
  return formatBitcoinAmountForLocale(
    localeTag,
    unit,
    amount,
    approximate: approximate,
  );
}

String formatBitcoinRange(
  BuildContext context,
  BitcoinDisplayUnit unit,
  num minAmount,
  num maxAmount,
) {
  final localeTag = Localizations.localeOf(context).toLanguageTag();
  final formatter = NumberFormat.decimalPattern(localeTag);
  final minText = formatter.format(minAmount.round());
  final maxText = formatter.format(maxAmount.round());
  switch (unit) {
    case BitcoinDisplayUnit.sats:
      return '$minText - $maxText sats';
    case BitcoinDisplayUnit.bitcoin:
      return '₿$minText - ₿$maxText';
  }
}
