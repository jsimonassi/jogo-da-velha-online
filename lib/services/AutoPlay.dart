import 'dart:math';
import '../models/Match.dart';

///Gerencia as jogadas do bot
///Uma inteligência artificial não muito inteligente.
class AutoPlay{

  static String makeABotPlay(Match currentMatch){
    List<String> ids = ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"];
    bool isValidPlay = false;
    var rnd = new Random();
    String key;

    while(!isValidPlay){
      key = ids.elementAt(rnd.nextInt(ids.length - 1));  //procura uma posição aleatória do jogo
      if(currentMatch.plays[key] == null){ //Alguém já jogou nessa posição?
        isValidPlay = true; //Ninguém jogou, o bot pode jogar aqui!
      }
      //Se já jogaram, repete o loop e procura outra posição pra jogar.
    }
    return key; //Retornar chave do Map que o bot pode jogar
  }
}