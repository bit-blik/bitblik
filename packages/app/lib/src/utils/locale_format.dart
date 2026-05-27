import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String effectiveFormatLocale(BuildContext context) {
  final localeTag = Localizations.localeOf(context).toLanguageTag();
  if (localeTag.toLowerCase().startsWith('en')) {
    return 'en_GB';
  }
  return localeTag;
}

String formatLocalizedDateTime(BuildContext context, DateTime value) {
  final localeTag = effectiveFormatLocale(context);
  return DateFormat.yMd(localeTag).add_Hm().format(value.toLocal());
}
