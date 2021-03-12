

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constants/messages.dart';
import '../Constants/colors.dart';
import '../components/red_button.dart';

class SignUpPage extends StatelessWidget {

  bool validateInfos(){
    return true ? true : false; //Todo: Implementar validação de campos
  }

  void registerNewUser(BuildContext context){ //Todo: Implementar trataivas de erros
    if(validateInfos()){
      Navigator.pop(context);
    }
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
            Container(
                alignment: Alignment.center,
              child:Text(
                AppMessages.newAccount,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "Roboto", // TODO: Checar pq não está alterando
                ),
              )
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox( //TODO: SizedBox aceita onPressed?
                height: 150,
                width: 150,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                )
            ),
            SizedBox(
              height: 50,
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
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    labelText: AppMessages.nickNamePlaceholder,
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
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
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
              height: 20,
            ),
            InkWell(
                onTap: (){
                  registerNewUser(context);
                },
                child: RedButton(AppMessages.initLogin)
            ),
          ],
        ),
      )
    );
  }
}
