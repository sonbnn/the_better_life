import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void callback(NotificationResponse notificationResponse) {
    showDialog(
        context: injector.get<NavigationService>().getCurrentContext,
        barrierDismissible: true,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              content: Container(
                height: 300,
                width: 300,
                child: Column(
                  children: [
                    Text( '1'),
                    Text( '2'),
                    Text( '3'),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) {

      },
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
              return Container(
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
            }
        );
      }
    ); 
  }
  
  Future showNotification({ int id = 0, String? title, String? body, String? payload }) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName'),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future scheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledNotificationDateTime,
  }) async {
    return notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        scheduledNotificationDateTime,
        tz.local,
      ),
      notificationDetails(),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}