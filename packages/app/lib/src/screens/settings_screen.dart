import 'package:bitblik_core/core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import 'coordinator_management_screen.dart';
import 'display_settings_screen.dart';
import 'neko_management_screen.dart';
import 'notification_settings_screen.dart';
import 'offer_creation_settings_screen.dart';
import 'wallet_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final selectedMethod = ref.watch(selectedPaymentSystemProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.settings.title)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.public),
            title: Text(t.settings.paymentSystem.title),
            subtitle: Text(
              '${selectedMethod.flag} ${_countryName(t, selectedMethod)} · ${selectedMethod.label}',
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _selectPaymentSystem(context, ref, selectedMethod),
          ),
          ListTile(
            leading: const Icon(Icons.pets),
            title: Text(t.nekoManagement.title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              if (kIsWeb) {
                context.go(NekoManagementScreen.routeName);
              } else {
                context.push(NekoManagementScreen.routeName);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: Text(t.wallet.title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              if (kIsWeb) {
                context.go(WalletScreen.routeName);
              } else {
                context.push(WalletScreen.routeName);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: Text(t.coordinator.title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              if (kIsWeb) {
                context.go(CoordinatorManagementScreen.routeName);
              } else {
                context.push(CoordinatorManagementScreen.routeName);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: Text(t.notificationSettings.title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.push(NotificationSettingsScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.edit_note),
            title: Text(t.settings.offerCreation.title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.push(OfferCreationSettingsScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.monitor_outlined),
            title: Text(t.settings.display.title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.push(DisplaySettingsScreen.routeName),
          ),
        ],
      ),
    );
  }

  /// Localized country name keyed by the method's ISO country code, falling
  /// back to the raw code if no translation exists.
  String _countryName(Translations t, PaymentSystem method) {
    final name = t['settings.paymentSystem.countries.${method.country}'];
    return name is String ? name : method.country;
  }

  Future<void> _selectPaymentSystem(
    BuildContext context,
    WidgetRef ref,
    PaymentSystem current,
  ) async {
    final t = Translations.of(context);
    final chosen = await showDialog<PaymentSystem>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(t.settings.paymentSystem.dialogTitle),
          children: [
            for (final method in kPaymentSystems)
              RadioListTile<PaymentSystem>(
                value: method,
                groupValue: current,
                title: Text('${method.flag}  ${_countryName(t, method)}'),
                subtitle: Text('${method.label} · ${method.currency}'),
                onChanged: (value) => Navigator.of(context).pop(value),
              ),
          ],
        );
      },
    );
    if (chosen != null && chosen.id != current.id) {
      await ref.read(selectedPaymentSystemProvider.notifier).set(chosen);
    }
  }
}
