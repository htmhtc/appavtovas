import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AvtovasNotificationsClient {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final channelId = 0;
  final notificationsDuration = const Duration(hours: 1);
  final locationName = 'Europe/Moscow';
  late final tz.Location location;

  AvtovasNotificationsClient() {
    init();
  }

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    final location = tz.getLocation(locationName);
    tz.setLocalLocation(location);
  }

  void scheduleNotification(
      {required String title,
      required String body,
      required DateTime dateTime,}) async {
    final tzDateTime =
        tz.TZDateTime.from(dateTime, location).subtract(notificationsDuration);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        channelId, title, body, tzDateTime, NotificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,);
  }
}
