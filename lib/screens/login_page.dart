import 'dart:math';

import 'package:flutter/material.dart';
import '../components/custom_dailog.dart';
import '../components/game_button.dart';
import '../constants/Constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.backgroundGrey1, AppColors.backgroundGrey2])),
            child: Container(
              child: Center(
                child: Text(
                  'Testando',
                  style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )));
  }
}
