import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static void initializeNotificationSettings() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      showNotification(event);
    });
  }

  static Future<String?> getFCMToken() async {
    var firebase = FirebaseMessaging.instance;
    return await firebase.getToken();
  }

  static Future<void> showNotification(RemoteMessage payload) async {
    var android = const AndroidInitializationSettings('ic_launcher');

    var initialSetting = InitializationSettings(
      android: android,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initialSetting);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'default_notification_channel_id',
      'Notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: 'ic_launcher',
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(0, payload.notification!.title,
        payload.notification!.body, platformChannelSpecifics);
  }
}
