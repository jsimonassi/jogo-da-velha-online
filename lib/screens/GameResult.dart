import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Messages.dart';
import '../models/Match.dart';

class GameResult extends StatefulWidget {

  @override
  _GameResultState createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height*0.1),
            Text(
              AppMessages.endOfMatch,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: size.height * 0.05),
            CircleAvatar(
              maxRadius: 80,
            ),
            SizedBox(
                height: size.height * 0.05),
            Text(
              AppMessages.endOfMatch,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      )
    );
  }
}