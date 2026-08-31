import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/widgets/dispute_conversation_card.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';

class _FakeCommunication extends DisputeCommunicationService {
  _FakeCommunication({
    required super.ndk,
    this.transport = DisputeTextTransport.nip17,
  });

  final DisputeTextTransport transport;
  Iterable<String>? receivedLegacyRendezvousRelays;
  Iterable<String>? receivedDmRelayDiscoveryRelays;

  @override
  Future<DisputeTextTransport> sendText({
    required Offer offer,
    required String myPubkey,
    required String content,
    String? participantPubkey,
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
  }) async => const [];
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
      unorderedEquals({...kDiscoveryRelays, 'wss://known-coordinator.example'}),
    );
  });
}
