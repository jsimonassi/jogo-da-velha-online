import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/models/Match.dart';

import '../models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/Colors.dart';

class History extends StatelessWidget {
  //var image1 =
   //   'https://esportes.estadao.com.br/blogs/crop/1200x1200/robson-morelli/wp-content/uploads/sites/37/2020/08/neymar_170820203236.jpg';

  User player1;
  User player2;
  Match match;

  History(player1, player2, match) {
    this.player1 = player1;
    this.player2 = player2;
    this.match = match;
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: 400,
        height: 100,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(vertical: 10),
        color: AppColors.backgroundGreyHistory,
        child: Stack(
          children: <Widget>[
            Row(children: <Widget>[
                CircleAvatar(
                  maxRadius: 36.0,
                  backgroundImage: this.player1.urlImage == null ?
                  ExactAssetImage('./assets/images/profile-icon.png') :
                  NetworkImage(this.player1.urlImage)
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                  Text(
                      "Vs. " + this.player2.nickname,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      "15/03/2021 - 22:27",
                      //this.match.timestamp,
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    )
                  ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                    "VENCEU",
                    //this.match.winner,
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )
                 ),
                ]),
              Expanded(child: Container()),
              CircleAvatar(
                maxRadius: 36.0,
                backgroundImage: this.player2.urlImage == null ?
                ExactAssetImage('./assets/images/profile-icon.png') :
                NetworkImage(this.player2.urlImage)
              ),
          ]),
        ]),
      ),
    );

  }
}
