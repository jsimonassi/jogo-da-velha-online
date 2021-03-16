import 'package:flutter/material.dart';
import 'package:jogodavelha/screens/Home.dart';
import './screens/Game.dart';
import './screens/Login.dart';
import './constants/messages.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: AppMessages.appTitle,
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primaryColor: Colors.black),
      home: new LoginPage(),
    );
  }
}
