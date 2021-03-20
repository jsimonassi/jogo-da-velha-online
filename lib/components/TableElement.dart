import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';

class TableElement extends StatelessWidget {

  String id; //Identifica qual é o botão
  bool isX; // Se for X, deve exibir X, se não, exibir O)
  bool wasPressed; //Se foi pressionado, exibir valor.
  VoidCallback callback;
  int currentTime;

  TableElement(this.id, this.isX, this.wasPressed, this.currentTime, this.callback);

  getBackgroundGradient(){
    if(this.currentTime != null && this.currentTime % 2 == 0){
      return [AppColors.defaultElement1, AppColors.defaultElement2, AppColors.defaultElement3, AppColors.defaultElement4];
    }
    return [AppColors.defaultElement4, AppColors.defaultElement3, AppColors.defaultElement2, AppColors.defaultElement1];
  }

  getBeginDirection(){
    if(this.currentTime != null && this.currentTime % 2 == 0){
      return Alignment.topLeft;
    }
    return Alignment.topRight;
  }

  getEndDirection(){
    if(this.currentTime != null && this.currentTime % 2 == 0){
      return Alignment.bottomRight;
    }
    return Alignment.bottomLeft;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: getBackgroundGradient(),
              begin: getBeginDirection(),
              end: getEndDirection(),
            ),
          ),
          width: size.width * 0.25,
          height: size.width * 0.25,
          duration: Duration(seconds: 5),
          child: TextButton(
            onPressed: callback,
            child: Text(""),
          ),
        ),
      )
    );
  }
}
