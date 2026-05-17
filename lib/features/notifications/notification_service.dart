import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(initializationSettings);
  }

  static Future<void> showArrivalNotification(String visitorName, String stationId) async {
    const androidDetails = AndroidNotificationDetails(
      'arrival_channel',
      'Arrivals',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    
    await _plugin.show(
      0,
      'Your visitor has arrived',
      '$visitorName is at $stationId reception.',
      notificationDetails,
    );
  }
}
