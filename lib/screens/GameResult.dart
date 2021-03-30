import 'package:flutter/material.dart';
import '../models/Match.dart';

class GameResult extends StatefulWidget {
  Match lastMatch;
  GameResult(this.lastMatch);
  @override
  _GameResultState createState() {
    _GameResultState(this.lastMatch);
  }
}

class _GameResultState extends State<GameResult> {

  Match _lastMatch;

  _GameResultState(this._lastMatch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}