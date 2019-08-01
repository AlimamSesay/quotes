import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../utils/routes.dart';
import '../utils/screen_util.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () {
      AppRoutes.makeFirst(context, HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    Constant.setScreenAwareConstant(context);

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
