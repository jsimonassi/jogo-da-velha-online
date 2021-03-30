import 'package:flutter/material.dart';
import '../models/Match.dart';

class GameResult extends StatefulWidget {

  @override
  _GameResultState createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {

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