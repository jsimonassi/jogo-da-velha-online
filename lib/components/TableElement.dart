import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import '../models/Match.dart';

///Elemento da tabela do game.
///Botão que mostra X ou O de acordo com a escolha do usuário.
class TableElement extends StatelessWidget {

  String id; //Identifica qual é o botão
  VoidCallback callback;
  int currentTime;
  Match currentMatch;
  String pressedBy;

  TableElement(this.id, this.currentMatch, this.currentTime, this.callback);

  bool wasPressed(){
    return this.currentMatch.plays[id] != null;
  }

  bool wasPressedByP1(){
    return currentMatch.plays[id] == currentMatch.player1Id;
  }

  getXorO(){
    if(wasPressed() && wasPressedByP1()){ //Quem pressionou foi o player 1?
     return Image.asset('./assets/images/x-icon.png');
    }else if(wasPressed()) { //Quem pressionou foi o Player 2?
      return Image.asset('./assets/images/o-icon.png');
    }
    return null; //Ninguém pressionou
  }

  getBackgroundGradient(){
    var colors1;
    var colors2;
    if(wasPressed() && wasPressedByP1()){
      colors1 =  [AppColors.pressedP1Button1, AppColors.pressedP1Button2, AppColors.pressedP1Button3, AppColors.pressedP1Button4];
      colors2 = [AppColors.pressedP1Button1, AppColors.pressedP1Button2, AppColors.pressedP1Button3, AppColors.pressedP1Button4];
    }else if(wasPressed()){
      colors1 =  [AppColors.pressedP2Button1, AppColors.pressedP2Button2, AppColors.pressedP2Button3, AppColors.pressedP2Button4];
      colors2 = [AppColors.pressedP2Button1, AppColors.pressedP2Button2, AppColors.pressedP2Button3, AppColors.pressedP2Button4];
    }else{
      colors1 =  [AppColors.notPressedButton1, AppColors.notPressedButton2, AppColors.notPressedButton3, AppColors.notPressedButton4];
      colors2 = [AppColors.notPressedButton4, AppColors.notPressedButton3, AppColors.notPressedButton2, AppColors.notPressedButton1];
    }

    if(this.currentTime != null && this.currentTime % 2 == 0){
      return colors1;
    }
    return colors2;
  }

  getBeginDirection(){
    if(this.currentTime != null && this.currentTime % 2 == 0){
      return Alignment.topLeft;
    }
    return Alignment.topRight;
  }

  getEndDirection(){
    if(this.currentTime != null && this.currentTime % 2 == 0){
      return Alignment.bottomRight;
    }
    return Alignment.bottomLeft;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: getBackgroundGradient(),
              begin: getBeginDirection(),
              end: getEndDirection(),
            ),
          ),
          width: size.width * 0.20,
          height: size.width * 0.20,
          duration: Duration(seconds: 1), //Não vai chegar a 15 se o current time for menor que isso
          child: TextButton(
            onPressed: callback,
            child: AnimatedContainer( //Todo: Ia ser massa se a imagem fosse crescendo
              duration: Duration(seconds: 1),
              child: getXorO()
                ),
              ),
            ),
          ),
    );
  }
}
