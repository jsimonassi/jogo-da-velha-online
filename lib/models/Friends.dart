class Friends{
  String _idUser;
  List<String> _friendslist;


  Friends(this._idUser, this._friendslist){
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUser" : this._idUser,
      "friendslist": this._friendslist,
    };
    return map;
  }

  String get idUser => _idUser;

  List<String> get friendslist => _friendslist;

  set friendslist(List<String> value) {
    _friendslist = value;
  }

  set idUser(String value) {
    _idUser = value;
  }
}