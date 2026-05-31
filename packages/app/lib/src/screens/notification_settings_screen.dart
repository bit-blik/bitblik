import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  static const routeName = '/notification-settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final enabled = ref.watch(newOfferNotificationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.notificationSettings.title)),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: Text(t.notificationSettings.newOfferAlerts.label),
            subtitle: Text(t.notificationSettings.newOfferAlerts.description),
            value: enabled,
            onChanged: (value) =>
                ref.read(newOfferNotificationsProvider.notifier).set(value),
          ),
        ],
      ),
    );
  }
}
