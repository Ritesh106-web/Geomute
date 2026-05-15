import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);
  }

  Future<void> showSoundModeNotification(String mode, String zoneName) async {
    String title = '';
    String body = '';
    String emoji = '';

    switch (mode) {
      case 'silent':
        title = '🔇 Silent Mode Activated';
        body = 'Entered silent zone: $zoneName';
        emoji = '🔇';
        break;
      case 'vibrate':
        title = '📳 Vibrate Mode Activated';
        body = 'Entered vibrate zone: $zoneName';
        emoji = '📳';
        break;
      case 'normal':
        title = '🔊 Normal Mode Restored';
        body = 'Exited silent zone';
        emoji = '🔊';
        break;
    }

    const androidDetails = AndroidNotificationDetails(
      'geomute_channel',
      'GeoMute Notifications',
      channelDescription: 'Sound mode change notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
    );
  }
}