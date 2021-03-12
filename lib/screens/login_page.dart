import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Messages.dart';
import '../components/custom_dailog.dart';
import '../components/game_button.dart';
import '../constants/Colors.dart';
import '../screens/home_page.dart';
import '../components/RedButton.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void initLoginFlux(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => HomePage())
    );
  }

  void initSignUpFlux(){

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top:60,
          left: 40,
          right: 40
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/logo-small.png"),
            ),
            SizedBox( //Apenas para colocar um espaço entre a imagem e o input
              height: 80,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteLowOpcacity,
                borderRadius: BorderRadius.all(
                  Radius.circular(10)
                )
              ),
             padding: EdgeInsets.only(
               left: 15,
             ),
             height: 50,
             child: TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                    )
                ),
                style: TextStyle( //Texto escrito pelo usário
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteLowOpcacity,
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)
                  )
              ),
              padding: EdgeInsets.only(
                left: 15,
              ),
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        top: 5,
                      bottom: 5
                    ),
                    labelText: AppMessages.passwordPlaceholder,
                    labelStyle: TextStyle(
                      color: AppColors.whiteLowOpcacity,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )
                ),
                style: TextStyle( //Texto escrito pelo usário
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          InkWell(
            onTap: (){
              initLoginFlux();
            },
            child: RedButton(AppMessages.initLogin)
        ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: TextButton(
                child: Text(
                  AppMessages.singUpMessage,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400
                  ),
                ),
                onPressed: () => {initSignUpFlux()},
              )
            )
          ],
        ) /* add child content here */,
      ),
    );
  }
}
