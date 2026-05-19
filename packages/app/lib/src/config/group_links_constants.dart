import 'package:flutter/foundation.dart';

/// Default group link constants
/// These are used as fallback values when no runtime configuration is provided
class GroupLinksConstants {
  static const String defaultTelegram =
      !kDebugMode
          ? 'https://t.me/+xSktv2JukXUxYmEx'
          : 'https://t.me/+MmXPxSylJC0zNzIx';

  static const String defaultElement =
      !kDebugMode
          ? 'https://matrix.to/#/#bitblik-offers:matrix.org'
          : 'https://matrix.to/#/#test-bitblik-offers:matrix.org';

  static const String defaultSimplex =
      !kDebugMode
          ? 'https://simplex.chat/contact#/?v=2-7&smp=smp%3A%2F%2Fu2dS9sG8nMNURyZwqASV4yROM28Er0luVTx5X1CsMrU%3D%40smp4.simplex.im%2FjwS8YtivATVUtHogkN2QdhVkw2H6XmfX%23%2F%3Fv%3D1-3%26dh%3DMCowBQYDK2VuAyEAsNpGcPiALZKbKfIXTQdJAuFxOmvsuuxMLR9rwMIBUWY%253D%26srv%3Do5vmywmrnaxalvz6wi3zicyftgio6psuvyniis6gco6bp6ekl4cqj4id.onion&data=%7B%22groupLinkId%22%3A%22hCkt5Ph057tSeJdyEI0uug%3D%3D%22%7D'
          : 'https://simplex.chat/contact#/?v=2-7&smp=smp%3A%2F%2Fu2dS9sG8nMNURyZwqASV4yROM28Er0luVTx5X1CsMrU%3D%40smp4.simplex.im%2F-FjYjoPVW323UWnxJ-ICEIvlUY0vnuRM%23%2F%3Fv%3D1-4%26dh%3DMCowBQYDK2VuAyEAX-eUfNzP4E_n0BkC-5A7iqHrchhcDC23FopK4JPXm3Q%253D%26q%3Dc%26srv%3Do5vmywmrnaxalvz6wi3zicyftgio6psuvyniis6gco6bp6ekl4cqj4id.onion&data=%7B%22groupLinkId%22%3A%22pG-_A9dIAhbdz8ZTTpbNdQ%3D%3D%22%7D';

  static const String defaultSignal =
      !kDebugMode
          ? 'https://signal.group/#CjQKIGcFyMrwHN1UPB57IhdkGmz23_64AhyIU5oBaZufe2hcEhCltosTHbc9ROywT0KETJbk'
          : 'https://signal.group/#CjQKIIgYFxedCjVqrRIThiXtlvU26RLrrcL7D9Z9yrUc08rnEhD7BFT3pCt2JfxEQB3JZtaA';
}
