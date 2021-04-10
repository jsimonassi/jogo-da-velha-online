import 'package:flutter/material.dart';
import 'package:jogodavelha/components/RedButton.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Messages.dart';
import '../models/User.dart';


///Componente exibido na tela de notificações quando uma
///solicitação de amizade é recebida.
class AddFriend extends StatelessWidget {
  User _newFriend;
  VoidCallback _acceptRequestCallback;
  VoidCallback _rejectRequestCallback;
  VoidCallback _closeNotificationCallback;

  AddFriend(this._newFriend, this._closeNotificationCallback, this._rejectRequestCallback, this._acceptRequestCallback);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 110,
      color: AppColors.backgroundGrey1,
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            backgroundImage: this._newFriend.urlImage == null
                ? ExactAssetImage('./assets/images/profile-icon.png')
                : NetworkImage(this._newFriend.urlImage),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this._newFriend.nickname,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    AppMessages.addFriendMsg,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    child: Row(
                      children: <Widget> [
                        RedButton(AppMessages.rejectFriend, this._rejectRequestCallback),
                        SizedBox(width: size.width * 0.1),
                        RedButton(AppMessages.acceptFriend, this._acceptRequestCallback),
                      ],
                    ),
                  ),
                ]),
          ),
          Expanded(child: Container()),
          Container(
            height: size.height,
            alignment: Alignment.topCenter,
            child: IconButton(
                icon: new Icon(Icons.close),
                color: Colors.white,
                onPressed: this._closeNotificationCallback) ,
          )
        ],
      ),
    );
  }
}
