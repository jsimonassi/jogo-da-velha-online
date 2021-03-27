/*
  Este componente deve montar a partida a partir do Lobby
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/screens/GameMultiplayer.dart';
import 'package:jogodavelha/screens/Lobby.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../models/LobbyModel.dart';
import '../models/User.dart';
import '../models/Match.dart';
import '../services/Api.dart';

LobbyModel currentLobby;

class PreMatch extends StatefulWidget {
  @override
  _PreMatchState createState() => _PreMatchState();

  PreMatch(LobbyModel lobby) {
    currentLobby = lobby;
  }
}

class _PreMatchState extends State<PreMatch> {

  User _player1;
  User _player2;
  int _counter = 5;

  @override
  void initState() {
    setVariables();
    super.initState();
  }

  setVariables() async{
    startTimer();
    if(currentLobby.player1 == CurrentUser.user.id){
      _player1 = CurrentUser.user;
      Api.getUser(currentLobby.player2).then((p2) {
        setState(() {
          _player2 = p2;
        });
      });
    }else{
      _player2 = CurrentUser.user;
      Api.getUser(currentLobby.player1).then((p1) {
        setState(() {
          _player1 = p1;
        });
      });
    }
  }

  createMatch() async {
    try{
      Match currentMatch = new Match();
      currentMatch.player1Id = _player1.id;
      currentMatch.player2Id = _player2.id;
      currentMatch.matchtoken = currentLobby.token;
      currentMatch.playerOfTheRound = _player1.id;
      currentMatch.timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      await Api.updateMatch(currentMatch);
      await Api.deleteLobby(currentLobby);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => GameMultiplayer()));
    }catch(e){
      print(e);
    }
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_counter == 1) {
          setState(() {
            timer.cancel();
            createMatch();
          });
        } else {
          setState(() {
            _counter--;
          });
        }
      },
    );
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
              margin: EdgeInsets.only(
                top: size.height * 0.05,
              ),
              child: Text(
                AppMessages.initMatch,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            //Expanded(child: Container()),
            Row(
              children: <Widget>[
                Expanded(child: Container()),
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 60,
                      backgroundColor: AppColors.backgroundGrey2,
                      backgroundImage: _player1 != null && _player1.urlImage != null?
                      NetworkImage(_player1.urlImage): ExactAssetImage('./assets/profile-icon.png'),
                    ),
                    Text(
                      _player1 != null? _player1.nickname : "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  width: size.width * 0.2,
                  height: size.height * 0.4,
                  padding: EdgeInsets.all(8),
                  child: Image.asset('./assets/vs-icon.png'),
                ),
                Expanded(child: Container()),
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 60,
                      backgroundColor: AppColors.backgroundGrey2,
                      backgroundImage: _player2 != null && _player2.urlImage != null?
                      NetworkImage(_player2.urlImage): ExactAssetImage('./assets/profile-icon.png'),
                    ),
                    Text(
                      _player2 != null? _player2.nickname : "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
            Text(
              _counter.toString(),
              style: TextStyle(
                  color: AppColors.redPrimary,
                  fontSize: 150,
                  fontWeight: FontWeight.bold
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
