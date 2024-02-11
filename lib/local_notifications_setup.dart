import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class LocalNotifications {
  static Future<bool?> init() {
    const initializationAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );
    final localNotification = FlutterLocalNotificationsPlugin();
    localNotification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    return localNotification.initialize(initializationSettings);
  }
}
