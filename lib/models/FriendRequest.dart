import 'package:uuid/uuid.dart';

///Classe que modela um objeto de solicitação de amizade
class FriendRequest{

  String _token;
  String _idUserFrom;
  String _idUserTo;
  String _idNotificationUserTo;
  String _text;

  FriendRequest(from, to, notificationId, token){
    this._token = token != null? token: Uuid().v4();
    this._idUserFrom = from;
    this._idUserTo = to;
    this._idNotificationUserTo = notificationId;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "id" : this.token,
      "from": this._idUserFrom,
      "to": this._idUserTo,
      "from_notification_id": this._idNotificationUserTo,
    };
    return map;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  String get idNotificationUserTo => _idNotificationUserTo;

  set idNotificationUserTo(String value) {
    _idNotificationUserTo = value;
  }

  String get idUserTo => _idUserTo;

  set idUserTo(String value) {
    _idUserTo = value;
  }

  String get idUserFrom => _idUserFrom;

  set idUserFrom(String value) {
    _idUserFrom = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }
}