import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> init() async {
    await AwesomeNotifications().initialize(
      null, // icon, default null uses app icon
      [
        NotificationChannel(
          channelKey: 'alarm_channel',
          channelName: 'Alarms',
          channelDescription: 'Notification channel for alarms',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: const Color(0xFFFFFFFF),
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
        )
      ],
    );
  }

  Future<void> schedule(DateTime dateTime, {required int id}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'alarm_channel',
        title: 'Alarm',
        body: 'Your alarm is ringing!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: dateTime.year,
        month: dateTime.month,
        day: dateTime.day,
        hour: dateTime.hour,
        minute: dateTime.minute,
        second: 0,
        millisecond: 0,
        repeats: false,
      ),
    );
  }

  Future<void> cancel(int id) async {
    await AwesomeNotifications().cancel(id);
  }
}
