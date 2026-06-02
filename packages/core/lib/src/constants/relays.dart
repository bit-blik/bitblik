/// The Bitblik project's Nostr identity. Its NIP-65 (kind [kKindRelayList])
/// relay list defines the **discovery relays** — where coordinators publish
/// their advertisement (kind [kKindCoordinatorInfo]) + NIP-65 events and where
/// clients look for them. Editing Bitblik's published relay list re-points
/// discovery for every client without shipping a new build.
const String kBitblikNpub =
    'npub1k3g092rlzvn7nftz3jte9pkx63zp705nh78r6hjpjm55fjg7r2cqx8stj3';

/// Hex form of [kBitblikNpub] (decoded once, here, to avoid runtime decoding).
const String kBitblikPubkeyHex =
    'b450f2a87f1327e9a5628c979286c6d4441f3e93bf8e3d5e4196e944c91e1ab0';

/// Hardcoded **bootstrap** relays — used only to fetch Bitblik's profile
/// NIP-65 ([kBitblikNpub]), which in turn yields the live discovery relays.
/// Also the fallback discovery set when Bitblik's relay list can't be fetched.
///
/// This is intentionally broad/common so the bootstrap fetch succeeds. It is
/// NOT the set of relays used to talk to a coordinator, and must not be
/// confused with NWC wallet relays.
const List<String> kDiscoveryRelays = [
  'wss://relay.primal.net',
  'wss://nos.lol',
  'wss://nostr.mom',
  'wss://relay.damus.io',
  'wss://offchain.pub',
  'wss://purplepag.es',
  'wss://indexer.coracle.social',
  'wss://user.kindpag.es',
  'wss://directory.yabu.me',
  'wss://profiles.nostr1.com',
];

/// Normalize a relay URL for comparison/dedup: trims whitespace and drops a
/// single trailing slash. Used when matching published relay URLs against
/// NDK's connectivity map and when building relay unions.
String normalizeRelayUrl(String url) {
  var u = url.trim();
  if (u.endsWith('/')) u = u.substring(0, u.length - 1);
  return u;
}

