import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Os arquivos de ambiente deveriam ser carregados automaticamente do build.gradle,
/// mas ainda não consegui finalizar essa configuração.
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