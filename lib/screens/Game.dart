import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/components/MultiplayerHeader.dart';
import 'package:jogodavelha/components/TableElement.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Numbers.dart';
import 'package:jogodavelha/services/Api.dart';
import 'package:jogodavelha/services/AutoPlay.dart';
import 'package:jogodavelha/services/CheckWinner.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../models/User.dart';
import '../models/Match.dart';
import '../components/ChatMessage.dart';
import '../constants/Messages.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import '../screens/GameResult.dart';
import '../storage/Bot.dart';

class Game extends StatefulWidget {
  Match currentMatch;
  User player1;
  User player2;

  Game(this.currentMatch, this.player1, this.player2);
  @override
  State<StatefulWidget> createState() {
    return _GameState(this.currentMatch, this.player1, this.player2);
  }
}

class _GameState extends State<Game> {

  User _player1;
  User _player2;
  Match _currentMatch;
  Timer _timer; //Objeto da thread de tempo
  int _currentTime = 60; //Tempo atual
  Stream<DocumentSnapshot> _stream;
  AudioPlayer audioController;

  _GameState(this._currentMatch, this._player1, this._player2);

  @override
  void initState() {
    initTimer();
    playMusic();
    super.initState();
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
    
    if(_currentMatch.playerOfTheRound == Bot.botInfos.id){
      //Todo: interessante dar um tempinho pro bot "pensar"
      _currentMatch.setMatchPlays(AutoPlay.makeABotPlay(_currentMatch), _currentMatch.playerOfTheRound); //Atualiza currentMatch com jogada atual
      playAudioEffect("sounds/click.mp3");
      checkWinner();
      setState(() {
        _currentTime = 0;  //Seta timer da rodada p/ 0 e troca de jogador
      });
    }
  }

  makeAPlay(String key){
    if(_currentMatch.playerOfTheRound == CurrentUser.user.id && _currentMatch.plays[key] == null){
      _currentMatch.setMatchPlays(key, _currentMatch.playerOfTheRound); //Atualiza currentMatch com jogada atual
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
    }
    if(_currentMatch.winner != null){ //Fim de jogo
      print("ACABOUU");
      audioController.stop();
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
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('./assets/images/logo-low.png')
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
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









// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import '../components/custom_dailog.dart';
// import '../components/game_button.dart';
// import '../constants/colors.dart';
//
// class Game extends StatefulWidget {
//   @override
//   _GameState createState() => new _GameState();
// }
//
// class _GameState extends State<Game> {
//   List<GameButton> buttonsList;
//   var player1;
//   var player2;
//   var activePlayer;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     buttonsList = doInit();
//   }
//
//   List<GameButton> doInit() {
//     player1 = new List();
//     player2 = new List();
//     activePlayer = 1;
//
//     var gameButtons = <GameButton>[
//       new GameButton(id: 1),
//       new GameButton(id: 2),
//       new GameButton(id: 3),
//       new GameButton(id: 4),
//       new GameButton(id: 5),
//       new GameButton(id: 6),
//       new GameButton(id: 7),
//       new GameButton(id: 8),
//       new GameButton(id: 9),
//     ];
//     return gameButtons;
//   }
//
//   void playGame(GameButton gb) {
//     setState(() {
//       if (activePlayer == 1) {
//         gb.text = "X";
//         gb.bg = Colors.red;
//         activePlayer = 2;
//         player1.add(gb.id);
//       } else {
//         gb.text = "0";
//         gb.bg = Colors.black;
//         activePlayer = 1;
//         player2.add(gb.id);
//       }
//       gb.enabled = false;
//       int winner = checkWinner();
//       if (winner == -1) {
//         if (buttonsList.every((p) => p.text != "")) {
//           showDialog(
//               context: context,
//               builder: (_) => new CustomDialog("Game Tied",
//                   "Press the reset button to start again.", resetGame));
//         } else {
//           activePlayer == 2 ? autoPlay() : null;
//         }
//       }
//     });
//   }
//
//   void autoPlay() {
//     var emptyCells = new List();
//     var list = new List.generate(9, (i) => i + 1);
//     for (var cellID in list) {
//       if (!(player1.contains(cellID) || player2.contains(cellID))) {
//         emptyCells.add(cellID);
//       }
//     }
//
//     var r = new Random();
//     var randIndex = r.nextInt(emptyCells.length - 1);
//     var cellID = emptyCells[randIndex];
//     int i = buttonsList.indexWhere((p) => p.id == cellID);
//     playGame(buttonsList[i]);
//   }
//
//   int checkWinner() {
//     var winner = -1;
//     if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
//       winner = 1;
//     }
//     if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
//       winner = 2;
//     }
//
//     // row 2
//     if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
//       winner = 1;
//     }
//     if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
//       winner = 2;
//     }
//
//     // row 3
//     if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
//       winner = 1;
//     }
//     if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
//       winner = 2;
//     }
//
//     // col 1
//     if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
//       winner = 1;
//     }
//     if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
//       winner = 2;
//     }
//
//     // col 2
//     if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
//       winner = 1;
//     }
//     if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
//       winner = 2;
//     }
//
//     // col 3
//     if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
//       winner = 1;
//     }
//     if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
//       winner = 2;
//     }
//
//     //diagonal
//     if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
//       winner = 1;
//     }
//     if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
//       winner = 2;
//     }
//
//     if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
//       winner = 1;
//     }
//     if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
//       winner = 2;
//     }
//
//     if (winner != -1) {
//       if (winner == 1) {
//         showDialog(
//             context: context,
//             builder: (_) => new CustomDialog("Player 1 Won",
//                 "Press the reset button to start again.", resetGame));
//       } else {
//         showDialog(
//             context: context,
//             builder: (_) => new CustomDialog("Player 2 Won",
//                 "Press the reset button to start again.", resetGame));
//       }
//     }
//
//     return winner;
//   }
//
//   void resetGame() {
//     if (Navigator.canPop(context)) Navigator.pop(context);
//     setState(() {
//       buttonsList = doInit();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(
//           title: new Text("Jogo da velha"),
//         ),
//         body: new Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             new Expanded(
//               child: new GridView.builder(
//                 padding: const EdgeInsets.all(10.0),
//                 gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     childAspectRatio: 1.0,
//                     crossAxisSpacing: 9.0,
//                     mainAxisSpacing: 9.0),
//                 itemCount: buttonsList.length,
//                 itemBuilder: (context, i) => new SizedBox(
//                   width: 100.0,
//                   height: 100.0,
//                   child: new RaisedButton(
//                     padding: const EdgeInsets.all(8.0),
//                     onPressed: buttonsList[i].enabled
//                         ? () => playGame(buttonsList[i])
//                         : null,
//                     child: new Text(
//                       buttonsList[i].text,
//                       style:
//                           new TextStyle(color: Colors.amber, fontSize: 20.0),
//                     ),
//                     color: buttonsList[i].bg,
//                     disabledColor: buttonsList[i].bg,
//                   ),
//                 ),
//               ),
//             ),
//             new RaisedButton(
//               child: new Text(
//                 "Reset",
//                 style: new TextStyle(color: Colors.white, fontSize: 20.0),
//               ),
//               color: Colors.red,
//               padding: const EdgeInsets.all(20.0),
//               onPressed: resetGame,
//             )
//           ],
//         ));
//   }
// }
