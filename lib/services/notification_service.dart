// lib/services/notification_service.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static void initialize() {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    _localNotifications.initialize(initializationSettings);
  }

  static Future<void> showNotification(String activity) async {
    var androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'channelDescription', 
      importance: Importance.max,
      priority: Priority.high,
    );

    var generalNotificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      0,  // id da notificação
      'Tempo Concluído',  // título
      'Você concluiu a atividade: $activity',  // corpo da notificação
      generalNotificationDetails,  // detalhes da notificação
    );
  }
}
