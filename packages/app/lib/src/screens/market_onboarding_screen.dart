import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';

/// First-launch market/country picker. Shown once on a fresh install (no market
/// saved yet) before the home screen, so the first coordinator-discovery sweep
/// only runs after the user picks their market. The choice is persisted; on
/// later launches the app goes straight to the home screen for that market.
class MarketOnboardingScreen extends ConsumerStatefulWidget {
  const MarketOnboardingScreen({super.key});

  static const routeName = '/onboarding';

  @override
  ConsumerState<MarketOnboardingScreen> createState() =>
      _MarketOnboardingScreenState();
}

class _MarketOnboardingScreenState
    extends ConsumerState<MarketOnboardingScreen> {
  bool _saving = false;

  /// Localized country name keyed by the method's ISO country code, falling
  /// back to the raw code if no translation exists.
  String _countryName(Translations t, PaymentSystem method) {
    final name = t['settings.paymentSystem.countries.${method.country}'];
    return name is String ? name : method.country;
  }

  Future<void> _choose(PaymentSystem method) async {
    if (_saving) return;
    setState(() => _saving = true);
    // Persist the choice while onboarding is still "active" (keeps the picker
    // clean — the cold-start overlay stays suppressed until we navigate away).
    await ref.read(selectedPaymentSystemProvider.notifier).set(method);
    if (!mounted) return;
    // Onboarding done: let the overlay + discovery behave normally on the home
    // screen, then go there.
    ref.read(needsMarketOnboardingProvider.notifier).state = false;
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Icon(
                    Icons.public,
                    size: 56,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    t.onboarding.title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.onboarding.subtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: kPaymentSystems.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final method = kPaymentSystems[index];
                        return Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(
                              color: theme.colorScheme.outlineVariant,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            leading: Text(
                              method.flag,
                              style: const TextStyle(fontSize: 30),
                            ),
                            title: Text(
                              method.label,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              '${_countryName(t, method)} · ${method.currency}',
                            ),
                            trailing:
                                _saving
                                    ? null
                                    : const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    ),
                            onTap: _saving ? null : () => _choose(method),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
