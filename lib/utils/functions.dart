import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int> getIntFromSharedPref(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getInt(key);
  return value;
}

Future<void> setIntToSharedPref(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<bool> getBoolFromSharedPref(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getBool(key);
  return value;
}

Future<void> setBoolToSharedPref(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<void> setNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int hour,
    int minute) async {
  var time = new Time(hour, minute, 0);
  var androidPlatformChannelSpecifics =
      new AndroidNotificationDetails('id', 'name', 'Quote of the day');
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(0, 'Quote of the day',
      'Check your quote of the day', time, platformChannelSpecifics,
      payload: 'The payload todo id');
}

Future<void> cancelAllNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  await flutterLocalNotificationsPlugin.cancelAll();
}
