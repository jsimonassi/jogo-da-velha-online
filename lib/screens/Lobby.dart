/*
Responsável por encontrar jogadores para a partida
*/

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/components/Loading.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/screens/PreMatch.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import 'package:marquee_text/marquee_text.dart';
import '../constants/Messages.dart';
import '../services/Api.dart';
import '../models/LobbyModel.dart';
import '../models/User.dart';
//Todo: Acho que tratei todos os cenários, mas é bom validar com a equipe.

///Tela de Lobby.
///Nesta tela o usuário é capaz de encontrar um novo oponente para a partida.

String challenge = "";

class Lobby extends StatefulWidget {

  Lobby(String friendId){
    challenge = friendId;
  }

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  String _searchState = AppMessages.findUsers;
  User _player1 = User();
  User _player2 = User();
  LobbyModel currentLobby;
  Stream<DocumentSnapshot> stream;
  bool _showNotFindMessage = false;
  Timer timer;

  @override
  void initState() {
    searchLobby();
    showNotFindMessage();
    super.initState();
  }

  showNotFindMessage() async {
    timer = Timer(Duration(seconds: 5), () {
      setState(() {
        _showNotFindMessage = true;
      });
    });
  }

  getTimeOutMessage() {
    if (_showNotFindMessage) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Text(
          "Não estamos encontrando nenhum jogador online no momento. Vamos continuar buscando.",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );
    }
    return Container();
  }

  removeUserFromLobby(context) async {
    Loading.enableLoading(context);
    try {
      if (currentLobby != null) {
        //Ainda existe esse Lobby?
        if (currentLobby.player1 == CurrentUser.user.id) {
          //Posso só apagar pq foi eu que fiz o Lobby e ninguém entrou
          await Api.deleteLobby(currentLobby);
        } else {
          //O Lobby é de alguém, então vou sair dele
          currentLobby.player2 = null; //Saí dele
          await Api.updateLobby(currentLobby); //Atualizei o db
        }
      }
    } catch (e) {
      print(e);
    } finally {
      Loading.disableLoading(context);
      Navigator.of(context).pop(true);
    }
  }

  createLobby() async {
    try {
      var newLobby = new LobbyModel();
      newLobby.player1 = CurrentUser.user.id; //Eu sou o player 1 do Lobby
      newLobby.challenge = challenge;// Se for desafio, aqui vai ter o id do novo usuário
      currentLobby = newLobby; //Atualiza LobbyCorrente
      await Api.updateLobby(newLobby);
      createListener(); //Cria listener pra esperar outro jogador
    } catch (e) {
      print(e);
    }
  }

  searchLobby() async {
    //Todo: Validar muito isso aqui!!
    try {
      List<LobbyModel> lobbys =
          await Api.getLobbys(); // Verificar se já existe Lobby
      bool isFull = false; //Diz se todos os lobbys estão cheios
      if (lobbys != null && lobbys.isNotEmpty) {
        //Já existe um Lobby criado. Entrar no mesmo:
        for (int i = 0; i < lobbys.length; i++) {
          if(challenge == ""){
            if (lobbys[i].player1 != null && lobbys[i].player2 == null) {
              currentLobby = lobbys[i]; //Lobby atual é setado
              currentLobby.player2 = CurrentUser
                  .user.id; //Informação que estava faltando é o player2
              isFull = false;
              break;
            } else if (lobbys[i].player1 == null && lobbys[i].player2 != null) {
              currentLobby = lobbys[i]; //Lobby atual é setado
              currentLobby.player1 = CurrentUser.user.id;
              isFull = false;
              break;
            }
            isFull = true;
          }else{ //é um desafio
            if(lobbys[i].challenge == CurrentUser.user.id){ //O desafio é pra mim?
              currentLobby = lobbys[i]; //Lobby atual é setado
              currentLobby.player2 = CurrentUser
                  .user.id; //Informação que estava faltando é o player2
              isFull = false;
              break;
            }
          }
        }
        if (isFull) {
          //Caso em que existe lobby, mas estão cheios
          createLobby();
          return;
        }
        await Api.updateLobby(
            currentLobby); //Agora eu sou o player 2 desse Lobby
        createListener();
      } else {
        //Não existe Lobby Criado. Vou fazer o meu!
        createLobby();
      }
    } catch (e) {
      print(e);
    }
  }

  _updateStates() {
    if (currentLobby.player1 != null &&
        currentLobby.player2 != null &&
        currentLobby.token != null) {
      stream = null;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PreMatch(currentLobby)));
    } else {
      Api.getUser(currentLobby.player1).then((user) => {
            setState(() {
              _player1 = user;
            })
          });
      Api.getUser(currentLobby.player2).then((user) => {
            setState(() {
              _player2 = user;
            })
          });
    }
  }

  createListener() {
    stream = Api.createListenerForLobby(currentLobby);
    stream.listen((obj) {
      //Callback
      if (mounted) {
        if (obj.data != null) {
          currentLobby.token = obj.data["token"];
          currentLobby.player1 = obj.data["player1"];
          currentLobby.player2 = obj.data["player2"];
          _updateStates();
        } else {
          //Lobby morreu
          currentLobby = null;
          setState(() {
            _player1 = null;
            _player2 = null;
          });
        }
      }
    });
  }

  Future<bool> _onWillPop() async {
    removeUserFromLobby(context);
    return true;
  }

  @override
  void dispose() {
    stream = null;
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new WillPopScope(
      onWillPop: _onWillPop, //Sobreescrevendo onBackPressed
      child: new Scaffold(
          body: Container(
        width: size.width,
        padding: EdgeInsets.only(top: 60),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_gradient.jpg"),
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
              backgroundImage: _player1 != null && _player1.urlImage != null
                  ? NetworkImage(_player1.urlImage)
                  : ExactAssetImage('./assets/images/profile-icon.png'),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: 100,
              child: MarqueeText(
                text: _player1 != null && _player1.nickname != null
                    ? _player1.nickname
                    : '',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            CircleAvatar(
              backgroundColor: AppColors.backgroundGrey2,
              radius: 80,
              backgroundImage: _player2 != null && _player2.urlImage != null
                  ? NetworkImage(_player2.urlImage)
                  : ExactAssetImage('./assets/images/profile-icon.png'),
            ),
            Container(
              width: 100,
              child: MarqueeText(
                text: _player2 != null && _player2.nickname != null
                    ? _player2.nickname
                    : '',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )),
            getTimeOutMessage()
          ],
        ),
      )),
    );
  }
}
