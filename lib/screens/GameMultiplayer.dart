import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jogodavelha/components/MultiplayerHeader.dart';
import 'package:jogodavelha/components/TableElement.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../models/User.dart';
import '../models/Match.dart';
import '../components/ChatMessage.dart';
import '../constants/Messages.dart';

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
  User bot = User().generateBot();
  Timer _timer; //Objeto da thread de tempo
  int _currentTime = 0; //Tempo atual
  int _currentAnimationTime = 0;
  int _lastAnimationUpdate = 0; //Apenas para contar de 5 em 5

  _GameMultiplayerState(this._currentMatch, this._player1, this._player2);

  @override
  void initState() {
    initTimer();
    setState(() {});
    super.initState();
  }

  initTimer()  {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
        if (_currentTime == 0) {
          setState(() {
            _currentTime = 60;
            _currentMatch.playerOfTheRound = _currentMatch.playerOfTheRound == _player1.id? _player2.id : _player1.id;
            //timer.cancel();
          });
        } else {
          setState(() {
            _currentTime--;
            _lastAnimationUpdate++;
          });
        }
      },
    );
  }

  updateAnimations() {
    if( _lastAnimationUpdate > 5){
      setState(() {
        _lastAnimationUpdate = 0;
        _currentAnimationTime++;
      });
    }
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
    var gameArea = Table(
      children: [
        TableRow(children: <Widget>[
          TableElement("a1", true, false, _currentAnimationTime, () => {}),
          TableElement("a2", true, false, _currentAnimationTime, () => {}),
          TableElement("a3", true, false, _currentAnimationTime, () => {}),
        ]),
        TableRow(children: <Widget>[
          TableElement("b1", true, false, _currentAnimationTime, () => {}),
          TableElement("b2", true, false, _currentAnimationTime, () => {}),
          TableElement("b3", true, false, _currentAnimationTime, () => {}),
        ]),
        TableRow(children: <Widget>[
          TableElement("c1", true, false, _currentAnimationTime, () => {}),
          TableElement("c2", true, false, _currentAnimationTime, () => {}),
          TableElement("c3", true, false, _currentAnimationTime, () => {}),
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
            onPressed: () => {})
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
                      image: AssetImage("assets/bg_gradient.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        height: size.height * 0.18, //Todo: Muito ruim
                        child: MultiplayerHeader(_player1, _player2, _currentMatch.playerOfTheRound == _player1.id? true: false, _currentTime),
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
