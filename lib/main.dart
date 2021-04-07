import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import './screens/Login.dart';
import './constants/Messages.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Todo: Recuperar com algum tipo de Shared Preferences do Flutter o usuário logado e gerar uma instância de Bot
    OneSignal.shared.init("75351604-9285-4931-b3de-bb1efbff7567"); //OneSignal Push Notifications - Se for alterar, cuidado pra não quebrar as notificações ;)
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
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
