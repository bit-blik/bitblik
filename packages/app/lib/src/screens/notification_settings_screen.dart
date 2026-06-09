import 'dart:io';
import '../config/build_flavor.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';

bool get _isAndroid => !kIsWeb && Platform.isAndroid;

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
            subtitle: Text(t.notificationSettings.newOfferAlerts.description(app: buildAppName)),
            value: _isAndroid && enabled,
            onChanged: _isAndroid
                ? (value) =>
                    ref.read(newOfferNotificationsProvider.notifier).set(value)
                : null,
          ),
        ],
      ),
    );
  }
}
