import 'package:flutter/material.dart';
import './screens/home_page.dart';
import './screens/login_page.dart';
import './constants/Messages.dart';

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
