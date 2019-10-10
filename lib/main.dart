import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: Color(0xFF18a096)),
    );
  }
}
