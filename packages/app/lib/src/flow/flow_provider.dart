import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitblik_core/core.dart';

import '../providers/providers.dart'
    show selectedPaymentSystemProvider, ndkProvider, apiServiceProvider;
import 'taker_receive_invoice.dart';

/// The single route used for every coordinator flow interaction.
const String flowRoute = '/flow';

/// Loads and caches [FlowEngine]s parsed from the flow definitions bundled as
/// package assets from `bitblik_core/lib/flows/` — the single source of truth
/// shared with the coordinator and core tests (no copy in this repo).
class AppFlowLoader {
  static final Map<String, FlowEngine> _cache = {};

  static Future<FlowEngine> load(String flowId) async {
    final cached = _cache[flowId];
    if (cached != null) return cached;
    final src = await rootBundle.loadString(
      'packages/bitblik_core/flows/$flowId.yml',
    );
    final engine = await FlowEngine.fromYamlWithImports(
      src,
      (importPath) =>
          rootBundle.loadString('packages/bitblik_core/flows/$importPath'),
    );
    _cache[flowId] = engine;
    return engine;
  }
}

/// The [FlowEngine] for the active payment system. Watches
/// [selectedPaymentSystemProvider] so it re-resolves when the market changes.
final flowEngineProvider = FutureProvider<FlowEngine>((ref) async {
  final ps = ref.watch(selectedPaymentSystemProvider);
  return AppFlowLoader.load(ps.flowId);
});

/// When the active flow captures the taker's payout instruction at reserve,
/// generate one for [offer]'s net payout from the receiving wallet so it can be
/// sent with `reserve_offer`. Both the legacy `accept_taker_invoice` keyword and
/// its typed `accept_taker_payout` alias are recognized.
Future<ReceivingPayment?> reserveTakerInvoiceIfNeeded(
  WidgetRef ref,
  Offer offer,
) async {
  final engine = await ref.read(flowEngineProvider.future);
  final t = engine.transitionFor(engine.initialState, 'reserve_offer');
  if (t == null ||
      !t.actions.any(
        const {'accept_taker_invoice', 'accept_taker_payout'}.contains,
      )) {
    return null;
  }
  final ndk = ref.read(ndkProvider);
  if (ndk == null) throw Exception('No wallet available to receive payout');
  final coordinator = ref
      .read(apiServiceProvider)
      .getCoordinatorInfoByPubkey(offer.coordinatorPubkey);
  final takerFees =
      offer.takerFees ??
      (coordinator == null
          ? 0
          : OfferQuote.takerFeeSats(offer.amountSats, coordinator.takerFee));
  final netSats = offer.amountSats - takerFees;
  if (netSats <= 0) throw Exception('Invalid payout amount');
  return createBestReceivingPayment(
    ndk,
    netSats,
    coordinatorSupportsBolt12:
        coordinator?.outgoingPaymentTypes.contains('bolt12') ?? false,
  );
}
