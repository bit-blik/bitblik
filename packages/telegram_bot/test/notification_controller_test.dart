import 'package:bitblik_core/core.dart';
import 'package:bitblik_telegram_bot/bitblik_telegram_bot.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

class _FakeTelegram implements TelegramClient {
  final List<String> sent = [];
  final List<(TelegramMessageRef, String)> edited = [];
  final List<TelegramMessageRef> deleted = [];
  int _nextId = 1;

  @override
  Future<List<TelegramMessageRef>> sendMessage(String text) async {
    sent.add(text);
    return [
      TelegramMessageRef(
        chatId: '-1001',
        messageId: _nextId++,
      ),
    ];
  }

  @override
  Future<bool> editMessage(TelegramMessageRef message, String text) async {
    edited.add((message, text));
    return true;
  }

  @override
  Future<bool> deleteMessage(TelegramMessageRef message) async {
    deleted.add(message);
    return true;
  }
}

Nip01Event offerEvent({
  required String coordinator,
  required String offerId,
  required String status,
  required int eventCreatedAt,
  required int offerCreatedAt,
  String platform = 'Bitblik',
}) =>
    Nip01Event(
      pubKey: coordinator,
      kind: kKindOffer,
      content: '',
      createdAt: eventCreatedAt,
      tags: [
        ['d', offerId],
        ['s', status],
        ['y', platform],
        ['amt', '12000'],
        ['fa', '50'],
        ['f', 'PLN'],
        ['premium', '2.5'],
        ['category', 'shop'],
        ['created_at', '$offerCreatedAt'],
      ],
    );

void main() {
  const coordinatorA =
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
  const coordinatorB =
      'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb';
  late DateTime now;
  late _FakeTelegram telegram;
  late MemoryNotificationStateStore store;
  late OfferNotificationController controller;
  late List<String> logs;

  Future<OfferNotificationController> createController() async {
    final value = OfferNotificationController(
      telegram: telegram,
      store: store,
      paymentSystem: kBlik,
      frontendDomain: 'bitblik.app',
      coordinatorMinInterval: const Duration(seconds: 10),
      coordinatorCooldown: const Duration(minutes: 10),
      clock: () => now,
      logger: logs.add,
    );
    await value.init();
    await value.updateCoordinatorPolicy(
      allowed: {coordinatorA, coordinatorB},
      muted: {},
      coordinatorIdentities: const {
        coordinatorA: CoordinatorIdentity(
          name: 'Alice Coordinator',
        ),
        coordinatorB: CoordinatorIdentity(name: 'Bob Coordinator'),
      },
    );
    return value;
  }

  setUp(() async {
    now = DateTime.utc(2026, 8, 31, 12);
    telegram = _FakeTelegram();
    store = MemoryNotificationStateStore();
    logs = [];
    controller = await createController();
  });

  test('announces a newly funded offer once with shared coordinator wording',
      () async {
    final timestamp = now.millisecondsSinceEpoch ~/ 1000;
    final event = offerEvent(
      coordinator: coordinatorA,
      offerId: 'offer-1',
      status: 'pending',
      eventCreatedAt: timestamp,
      offerCreatedAt: timestamp,
    );

    await controller.handleEvent(event);
    await controller.handleEvent(event);

    expect(telegram.sent, hasLength(1));
    expect(
      telegram.sent.single,
      '<b>Alice Coordinator</b>\n'
      'New offer/Nowa oferta: 12000 sats (50.00 PLN), Shop/Sklep, '
      '+2.5% premium/premia -&gt; https://bitblik.app/offers/offer-1',
    );
    expect(
      logs.where((message) => message.startsWith('Offer funded:')),
      hasLength(1),
    );
  });

  test('strikes canceled offers and deletes takerPaid offers', () async {
    final timestamp = now.millisecondsSinceEpoch ~/ 1000;
    await controller.handleEvent(offerEvent(
      coordinator: coordinatorA,
      offerId: 'cancelled',
      status: 'pending',
      eventCreatedAt: timestamp,
      offerCreatedAt: timestamp,
    ));
    await controller.handleEvent(offerEvent(
      coordinator: coordinatorA,
      offerId: 'cancelled',
      status: 'canceled',
      eventCreatedAt: timestamp + 1,
      offerCreatedAt: timestamp,
    ));

    now = now.add(const Duration(seconds: 11));
    await controller.handleEvent(offerEvent(
      coordinator: coordinatorB,
      offerId: 'paid',
      status: 'pending',
      eventCreatedAt: timestamp + 2,
      offerCreatedAt: timestamp + 2,
    ));
    await controller.handleEvent(offerEvent(
      coordinator: coordinatorB,
      offerId: 'paid',
      status: 'success',
      eventCreatedAt: timestamp + 3,
      offerCreatedAt: timestamp + 2,
    ));

    expect(telegram.edited, hasLength(1));
    expect(
      telegram.edited.single.$2,
      startsWith('<s><b>Alice Coordinator</b>'),
    );
    expect(telegram.edited.single.$2, endsWith('</s>'));
    expect(telegram.deleted, hasLength(1));
    expect(logs, contains(contains('Offer funded: cancelled from Alice')));
    expect(
      logs,
      contains(contains('Offer cancelled/expired: cancelled from Alice')),
    );
    expect(logs, contains(contains('Offer funded: paid from Bob')));
    expect(logs, contains(contains('Offer finished: paid from Bob')));
  });

  test('rate limits only the coordinator that funds too frequently', () async {
    final timestamp = now.millisecondsSinceEpoch ~/ 1000;
    Future<void> funded(String coordinator, String id, int createdAt) =>
        controller.handleEvent(offerEvent(
          coordinator: coordinator,
          offerId: id,
          status: 'pending',
          eventCreatedAt: createdAt,
          offerCreatedAt: createdAt,
        ));

    await funded(coordinatorA, 'a1', timestamp);
    now = now.add(const Duration(seconds: 3));
    await funded(coordinatorA, 'a2', timestamp + 3);
    await funded(coordinatorB, 'b1', timestamp + 3);
    now = now.add(const Duration(minutes: 5));
    await funded(coordinatorA, 'a3', timestamp + 303);
    now = now.add(const Duration(minutes: 6));
    await funded(coordinatorA, 'a4', timestamp + 663);

    expect(telegram.sent, hasLength(3));
    expect(telegram.sent[0], contains('/a1'));
    expect(telegram.sent[1], contains('/b1'));
    expect(telegram.sent[2], contains('/a4'));
  });

  test('mute list blocks offers and removes active coordinator messages',
      () async {
    final timestamp = now.millisecondsSinceEpoch ~/ 1000;
    await controller.handleEvent(offerEvent(
      coordinator: coordinatorA,
      offerId: 'offer-1',
      status: 'pending',
      eventCreatedAt: timestamp,
      offerCreatedAt: timestamp,
    ));

    await controller.updateCoordinatorPolicy(
      allowed: {coordinatorB},
      muted: {coordinatorA},
    );
    await controller.handleEvent(offerEvent(
      coordinator: coordinatorA,
      offerId: 'offer-2',
      status: 'pending',
      eventCreatedAt: timestamp + 1,
      offerCreatedAt: timestamp + 1,
    ));

    expect(telegram.sent, hasLength(1));
    expect(telegram.deleted, hasLength(1));
  });

  test('does not announce old pending offers seen during initial replay',
      () async {
    final timestamp = now.millisecondsSinceEpoch ~/ 1000;
    await controller.handleEvent(offerEvent(
      coordinator: coordinatorA,
      offerId: 'old',
      status: 'pending',
      eventCreatedAt: timestamp,
      offerCreatedAt: timestamp - 3600,
    ));

    expect(telegram.sent, isEmpty);
    expect(
        logs.where((message) => message.startsWith('Offer funded:')), isEmpty);
  });

  test('persisted Telegram ids support lifecycle updates after restart',
      () async {
    final timestamp = now.millisecondsSinceEpoch ~/ 1000;
    await controller.handleEvent(offerEvent(
      coordinator: coordinatorA,
      offerId: 'offer-1',
      status: 'pending',
      eventCreatedAt: timestamp,
      offerCreatedAt: timestamp,
    ));

    controller = await createController();
    await controller.handleEvent(offerEvent(
      coordinator: coordinatorA,
      offerId: 'offer-1',
      status: 'success',
      eventCreatedAt: timestamp + 1,
      offerCreatedAt: timestamp,
    ));

    expect(telegram.deleted, hasLength(1));
  });

  test('ignores undiscovered coordinators and another payment system',
      () async {
    final timestamp = now.millisecondsSinceEpoch ~/ 1000;
    await controller.handleEvent(offerEvent(
      coordinator:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc',
      offerId: 'unknown',
      status: 'pending',
      eventCreatedAt: timestamp,
      offerCreatedAt: timestamp,
    ));
    await controller.handleEvent(offerEvent(
      coordinator: coordinatorA,
      offerId: 'twint',
      status: 'pending',
      platform: 'Bittwint',
      eventCreatedAt: timestamp + 1,
      offerCreatedAt: timestamp + 1,
    ));

    expect(telegram.sent, isEmpty);
  });
}
