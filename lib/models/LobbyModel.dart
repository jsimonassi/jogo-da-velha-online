import 'package:uuid/uuid.dart';

class LobbyModel {

  String _token;
  String _player1;
  String _player2;

  LobbyModel(){
    this._token = Uuid().v4();
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "token" : this._token,
      "player1" : this._player1,
      "player2" : this._player2,
    };
    return map;
  }

  String get player2 => _player2;

  set player2(String value) {
    _player2 = value;
  }

  String get player1 => _player1;

  set player1(String value) {
    _player1 = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }
}