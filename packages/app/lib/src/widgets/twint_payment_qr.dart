import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../utils/save_payment_qr.dart';
import '../utils/twint_qr_image.dart';

/// Presentation of an authorized shop payload. The caller owns retrieval and
/// validation; this widget never submits a payment or a flow action.
class TwintPaymentQr extends StatefulWidget {
  final String payload;
  final DateTime expiresAt;
  final bool showInstructions;
  final Future<PaymentQrSaveResult> Function(Uint8List) saveImage;

  const TwintPaymentQr({
    super.key,
    required this.payload,
    required this.expiresAt,
    this.showInstructions = true,
    this.saveImage = savePaymentQr,
  });

  @override
  State<TwintPaymentQr> createState() => _TwintPaymentQrState();
}

class _TwintPaymentQrState extends State<TwintPaymentQr>
    with WidgetsBindingObserver {
  Uint8List? _png;
  Timer? _expiryTimer;
  bool _expired = false;
  bool _saving = false;
  bool _saveFailed = false;
  DialogRoute<void>? _previewRoute;

  bool get _canPay => !_expired && widget.expiresAt.isAfter(DateTime.now());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resetImage();
  }

  @override
  void didUpdateWidget(TwintPaymentQr oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.payload != widget.payload ||
        oldWidget.expiresAt != widget.expiresAt) {
      _resetImage();
    }
  }

  void _resetImage() {
    _dismissPreview();
    _expiryTimer?.cancel();
    _saveFailed = false;
    final remaining = widget.expiresAt.difference(DateTime.now());
    _expired = remaining <= Duration.zero;
    _png = _expired ? null : renderTwintQrPng(widget.payload);
    if (!_expired) {
      _expiryTimer = Timer(remaining, () {
        if (mounted) {
          setState(() {
            _expired = true;
            _png = null;
          });
          _dismissPreview();
        }
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted && !_canPay) {
      setState(() {
        _expired = true;
        _png = null;
      });
      _dismissPreview();
    }
  }

  void _dismissPreview() {
    final route = _previewRoute;
    _previewRoute = null;
    if (route == null) return;
    // Updates/disposal can occur during build. Remove only our own route once
    // that frame finishes, never a newer route opened above it.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (route.isActive) route.navigator?.removeRoute(route);
    });
  }

  Future<void> _showPreview() async {
    if (!_canPay || _png == null || _previewRoute != null) return;
    final png = _png!;
    final strings = Translations.of(context);
    final route = DialogRoute<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        scrollable: true,
        title: Text(strings.twint.shop.qrLabel),
        content: SizedBox(
          width: 400,
          child: Image.memory(
            png,
            semanticLabel: strings.twint.shop.qrLabel,
            filterQuality: FilterQuality.none,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(strings.common.buttons.close),
          ),
        ],
      ),
    );
    _previewRoute = route;
    await Navigator.of(context, rootNavigator: true).push(route);
    if (identical(_previewRoute, route)) _previewRoute = null;
  }

  Future<void> _save() async {
    if (_saving || !_canPay || _png == null) return;
    final payload = widget.payload;
    final expiresAt = widget.expiresAt;
    setState(() {
      _saving = true;
      _saveFailed = false;
    });
    try {
      final result = await widget.saveImage(_png!);
      if (!mounted ||
          widget.payload != payload ||
          widget.expiresAt != expiresAt ||
          !_canPay) {
        return;
      }
      final strings = Translations.of(context).twint.shop;
      final message = switch (result) {
        PaymentQrSaveResult.saved => strings.saved,
        PaymentQrSaveResult.downloadStarted => strings.downloadStarted,
        PaymentQrSaveResult.cancelled => null,
      };
      if (message != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (_) {
      if (mounted &&
          widget.payload == payload &&
          widget.expiresAt == expiresAt &&
          _canPay) {
        setState(() => _saveFailed = true);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _dismissPreview();
    WidgetsBinding.instance.removeObserver(this);
    _expiryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = Translations.of(context).twint.shop;
    if (!_canPay || _png == null) {
      return Semantics(
        liveRegion: true,
        child: Text(strings.expired, textAlign: TextAlign.center),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showInstructions) ...[
          Text(strings.payInstructions, textAlign: TextAlign.center),
          const SizedBox(height: 16),
        ],
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.download),
              label: Text(
                _saving
                    ? strings.saving
                    : savesPaymentQrToGallery
                    ? strings.saveImage
                    : strings.downloadImage,
              ),
            ),
            IconButton.outlined(
              tooltip: strings.qrLabel,
              onPressed: _showPreview,
              icon: const Icon(Icons.qr_code_2),
            ),
          ],
        ),
        if (_saveFailed) ...[
          const SizedBox(height: 12),
          Semantics(
            liveRegion: true,
            child: Text(
              strings.saveFailed,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ],
    );
  }
}
