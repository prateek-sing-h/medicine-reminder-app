import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings =
        InitializationSettings(android: androidInit);

    await _plugin.initialize(settings);

    const AndroidNotificationChannel channel =
        AndroidNotificationChannel(
      'medicine_channel',
      'Medicine Reminders',
      importance: Importance.max,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static void triggerAfterDelay(
      Duration delay, String body) {
    Timer(delay, () {
      _plugin.show(
        0,
        'Medicine Reminder',
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'medicine_channel',
            'Medicine Reminders',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    });
  }
}
