import 'package:flutter/foundation.dart';

import 'build_flavor.dart';

/// One set of community links for a (flavor, build-mode) combination.
class GroupLinkSet {
  final String telegram;
  final String element;
  final String simplex;
  final String signal;

  const GroupLinkSet({
    this.telegram = '',
    this.element = '',
    this.simplex = '',
    this.signal = '',
  });
}

const _bitblikRelease = GroupLinkSet(
  telegram: 'https://t.me/+xSktv2JukXUxYmEx',
  element: 'https://matrix.to/#/#bitblik-offers:matrix.org',
  simplex:
      'https://simplex.chat/contact#/?v=2-7&smp=smp%3A%2F%2Fu2dS9sG8nMNURyZwqASV4yROM28Er0luVTx5X1CsMrU%3D%40smp4.simplex.im%2FjwS8YtivATVUtHogkN2QdhVkw2H6XmfX%23%2F%3Fv%3D1-3%26dh%3DMCowBQYDK2VuAyEAsNpGcPiALZKbKfIXTQdJAuFxOmvsuuxMLR9rwMIBUWY%253D%26srv%3Do5vmywmrnaxalvz6wi3zicyftgio6psuvyniis6gco6bp6ekl4cqj4id.onion&data=%7B%22groupLinkId%22%3A%22hCkt5Ph057tSeJdyEI0uug%3D%3D%22%7D',
  signal:
      'https://signal.group/#CjQKIGcFyMrwHN1UPB57IhdkGmz23_64AhyIU5oBaZufe2hcEhCltosTHbc9ROywT0KETJbk',
);

const _bitblikDebug = GroupLinkSet(
  telegram: 'https://t.me/+MmXPxSylJC0zNzIx',
  element: 'https://matrix.to/#/#test-bitblik-offers:matrix.org',
  simplex:
      'https://simplex.chat/contact#/?v=2-7&smp=smp%3A%2F%2Fu2dS9sG8nMNURyZwqASV4yROM28Er0luVTx5X1CsMrU%3D%40smp4.simplex.im%2F-FjYjoPVW323UWnxJ-ICEIvlUY0vnuRM%23%2F%3Fv%3D1-4%26dh%3DMCowBQYDK2VuAyEAX-eUfNzP4E_n0BkC-5A7iqHrchhcDC23FopK4JPXm3Q%253D%26q%3Dc%26srv%3Do5vmywmrnaxalvz6wi3zicyftgio6psuvyniis6gco6bp6ekl4cqj4id.onion&data=%7B%22groupLinkId%22%3A%22pG-_A9dIAhbdz8ZTTpbNdQ%3D%3D%22%7D',
  signal:
      'https://signal.group/#CjQKIIgYFxedCjVqrRIThiXtlvU26RLrrcL7D9Z9yrUc08rnEhD7BFT3pCt2JfxEQB3JZtaA',
);

// Empty fields hide the corresponding community button.
const _bitwayRelease = GroupLinkSet(
  telegram: 'https://t.me/+LggNXOqCkWc0YmQx',
  simplex: 'https://smp18.simplex.im/g#0c-6KAwTCR3_VxJKq_ovGSFsyzg_VMwmxiu5BIiOXTw'
);

const _bitwayDebug = GroupLinkSet(
  telegram: 'https://t.me/+LggNXOqCkWc0YmQx',
  simplex: 'https://smp18.simplex.im/g#0c-6KAwTCR3_VxJKq_ovGSFsyzg_VMwmxiu5BIiOXTw'
);

/// Default group link constants, resolved per flavor and build mode.
/// These are used as fallback values when no runtime configuration is
/// provided.
class GroupLinksConstants {
  static GroupLinkSet get _current {
    if (buildDefaultPaymentSystemId == 'mbway') {
      return kDebugMode ? _bitwayDebug : _bitwayRelease;
    }
    return kDebugMode ? _bitblikDebug : _bitblikRelease;
  }

  static String get defaultTelegram => _current.telegram;
  static String get defaultElement => _current.element;
  static String get defaultSimplex => _current.simplex;
  static String get defaultSignal => _current.signal;
}
