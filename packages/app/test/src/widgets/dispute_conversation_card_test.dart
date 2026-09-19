import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/widgets/dispute_conversation_card.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';

class _FakeCommunication extends DisputeCommunicationService {
  _FakeCommunication({
    required super.ndk,
    this.transport = DisputeTextTransport.nip17,
    this.legacyMessages = const [],
    this.nip17Messages = const [],
  });

  DisputeTextTransport transport;
  final List<LegacyNip04Message> legacyMessages;
  final List<Nip17Message> nip17Messages;
  Iterable<String>? receivedLegacyRendezvousRelays;
  Iterable<String>? receivedDmRelayDiscoveryRelays;

  @override
  Future<DisputeTextTransport> resolveTextTransport({
    required Offer offer,
    required String myPubkey,
    String? participantPubkey,
    Iterable<String>? recipientDmRelayDiscoveryRelays,
  }) async => transport;

  @override
  Future<DisputeTextTransport> sendText({
    required Offer offer,
    required String myPubkey,
    required String content,
    String? participantPubkey,
    bool allowNonDispute = false,
    required Iterable<String> recipientDmRelayDiscoveryRelays,
    required Iterable<String> legacyRendezvousRelays,
  }) async {
    receivedDmRelayDiscoveryRelays = recipientDmRelayDiscoveryRelays;
    receivedLegacyRendezvousRelays = legacyRendezvousRelays;
    return transport;
  }

  @override
  Future<List<LegacyNip04Message>> loadLegacyMessages({
    required Offer offer,
    required String myPubkey,
    String? participantPubkey,
    required Iterable<String> legacyRendezvousRelays,
    bool forceRefresh = false,
    bool includeUnbound = false,
  }) async => legacyMessages;

  @override
  Future<List<Nip17Message>> loadMessagesSnapshot({
    required Offer offer,
    required String myPubkey,
    String? participantPubkey,
    bool includeUnbound = false,
  }) async => nip17Messages;
}

void main() {
  const makerPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000001';
  const coordinatorPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000002';
  final maker = Bip340.getPublicKey(makerPrivateKey);
  final coordinator = Bip340.getPublicKey(coordinatorPrivateKey);

  late Ndk ndk;

  Offer offer(String status, {DateTime? disputeAt}) => Offer(
    id: 'case-1',
    amountSats: 1490,
    makerFees: 10,
    status: OfferStatus.values.firstWhere(
      (value) => value.name == status,
      orElse: () => OfferStatus.unknown,
    ),
    statusRaw: status,
    fiatAmount: 100,
    fiatCurrency: 'PLN',
    createdAt: DateTime.utc(2026),
    makerPubkey: maker,
    coordinatorPubkey: coordinator,
    takerPubkey: Bip340.getPublicKey(
      '0000000000000000000000000000000000000000000000000000000000000003',
    ),
    disputeAt: disputeAt,
  );

  setUp(() {
    ndk = Ndk(
      NdkConfig(
        cache: MemCacheManager(),
        eventVerifier: Bip340EventVerifier(),
        bootstrapRelays: const [],
      ),
    );
    ndk.accounts.loginPrivateKey(pubkey: maker, privkey: makerPrivateKey);
  });

  tearDown(() => ndk.destroy());

  Future<void> pumpCard(
    WidgetTester tester,
    Offer value, {
    DisputeTextTransport transport = DisputeTextTransport.nip17,
    Iterable<String> legacyRendezvousRelays = const [],
    DisputeCommunicationService? communication,
    CoordinatorRecord? coordinatorRecord,
  }) async {
    await LocaleSettings.setLocale(AppLocale.en);
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            publicKeyProvider.overrideWith((ref) async => maker),
            ndkProvider.overrideWithValue(ndk),
            discoveryRelaysProvider.overrideWithValue(const [
              'wss://live-discovery.example',
            ]),
            if (coordinatorRecord != null)
              coordinatorRecordByPubkeyProvider(
                value.coordinatorPubkey,
              ).overrideWithValue(coordinatorRecord),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: DisputeConversationCard(
                  offer: value,
                  communication:
                      communication ??
                      _FakeCommunication(ndk: ndk, transport: transport),
                  legacyRendezvousRelays: legacyRendezvousRelays,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('open dispute keeps financial actions out of chat', (
    tester,
  ) async {
    await pumpCard(tester, offer(OfferStatus.dispute.name));

    expect(find.text('Private coordinator conversation'), findsOneWidget);
    expect(find.textContaining('maker refund'), findsNothing);
    expect(find.text('Submit invoice'), findsNothing);
  });

  testWidgets('chat header prefers the coordinator kind-0 name', (
    tester,
  ) async {
    await pumpCard(
      tester,
      offer(OfferStatus.dispute.name),
      coordinatorRecord: CoordinatorRecord(
        pubkeyHex: coordinator,
        profileName: 'MBWay Coordinator',
      ),
    );

    expect(find.text('MBWay Coordinator'), findsOneWidget);
    expect(find.text('Private coordinator conversation'), findsNothing);
  });

  testWidgets('resolved dispute history is read-only', (tester) async {
    await pumpCard(
      tester,
      offer(OfferStatus.cancelled.name, disputeAt: DateTime.utc(2026, 1, 2)),
    );

    expect(
      find.text('This resolved dispute history is read-only.'),
      findsOneWidget,
    );
    expect(find.text('Submit invoice'), findsNothing);
    expect(find.byTooltip('Attach payment evidence'), findsNothing);
  });

  testWidgets(
    'reopening resolves legacy transport before enabling attachments',
    (tester) async {
      for (var visit = 0; visit < 2; visit++) {
        await pumpCard(
          tester,
          offer(OfferStatus.dispute.name),
          transport: DisputeTextTransport.legacyNip04,
          legacyRendezvousRelays: const ['wss://coordinator.example'],
        );
        await tester.pumpAndSettle();
        expect(find.text('NIP-04'), findsOneWidget);
        expect(find.text('NIP-17'), findsNothing);
        expect(find.byTooltip('Attach payment evidence'), findsNothing);
        await tester.pumpWidget(const SizedBox.shrink());
      }
    },
  );

  testWidgets('successful NIP-17 send clears earlier legacy mode', (
    tester,
  ) async {
    final communication = _FakeCommunication(
      ndk: ndk,
      transport: DisputeTextTransport.legacyNip04,
    );
    await pumpCard(
      tester,
      offer(OfferStatus.dispute.name),
      communication: communication,
    );
    await tester.pumpAndSettle();
    expect(find.text('NIP-04'), findsOneWidget);
    communication.transport = DisputeTextTransport.nip17;
    await tester.enterText(find.byType(TextField).first, 'Try again');
    await tester.tap(find.byTooltip('Send message'));
    await tester.pumpAndSettle();
    expect(find.text('NIP-17'), findsOneWidget);
    expect(find.byTooltip('Attach payment evidence'), findsOneWidget);
  });

  testWidgets('image picker errors stay inside the chat error handler', (
    tester,
  ) async {
    const channel = MethodChannel('plugins.flutter.io/image_picker');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (_) async {
          throw PlatformException(code: 'photo_access_denied');
        });
    addTearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });
    await pumpCard(tester, offer(OfferStatus.dispute.name));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Attach payment evidence'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(
      find.text('The private-message operation failed. Please try again.'),
      findsOneWidget,
    );
    expect(find.byType(LinearProgressIndicator), findsNothing);
  });

  testWidgets('reopening a dispute retains both NIP-04 and NIP-17 history', (
    tester,
  ) async {
    final communication = _FakeCommunication(
      ndk: ndk,
      legacyMessages: [
        LegacyNip04Message(
          event: Nip01Event(
            pubKey: maker,
            kind: 4,
            createdAt: 1,
            tags: [
              ['p', coordinator],
            ],
            content: 'encrypted',
          ),
          peerPubKey: coordinator,
          isOutgoing: true,
          content: 'Earlier legacy message',
        ),
      ],
      nip17Messages: [
        Nip17Message(
          rumor: Nip01Event(
            pubKey: coordinator,
            kind: 14,
            createdAt: 2,
            tags: [
              ['p', maker],
            ],
            content: 'New private reply',
          ),
          wrappedEvent: Nip01Event(
            pubKey: coordinator,
            kind: 1059,
            tags: [],
            content: 'wrapped',
          ),
          peerPubKey: coordinator,
          isOutgoing: false,
        ),
      ],
    );
    for (var visit = 0; visit < 2; visit++) {
      await pumpCard(
        tester,
        offer(OfferStatus.dispute.name),
        communication: communication,
        legacyRendezvousRelays: const ['wss://coordinator.example'],
      );
      await tester.pumpAndSettle();
      expect(find.text('Earlier legacy message'), findsOneWidget);
      expect(find.text('New private reply'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
    }
  });

  testWidgets(
    'legacy fallback shows its transport pill and hides attachments',
    (tester) async {
      await pumpCard(
        tester,
        offer(OfferStatus.dispute.name),
        transport: DisputeTextTransport.legacyNip04,
        legacyRendezvousRelays: const ['wss://coordinator.example'],
      );

      await tester.enterText(find.byType(TextField).first, 'Need help');
      await tester.tap(find.byTooltip('Send message'));
      await tester.pumpAndSettle();

      expect(find.text('Legacy NIP-04 compatibility channel'), findsOneWidget);
      expect(find.text('NIP-04'), findsOneWidget);
      expect(find.textContaining('exposes sender, recipient'), findsNothing);
      expect(find.byTooltip('Attach payment evidence'), findsNothing);
      expect(find.widgetWithText(TextField, 'Reply here'), findsOneWidget);
    },
  );

  testWidgets(
    'sending a NIP-17 message updates the chat without a setState error',
    (tester) async {
      await pumpCard(tester, offer(OfferStatus.dispute.name));

      await tester.enterText(find.byType(TextField).first, 'Need help');
      await tester.tap(find.byTooltip('Send message'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('legacy fallback uses only the offer coordinator known relays', (
    tester,
  ) async {
    final communication = _FakeCommunication(
      ndk: ndk,
      transport: DisputeTextTransport.legacyNip04,
    );
    await pumpCard(
      tester,
      offer(OfferStatus.dispute.name),
      communication: communication,
      coordinatorRecord: CoordinatorRecord(
        pubkeyHex: coordinator,
        relays: const ['wss://known-coordinator.example'],
      ),
    );

    await tester.enterText(find.byType(TextField).first, 'Need help');
    await tester.tap(find.byTooltip('Send message'));
    await tester.pumpAndSettle();

    expect(communication.receivedLegacyRendezvousRelays, const [
      'wss://known-coordinator.example',
    ]);
    expect(
      communication.receivedDmRelayDiscoveryRelays,
      unorderedEquals({
        ...kDiscoveryRelays,
        'wss://live-discovery.example',
        'wss://known-coordinator.example',
      }),
    );
  });
}
