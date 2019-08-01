import 'package:flutter/material.dart';
import 'settings_screen.dart';
import '../utils/routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              AppRoutes.push(context, SettingsScreen());
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[Text('Hello Home')],
      ),
    );
  }
}
