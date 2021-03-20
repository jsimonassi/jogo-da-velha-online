import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/screens/GameMultiplayer.dart';
import '../storage/CurrentUser.dart';
import '../components/RedButton.dart';
import '../screens/Game.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg_gradient.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
                width: size.width,
                height: size.height * 0.15,
                color: AppColors.backgroundGrey2,
                child: Image.asset(
              "assets/logo-small.png",
              width: size.width * 0.4,
            )),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                color: AppColors.backgroundGrey1,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      backgroundImage: CurrentUser.user.urlImage == null? 
                      ExactAssetImage("assets/profile-icon.png") : NetworkImage(CurrentUser.user.urlImage),
                      maxRadius: 36.0,
                      backgroundColor: AppColors.backgroundGrey2,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      AppMessages.hello + CurrentUser.user.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          decoration: TextDecoration.none),
                    )
                  ],
                )),
            SizedBox(
              height: size.height * 0.03,
            ),
           Container(
             width: size.width * 0.8,
             child: RedButton(AppMessages.newGame, () => {Navigator.push(context,
                 MaterialPageRoute(builder: (BuildContext context) => Game()))}),
           ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              width: size.width * 0.8,
              child: RedButton(AppMessages.newTraining, () => {Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) => GameMultiplayer()))}),
            ),
          ],
        ),
      ),
    );
  }
}
