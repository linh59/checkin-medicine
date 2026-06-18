import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  /// INIT
  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit
    );

    await _plugin.initialize(settings: initSettings);

    await _requestPermissions();
  }

  /// PERMISSION (
  static Future<void> _requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();
  }

  /// SCHEDULE
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    final scheduledDate = tz.TZDateTime.from(dateTime, tz.local);

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails:  NotificationDetails(
        android: AndroidNotificationDetails(
          'medicine_channel',
          'Medicine Reminder',
          channelDescription: 'Reminder for medicine intake',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),

      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

      matchDateTimeComponents: DateTimeComponents.time,

    );
  }

  /// CANCEL
  static Future<void> cancel(int id) async {
    await _plugin.cancel(id: id);
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}