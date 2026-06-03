/// Thrown when a maker attempts to take (reserve) their own offer.
///
/// Used as a client-side guard so the same maker pubkey cannot act as taker.
class CannotTakeOwnOfferException implements Exception {
  const CannotTakeOwnOfferException();

  @override
  String toString() => 'CannotTakeOwnOfferException: cannot take your own offer';
}
