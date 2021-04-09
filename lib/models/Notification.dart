import 'package:uuid/uuid.dart';

/// Model que descreve uma notificação.
/// Notification Types:
/// 0: AddFriend,
/// 1: Infos,
/// 2: Desafios

class Notification{
  int _type;
  String _userTo; //Pra quem vai a notificação
  String _userFrom;// Quem mandou a notificação
  String _textDescription; //Texto da notificação
  String _timestamp; //Tá aqui, mas nem sei se vou usar
  String _id;

  Notification(int type, String userFrom, String userTo, String textDescription, String id){
    this._type = type;
    this._userFrom = userFrom;
    this._userTo = userTo;
    this._textDescription = textDescription;
    this._id = id == null? Uuid().v4(): id;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "type" : this._type,
      "to" : this._userTo,
      "from": this._userFrom,
      "timestamp" : this._timestamp,
      "text" : this._textDescription,
      "id": this._id
    };
    return map;
  }

  String get textDescription => _textDescription;

  set textDescription(String value) {
    _textDescription = value;
  }

  String get userTo => _userTo;

  set userTo(String value) {
    _userTo = value;
  }

  int get type => _type;

  set type(int value) {
    _type = value;
  }

  String get timestamp => _timestamp;

  set timestamp(String value) {
    _timestamp = value;
  }

  String get userFrom => _userFrom;

  set userFrom(String value) {
    _userFrom = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}