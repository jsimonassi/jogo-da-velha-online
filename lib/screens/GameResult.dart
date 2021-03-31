import 'package:flutter/material.dart';
import 'package:jogodavelha/components/RedButton.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/screens/Lobby.dart';
import 'package:jogodavelha/screens/MenuNavigation.dart';
import '../models/User.dart';

User winner;

class GameResult extends StatefulWidget {

  GameResult(User matchWinner){
    winner= matchWinner;
  }

  @override
  _GameResultState createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {

  getProfileImage(){
    if(winner == null){
      return NetworkImage("https://super.abril.com.br/wp-content/uploads/2017/03/por-que-o-jogo-da-velha-tem-esse-nome.jpg?quality=70&strip=info&resize=680,453");
    }else if(winner.urlImage != null){
      return NetworkImage(winner.urlImage);
    }
    return ExactAssetImage('./assets/images/profile-icon.png');
  }

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
                height: size.height * 0.02),
            Text(
              AppMessages.winner,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: AppColors.redPrimary,
              ),
            ),
            SizedBox(
                height: size.height * 0.05),
            CircleAvatar(
              maxRadius: 80,
              backgroundImage: getProfileImage(),
            ),
            SizedBox(
                height: size.height * 0.05),
            Text(
              winner != null? winner.nickname : AppMessages.old,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Expanded(child: Container()),
            RedButton(AppMessages.playAgain, () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) => Lobby()),  (Route<dynamic> route) => false);
            }),
            SizedBox(
                height: size.height * 0.03),
            RedButton(AppMessages.home, () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) => MenuNavigation()),  (Route<dynamic> route) => false);
            }),
            Expanded(child: Container()),
          ],
        ),
      )
    );
  }
}