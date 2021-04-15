import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import './screens/Login.dart';
import './constants/Messages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  //use flutter run --release em um dispositivo físico para usar as variáveis de produção
  //use final Map<String, String> env = DotEnv().env; para acessar as variáveis de ambiente
  const bool inProduction = const bool.fromEnvironment('dart.vm.product');
  await DotEnv().load(inProduction ? '.env_release' : '.env_debug');
  runApp(new MyApp());
}

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
