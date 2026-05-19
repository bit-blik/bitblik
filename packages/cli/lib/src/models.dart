import 'package:bitblik_core/core.dart';

class CoordinatorListItem {
  final String pubkeyHex;
  final CoordinatorInfo info;
  final DateTime lastSeen;
  bool? responsive;

  CoordinatorListItem({
    required this.pubkeyHex,
    required this.info,
    required this.lastSeen,
    required this.responsive,
  });

  Map<String, Object?> toJson() => {
        'pubkey': pubkeyHex,
        ...info.toJson(),
        'last_seen': lastSeen.toUtc().toIso8601String(),
        'responsive': responsive,
      };
}
