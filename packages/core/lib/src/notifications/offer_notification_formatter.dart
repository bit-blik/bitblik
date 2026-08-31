import '../models/offer.dart';
import '../payment/payment_system.dart';

/// Builds the bilingual new-offer announcement shared by coordinators and the
/// central Telegram bot.
String formatFundedOfferNotification(
  Offer offer, {
  required String frontendDomain,
}) {
  final paymentSystem = paymentSystemForOffer(offer);
  final strings =
      _stringsByCountry[paymentSystem.country] ?? _stringsByCountry['PL']!;
  final fiatText =
      '${offer.fiatAmount.toStringAsFixed(2)} ${offer.fiatCurrency}';
  final bank = bankForOffer(offer);
  final bankTag = bank == null ? '' : ' [${bank.label}]';
  final categoryText = _formatCategory(offer.category, strings);
  final categorySuffix = categoryText == null ? '' : ', $categoryText';
  final premiumSuffix = offer.premiumPercent > 0
      ? ', +${_formatPremium(offer.premiumPercent)}% ${strings.premium}'
      : '';
  final domain = frontendDomain
      .trim()
      .replaceFirst(RegExp(r'^https?://'), '')
      .replaceFirst(RegExp(r'/$'), '');

  return '${strings.newOffer}$bankTag: ${offer.amountSats} sats '
      '($fiatText)$categorySuffix$premiumSuffix -> '
      'https://$domain/offers/${offer.id}';
}

class _OfferNotificationStrings {
  final String newOffer;
  final String premium;
  final String shop;
  final String atm;
  final String online;

  const _OfferNotificationStrings({
    required this.newOffer,
    required this.premium,
    required this.shop,
    required this.atm,
    required this.online,
  });
}

const Map<String, _OfferNotificationStrings> _stringsByCountry = {
  'PL': _OfferNotificationStrings(
    newOffer: 'New offer/Nowa oferta',
    premium: 'premium/premia',
    shop: 'Shop/Sklep',
    atm: 'ATM/Bankomat',
    online: 'Online',
  ),
  'PT': _OfferNotificationStrings(
    newOffer: 'New offer/Nova oferta',
    premium: 'premium',
    shop: 'Shop/Loja',
    atm: 'ATM/Multibanco',
    online: 'Online',
  ),
  'CH': _OfferNotificationStrings(
    newOffer: 'New offer/Neues Angebot',
    premium: 'premium/Premium',
    shop: 'Shop/Geschäft',
    atm: 'ATM/Bancomat',
    online: 'Online',
  ),
  'SK': _OfferNotificationStrings(
    newOffer: 'New offer/Nová ponuka',
    premium: 'premium/prémia',
    shop: 'Shop/Obchod',
    atm: 'ATM/Bankomat',
    online: 'Online',
  ),
};

String _formatPremium(double premium) {
  final value = premium.toStringAsFixed(1);
  return value.endsWith('.0') ? value.substring(0, value.length - 2) : value;
}

String? _formatCategory(
  OfferCategory? category,
  _OfferNotificationStrings strings,
) {
  switch (category) {
    case OfferCategory.shop:
      return strings.shop;
    case OfferCategory.atm:
      return strings.atm;
    case OfferCategory.online:
      return strings.online;
    case null:
      return null;
  }
}
