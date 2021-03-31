import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import './screens/Login.dart';
import './constants/Messages.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Todo: Recuperar com algum tipo de Shared Preferences do Flutter o usuário logado e gerar uma instância de Bot

    return new MaterialApp(
      title: AppMessages.appTitle,
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryColor: Colors.black,
        accentColor: AppColors.redPrimary,
      ),
      home: new LoginPage(),
    );
  }
}
