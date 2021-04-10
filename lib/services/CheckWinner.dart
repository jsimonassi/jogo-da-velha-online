import '../models/Match.dart';

///Verifica o ganhador da partida.
class CheckWinner{

  String player1;
  String player2;
  Match currentMatch;

  CheckWinner(this.player1, this.player2, this.currentMatch);

  bool _checkWinnerByRow(String id){
    if(this.currentMatch.plays["a1"] == id && this.currentMatch.plays["a2"] == id && this.currentMatch.plays["a3"] == id){
      return true;
    }if(this.currentMatch.plays["b1"] == id && this.currentMatch.plays["b2"] == id && this.currentMatch.plays["b3"] == id){
      return true;
    }if(this.currentMatch.plays["c1"] == id && this.currentMatch.plays["c2"] == id && this.currentMatch.plays["c3"] == id){
      return true;
    }
    return false;
  }

  bool _checkWinnerByColumn(String id){
    if(this.currentMatch.plays["a1"] == id && this.currentMatch.plays["b1"] == id && this.currentMatch.plays["c1"] == id){
      return true;
    }if(this.currentMatch.plays["a2"] == id && this.currentMatch.plays["b2"] == id && this.currentMatch.plays["c2"] == id){
      return true;
    }if(this.currentMatch.plays["a3"] == id && this.currentMatch.plays["b3"] == id && this.currentMatch.plays["c3"] == id){
      return true;
    }
    return false;
  }

  bool _checkWinnerByDiagonal(String id){
    if(this.currentMatch.plays["a1"] == id && this.currentMatch.plays["b2"] == id && this.currentMatch.plays["c3"] == id){
      return true;
    }if(this.currentMatch.plays["a3"] == id && this.currentMatch.plays["b2"] == id && this.currentMatch.plays["c1"] == id) {
      return true;
    }
    return false;
  }


  String check() {
    if (_checkWinnerByRow(this.player1)) {
      print("Player 1 ganhou por linha");
      return player1;
    } else if (_checkWinnerByRow(this.player2)) {
      print("Player 2 ganhou por linha");
      return player2;
    } else if (_checkWinnerByColumn(this.player1)) {
      print("Player 1 ganhou por coluna");
      return player1;
    } else if (_checkWinnerByColumn(this.player2)) {
      print("Player 2 ganhou por coluna");
      return player2;
    } else if (_checkWinnerByDiagonal(this.player1)) {
      print("Player 1 ganhou pela diagonal");
      return player1;
    } else if (_checkWinnerByDiagonal(this.player2)) {
      print("Player 2 ganhou pela diagonal");
      return player2;
    }
    if(currentMatch.plays.length >= 9){ //Se não tem mais onde jogar e ninguém ganhou, deu velha
      return "velha";
    }
    return null;
  }
}