import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Messages.dart';

///Botão vermelho no estilo do app.
class GreyButton extends StatelessWidget {

  String buttonTitle;
  VoidCallback callback;

  GreyButton(String buttonTitle, VoidCallback callback){
    this.buttonTitle = buttonTitle;
    this.callback = callback;
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
        height: 45,
        child: TextButton(onPressed: this.callback,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(AppColors.grayPrimary),
          ),
          child: Text(
            this.buttonTitle,
            style: TextStyle(
                color: Colors.white
            ),
          ),
        )
    );
  }
}
