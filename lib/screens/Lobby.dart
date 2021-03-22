/*
Responsável por encontrar jogadores para a partida
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/components/Loading.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../constants/Messages.dart';

class Lobby extends StatefulWidget {
  @override
  _LobbyState createState() => _LobbyState();
}

  removeUserFromLobby(context){
    //Todo: Remover da lista de lobby lá do bd
    Navigator.of(context).pop(true);
  }


class _LobbyState extends State<Lobby> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          width: size.width,
        padding: EdgeInsets.only(top: 60),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg_gradient.jpg"),
          fit: BoxFit.cover,
        ),
      ),
          child: Column(
            children: <Widget>[
              Container(
                width: size.width,
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {removeUserFromLobby(context);},
                    ),
                    Text(
                      AppMessages.findUsers,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16
                      ),
                    ),
                  ],
                )
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              CircleAvatar(
                backgroundColor: AppColors.backgroundGrey2,
                radius: 80,
                backgroundImage: CurrentUser.user.urlImage == null? ExactAssetImage('./assets/profile-icon.png'): NetworkImage(CurrentUser.user.urlImage),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                CurrentUser.user.nickname,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CircleAvatar(
                backgroundColor: AppColors.backgroundGrey2,
                radius: 80,
                backgroundImage: CurrentUser.user.urlImage == null? ExactAssetImage('./assets/profile-icon.png'): NetworkImage(CurrentUser.user.urlImage),
              ),
              Text(
                CurrentUser.user.nickname,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26
                ),
              ),
              Expanded(child: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )),
            ],
          ) ,
    ));
  }
}
