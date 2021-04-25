import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/models/User.dart';
import 'package:jogodavelha/screens/MenuNavigation.dart';
import 'package:jogodavelha/services/Config.dart';
import 'package:jogodavelha/storage/Bot.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import 'package:jogodavelha/storage/NotificationsStore.dart';
import 'package:jogodavelha/storage/Storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import './screens/Login.dart';

Future<void> main() async {
  try{
    //use flutter run --release em um dispositivo físico para usar as variáveis de produção
    await Config.loadEnvironment(); //Carrega variáveis de acordo com o ambiente

    Bot.botInfos = Bot.generateBot();//Gera bot

    String lastUser = await Storage.retrieve('last_user'); //Recuperando último usuário logado para login automático
    print(lastUser);
    if(lastUser != null){
      Map<String,dynamic> decodedUser = jsonDecode(lastUser);
      CurrentUser.user = User().mapToUser(decodedUser);
      await NotificationStore.refreshNotificationsList();
    }

    OneSignal.shared.init(Config.env['ONE_SIGNAL_KEY']); //OneSignal Push Notifications - Se for alterar, cuidado pra não quebrar as notificações ;)
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

  }catch(e){
    print(e);
  }finally{
    runApp(new MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Config.env['APP_NAME'],
      debugShowCheckedModeBanner: Config.env['ENVIRONMENT'] == 'debug'? true: false,
      theme: new ThemeData(
          primaryColor: Colors.black,
        accentColor: AppColors.redPrimary,
      ),
      home: CurrentUser.user == null? new LoginPage(): new MenuNavigation(),
    );
  }
}
