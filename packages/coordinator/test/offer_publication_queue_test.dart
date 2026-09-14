import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/services/offer_publication_queue.dart';
import 'package:test/test.dart';

void main() {
  final reserved = Offer(
    id: '970fb23b-9602-4f9b-b6fa-6a220b83a1ba',
    amountSats: 34171,
    makerFees: 0,
    fiatAmount: 100,
    fiatCurrency: 'PLN',
    status: OfferStatus.reserved,
    createdAt: DateTime.utc(2026, 9, 14),
    makerPubkey: 'maker',
    coordinatorPubkey: 'coordinator',
  );

  test('a delayed rebroadcast publishes the current dispute, not its snapshot',
      () async {
    final current = reserved.copyWith(status: OfferStatus.dispute);
    final queue = OfferPublicationQueue(loadOffer: (_) async => current);
    final published = <Offer>[];

    await queue.publish(reserved.id, (offer) async => published.add(offer));

    expect(published.single.status, OfferStatus.dispute);
  });

  test('same-offer publications cannot overtake each other', () async {
    var current = reserved;
    final queue = OfferPublicationQueue(loadOffer: (_) async => current);
    final publishing = Completer<void>();
    final release = Completer<void>();
    final published = <OfferStatus>[];
    final first = queue.publish(reserved.id, (offer) async {
      publishing.complete();
      await release.future;
      published.add(offer.status);
    });
    await publishing.future;

    current = reserved.copyWith(status: OfferStatus.dispute);
    final second = queue.publish(reserved.id, (offer) async {
      published.add(offer.status);
    });
    await Future<void>.delayed(Duration.zero);
    expect(published, isEmpty);
    release.complete();
    await Future.wait([first, second]);
    expect(published, [OfferStatus.reserved, OfferStatus.dispute]);
  });

  test('failed publication does not block the next dispute update', () async {
    final current = reserved.copyWith(status: OfferStatus.dispute);
    final queue = OfferPublicationQueue(loadOffer: (_) async => current);
    final failure = queue.publish(reserved.id, (_) async {
      throw StateError('relay unavailable');
    });
    final assertion = expectLater(failure, throwsStateError);
    Offer? published;
    final retry =
        queue.publish(reserved.id, (offer) async => published = offer);
    await assertion;
    await retry;
    expect(published?.status, OfferStatus.dispute);
  });
}
