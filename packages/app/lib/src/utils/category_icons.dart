import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';

IconData? categoryIconData(OfferCategory? category) {
  switch (category) {
    case OfferCategory.shop:
      return Icons.storefront_outlined;
    case OfferCategory.atm:
      return Icons.local_atm_outlined;
    case OfferCategory.online:
      return Icons.shopping_bag_outlined;
    case null:
      return null;
  }
}

String? categoryAssetPath(OfferCategory? category) {
  switch (category) {
    case OfferCategory.shop:
      return 'assets/category_shop.png';
    case OfferCategory.atm:
      return 'assets/category_atm.png';
    case OfferCategory.online:
      return 'assets/category_online.png';
    case null:
      return null;
  }
}

/// Pass [color] to tint the icon. Omit for original full-color asset.
Widget categoryIconWidget(OfferCategory? category, double size, {Color? color}) {
  final asset = categoryAssetPath(category);
  if (asset != null) {
    return Image.asset(
      asset,
      width: size,
      height: size,
      color: color,
      colorBlendMode: color != null ? BlendMode.srcIn : null,
    );
  }
  final icon = categoryIconData(category);
  if (icon == null) return const SizedBox.shrink();
  return Icon(icon, size: size, color: color);
}
