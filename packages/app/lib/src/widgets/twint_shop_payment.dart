import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../flow/flow_timeout.dart';
import 'twint_payment_qr.dart';

/// Loads an authorized snapshot for this reservation. Cached offer payloads
/// cannot prove that the maker has not replaced a previously received QR.
class TwintShopPayment extends StatefulWidget {
  final Offer offer;
  final FlowEngine engine;
  final bool showInstructions;
  final Future<Offer?> Function(Offer) loadOffer;

  const TwintShopPayment({
    super.key,
    required this.offer,
    required this.engine,
    this.showInstructions = true,
    required this.loadOffer,
  });

  @override
  State<TwintShopPayment> createState() => _TwintShopPaymentState();
}

class _TwintShopPaymentState extends State<TwintShopPayment>
    with WidgetsBindingObserver {
  Offer? _authorized;
  bool _loading = true;
  int _generation = 0;

  Object _revision(Offer offer) => (
    offer.id,
    offer.coordinatorPubkey,
    offer.takerPubkey,
    offer.statusRaw,
    offer.reservedAt,
    offer.blikReceivedAt,
    offer.blikCode,
    offer.fiatAmount,
    offer.fiatCurrency,
    offer.category,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  @override
  void didUpdateWidget(TwintShopPayment oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_revision(oldWidget.offer) != _revision(widget.offer)) _load();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _load();
  }

  Future<void> _load() async {
    final generation = ++_generation;
    final requested = widget.offer;
    setState(() {
      _authorized = null;
      _loading = true;
    });
    Offer? accepted;
    try {
      final remote = await widget.loadOffer(requested);
      if (remote != null &&
          remote.id == requested.id &&
          remote.category == OfferCategory.shop &&
          paymentSystemForOffer(remote).id == 'twint' &&
          remote.statusRaw == 'reserved' &&
          remote.takerPubkey != null &&
          remote.takerPubkey == requested.takerPubkey &&
          remote.fiatCurrency == 'CHF' &&
          remote.blikReceivedAt != null &&
          // Status updates use epoch seconds; private RPC timestamps preserve
          // subsecond precision. Compare at the wire's shared precision.
          remote.reservedAt != null &&
          remote.reservedAt!.millisecondsSinceEpoch ~/ 1000 ==
              (requested.reservedAt?.millisecondsSinceEpoch ?? -1) ~/ 1000) {
        final qr = TwintShopQr.tryParse(remote.blikCode ?? '');
        if (qr != null &&
            qr.matchesAmount(remote.fiatAmount) &&
            qr.matchesAmount(requested.fiatAmount)) {
          accepted = remote;
        }
      }
    } catch (_) {
      // The retry state never includes private payloads or raw server errors.
    }
    if (!mounted || generation != _generation) return;
    setState(() {
      _authorized = accepted;
      _loading = false;
    });
  }

  @override
  void dispose() {
    ++_generation;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    if (widget.offer.statusRaw != 'reserved') {
      return Text(t.twint.shop.expired, textAlign: TextAlign.center);
    }
    final offer = _authorized;
    if (offer != null) {
      final deadline = flowStateDeadline(widget.engine, 'reserved', offer);
      if (deadline != null) {
        return TwintPaymentQr(
          payload: offer.blikCode!,
          expiresAt: deadline,
          showInstructions: widget.showInstructions,
        );
      }
    }
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(
          semanticsLabel: t.common.notifications.loading,
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(liveRegion: true, child: Text(t.twint.shop.loadingFailed)),
        const SizedBox(height: 8),
        OutlinedButton(onPressed: _load, child: Text(t.common.buttons.retry)),
      ],
    );
  }
}
