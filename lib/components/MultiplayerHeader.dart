import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import '../models/User.dart';

class MultiplayerHeader extends StatelessWidget {

  User player1;
  User player2;
  bool isPlayerOfTheRound;

  MultiplayerHeader(User player1, User player2, bool isPlayerOfTheRound){
    this.player1 = player1;
    this.player2 = player2;
    this.isPlayerOfTheRound = isPlayerOfTheRound;
  }

  setBackgroundForCurrentUser(bool isPlayerOfTheRound){
    if(isPlayerOfTheRound){ //Muda a cor do background para o primeiro jogador
      return  new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              AppColors.player1Gradient1,
              AppColors.player1Gradient2,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0]),
      );
    }

    return  new BoxDecoration(
      gradient: new LinearGradient(
          colors: [
            AppColors.player2Gradient1,
            AppColors.player2Gradient2,
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0]),
    );

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        left: 5,
        right: 5
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), //Não sei se deixo
            topRight: Radius.circular(20), //Dúvida cruel
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
        ),
        child: Container(
          width: size.width,
          height: size.height * 0.16,
          child: Row(
            children: <Widget> [
              Expanded(
              child:Container( //Jogador 1
                padding: EdgeInsets.only(
                  top: 5,
                  left: 10,
                ),
                decoration: setBackgroundForCurrentUser(this.isPlayerOfTheRound),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    CircleAvatar(
                      backgroundImage: this.player1.urlImage == null?
                      ExactAssetImage("assets/profile-icon.png") : NetworkImage(this.player1.urlImage),
                      maxRadius: 40,
                    ),
                    Text(
                      player1.nickname,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              ),//Fim jogador 1
              ClipRRect(
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(10), //Não sei se deixo
                //     topRight: Radius.circular(10), //Dúvida cruel
                //     bottomLeft: Radius.circular(10),
                //     bottomRight: Radius.circular(10)
                // ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 3,
                    right: 3,
                  ),
                  color: AppColors.backgroundGrey2,
                  child: Image.asset('./assets/vs-icon.png'),
                ),
              ),
              Expanded(
                  child: Container(//Jogador 2
                    padding: EdgeInsets.only(
                        top: 5,
                        right: 10
                    ),
                   decoration: setBackgroundForCurrentUser(!this.isPlayerOfTheRound), //Se é a vez do jogador 1, Não é a vez do jogador 2(!)
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget> [
                        CircleAvatar(
                          backgroundImage: this.player1.urlImage == null?
                          ExactAssetImage("assets/profile-icon.png") : NetworkImage(this.player1.urlImage),
                          maxRadius: 40,
                        ),
                        Text(
                          player1.nickname,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
