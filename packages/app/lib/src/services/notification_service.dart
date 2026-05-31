import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

typedef NotificationTap = ({String? actionId, String? payload});

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  static const int _foregroundServiceId = 99;
  static const int _blikReminderId = 10;
  static const String _newOfferCategoryId = 'new_offer';
  static const String actionTakeOffer = 'take_offer';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  Timer? _blikReminderTimer;

  final _tapController = StreamController<NotificationTap>.broadcast();
  Stream<NotificationTap> get tapStream => _tapController.stream;

  Future<void> init() async {
    if (_initialized || kIsWeb) return;
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      notificationCategories: [
        DarwinNotificationCategory(
          _newOfferCategoryId,
          actions: [
            DarwinNotificationAction.plain(
              actionTakeOffer,
              'Take Offer',
              options: {DarwinNotificationActionOption.foreground},
            ),
          ],
        ),
      ],
    );
    const linuxSettings = LinuxInitializationSettings(defaultActionName: 'Open');
    final settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
      linux: linuxSettings,
    );
    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          _tapController.add((actionId: response.actionId, payload: payload));
        }
      },
    );
    if (!kIsWeb && Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
    _initialized = true;
  }

  Future<void> show(
    int id,
    String title,
    String body, {
    String? payload,
  }) async {
    if (!_initialized || kIsWeb) return;
    const androidDetails = AndroidNotificationDetails(
      'offer_status',
      'Offer Status',
      channelDescription: 'Notifications about offer status changes',
      importance: Importance.high,
      priority: Priority.high,
    );
    const darwinDetails = DarwinNotificationDetails();
    const linuxDetails = LinuxNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
      linux: linuxDetails,
    );
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }

  Future<void> showNewOffer({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    if (!_initialized || kIsWeb) return;
    const androidDetails = AndroidNotificationDetails(
      'offer_status',
      'Offer Status',
      channelDescription: 'Notifications about offer status changes',
      importance: Importance.high,
      priority: Priority.high,
      actions: [
        AndroidNotificationAction(
          actionTakeOffer,
          'Take Offer',
          showsUserInterface: true,
        ),
      ],
    );
    const darwinDetails = DarwinNotificationDetails(
      categoryIdentifier: _newOfferCategoryId,
    );
    const linuxDetails = LinuxNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
      linux: linuxDetails,
    );
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }

  void scheduleBlikReminder(String title, String body) {
    _blikReminderTimer?.cancel();
    _blikReminderTimer = Timer(const Duration(minutes: 1), () {
      show(_blikReminderId, title, body);
    });
  }

  void cancelBlikReminder() {
    _blikReminderTimer?.cancel();
    _blikReminderTimer = null;
  }

  Future<void> startOfferForegroundService(String title, String body) async {
    if (!_initialized || kIsWeb) return;
    if (!Platform.isAndroid) return;
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.startForegroundService(
          id: _foregroundServiceId,
          title: title,
          body: body,
          notificationDetails: const AndroidNotificationDetails(
            'offer_foreground',
            'Active Offer',
            channelDescription:
                'Keeps relay connection alive during an active offer',
            importance: Importance.low,
            priority: Priority.low,
            ongoing: true,
            showWhen: false,
          ),
          startType: AndroidServiceStartType.startSticky,
          foregroundServiceTypes: {
            AndroidServiceForegroundType.foregroundServiceTypeDataSync,
          },
        );
  }

  Future<void> stopOfferForegroundService() async {
    if (!_initialized || kIsWeb) return;
    if (!Platform.isAndroid) return;
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.stopForegroundService();
  }
}
