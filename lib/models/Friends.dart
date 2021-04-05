class Friends{
  String _idUser;
  List<String> _friendsList;

  Friends(this._idUser, this._friendsList){}

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUser" : this._idUser,
      "friendslist": this._friendsList,
    };
    return map;
  }

  String get idUser => _idUser;

  List<String> get friendslist => _friendsList;

  set friendslist(List<String> value) {
    _friendsList = value;
  }

  set idUser(String value) {
    _idUser = value;
  }
}