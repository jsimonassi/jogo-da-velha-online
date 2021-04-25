import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

///Configura keys de acordo com o ambiente de execução (dev ou prod)
class Config {
  static Map<String, String> env;
  static Future<void> loadEnvironment() async{
    try {
      const bool inProduction = const bool.fromEnvironment('dart.vm.product');
      await DotEnv().load(inProduction ? '.env_release' : '.env_debug');
      env = DotEnv().env;
    }catch(e){
      throw FlutterError("Config Variables error");
    }
  }
}