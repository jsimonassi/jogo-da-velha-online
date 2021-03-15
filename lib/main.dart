import 'package:flutter/material.dart';
import './screens/Home_Page.dart';
import './screens/Login_Page.dart';
import './constants/messages.dart';
import './screens/Edit_Page.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: AppMessages.appTitle,
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primaryColor: Colors.black),
      home: new LoginPage(),
      //home: new EditPage(),

    );
  }
}
