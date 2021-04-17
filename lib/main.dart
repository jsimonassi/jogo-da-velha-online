import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/services/Config.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import './screens/Login.dart';

Future<void> main() async {
  //use flutter run --release em um dispositivo físico para usar as variáveis de produção
  await Config.loadEnvironment(); //Carrega variáveis de acordo com o ambiente
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Todo: Recuperar com algum tipo de Shared Preferences do Flutter o usuário logado e gerar uma instância de Bot
    OneSignal.shared.init(Config.env['ONE_SIGNAL_KEY']); //OneSignal Push Notifications - Se for alterar, cuidado pra não quebrar as notificações ;)
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    return new MaterialApp(
      title: Config.env['APP_NAME'],
      debugShowCheckedModeBanner: Config.env['ENVIRONMENT'] == 'debug'? true: false,
      theme: new ThemeData(
          primaryColor: Colors.black,
        accentColor: AppColors.redPrimary,
      ),
      home: new LoginPage(),
    );
  }
}
