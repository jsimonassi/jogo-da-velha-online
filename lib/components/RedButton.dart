import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Messages.dart';

class RedButton extends StatelessWidget {

  String buttonTitle;

  RedButton(String buttonTitle){
    this.buttonTitle = buttonTitle;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 45,
      margin: EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.redPrimary,
          borderRadius: BorderRadius.all(
              Radius.circular(5)
          )
      ),
      child: Text(
        this.buttonTitle,
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }
}
