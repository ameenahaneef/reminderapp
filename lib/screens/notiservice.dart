// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;



// class NotificationsServices{
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

//   final AndroidInitializationSettings _androidInitializationSettings=AndroidInitializationSettings('@mipmap/ic_launcher');

//   static const String channelId='channelId';

//   void initialiseNotifications()async{
//     tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
//     InitializationSettings initializationSettings=InitializationSettings(android: _androidInitializationSettings,);
//   await  _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
  


//   Future<void> scheduleNotification(
//       int id, String title, String body, DateTime scheduledDate) async {
//         tz.initializeTimeZones();
//         tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'channelId',
//       'channelName',
      
//       importance: Importance.max,
//       priority: Priority.high,
//     //  playSound: true,
//     //   sound: RawResourceAndroidNotificationSound('assets/audio/alarm-20025.mp3'), // add this line
//     );
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );


//      print('Scheduled Date: $scheduledDate');
//   print('TZDateTime: ${tz.TZDateTime.from(scheduledDate, tz.local)}');
//   print('Notification Details: $notificationDetails');
//     print('ssssss');


//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//     tz.TZDateTime(tz.getLocation('Asia/Kolkata'),scheduledDate.year,scheduledDate.month,scheduledDate.day,scheduledDate.hour,scheduledDate.minute), // convert DateTime to TZDateTime
//       notificationDetails,
//       androidAllowWhileIdle: true,
   
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//     print('notification scheduled successfully');
//   }


// void sendNotification(String title,String body)async{
//     AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails('channelId', 'channelName',importance: Importance.max,priority: Priority.high);
//     NotificationDetails notificationDetails=NotificationDetails(
//       android:androidNotificationDetails,
//     );
//   await  _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
//   }

// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:newproj/screens/addmed.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;



class NotificationsServices{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings=AndroidInitializationSettings('@mipmap/ic_launcher');

  static const String channelId='channelId';

  void initialiseNotifications()async{
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    InitializationSettings initializationSettings=InitializationSettings(android: _androidInitializationSettings,);
  await  _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  


  Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledDate) async {
        tz.initializeTimeZones();
        tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      
      importance: Importance.max,
      priority: Priority.high,
     playSound: true,
      //sound: RawResourceAndroidNotificationSound('notification'), 
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );


     print('Scheduled Date: $scheduledDate');
  print('TZDateTime: ${tz.TZDateTime.from(scheduledDate, tz.local)}');
  print('Notification Details: $notificationDetails');
    print('ssssss');


    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'title',
      'body',
    tz.TZDateTime(tz.getLocation('Asia/Kolkata'),scheduledDate.year,scheduledDate.month,scheduledDate.day,scheduledDate.hour,scheduledDate.minute), // convert DateTime to TZDateTime
      notificationDetails,
androidAllowWhileIdle: true,
androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
   
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    print('notification scheduled successfully');
  }
// await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     'scheduled title',
//     'scheduled body',
//     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//     const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'your channel id', 'your channel name',
//             channelDescription: 'your channel description')),
//     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime);

  void sendNotification(String title,String body)async{
    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails('channelId', 'channelName',importance: Importance.max,priority: Priority.high);
    NotificationDetails notificationDetails=NotificationDetails(
      android:androidNotificationDetails,
    );
  await  _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }
   
  }


