import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/components/MultiplayerHeader.dart';
import 'package:jogodavelha/components/TableElement.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Numbers.dart';
import 'package:jogodavelha/models/Message.dart';
import 'package:jogodavelha/services/Api.dart';
import 'package:jogodavelha/services/CheckWinner.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../models/User.dart';
import '../models/Match.dart';
import '../components/ChatMessage.dart';
import '../constants/Messages.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import '../screens/GameResult.dart';

class GameMultiplayer extends StatefulWidget {
  Match currentMatch;
  User player1;
  User player2;

  GameMultiplayer(this.currentMatch, this.player1, this.player2);
  @override
  State<StatefulWidget> createState() {
    return _GameMultiplayerState(this.currentMatch, this.player1, this.player2);
  }
}

class _GameMultiplayerState extends State<GameMultiplayer> {

  User _player1;
  User _player2;
  Match _currentMatch;
  Timer _timer; //Objeto da thread de tempo
  int _currentTime = 0; //Tempo atual
  Stream<DocumentSnapshot> _stream;
  AudioPlayer audioController;
  TextEditingController _controllerMessage = TextEditingController();

  _GameMultiplayerState(this._currentMatch, this._player1, this._player2);


  @override
  void initState() {
    createListenerForChat();
    initTimer();
    initListener();
    playMusic();
    super.initState();
  }

  void createListenerForChat() {
    Stream<QuerySnapshot> stream = Api.createListenerForChat(_currentMatch.matchtoken);
    stream.listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        print(change);
      });
    });
  }

  initTimer()  { //Apenas um contatador pra tudo. Evite criar outro!
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
        if (_currentTime <= 0) {
          setState(() {
            _currentTime = AppNumbers.maxTimerValue;
            alterPlayerOfTheRound();
          });
        } else {
          setState(() {
            _currentTime--;
          });
        }
      },
    );
  }

  playMusic() async {
    AudioCache cache = new AudioCache();
    audioController =  await cache.loop("sounds/song-good-stars.mp3");
  }

  playAudioEffect(String audioPath) async {
    AudioCache cache = new AudioCache();
    await cache.play(audioPath);
  }

  // Métodos de controle da partida
  alterPlayerOfTheRound(){
    _currentMatch.playerOfTheRound = _currentMatch.playerOfTheRound == _player1.id? _player2.id : _player1.id;
    updateCurrentMatch();
  }

  makeAPlay(String key){
    if(_currentMatch.playerOfTheRound == CurrentUser.user.id && _currentMatch.plays[key] == null){
      _currentMatch.setMatchPlays(key, _currentMatch.playerOfTheRound); //Atualiza currentMatch com jogada atual
      updateCurrentMatch(); //Manda atualização para o bd
      playAudioEffect("sounds/click.mp3");
      checkWinner();
      setState(() {
        _currentTime = 0;  //Seta timer da rodada p/ 0 e troca de jogador
      });
    }
  }


  checkWinner(){
    var winner = CheckWinner(_player1.id, _player2.id, _currentMatch).check();
    if(winner != null){
      audioController.stop();
      if(winner.contains(_player1.id)){
        setState(() {
          _currentMatch.winner = _player1.id;
        });
      }else if(winner.contains(_player2.id)){
        setState(() {
          _currentMatch.winner = _player2.id;
        });
      }else{
        setState(() {
          _currentMatch.winner = "velha";
        });
      }
      updateCurrentMatch();
    }
    if(_currentMatch.winner != null){ //Fim de jogo
      print("ACABOUU");
      if(_currentMatch.winner.contains("velha")){
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) => GameResult(null)),  (Route<dynamic> route) => false);
      }else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) =>
                GameResult(_currentMatch.winner == _player1.id
                    ? _player1
                    : _player2)), (Route<dynamic> route) => false);
      }
    }
  }

  //Métodos de atualização do banco e listeners
  updateCurrentMatch(){
    Api.updateMatch(_currentMatch);
  }

  initListener(){
    try{
      _stream = Api.createListenerForMatch(_currentMatch);
      _stream.listen((obj){//Callback
        if(mounted){
          if(obj.data != null){
            _currentMatch.player1Id = obj.data["player1id"];
            _currentMatch.player2Id = obj.data["player2id"];
            _currentMatch.winner = obj.data["winner"];
            _currentMatch.plays = Map<String, dynamic>.from(obj["plays"]);
            _currentMatch.matchtoken = obj.data["matchtoken"];
            _currentMatch.timestamp = obj.data["timestamp"];
            _currentMatch.playerOfTheRound = obj.data["player_of_the_round"];
            checkWinner();
          }
        }
      });
    }catch(e){
      print(e);
    }

  }

  @override
  void dispose() {
    //Cancela o cronometro
    if (_timer != null) {
      _timer.cancel();
      setState(() {
        _stream = null;
      });
    }
    audioController.stop();
    super.dispose();
  }


  addMessage() async{
    try{
      Message message = new Message();
      message.idGame = _currentMatch.matchtoken;
      message.message = _controllerMessage.text;
      message.timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      message.idUser = CurrentUser.user.id;
      await  Api.addChat(message);

    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var gameArea = Table(
      children: [
        TableRow(children: <Widget>[
          TableElement("a1", _currentMatch, _currentTime, () => {makeAPlay("a1")}),
          TableElement("a2", _currentMatch, _currentTime, () => {makeAPlay("a2")}),
          TableElement("a3", _currentMatch, _currentTime, () => {makeAPlay("a3")}),
        ]),
        TableRow(children: <Widget>[
          TableElement("b1", _currentMatch, _currentTime, () => {makeAPlay("b1")}),
          TableElement("b2", _currentMatch, _currentTime, () => {makeAPlay("b2")}),
          TableElement("b3", _currentMatch, _currentTime, () => {makeAPlay("b3")}),
        ]),
        TableRow(children: <Widget>[
          TableElement("c1", _currentMatch, _currentTime, () => {makeAPlay("c1")}),
          TableElement("c2", _currentMatch, _currentTime, () => {makeAPlay("c2")}),
          TableElement("c3", _currentMatch, _currentTime, () => {makeAPlay("c3")}),
        ]),
      ],
    );


    var chat = ListView(
      //shrinkWrap: true, //Que comando mágico é esse???
      children: <Widget>[
        ChatMessage(
//Todo: Deverá ser adicionado em tempo de execução
          messageType: MessageType.sent,
          message: "Muito legal esse jogo!",
          backgroundColor: AppColors.redPrimary,
          textColor: Colors.white,
        ),
        ChatMessage(
          messageType: MessageType.received,
          message: "É sim, mas eu vou te ganhar boboca",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        ),
        ChatMessage(
          messageType: MessageType.sent,
          message: "Só desenvolvedor bolado",
          backgroundColor: AppColors.redPrimary,
          textColor: Colors.white,
        ),
        ChatMessage(
          messageType: MessageType.sent,
          message: "Turminha nota mil",
          backgroundColor: AppColors.redPrimary,
          textColor: Colors.white,
        ),
      ],
    );

    var chatInput = Row(
      children: <Widget>[
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteLowOpcacity,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.only(
                left: 15,
              ),
              height: 50,
              child: TextField(
                controller: _controllerMessage,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    labelText: AppMessages.chatPlaceholder,
                    labelStyle: TextStyle(
                      color: AppColors.whiteLowOpcacity,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )),
        IconButton(
            icon: const Icon(Icons.send),
            color: Colors.white,
            onPressed: (){addMessage();})
      ],
    );

    //Aqui é onde junta tudo!!
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( //Tela subir quando teclado aparecer
          //physics: NeverScrollableScrollPhysics(), //Usuário não pode rolar
          child: ConstrainedBox( //Tamanho total da tela
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(// ?
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg_gradient.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        height: size.height * 0.18, //Todo: Muito ruim
                        child: MultiplayerHeader(_player1, _player2, _currentMatch.playerOfTheRound, _currentTime),
                      ),
                      Container(
                        height: size.height * 0.42, //Todo: Muito ruim
                        child: gameArea,
                      ),
                      Container(
                        height: size.height * 0.27, //Todo: Muito ruim
                        child: chat,
                      ),
                      Expanded(
                        child: chatInput,
                      ),
                    ],
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }

}
