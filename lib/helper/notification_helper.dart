import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _notification.initialize(const InitializationSettings(
      android: AndroidInitializationSettings("obat_icon"),
    ));
    tz.initializeTimeZones();
  }

  static Future<void> scheduleDrinkingReminders() async {
    // Cancel any existing notifications first
    await _notification.cancelAll();

    // Set up notification details
    var androidDetails = const AndroidNotificationDetails(
      "drink_reminders",
      "Drink Reminders",
      importance: Importance.high,
      priority: Priority.high,
      channelDescription: "Reminders to drink water throughout the day",
    );
    var notificationDetails = NotificationDetails(android: androidDetails);

    // Get current date
    final now = tz.TZDateTime.now(tz.local);

    // Create a schedule from 6 AM to 10 PM with 2-hour intervals
    for (int hour = 6; hour <= 22; hour += 2) {
      // Create notification time for today
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour, // Hour of the day
        0, // Minutes
      );

      // If the time has already passed today, schedule for tomorrow
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // Schedule the notification with a unique ID based on the hour
      await _notification.zonedSchedule(
        hour,
        'Waktunya Minum Air',
        'Jangan lupa untuk minum air ya! Tetap jaga kesehatanmu 💧',
        scheduledDate,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents:
            DateTimeComponents.time, // This makes it repeat daily
      );
    }
  }

  static Future<void> cancelAllNotifications() async {
    await _notification.cancelAll();
  }
}
