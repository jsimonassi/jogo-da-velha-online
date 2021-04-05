import 'package:uuid/uuid.dart';

class FriendRequest{

  String _token;
  String _idFrom;
  String _idTo;
  String _text;

  FriendRequest(from, to, token){
    this._token = token != null? token: Uuid().v4();
    this._idFrom = from;
    this._idTo = to;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "id" : this.token,
      "from": this._idFrom,
      "to": this._idTo
    };
    return map;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  String get idTo => _idTo;

  set idTo(String value) {
    _idTo = value;
  }

  String get idFrom => _idFrom;

  set idFrom(String value) {
    _idFrom = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }
}