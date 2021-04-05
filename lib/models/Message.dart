import 'package:cloud_firestore/cloud_firestore.dart';

class Message {

  String _idUser;
  String _message;
  String _timeStamp;
  String _idGame;

  Message();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "id_user" : this._idUser,
      "message" : this._message,
      "time_stamp" : this._timeStamp,
      "id_game" : this._idGame,
    };
    return map;
  }

  String get idGame => _idGame;

  set idGame(String value) {
    _idGame = value;
  }

  String get timeStamp => _timeStamp;

  set timeStamp(String value) {
    _timeStamp = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get idUser => _idUser;

  set idUser(String value) {
    _idUser = value;
  }
}