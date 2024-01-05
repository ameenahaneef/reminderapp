import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class LocalNotifications{
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  static Future init()async{
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification:((id, title, body, payload) => null));
final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
        defaultActionName: 'Open notification');
final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux);
_flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse:(details)=>null);
  }
 
//to show simple noti
static Future showSimpleNotifications({
  required String title,
  required String body,
  required String payload,
})async{
  const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
await _flutterLocalNotificationsPlugin.show(
    0, title,body, notificationDetails,
    payload: payload);

}

//toshow periodic
static Future showPeriodicNNotifications(
  {
  required String title,
  required String body,
  required String payload,
}
)async{
  const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel 2', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
  await _flutterLocalNotificationsPlugin.periodicallyShow(1, title, body, 
  RepeatInterval.everyMinute
  , notificationDetails);
}

//to close all notification
static Future cancelAll()async{ 
  await _flutterLocalNotificationsPlugin.cancelAll();


}




static Future showPeriodicNNotificationsHourly(
  {
  required String title,
  required String body,
  required String payload,
}
)async{
  const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel 3', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
  await _flutterLocalNotificationsPlugin.periodicallyShow(2, title, body, 
  RepeatInterval.hourly
  , notificationDetails);
}
//to close a notification
static Future cancelhourlyone(int id)async{
  await _flutterLocalNotificationsPlugin.cancel(id);
}

//to schedule local noti
static Future showScheduleNotifications({
    required String title,
    required String body,
    required String payload,
  })async{
    tz.initializeTimeZones();
    await _flutterLocalNotificationsPlugin.zonedSchedule(3, title, body, tz.TZDateTime.now(tz.local).add(Duration(minutes: 5)),
    const NotificationDetails(android: AndroidNotificationDetails('channel 4', 'your channel Name',channelDescription: 'your channel description',
    importance: Importance.max,priority: Priority.high,ticker: 'ticker')),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
    //var localTime=tz.local;
  }
  //close a specific channel notification
  static Future cancelZoned(int id)async{
    await _flutterLocalNotificationsPlugin.cancel(id);
  }






  static Future showScheduleNotificationstwo({
    required String title,
    required String body,
    required String payload,
  })async{
    tz.initializeTimeZones();
    await _flutterLocalNotificationsPlugin.zonedSchedule(4, title, body, tz.TZDateTime.now(tz.local).add(Duration(hours: 2)),
    const NotificationDetails(android: AndroidNotificationDetails('channel 5', 'your channel Name',channelDescription: 'your channel description',
    importance: Importance.max,priority: Priority.high,ticker: 'ticker')),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }
  //close a specific channel notification
  static Future cancelZonedtwo(int id)async{
    await _flutterLocalNotificationsPlugin.cancel(id);
    
  }





 
}