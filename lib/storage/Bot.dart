import 'package:jogodavelha/models/User.dart';
import '../constants/Messages.dart';

///Bot geral da aplicação. bem como métodos de manipulação do mesmo.
class Bot extends User{

  static User botInfos;

  static User generateBot(){
    //Todo: Bots customizados? Implementar lógica aqui!
    User bot = User();
    bot.name = AppMessages.botName;
    bot.nickname = AppMessages.botNickname;
    bot.id = "00";
    bot.email = "bot@jogodavelha.com.br";
    return bot;
  }
}