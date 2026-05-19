import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:ndk/shared/nips/nip19/nip19.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import '../services/nostr_service.dart';

class CoordinatorSelector extends ConsumerStatefulWidget {
  final DiscoveredCoordinator? selectedCoordinator;
  final Function(DiscoveredCoordinator)? onCoordinatorSelected;
  final bool showInfoOnly;
  final double? fiatExchangeRate;
  final Function(bool)? onTermsAcceptedChanged;

  const CoordinatorSelector({
    super.key,
    this.selectedCoordinator,
    this.onCoordinatorSelected,
    this.showInfoOnly = false,
    this.fiatExchangeRate,
    this.onTermsAcceptedChanged,
  });

  @override
  ConsumerState<CoordinatorSelector> createState() =>
      _CoordinatorSelectorState();
}

class _CoordinatorSelectorState extends ConsumerState<CoordinatorSelector> {
  bool _termsAccepted = false;
  bool _isLoadingTerms = true;

  @override
  void initState() {
    super.initState();
    _loadTermsAcceptance();
  }

  Future<void> _loadTermsAcceptance() async {
    if (widget.selectedCoordinator?.termsOfUsageNaddr == null) {
      setState(() {
        _termsAccepted = false;
        _isLoadingTerms = false;
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final key = 'terms_accepted_${widget.selectedCoordinator!.pubkey}';
    final accepted = prefs.getBool(key) ?? false;

    setState(() {
      _termsAccepted = accepted;
      _isLoadingTerms = false;
    });
    widget.onTermsAcceptedChanged?.call(accepted);
  }

  Future<void> _saveTermsAcceptance(bool accepted) async {
    if (widget.selectedCoordinator?.termsOfUsageNaddr == null) return;

    final prefs = await SharedPreferences.getInstance();
    final key = 'terms_accepted_${widget.selectedCoordinator!.pubkey}';
    await prefs.setBool(key, accepted);

    setState(() {
      _termsAccepted = accepted;
    });
    widget.onTermsAcceptedChanged?.call(accepted);
  }

  Future<void> _openTermsOfUsage(String naddr) async {
    final url = 'https://njump.to/$naddr';
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  void didUpdateWidget(CoordinatorSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCoordinator?.pubkey !=
        widget.selectedCoordinator?.pubkey) {
      _loadTermsAcceptance();
    }
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String text, {
    Color? iconColor,
    Color? textColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: iconColor ?? Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: textColor ?? Colors.grey),
        ),
      ],
    );
  }

  Future<void> _showCoordinatorPicker(BuildContext context) async {
    final t = Translations.of(context);
    final coordinatorsAsync = ref.read(discoveredCoordinatorsProvider);
    if (coordinatorsAsync is AsyncData<List<DiscoveredCoordinator>>) {
      final coordinators = coordinatorsAsync.value;
      await showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              children:
                  coordinators.map((coordinator) {
                    final rate = widget.fiatExchangeRate ?? 1.0;
                    final minPln = (coordinator.minAmountSats /
                            100000000.0 *
                            rate)
                        .toStringAsFixed(2);
                    final maxPln =
                        (coordinator.maxAmountSats / 100000000.0 * rate)
                            .floor()
                            .toString();
                    final feePct = coordinator.makerFee.toStringAsFixed(2);
                    final t = Translations.of(context);
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              (coordinator.icon != null &&
                                      coordinator.icon!.isNotEmpty)
                                  ? (coordinator.icon!.startsWith('http')
                                      ? Image.network(
                                        coordinator.icon!,
                                        width: 32,
                                        height: 32,
                                      )
                                      : Image.asset(
                                        coordinator.icon!,
                                        width: 32,
                                        height: 32,
                                      ))
                                  : const Icon(Icons.account_circle, size: 32),
                              const SizedBox(width: 8),
                              Text(
                                coordinator.name,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      (coordinator.responsive == false ||
                                              coordinator.responsive == null)
                                          ? Colors.grey
                                          : null,
                                ),
                              ),
                              if (coordinator.responsive == true)
                                const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 18,
                                  ),
                                ),
                              if (coordinator.responsive == false)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Tooltip(
                                    message:
                                        t.coordinator.selector.unresponsive,
                                    preferBelow: false,
                                    child: const Icon(
                                      Icons.error_outline,
                                      color: Colors.redAccent,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              if (coordinator.responsive == null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Tooltip(
                                    message:
                                        t.coordinator.selector.waitingResponse,
                                    preferBelow: false,
                                    child: const Icon(
                                      Icons.help_outline,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              const Spacer(),
                              IconButton(
                                icon: Image.asset(
                                  'assets/nostr.png',
                                  width: 32,
                                  height: 32,
                                ),
                                tooltip:
                                    t.coordinator.selector.viewNostrProfile,
                                onPressed: () async {
                                  final url =
                                      'https://njump.to/${Nip19.encodePubKey(coordinator.pubkey)}';
                                  await launchUrl(
                                    Uri.parse(url),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                              ),
                              if (widget.selectedCoordinator?.pubkey ==
                                  coordinator.pubkey)
                                Icon(
                                  Icons.check,
                                  color: Theme.of(context).primaryColor,
                                ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Wrap(
                            spacing: 12,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              if (coordinator.version.isNotEmpty)
                                Text(
                                  'v${coordinator.version}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                              Text(
                                t.coordinator.info.rangeDisplay(
                                  minAmount: minPln,
                                  maxAmount: maxPln,
                                  currency: 'PLN',
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                t.coordinator.info.feeDisplay(fee: feePct),
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap:
                          (coordinator.responsive == false ||
                                  coordinator.responsive == null)
                              ? null
                              : () {
                                Navigator.of(context).pop();
                                widget.onCoordinatorSelected?.call(coordinator);
                              },
                      tileColor:
                          (coordinator.responsive == false ||
                                  coordinator.responsive == null)
                              ? Colors.grey.withOpacity(0.15)
                              : null,
                    );
                  }).toList(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final coordinatorsAsync = ref.watch(discoveredCoordinatorsProvider);
    final selectedCoordinator = widget.selectedCoordinator;

    // Handle loading state
    if (coordinatorsAsync is AsyncLoading) {
      return Center(
        child: ElevatedButton.icon(
          icon: const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          label: Text(t.coordinator.selector.loading),
          onPressed: null, // Disabled while loading
        ),
      );
    }

    // Handle error state
    if (coordinatorsAsync is AsyncError) {
      return Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.error_outline),
          label: Text(t.coordinator.selector.errorLoading),
          onPressed: () => _showCoordinatorPicker(context),
        ),
      );
    }

    // Handle data state
    if (coordinatorsAsync is AsyncData<List<DiscoveredCoordinator>>) {
      final coordinators = coordinatorsAsync.value;

      // Debug logging
      Logger.log.d(
        () =>
            '🔍 CoordinatorSelector: Found ${coordinators.length} coordinators',
      );
      for (final coordinator in coordinators) {
        Logger.log.d(
          () => '  - ${coordinator.name}: responsive=${coordinator.responsive}',
        );
      }

      // Find the first responsive coordinator for auto-selection
      final responsiveCoordinators =
          coordinators.where((c) => c.responsive == true).toList();
      final firstResponsiveCoordinator =
          responsiveCoordinators.isNotEmpty
              ? responsiveCoordinators.first
              : null;

      Logger.log.d(
        () =>
            '🔍 CoordinatorSelector: Found ${responsiveCoordinators.length} responsive coordinators',
      );
      if (firstResponsiveCoordinator != null) {
        Logger.log.d(
          () => '  - First responsive: ${firstResponsiveCoordinator.name}',
        );
      } else {
        Logger.log.d(() => '  - No responsive coordinators found');
      }

      // Auto-select the first responsive coordinator if none is selected
      if (selectedCoordinator == null &&
          firstResponsiveCoordinator != null &&
          widget.onCoordinatorSelected != null) {
        Logger.log.d(
          () =>
              '🔍 CoordinatorSelector: Auto-selecting ${firstResponsiveCoordinator.name}',
        );
        // Use WidgetsBinding to call the callback after the current build is complete
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onCoordinatorSelected!(firstResponsiveCoordinator);
        });
      }

      // Use selected coordinator if available, otherwise use the first responsive one
      final displayCoordinator =
          selectedCoordinator ?? firstResponsiveCoordinator;
      Logger.log.d(
        () =>
            '🔍 CoordinatorSelector: Display coordinator: ${displayCoordinator?.name ?? 'none'}',
      );

      if (displayCoordinator != null) {
        // Compose details for min/max PLN and maker fee
        final rate = widget.fiatExchangeRate ?? 1.0;
        final minPln = (displayCoordinator.minAmountSats / 100000000.0 * rate)
            .toStringAsFixed(2);
        final maxPln =
            (displayCoordinator.maxAmountSats / 100000000.0 * rate)
                .floor()
                .toString();
        final feePct = displayCoordinator.makerFee.toStringAsFixed(2);
        final t = Translations.of(context);
        return GestureDetector(
          onTap: () => _showCoordinatorPicker(context),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      (displayCoordinator.icon != null &&
                              displayCoordinator.icon!.isNotEmpty)
                          ? (displayCoordinator.icon!.startsWith('http')
                              ? Image.network(
                                displayCoordinator.icon!,
                                width: 32,
                                height: 32,
                              )
                              : Image.asset(
                                displayCoordinator.icon!,
                                width: 32,
                                height: 32,
                              ))
                          : const Icon(Icons.account_circle, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        displayCoordinator.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Wrap(
                    spacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (displayCoordinator.version.isNotEmpty)
                        Text(
                          'v${displayCoordinator.version}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      Text(
                        t.coordinator.info.rangeDisplay(
                          minAmount: minPln,
                          maxAmount: maxPln,
                          currency: 'PLN',
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        t.coordinator.info.feeDisplay(fee: feePct),
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                  // Terms of Usage checkbox
                  if (displayCoordinator.termsOfUsageNaddr != null &&
                      !widget.showInfoOnly) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (_isLoadingTerms)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        else
                          Checkbox(
                            value: _termsAccepted,
                            onChanged: (bool? value) {
                              _saveTermsAcceptance(value ?? false);
                            },
                          ),
                        Expanded(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _saveTermsAcceptance(!_termsAccepted);
                                },
                                child: Text(
                                  t.coordinator.selector.termsAccept,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap:
                                      () => _openTermsOfUsage(
                                        displayCoordinator.termsOfUsageNaddr!,
                                      ),
                                  child: Text(
                                    t.coordinator.selector.termsOfUsage,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // IconButton(
                        //   icon: const Icon(
                        //     Icons.open_in_new,
                        //     size: 18,
                        //     color: Colors.blue,
                        //   ),
                        //   onPressed: () => _openTermsOfUsage(
                        //     displayCoordinator.termsOfUsageNaddr!,
                        //   ),
                        //   padding: EdgeInsets.zero,
                        //   constraints: const BoxConstraints(),
                        // ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      }
    }

    // Fallback - show choose coordinator button
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.hub),
        label: Text(t.coordinator.selector.choose),
        onPressed: () => _showCoordinatorPicker(context),
      ),
    );
  }
}
