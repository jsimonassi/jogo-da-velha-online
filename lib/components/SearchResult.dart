import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import '../constants/Colors.dart';
import '../constants/Messages.dart';

///Componente de resultado de busca ao usuário.
class SearchResult extends StatelessWidget {
  String urlImage;
  String nickname;
  String nome;
  int wins;
  int losses;
  String secondButtonTitle;
  VoidCallback secondButtonAction;
  VoidCallback firstButtonAction;
  bool secondButtonIsEnabled;
  bool firstButtonIsEnabled;


  SearchResult(this.urlImage, this.nickname, this.nome, this.wins, this.losses,
      this.secondButtonTitle, this.secondButtonAction, this.firstButtonAction, this.secondButtonIsEnabled, this.firstButtonIsEnabled);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.backgroundGrey2,
      width: size.width,
      height: 100.00,
      padding: EdgeInsets.only(
        top: 5,
        bottom: 5,
        right: 20
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
              left :10.00,
            ),
            child:CircleAvatar(
              backgroundImage: this.urlImage != null?NetworkImage(this.urlImage):ExactAssetImage('./assets/images/profile-icon.png'),
              backgroundColor: AppColors.backgroundGrey1,
              radius: 40.00,
            )  ,
          ),
          Container(
            padding: EdgeInsets.only(
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
                      fontSize: 18.00,
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
                Expanded(child: Container()),
                Container(
                  height: 35,
                  width: 100.00,
                  child: firstButtonIsEnabled? TextButton(
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
                  ): Container(),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppMessages.wins + this.wins.toString(),
                  style: TextStyle(
                    fontSize: 16.00,
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
                    fontSize: 16.00,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  height: 35.00,
                  width: 100.00,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: secondButtonIsEnabled? MaterialStateProperty.all<Color>(AppColors.redPrimary): MaterialStateProperty.all<Color>(AppColors.backgroundGrey1),
                    ),
                    onPressed: secondButtonIsEnabled? this.secondButtonAction: null,
                    child: Text(
                      secondButtonTitle,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
