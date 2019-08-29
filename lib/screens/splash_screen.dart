import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quotes/screens/quote_screen.dart';
import 'home_screen.dart';
import '../utils/routes.dart';
import '../utils/screen_utils.dart';
import '../utils/functions.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  init() async {
    final now = DateTime.now();
    final launch = await getBoolFromSharedPref(LAUNCH);
    if (launch == null) {
      setBoolToSharedPref(LAUNCH, true);
      setBoolToSharedPref(NOTIFICATION, true);
      setIntToSharedPref(ID, 499);
      setIntToSharedPref(HOUR, now.hour);
      setIntToSharedPref(MINUTE, now.minute);
      setNotification(flutterLocalNotificationsPlugin, now.hour, now.minute);
    }
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

    Future.delayed(Duration(milliseconds: 1000), () {
      AppRoutes.makeFirst(context, HomeScreen());
    });
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  Future onSelectNotification(String payload) async {
    AppRoutes.push(context, QuoteScreen(quoteOfTheDay: true));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils.setScreenAwareConstant(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: Text('splash')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
