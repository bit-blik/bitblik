import 'package:bitblik_core/core.dart';
import 'package:ndk/entities.dart';
import 'package:test/test.dart';

class _ReceivingWallet extends Wallet {
  final bool bolt11;
  final bool bip321;
  final Set<WalletPaymentProtocol> protocols;

  _ReceivingWallet(
    String id, {
    required this.bolt11,
    required this.bip321,
    required this.protocols,
  }) : super(
          id: id,
          name: id,
          type: WalletType.NWC,
          supportedUnits: const {'sat'},
          metadata: const {},
        );

  @override
  bool get canReceive => true;

  @override
  bool get canSend => false;

  @override
  Set<WalletPaymentProtocol> get receivePaymentProtocols => protocols;

  @override
  bool get supportsBip321Receive => bip321;

  @override
  bool get supportsBolt11InvoiceReceive => bolt11;

  @override
  Map<String, dynamic> toMetadata() => metadata;
}

void main() {
  const invoice = 'lnbc10u1example';
  const offer = 'lno1zcss9mk8y3wkklfvevcrszlmu23kfrxh49px20665dqwmn4p72pksese';

  test('extracts typed instructions from raw and BIP-321 values', () {
    expect(extractBolt11Invoice('lightning:$invoice'), invoice);
    expect(extractBolt11Invoice({'invoice': invoice}), invoice);
    expect(extractBolt12Offer(offer), offer);
    expect(extractBolt12Offer('bitcoin:?lno=$offer'), offer);
  });

  test('wire params preserve the explicit one-of field', () {
    expect(
      const ReceivingInvoice(invoice).toWireParams(purpose: 'taker'),
      {'taker_invoice': invoice},
    );
    expect(
      const ReceivingOffer(offer).toWireParams(purpose: 'maker'),
      {'maker_offer': offer},
    );
    expect(const ReceivingInvoice(invoice).bolt12, isNull);
    expect(const ReceivingOffer(offer).bolt11, isNull);
  });

  test('wraps only a BOLT12 offer into a BIP-321 payment URI', () {
    expect(bip321ForBolt12Offer(offer), 'bitcoin:?lno=$offer');
    expect(() => bip321ForBolt12Offer(invoice), throwsFormatException);
  });

  test('BOLT12 coordinator prefers a BIP-321 BOLT12 receiving wallet', () {
    final bolt11Wallet = _ReceivingWallet(
      'bolt11-default',
      bolt11: true,
      bip321: false,
      protocols: const {WalletPaymentProtocol.bolt11},
    );
    final bolt12Wallet = _ReceivingWallet(
      'bolt12',
      bolt11: false,
      bip321: true,
      protocols: const {WalletPaymentProtocol.bolt12},
    );

    expect(
      selectReceivingWalletForCoordinator(
        [bolt11Wallet, bolt12Wallet],
        coordinatorSupportsBolt12: true,
        defaultWallet: bolt11Wallet,
      ),
      same(bolt12Wallet),
    );
  });

  test('legacy coordinator selects only a direct BOLT11 receiver', () {
    final bolt12Wallet = _ReceivingWallet(
      'bolt12-default',
      bolt11: false,
      bip321: true,
      protocols: const {WalletPaymentProtocol.bolt12},
    );
    final bolt11Wallet = _ReceivingWallet(
      'bolt11',
      bolt11: true,
      bip321: false,
      protocols: const {WalletPaymentProtocol.bolt11},
    );

    expect(
      selectReceivingWalletForCoordinator(
        [bolt12Wallet, bolt11Wallet],
        coordinatorSupportsBolt12: false,
        defaultWallet: bolt12Wallet,
      ),
      same(bolt11Wallet),
    );
    expect(
      selectReceivingWalletForCoordinator(
        [bolt12Wallet],
        coordinatorSupportsBolt12: false,
        defaultWallet: bolt12Wallet,
      ),
      isNull,
    );
    expect(hasOnlyBolt12ReceivingWallets([bolt12Wallet]), isTrue);
    expect(
      hasOnlyBolt12ReceivingWallets([bolt12Wallet, bolt11Wallet]),
      isFalse,
    );
  });

  test('explicit compatible wallet selection is respected', () {
    final first = _ReceivingWallet(
      'first',
      bolt11: true,
      bip321: false,
      protocols: const {WalletPaymentProtocol.bolt11},
    );
    final selected = _ReceivingWallet(
      'selected',
      bolt11: true,
      bip321: true,
      protocols: const {
        WalletPaymentProtocol.bolt11,
        WalletPaymentProtocol.bolt12,
      },
    );

    expect(
      selectReceivingWalletForCoordinator(
        [first, selected],
        coordinatorSupportsBolt12: true,
        defaultWallet: first,
        walletId: selected.id,
      ),
      same(selected),
    );
  });
}
