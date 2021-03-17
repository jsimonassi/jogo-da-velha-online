import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import '../storage/CurrentUser.dart';

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
                child: Image.asset(
              "assets/logo-small.png",
              width: size.width * 0.4,
            )),
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 16),
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                color: AppColors.whiteLowOpcacity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          ExactAssetImage("assets/profile-icon.png"),
                      maxRadius: 36.0,
                    ),
                    Text(
                      "Olá, ${CurrentUser.user.name}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          decoration: TextDecoration.none),
                    )
                  ],
                )),
            Container(
              width: size.width * 0.8,
              margin: EdgeInsets.only(bottom: 16),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: AppColors.redPrimary,
                    onPressed: () {},
                    child: Text("Nova partida",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  )),
            ),
            Container(
              width: size.width * 0.8,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: AppColors.redPrimary,
                    onPressed: () {},
                    child: Text("Treinar",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
