import 'package:jogodavelha/constants/Colors.dart';

import '../models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/Colors.dart';

class History extends StatelessWidget {
  var image1 =
      'https://esportes.estadao.com.br/blogs/crop/1200x1200/robson-morelli/wp-content/uploads/sites/37/2020/08/neymar_170820203236.jpg';

  //User player1;
  //User player2;

  //Historico(player1, player2) {
  //this.player1 = player1;
  //this.player2 = player2;
  //}

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: 400,
        height: 100,
        padding: EdgeInsets.all(10.0),
        color: AppColors.backgroundGreyHistory,
        child: Stack(
          children: <Widget>[
            Row(children: <Widget>[
                CircleAvatar(
                    radius: 40,
                    backgroundImage: image1 == null ?
                    ExactAssetImage('./assets/profile-icon.png') :
                    NetworkImage(image1)
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text(
                      "Partida",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                      )
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      "15/03/2021 - 22:27",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )
                  ),
                  Text(
                      "VENCEU",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,

                  )
                 ),
                ]),
          Container(

            alignment: Alignment.centerRight,
            width: 140,
            child:
            CircleAvatar(
                radius: 40,
                backgroundImage: image1 == null ?
                ExactAssetImage('./assets/profile-icon.png') :
                NetworkImage(image1)
            ),
          )
            ]),
        ]),
      ),
    );

  }
}
