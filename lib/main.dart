import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'utils/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: AppColors.primary),
    );
  }
}
