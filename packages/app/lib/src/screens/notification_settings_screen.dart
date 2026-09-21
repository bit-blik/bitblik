import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import '../services/notification_service.dart';

bool get _isAndroid => !kIsWeb && Platform.isAndroid;

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  static const routeName = '/notification-settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final newOfferAlertsEnabled = ref.watch(newOfferNotificationsProvider);
    final activeOfferAlertsEnabled = ref.watch(
      activeOfferNotificationsProvider,
    );

    return Scaffold(
      appBar: AppBar(title: Text(t.notificationSettings.title)),
      body: ListView(
        children: [
          if (!_isAndroid)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                t.notificationSettings.androidOnly,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: Text(t.notificationSettings.newOfferAlerts.label),
            subtitle: Text(
              t.notificationSettings.newOfferAlerts.description(
                app: ref.watch(selectedPaymentSystemProvider).brandName,
              ),
            ),
            value: _isAndroid && newOfferAlertsEnabled,
            onChanged: _isAndroid
                ? (value) async {
                    if (!value) {
                      await ref
                          .read(newOfferNotificationsProvider.notifier)
                          .set(false);
                      return;
                    }
                    final granted = await NotificationService()
                        .requestPermissions();
                    if (granted) {
                      await ref
                          .read(newOfferNotificationsProvider.notifier)
                          .set(true);
                    }
                  }
                : null,
          ),
          SwitchListTile(
            secondary: const Icon(Icons.sync_outlined),
            title: Text(t.notificationSettings.activeOfferAlerts.label),
            subtitle: Text(
              t.notificationSettings.activeOfferAlerts.description(
                app: ref.watch(selectedPaymentSystemProvider).brandName,
              ),
            ),
            value: _isAndroid && activeOfferAlertsEnabled,
            onChanged: _isAndroid
                ? (value) async {
                    if (!value) {
                      await ref
                          .read(activeOfferNotificationsProvider.notifier)
                          .set(false);
                      return;
                    }
                    final granted = await NotificationService()
                        .requestPermissions();
                    if (granted) {
                      await ref
                          .read(activeOfferNotificationsProvider.notifier)
                          .set(true);
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
