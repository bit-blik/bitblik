import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../i18n/gen/strings.g.dart';
import 'package:bitblik_core/core.dart';
import '../providers/providers.dart';
import '../settings/app_preferences.dart';
import '../utils/category_icons.dart';
import '../widgets/premium_info.dart';

class OfferCreationSettingsScreen extends ConsumerStatefulWidget {
  const OfferCreationSettingsScreen({super.key});

  static const routeName = '/settings/offer-creation';

  @override
  ConsumerState<OfferCreationSettingsScreen> createState() =>
      _OfferCreationSettingsScreenState();
}

class _OfferCreationSettingsScreenState
    extends ConsumerState<OfferCreationSettingsScreen> {
  OfferCreationPreferences? _settings;
  String? _defaultBankId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final settings = await AppPreferencesStore.loadOfferCreation();
    final marketId = ref.read(selectedPaymentSystemProvider).id;
    final defaultBank = await AppPreferencesStore.loadDefaultBank(marketId);
    if (!mounted) return;
    setState(() {
      _settings = settings;
      _defaultBankId = defaultBank;
    });
  }

  /// The current market's bank-scoped ATM instrument, or null when the market
  /// has no banks (BLIK / MB WAY / TWINT).
  InstrumentSpec? get _bankInstrument {
    final ps = ref.read(selectedPaymentSystemProvider);
    final atm = ps.instrumentFor(OfferCategory.atm) ?? ps.instrumentFor(null);
    return (atm?.hasBanks ?? false) ? atm : null;
  }

  Future<void> _saveDefaultBank(String? bankId) async {
    final marketId = ref.read(selectedPaymentSystemProvider).id;
    setState(() => _defaultBankId = bankId);
    await AppPreferencesStore.saveDefaultBank(marketId, bankId);
  }

  Future<void> _save(OfferCreationPreferences settings) async {
    setState(() {
      _settings = settings;
    });
    await AppPreferencesStore.saveOfferCreation(settings);
  }

  String _categoryLabel(Translations t, OfferCategory category) {
    switch (category) {
      case OfferCategory.shop:
        return t.settings.offerCreation.categoryOptions.shop;
      case OfferCategory.atm:
        return t.settings.offerCreation.categoryOptions.atm;
      case OfferCategory.online:
        return t.settings.offerCreation.categoryOptions.online;
    }
  }

  CoordinatorRecord? _coordinatorFor(
    List<CoordinatorRecord> coordinators,
    String? pubkey,
  ) {
    if (pubkey == null) return null;
    for (final coordinator in coordinators) {
      if (coordinator.pubkey == pubkey) return coordinator;
    }
    return null;
  }

  Widget _coordinatorLogo(String? icon, double size) {
    if (icon != null && icon.isNotEmpty) {
      return icon.startsWith('http')
          ? Image.network(
            icon,
            width: size,
            height: size,
            errorBuilder:
                (_, _, _) => Icon(Icons.account_circle, size: size),
          )
          : Image.asset(icon, width: size, height: size);
    }
    return Icon(Icons.account_circle, size: size);
  }

  String _formatPremium(double premium) {
    final s = premium.toStringAsFixed(1);
    return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
  }

  /// Upper bound for the default-premium slider: the highest max premium
  /// advertised across every coordinator that supports premium. Falls back to
  /// 10% when none advertise one. The actual cap applied to an offer is the
  /// selected coordinator's own max, which may be lower.
  double _maxPremium(List<CoordinatorRecord> coordinators) {
    double max = 0;
    for (final coordinator in coordinators) {
      if (coordinator.maxPremium > max) max = coordinator.maxPremium;
    }
    return max > 0 ? max : 10.0;
  }

  Future<void> _showBankPicker(Translations t) async {
    final instrument = _bankInstrument;
    if (instrument == null) return;
    // Sentinel for the "no default" choice (ask/first each time).
    const noneId = '';
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(t.settings.offerCreation.dialogs.selectBank),
              ),
              ListTile(
                leading: const Icon(Icons.remove_circle_outline),
                title: Text(t.settings.offerCreation.defaultBankNone),
                trailing: _defaultBankId == null
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () => Navigator.of(context).pop(noneId),
              ),
              ...instrument.banks.map((b) {
                final isSel = b.id == _defaultBankId;
                return ListTile(
                  leading: const Icon(Icons.account_balance),
                  title: Text(b.label),
                  subtitle: Text('${b.validity.inMinutes} min'),
                  trailing: isSel
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () => Navigator.of(context).pop(b.id),
                );
              }),
            ],
          ),
        );
      },
    );
    if (selected != null) {
      await _saveDefaultBank(selected.isEmpty ? null : selected);
    }
  }

  Future<void> _showCategoryPicker(Translations t) async {
    final current = _settings;
    if (current == null) return;
    final selected = await showModalBottomSheet<OfferCategory>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(t.settings.offerCreation.dialogs.selectCategory),
              ),
              // Only categories the selected payment system supports
              // (e.g. MB WAY → ATM only).
              ...ref
                  .read(selectedPaymentSystemProvider)
                  .supportedCategories
                  .map((category) {
                final selected = current.defaultCategory == category;
                return ListTile(
                  leading: categoryIconWidget(category, 28),
                  title: Text(_categoryLabel(t, category)),
                  trailing:
                      selected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                  onTap: () => Navigator.of(context).pop(category),
                );
              }),
            ],
          ),
        );
      },
    );
    if (selected != null) {
      await _save(current.copyWith(defaultCategory: selected));
    }
  }

  Future<void> _showCoordinatorPicker(
    Translations t,
    List<CoordinatorRecord> coordinators,
  ) async {
    final current = _settings;
    if (current == null) return;
    const automaticSentinel = '__automatic__';
    final cheapestSentinel =
        OfferCreationPreferences.cheapestCoordinatorSentinel;
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(t.settings.offerCreation.dialogs.selectCoordinator),
              ),
              ListTile(
                leading: const Icon(Icons.verified),
                title: Text(t.settings.offerCreation.automaticCoordinator),
                subtitle: Text(
                  t.settings.offerCreation.automaticCoordinatorDescription,
                ),
                trailing:
                    current.preferredCoordinatorPubkey == null
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                onTap: () => Navigator.of(context).pop(automaticSentinel),
              ),
              ListTile(
                leading: const Icon(Icons.savings),
                title: Text(t.settings.offerCreation.cheapestCoordinator),
                subtitle: Text(
                  t.settings.offerCreation.cheapestCoordinatorDescription,
                ),
                trailing:
                    current.preferredCoordinatorPubkey == cheapestSentinel
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                onTap: () => Navigator.of(context).pop(cheapestSentinel),
              ),
              ...coordinators.map((coordinator) {
                final selected =
                    current.preferredCoordinatorPubkey == coordinator.pubkey;
                return ListTile(
                  leading: _coordinatorLogo(coordinator.icon, 28),
                  title: Text(coordinator.name),
                  trailing:
                      selected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                  onTap: () => Navigator.of(context).pop(coordinator.pubkey),
                );
              }),
            ],
          ),
        );
      },
    );
    if (selected == null) return;
    await _save(
      selected == automaticSentinel
          ? current.copyWith(clearPreferredCoordinator: true)
          : current.copyWith(preferredCoordinatorPubkey: selected),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final settings = _settings;
    final coordinatorsAsync = ref.watch(enabledCoordinatorsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.settings.offerCreation.title)),
      body:
          settings == null
              ? const Center(child: CircularProgressIndicator())
              : coordinatorsAsync.when(
                data: (coordinators) {
                  final isCheapest =
                      settings.preferredCoordinatorPubkey ==
                      OfferCreationPreferences.cheapestCoordinatorSentinel;
                  final preferred = _coordinatorFor(
                    coordinators,
                    settings.preferredCoordinatorPubkey,
                  );
                  final isAutomatic = preferred == null && !isCheapest;
                  final maxPremium = _maxPremium(coordinators);
                  final ps = ref.read(selectedPaymentSystemProvider);
                  // Coerce the stored default to a category this market actually
                  // supports (e.g. the global default `shop` for an ATM-only
                  // market like SK), and hide the picker entirely when there's
                  // no choice.
                  final supportedCats = ps.supportedCategories;
                  final effectiveDefaultCategory =
                      supportedCats.contains(settings.defaultCategory)
                          ? settings.defaultCategory
                          : (supportedCats.isNotEmpty
                              ? supportedCats.first
                              : settings.defaultCategory);
                  return ListView(
                    children: [
                      if (ps.hasCategoryChoice)
                        ListTile(
                          leading: categoryIconWidget(
                            effectiveDefaultCategory,
                            28,
                          ),
                          title:
                              Text(t.settings.offerCreation.defaultCategory),
                          subtitle: Text(
                            _categoryLabel(t, effectiveDefaultCategory),
                          ),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => _showCategoryPicker(t),
                        ),
                      if (_bankInstrument != null)
                        ListTile(
                          leading: const Icon(Icons.account_balance),
                          title: Text(t.settings.offerCreation.defaultBank),
                          subtitle: Text(
                            _bankInstrument!
                                    .bankById(_defaultBankId)
                                    ?.label ??
                                t.settings.offerCreation.defaultBankNone,
                          ),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => _showBankPicker(t),
                        ),
                      SwitchListTile(
                        secondary: const Icon(Icons.tune),
                        title: Row(
                          children: [
                            Flexible(
                              child:
                                  Text(t.settings.offerCreation.enablePremium),
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              icon: const Icon(Icons.info_outline, size: 18),
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              tooltip: '',
                              onPressed: () => showPremiumInfoDialog(context),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          t.settings.offerCreation.enablePremiumDescription,
                        ),
                        value: settings.premiumEnabled,
                        onChanged: (value) {
                          _save(settings.copyWith(premiumEnabled: value));
                        },
                      ),
                      if (settings.premiumEnabled)
                        _premiumSlider(t, settings, maxPremium),
                      ListTile(
                        leading:
                            isAutomatic
                                ? const Icon(Icons.verified)
                                : isCheapest
                                ? const Icon(Icons.savings)
                                : _coordinatorLogo(preferred!.icon, 28),
                        title: Text(
                          t.settings.offerCreation.preferredCoordinator,
                        ),
                        subtitle: Text(
                          isAutomatic
                              ? t.settings.offerCreation.automaticCoordinator
                              : isCheapest
                              ? t
                                  .settings
                                  .offerCreation
                                  .cheapestCoordinator
                              : preferred!.name,
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => _showCoordinatorPicker(t, coordinators),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('$error')),
              ),
    );
  }

  Widget _premiumSlider(
    Translations t,
    OfferCreationPreferences settings,
    double maxPremium,
  ) {
    final value = settings.defaultPremiumPercent.clamp(0.0, maxPremium);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.percent, color: Colors.grey),
              const SizedBox(width: 12),
              Text(
                t.settings.offerCreation.defaultPremium,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Text(
                '${_formatPremium(value)}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: value > 0 ? const Color(0xFFFF007F) : Colors.grey,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFFFF007F),
              thumbColor: const Color(0xFFFF007F),
              overlayColor: const Color(0x33FF007F),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: maxPremium,
              divisions: (maxPremium / 0.5).round().clamp(1, 1000),
              label: '${_formatPremium(value)}%',
              onChanged: (next) {
                // Snap to 0.5 steps.
                final snapped = (next * 2).round() / 2;
                _save(settings.copyWith(defaultPremiumPercent: snapped));
              },
            ),
          ),
          Text(
            t.settings.offerCreation.premiumPerCoordinatorNote,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
