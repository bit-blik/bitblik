import '../models/offer.dart';

/// Bridge between the wire/DB [OfferStatus] enum (camelCase) and flow state
/// names (snake_case, as written in the `*.yml` flow definitions).
///
/// The mapping is purely lexical — `blikSentToMaker` <-> `blik_sent_to_maker` —
/// so flow files stay readable while the enum remains the single wire vocabulary.
/// `created` and `unknown` are intentionally absent from flow definitions; see
/// [offerStatusFromFlowState] for how unknown names are handled.

/// camelCase -> snake_case (e.g. `blikSentToMaker` -> `blik_sent_to_maker`).
String flowStateForOfferStatus(OfferStatus status) {
  final name = status.name;
  final buf = StringBuffer();
  for (var i = 0; i < name.length; i++) {
    final ch = name[i];
    final lower = ch.toLowerCase();
    if (ch != lower) {
      buf.write('_');
      buf.write(lower);
    } else {
      buf.write(ch);
    }
  }
  return buf.toString();
}

/// snake_case -> [OfferStatus]. Returns [OfferStatus.unknown] for any name that
/// does not correspond to a known enum value (mirrors the append-only,
/// fail-safe parsing used elsewhere for forward compatibility).
OfferStatus offerStatusFromFlowState(String flowState) {
  final buf = StringBuffer();
  var upperNext = false;
  for (var i = 0; i < flowState.length; i++) {
    final ch = flowState[i];
    if (ch == '_') {
      upperNext = true;
      continue;
    }
    buf.write(upperNext ? ch.toUpperCase() : ch);
    upperNext = false;
  }
  final camel = buf.toString();
  try {
    return OfferStatus.values.byName(camel);
  } catch (_) {
    return OfferStatus.unknown;
  }
}
