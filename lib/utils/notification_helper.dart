import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

init() {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('intropage');
  var initializationSettingsIOs = IOSInitializationSettings();
  var initSetttings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOs);

  flutterLocalNotificationsPlugin.initialize(initSetttings,
      onSelectNotification: null);
}

onSelectNotification(String payload, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) {}));
}

Future<void> scheduleNotification() async {
  var scheduledNotificationDateTime = DateTime.now();
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel id',
    'channel name',
    'channel description',
    icon: 'intropage',
    importance: Importance.Max,
    priority: Priority.High,
    largeIcon: DrawableResourceAndroidBitmap('intropage'),
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.schedule(0, '', 'scheduled body',
      scheduledNotificationDateTime, platformChannelSpecifics);
}
