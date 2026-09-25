import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

typedef NotificationTap = ({String? actionId, String? payload});

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  static const _offerMonitoringChannel = MethodChannel(
    'app.bitblik/offer_monitoring',
  );
  static const int _blikReminderId = 10;
  static const String _newOfferCategoryId = 'new_offer';
  static const String actionTakeOffer = 'take_offer';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  Timer? _blikReminderTimer;
  late final _foregroundService = ForegroundServiceController(
    start: _startOfferForegroundService,
    stop: _stopOfferForegroundService,
  );

  final _tapController = StreamController<NotificationTap>.broadcast();
  Stream<NotificationTap> get tapStream => _tapController.stream;

  Future<void> init() async {
    if (_initialized || kIsWeb) return;
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
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
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open',
    );
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
    _initialized = true;
  }

  /// Requests notification permissions from the OS. Call this only when the
  /// user explicitly opts in (e.g. toggling the background-service switch in
  /// settings). Returns true if permissions were granted. On iOS/macOS this
  /// shows the system permission dialog; on Android 13+ it requests the
  /// POST_NOTIFICATIONS runtime permission.
  Future<bool> requestPermissions() async {
    if (!_initialized || kIsWeb) return false;
    if (Platform.isAndroid) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return granted ?? false;
    }
    if (Platform.isIOS || Platform.isMacOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    }
    return true;
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
      'New Offers',
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
      'New Offers',
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

  Future<void> startOfferForegroundService(String title, String body) {
    if (!_initialized || kIsWeb || !Platform.isAndroid) return Future.value();
    return _foregroundService.update((title, body));
  }

  Future<void> stopOfferForegroundService() {
    if (!_initialized || kIsWeb || !Platform.isAndroid) return Future.value();
    return _foregroundService.update(null);
  }

  /// The OS may have stopped dataSync at its background time limit.
  void resetForegroundServiceAfterResume() => _foregroundService.invalidate();

  Future<void> _startOfferForegroundService(String title, String body) async {
    if (!_initialized || kIsWeb) return;
    if (!Platform.isAndroid) return;
    await _offerMonitoringChannel.invokeMethod<void>('start', {
      'title': title,
      'body': body,
    });
  }

  Future<void> _stopOfferForegroundService() async {
    if (!_initialized || kIsWeb || !Platform.isAndroid) return;
    await _offerMonitoringChannel.invokeMethod<void>('stop');
  }
}

/// Serializes Android service commands and skips identical notification updates.
/// A failed command remains retryable and cannot poison the command queue.
class ForegroundServiceController {
  ForegroundServiceController({required this.start, required this.stop});

  final Future<void> Function(String, String) start;
  final Future<void> Function() stop;
  Future<void> _pending = Future.value();
  (String, String)? _applied;
  bool _known = false;
  int _generation = 0;

  void invalidate() {
    _known = false;
    _generation++;
  }

  Future<void> update((String, String)? notification) {
    final operation = _pending.then((_) async {
      if (_known && _applied == notification) return;
      final generation = _generation;
      if (notification == null) {
        await stop();
      } else {
        await start(notification.$1, notification.$2);
      }
      _applied = notification;
      _known = generation == _generation;
    });
    _pending = operation.catchError((Object _) {});
    return operation;
  }
}
