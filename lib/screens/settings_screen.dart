import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../utils/functions.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool notification;
  int hour;
  int minute;

  init() async {
    final n = await getBoolFromSharedPref(NOTIFICATION);
    final h = await getIntFromSharedPref(HOUR);
    final m = await getIntFromSharedPref(MINUTE);
    setState(() {
      hour = h;
      minute = m;
      notification = n;
    });
  }

  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    init();
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  Future onSelectNotification(String payload) async {
    //AppRoutes.push(context, QuoteScreen(quoteOfTheDay: true));
  }

  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Notification'),
                Checkbox(
                  value: notification,
                  onChanged: (bool value) async {
                    await setBoolToSharedPref(NOTIFICATION, value);
                    final h = await getIntFromSharedPref(HOUR);
                    final m = await getIntFromSharedPref(MINUTE);
                    if (value) {
                      setNotification(flutterLocalNotificationsPlugin, h, m);
                    } else {
                      cancelAllNotifications(flutterLocalNotificationsPlugin);
                    }
                    setState(() {
                      notification = value;
                    });
                  },
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              height: 36,
            ),
            RaisedButton(
              child: Column(
                children: <Widget>[
                  Text('Time of Quote of the day'),
                  Text('$hour:$minute'),
                ],
              ),
              onPressed: () async {
                final selectedTime = await _selectTime(context);
                if (selectedTime == null) return;
                final n = await getBoolFromSharedPref(NOTIFICATION);
                if (n) {
                  cancelAllNotifications(flutterLocalNotificationsPlugin);

                  setNotification(flutterLocalNotificationsPlugin,
                      selectedTime.hour, selectedTime.minute);
                }
                setIntToSharedPref(HOUR, selectedTime.hour);
                setIntToSharedPref(MINUTE, selectedTime.minute);
                setState(() {
                  hour = selectedTime.hour;
                  minute = selectedTime.minute;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
