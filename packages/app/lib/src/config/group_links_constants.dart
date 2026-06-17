import 'package:flutter/foundation.dart';

/// One set of community links for a (payment-system, build-mode) combination.
class GroupLinkSet {
  final String telegram;
  final String matrix;
  final String simplex;
  final String signal;

  const GroupLinkSet({
    this.telegram = '',
    this.matrix = '',
    this.simplex = '',
    this.signal = '',
  });

  bool get hasAnyLinks =>
      telegram.isNotEmpty ||
      matrix.isNotEmpty ||
      simplex.isNotEmpty ||
      signal.isNotEmpty;
}

const _blikRelease = GroupLinkSet(
  telegram: 'https://t.me/+xSktv2JukXUxYmEx',
  matrix: 'https://matrix.to/#/#bitblik-offers:matrix.org',
  simplex:
      'https://simplex.chat/contact#/?v=2-7&smp=smp%3A%2F%2Fu2dS9sG8nMNURyZwqASV4yROM28Er0luVTx5X1CsMrU%3D%40smp4.simplex.im%2FjwS8YtivATVUtHogkN2QdhVkw2H6XmfX%23%2F%3Fv%3D1-3%26dh%3DMCowBQYDK2VuAyEAsNpGcPiALZKbKfIXTQdJAuFxOmvsuuxMLR9rwMIBUWY%253D%26srv%3Do5vmywmrnaxalvz6wi3zicyftgio6psuvyniis6gco6bp6ekl4cqj4id.onion&data=%7B%22groupLinkId%22%3A%22hCkt5Ph057tSeJdyEI0uug%3D%3D%22%7D',
  signal:
      'https://signal.group/#CjQKIGcFyMrwHN1UPB57IhdkGmz23_64AhyIU5oBaZufe2hcEhCltosTHbc9ROywT0KETJbk',
);

const _blikDebug = GroupLinkSet(
);

// Empty fields hide the corresponding community button.
const _mbwayRelease = GroupLinkSet(
);

const _mbwayDebug = GroupLinkSet(
);

/// Default group link constants, resolved per payment system and build mode.
/// These are used as fallback values when no runtime configuration is
/// provided.
class GroupLinksConstants {
  /// Links for the given payment system id ('blik', 'mbway', ...), honoring
  /// debug/release mode. Unknown ids fall back to the BLIK set.
  static GroupLinkSet forPaymentSystem(String paymentSystemId) {
    if (paymentSystemId == 'mbway') {
      return kDebugMode ? _mbwayDebug : _mbwayRelease;
    }
    return kDebugMode ? _blikDebug : _blikRelease;
  }
}
