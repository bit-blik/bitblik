import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitblik_core/core.dart';

import '../providers/providers.dart'
    show selectedPaymentSystemProvider, ndkProvider;
import 'taker_receive_invoice.dart';

/// Flow ids whose UI is driven by the yaml flow definition (state -> screen
/// registry, engine-derived action buttons, yaml-timeout countdowns) instead of
/// the legacy hardcoded per-screen navigation.
const Set<String> kFlowDrivenFlowIds = {'twint', 'blik', 'mbway'};

bool isFlowDrivenFlow(String? flowId) =>
    flowId != null && kFlowDrivenFlowIds.contains(flowId);

/// Entry-point router helper: `/flow` when the active market is flow-driven,
/// otherwise the legacy per-status route unchanged. Lets existing maker/taker
/// navigation opt into the flow-driven screen without changing BLIK behaviour
/// (BLIK is not flow-driven → always gets [legacyRoute]).
String flowEntryRoute(WidgetRef ref, String legacyRoute) {
  final ps = ref.read(selectedPaymentSystemProvider);
  return isFlowDrivenFlow(ps.flowId) ? '/flow' : legacyRoute;
}

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

/// The [FlowEngine] for the active payment system, or null when that method is
/// not flow-driven (legacy enum navigation applies). Watches
/// [selectedPaymentSystemProvider] so it re-resolves when the market changes.
final flowEngineProvider = FutureProvider<FlowEngine?>((ref) async {
  final ps = ref.watch(selectedPaymentSystemProvider);
  if (!isFlowDrivenFlow(ps.flowId)) return null;
  return AppFlowLoader.load(ps.flowId!);
});

/// When the active flow captures the taker's payout invoice at reserve (its
/// `reserve_offer` transition runs `accept_taker_invoice` — e.g. TWINT), generate
/// a bolt11 invoice for [offer]'s net payout from the receiving wallet so it can
/// be sent with `reserve_offer`. Returns null when not needed. Throws if no
/// receiving wallet is configured / generation fails (the reserve then aborts).
Future<String?> reserveTakerInvoiceIfNeeded(WidgetRef ref, Offer offer) async {
  final ps = ref.read(selectedPaymentSystemProvider);
  if (!isFlowDrivenFlow(ps.flowId)) return null;
  final engine = await ref.read(flowEngineProvider.future);
  final t = engine?.transitionFor(engine.initialState, 'reserve_offer');
  if (t == null || !t.actions.contains('accept_taker_invoice')) return null;
  final ndk = ref.read(ndkProvider);
  if (ndk == null) throw Exception('No wallet available to receive payout');
  final netSats = offer.amountSats - (offer.takerFees ?? 0);
  if (netSats <= 0) throw Exception('Invalid payout amount');
  return createReceivingInvoice(ndk, netSats);
}
