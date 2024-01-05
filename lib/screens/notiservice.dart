// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationsServices {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   final AndroidInitializationSettings _androidInitializationSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   static const String channelId = 'channelId';

//   void initialiseNotifications() async {
//     tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
//     InitializationSettings initializationSettings = InitializationSettings(
//       android: _androidInitializationSettings,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }


//   void sendNotification(String title, String body) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channelId', 'channelName',
//             importance: Importance.max, priority: Priority.high);
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );
//     await _flutterLocalNotificationsPlugin.show(
//         0, title, body, notificationDetails);
//   }
//    Future<void> scheduleNotifications(List<DateTime> scheduledTimes) async {
//     for (int i = 0; i < scheduledTimes.length; i++) {
//       await _scheduleNotification(i + 1, scheduledTimes[i]);
//     }
//   }

//   Future<void> _scheduleNotification(int id, DateTime scheduledTimes) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channelId', 'channelName',
//             importance: Importance.max, priority: Priority.high);
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       'Medicine Reminder',
//       'Take your medicine',
//       tz.TZDateTime.from(scheduledTimes, tz.local),
//       notificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
     
//     );
//   }
// }







