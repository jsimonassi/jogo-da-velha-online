
///Classe que representa uma partida, seja ela online ou local.
class Match {

  String _player1Id;
  String _player2Id;
  String _winner;
  Map<String,dynamic> _plays;
  String _timestamp;
  String _matchtoken;
  String _playerOfTheRound;

  Match(){
    this._plays = new Map();
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "player1id" : this._player1Id,
      "player2id" : this._player2Id,
      "winner" : this._winner,
      "timestamp" : this._timestamp,
      "matchtoken" : this._matchtoken,
      "player_of_the_round" : this.playerOfTheRound,
      "plays" : this._plays,
    };
    return map;
  }

  setMatchPlays(String key, String player){
    this._plays.putIfAbsent(key, () => player);
  }

  String get playerOfTheRound => _playerOfTheRound;

  set playerOfTheRound(String value) {
    _playerOfTheRound = value;
  }

  String get matchtoken => _matchtoken;

  set matchtoken(String value) {
    _matchtoken = value;
  }

  String get timestamp => _timestamp;

  set timestamp(String value) {
    _timestamp = value;
  }

  Map<String, dynamic> get plays => _plays;

  set plays(Map<String, dynamic> value) {
    _plays = value;
  }

  String get winner => _winner;

  set winner(String value) {
    _winner = value;
  }

  String get player2Id => _player2Id;

  set player2Id(String value) {
    _player2Id = value;
  }

  String get player1Id => _player1Id;

  set player1Id(String value) {
    _player1Id = value;
  }
}