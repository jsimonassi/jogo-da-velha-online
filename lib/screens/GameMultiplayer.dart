import 'package:flutter/material.dart';
import 'package:jogodavelha/components/MultiplayerHeader.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';

class GameMultiplayer extends StatefulWidget {
  @override
  _GameMultiplayerState createState() => _GameMultiplayerState();
}


class _GameMultiplayerState extends State<GameMultiplayer> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget> [
              MultiplayerHeader(CurrentUser.user, CurrentUser.user, true),
            ],
          ),
        ),
      ),
    );
  }
}
