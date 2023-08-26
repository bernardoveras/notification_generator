import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  late final FlutterLocalNotificationsPlugin localNotificationsPlugin;

  Future<void> initialize() async {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isAndroid) {
      final result = await localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();

      if (result != true) {
        return;
      }
    } else {
      final result = await localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );

      if (result != true) {
        return;
      }
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await localNotificationsPlugin.initialize(initializationSettings);
  }

  void show({
    String? title,
    String? description,
  }) {
    localNotificationsPlugin.show(
      0,
      title,
      description,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          '1',
          'Notificações',
          priority: Priority.max,
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
