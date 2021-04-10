class Friend {

  String _friendId; //Id do amigo
  String _dateInitFriendship; //Data de início da amizade

  Friend(this._friendId, this._dateInitFriendship);

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "friend_id" : this._friendId,
      "init_friendship": this._dateInitFriendship,
    };
    return map;
  }

  String get dateInitFriendship => _dateInitFriendship;

  set dateInitFriendship(String value) {
    _dateInitFriendship = value;
  }

  String get friendId => _friendId;

  set friendId(String value) {
    _friendId = value;
  }
}