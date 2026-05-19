import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../i18n/gen/strings.g.dart';
import 'coordinator_management_screen.dart';
import 'neko_management_screen.dart';
import 'wallet_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.settings.title)),
      body: ListView(
        children: [
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
        ],
      ),
    );
  }
}
