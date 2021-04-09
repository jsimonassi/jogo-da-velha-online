

import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';

import '../constants/Colors.dart';
import '../constants/Colors.dart';
import '../constants/Colors.dart';
import '../constants/Messages.dart';
import 'RedButton.dart';

class SearchResult extends StatelessWidget {
  String urlImage;
  String nickname;
  String nome;
  int wins;
  int losses;
  String secondButtonTitle;
  VoidCallback secondButtonAction;
  VoidCallback firstButtonAction;


  SearchResult(this.urlImage, this.nickname, this.nome, this.wins, this.losses,
      this.secondButtonTitle, this.secondButtonAction, this.firstButtonAction);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.backgroundGrey2,
      width: size.width,
      height: 150.00,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
              left :10.00,
            ),
            child:CircleAvatar(
              backgroundImage: this.urlImage != null?NetworkImage(this.urlImage):ExactAssetImage('./assets/images/profile-icon.png'),
              backgroundColor: AppColors.backgroundGrey1,
              radius: 50.00,
            )  ,
          ),
          Container(
            padding: EdgeInsets.only(
              top: 20.00,
              left: 10.00,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  child: MarqueeText(
                    text: this.nickname,
                    style: TextStyle(
                      fontSize: 25.00,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: 30,
                  ),
                ),
                SizedBox(
                  height: 5.00,
                ),
                Text(
                  this.nome,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.00,
                ),
                Container(
                  height: 45.00,
                  width: 100.00,
                  child: TextButton(
                    onPressed:this.firstButtonAction,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.redPrimary),
                    ),
                    child: Text(
                      AppMessages.redButton,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.only(
              top: 20.00,
              left: 10.00,
              right: 10.00,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppMessages.wins + this.wins.toString(),
                  style: TextStyle(
                    fontSize: 20.00,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.00,
                ),
                Text(
                  AppMessages.losses + this.losses.toString(),
                  style: TextStyle(
                    fontSize: 20.00,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.00,
                ),
                Container(
                  height: 45.00,
                  width: 100.00,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.redPrimary),
                    ),
                    onPressed: this.secondButtonAction,
                    child: Text(
                      AppMessages.redButtonAdd,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
