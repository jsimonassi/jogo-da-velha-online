import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Messages.dart';

class RedButton extends StatelessWidget {

  String buttonTitle;
  VoidCallback callback;

  RedButton(String buttonTitle, VoidCallback callback){
    this.buttonTitle = buttonTitle;
    this.callback = callback;
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      height: 45,
      child: TextButton(onPressed: this.callback,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.redPrimary),
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
