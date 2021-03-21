import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jogodavelha/components/MultiplayerHeader.dart';
import 'package:jogodavelha/components/TableElement.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../models/User.dart';
import '../components/ChatMessage.dart';
import '../constants/Messages.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  User bot = User().generateBot();
  Timer _timer;
  int _currentTime = 0;

  @override
  void initState() {
    // TODO: implement initState
    initTimer();
    setState(() {});
    super.initState();
  }

  initTimer() {
    const oneSec = const  Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      if(mounted){
        setState(() {
          _currentTime++;
        });
      }
    });
  }

  updateAnimations(){
    //Todo: Atualizar gradientes a cada 5 segundos
  }

  @override
  void dispose() {
    //Cancela o cronometro
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg_gradient.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        /////////////////////////////////////////////////Header
        child: Column(children: <Widget>[
          MultiplayerHeader(CurrentUser.user, bot, true, _currentTime),
          SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true, //Que comando mágico é esse???
            children: <Widget>[
              SizedBox(
                width: size.width,
                child: Table(
                  ////////////////////////////////////////////////////////GameArea
                  children: [
                    TableRow(children: <Widget>[
                      TableElement("a1", true, false, _currentTime, () => {}),
                      TableElement("a2", true, false, _currentTime, () => {}),
                      TableElement("a3", true, false, _currentTime, () => {}),
                    ]),
                    TableRow(children: <Widget>[
                      TableElement("b1", true, false, _currentTime, () => {}),
                      TableElement("b2", true, false, _currentTime, () => {}),
                      TableElement("b3", true, false, _currentTime, () => {}),
                    ]),
                    TableRow(children: <Widget>[
                      TableElement("c1", true, false, _currentTime, () => {}),
                      TableElement("c2", true, false, _currentTime, () => {}),
                      TableElement("c3", true, false, _currentTime, () => {}),
                    ]),
                  ],
                ),
              ),
              Container(
                ///////////////////////////////////////////////////////Chat
                width: size.width,
                height: size.height * 0.2,
                //Todo: Encontrar uma forma de expandir tudo
                child: ListView(
                  shrinkWrap: true, //Que comando mágico é esse???
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
                ),
              ),
              Row(
                //////////////////////////////////////////////////////////Rodapé
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
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          labelText: AppMessages.emailPlaceholder,
                          labelStyle: TextStyle(
                            color: AppColors.whiteLowOpcacity,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          )),
                      style: TextStyle(
                        //Texto escrito pelo usário
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  )),
                  IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.white,
                      onPressed: () => {})
                ],
              ),
            ],
          ),
        ]),
      ),
    ));
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
