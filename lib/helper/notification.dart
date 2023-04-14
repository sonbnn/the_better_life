import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    _configureLocalTimeZone();
    requestIOSPermissions();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) {},
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: callback,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        showDialog(
          context: injector.get<NavigationService>().getCurrentContext,
          builder: (context) {
            return SizedBox(
              height: 300,
              width: 300,
              child: Column(
                children: [
                  Text(notificationResponse.input ?? ''),
                  Text(notificationResponse.id.toString() ?? ''),
                  Text(notificationResponse.notificationResponseType.toString() ?? ''),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future showNotification({int id = 0, String? title, String? body, String? payload}) async {
    final details = await notificationDetails();
    return notificationsPlugin.show(id, title, body, details, payload: payload);
  }

  Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,

      ),
      iOS: DarwinNotificationDetails(
      ),
    );
  }

  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minutes
  }) async {
    final details = await notificationDetails();

    notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _convertTime(hour, minutes),
      details,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidAllowWhileIdle: true,
    );
  }

  /// Request IOS permissions
  void requestIOSPermissions() {
    notificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  static void callback(NotificationResponse notificationResponse) {
    showDialog(
      context: injector.get<NavigationService>().getCurrentContext,
      barrierDismissible: true,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: const AlertDialog(
            content: SizedBox(height: 300, width: 300),
          ),
        );
      },
    );
  }

  cancelAll() async => await notificationsPlugin.cancelAll();

  cancel(id) async => await notificationsPlugin.cancel(id);
}
