import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:timezone/browser.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
/* for notification follow these steps
* ******** In build.gradle file which is outside the app folder
* inside the
* // defaultConfig{
 multiDexEnabled true//add this
}
* check thew compile sdk which for 34
inside the //android{
compileSdk = 34
}


*
* ******** in manifest file *******
* add this into manifest permission into manifest before the application tag
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/> //for local notification
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />  //for schedule notification
<uses-permission android:name="android.permission.USE_EXACT_ALARM" />       // for exact notification

* add this after/within the application
<receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
            </intent-filter>
        </receiver>

*
 */
class LocalNotificationService {
  LocalNotificationService._();

  static LocalNotificationService notificationService =
      LocalNotificationService._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
    "chat-app",
    "Local Notification",
    importance: Importance.max,
    priority: Priority.max,
  );

  //init
  Future<void> initNotificationService() async {
    plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    AndroidInitializationSettings android =
        const AndroidInitializationSettings("mipmap/ic_launcher");

    DarwinInitializationSettings iOS = const DarwinInitializationSettings();

    InitializationSettings settings =
        InitializationSettings(android: android, iOS: iOS);

    await plugin.initialize(settings);
  }

  Future<void> showNotification(String title, String body) async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    await plugin.show(0, title, body, notificationDetails);
  }

// scheduled Notification

Future<void> scheduledNotification() async {
  tz.Location location = tz.getLocation('Asia/Kolkata');
  await plugin.zonedSchedule(
    1,
    "Big Billion Days",
    "save Money",
    tz.TZDateTime.now(location).add(
      const Duration(seconds: 5),
    ),
    NotificationDetails(
      android: androidDetails,
    ),
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
  );
}

/* Step for schedule notification
* add this permission in manifest file <uses-permission android:name="android.permission.USE_EXACT_ALARM" />
*
* create method for it in which?!
*
* make unique id for it which is used as like condition statement (for eg reminder in which is check the any special event for upcoming notification ) that means if select 0 as for certain amount of time than the notification will only for that time only
*
* */

}
