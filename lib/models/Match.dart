

class Match {
  //usuario 1, usuario 2, vencedor, data, hora, token

  String _player1Id;
  String _player2Id;
  String _winner;
  Map<String,dynamic> _plays;
  String _timestamp;
  String _matchtoken;

  Match(){
    this._plays = new Map();
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "player1" : this._player1Id,
      "player2" : this._player2Id,
      "winner" : this._winner,
      "timestamp" : this._timestamp,
      "matchtoken" : this._matchtoken,
      "plays" : this._plays,
    };
    return map;
  }

  setMatchPlays(String key, String player){
    this._plays.putIfAbsent(key, () => player);
  }

  String get player1 => _player1Id;

  set player1(String value) {
    _player1Id = value;
  }

  String get player2 => _player2Id;

  set player2(String value) {
    _player2Id = value;
  }

  String get winner => _winner;

  set winner(String value) {
    _winner = value;
  }

  String get timestamp => _timestamp;

  set timestamp(String value) {
    _timestamp = value;
  }


  Map<String, dynamic> get plays => _plays;

  set plays(Map<String, dynamic> value) {
    _plays = value;
  }

  String get matchtoken => _matchtoken;

  set matchtoken(String value) {
    _matchtoken = value;
  }
}