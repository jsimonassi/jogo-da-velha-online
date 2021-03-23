/*
Responsável por encontrar jogadores para a partida
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/components/Loading.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/screens/GameMultiplayer.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../constants/Messages.dart';
import '../services/Api.dart';
import '../models/Lobby.dart';
import '../models/User.dart';

class Lobby extends StatefulWidget {
  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {

  String _searchState = AppMessages.findUsers;
  String _player2Image;
  String _player2Nickname = "";

  @override
  void initState() {
    createLobby();
    super.initState();
  }

  removeUserFromLobby(context) {
    //Todo: Remover da lista de lobby lá do bd
    Navigator.of(context).pop(true);
  }

  createLobby() async {
    try {
      List<LobbyModel> lobbys = await Api.getLobbys();
      if (lobbys != null && lobbys.isNotEmpty) {
        User player2 = await Api.getUser(lobbys[0].player1);
        if(player2 != null){ //Todo: Tratar user nulo. É possível??
          setState(() {
            _player2Image = player2.urlImage;
            _player2Nickname = player2.nickname;
          });
        }
        lobbys[0].player2 = CurrentUser.user.id;
        await Api.updateLobby(lobbys[0]);//Passar primeiro lobby disponível
        //Todo: Ir pra tela do game
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => GameMultiplayer(player2)));//Todo: Adicionar contador antes disso
      } else {
        var newLobby = new LobbyModel();
        newLobby.player1 = newLobby.token = CurrentUser.user.id;
        Api.updateLobby(newLobby);
        setState(() {
          _searchState = "Testando";
        });
      }
    } catch (e) {
      print(e);
    }
  }



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
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      removeUserFromLobby(context);
                    },
                  ),
                  Text(
                     _searchState,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ],
              )),
          SizedBox(
            height: size.height * 0.05,
          ),
          CircleAvatar(
            backgroundColor: AppColors.backgroundGrey2,
            radius: 80,
            backgroundImage: CurrentUser.user.urlImage == null
                ? ExactAssetImage('./assets/profile-icon.png')
                : NetworkImage(CurrentUser.user.urlImage),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            CurrentUser.user.nickname,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
          ),
          SizedBox(
            height: size.height * 0.08,
          ),
          CircleAvatar(
            backgroundColor: AppColors.backgroundGrey2,
            radius: 80,
            backgroundImage: _player2Image == null
                ? ExactAssetImage('./assets/profile-icon.png')
                : NetworkImage(_player2Image),
          ),
          Text(
            _player2Nickname,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )),
        ],
      ),
    ));
  }
}
