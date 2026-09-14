import 'package:bitblik_core/core.dart';

/// Publishes the current persisted offer, in order, even when callers hold
/// stale snapshots from startup rebroadcasts or slow transition side effects.
class OfferPublicationQueue {
  final Future<Offer?> Function(String id) loadOffer;
  final Map<String, Future<void>> _pending = {};

  OfferPublicationQueue({required this.loadOffer});

  Future<void> publish(
    String offerId,
    Future<void> Function(Offer current) publishCurrent,
  ) {
    final previous = _pending[offerId] ?? Future<void>.value();
    final operation =
        previous.then<void>((_) {}, onError: (Object _) {}).then((_) async {
      final current = await loadOffer(offerId);
      if (current != null) await publishCurrent(current);
    });
    late final Future<void> tracked;
    tracked = operation.whenComplete(() {
      if (identical(_pending[offerId], tracked)) _pending.remove(offerId);
    });
    _pending[offerId] = tracked;
    return tracked;
  }
}
