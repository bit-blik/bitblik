/// The Bitblik project's Nostr identity (hex pubkey). Its NIP-65 (kind
/// [kKindRelayList]) relay list defines the **discovery relays** — where
/// coordinators publish their advertisement (kind [kKindCoordinatorInfo]) +
/// NIP-65 events and where clients look for them. Editing Bitblik's published
/// relay list re-points discovery for every client without shipping a new build.
///
/// Stored as hex because that is the form Nostr filters require (the hot path);
/// the npub is derived on demand via `Nip19.encodePubKey` for the rare display
/// case. npub: npub1k3g092rlzvn7nftz3jte9pkx63zp705nh78r6hjpjm55fjg7r2cqx8stj3
const String kBitblikPubkeyHex =
    'b450f2a87f1327e9a5628c979286c6d4441f3e93bf8e3d5e4196e944c91e1ab0';

/// The Bitway (MB WAY / Portugal market) Nostr identity (hex pubkey). Used
/// instead of [kBitblikPubkeyHex] for discovery when the active payment system
/// is MB WAY, so the Bitway market resolves its own discovery relays +
/// coordinator set.
///
/// npub: npub180nj93uqjvvjksryaxaz8fk9gxwwtg06gxlkd5csrj6rqfg3phhs09n5s9
const String kBitwayPubkeyHex =
    '3be722c78093192b4064e9ba23a6c5419ce5a1fa41bf66d3101cb43025110def';

/// The Bittwint (TWINT / Switzerland market) Nostr identity (hex pubkey). Used
/// instead of [kBitblikPubkeyHex] for discovery when the active payment system
/// is TWINT, so the Bittwint market resolves its own discovery relays +
/// coordinator set.
///
/// npub: npub1jwyfy9ah5g6p6r509vcesmyjwwa93p9qrk4kx365d7pynxfkmqysf5a66q
const String kTwintPubkeyHex =
    '93889217b7a2341d0e8f2b31986c9273ba5884a01dab6347546f82499936d809';

/// Hardcoded **bootstrap** relays — used only to fetch Bitblik's profile
/// NIP-65 ([kBitblikPubkeyHex]), which in turn yields the live discovery relays.
/// Also the fallback discovery set when Bitblik's relay list can't be fetched.
///
/// This is intentionally broad/common so the bootstrap fetch succeeds. It is
/// NOT the set of relays used to talk to a coordinator, and must not be
/// confused with NWC wallet relays.
const List<String> kDiscoveryRelays = [
  'wss://relay.primal.net',
  'wss://nos.lol',
  'wss://nostr.mom',
  'wss://relay.damus.io'
];

/// Default inbox relays advertised for NIP-17 gift wraps.
///
/// These are the original BitBlik defaults used before the embedded console
/// was introduced. Keep them stable: NIP-17 senders may cache the recipient's
/// kind-10050 list, and changing it can silently split delivery across relays.
const List<String> kDefaultDmInboxRelays = [
  'wss://relay.primal.net',
  'wss://nos.lol',
  'wss://nostr.mom',
  'wss://relay.damus.io',
];

/// Normalize a relay URL for comparison/dedup: trims whitespace and drops a
/// single trailing slash. Used when matching published relay URLs against
/// NDK's connectivity map and when building relay unions.
String normalizeRelayUrl(String url) {
  var u = url.trim();
  if (u.endsWith('/')) u = u.substring(0, u.length - 1);
  return u;
}
