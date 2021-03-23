/*
Essa componente de Loading é na verdade outra tela. Foi a forma que consegui fazer.
 Pra chamar o componente é só fazer:
Loading.enableLoading(context) e para remover Loading.disableLoading(context);
 */

import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';

class Loading{
  static enableLoading(BuildContext context){
    showDialog(
        context: context,
        builder: (_) => new LoadingView());
  }

  static disableLoading(BuildContext context){
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height,
        color: AppColors.backgroundLoading,
        child: Column(
          children: <Widget>[
            Expanded(child: Container()),
            CircularProgressIndicator(),
            Expanded(child: Container()),
          ],
        )
    );
  }
}