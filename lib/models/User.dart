class User {
  //Atributos do usuário podem ser alterados, desde que seja alterado o toMap()
  String _idUser;
  String _name;
  String _nickname;
  String _email;
  String _urlImage;
  String _password;

  //Contrutor padrão. Crie outros, se necessário.
  User();

  //Firebase Firestore recebe um map. É preciso sobrescrever o método toMap
  //pra retornar o que a gente quer. Quase um json
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "name" : this._name,
      "email" : this._email,
      "nickname": this._nickname,
      "urlImage": this._urlImage,
      "password": this._password
    };
    return map;
  }


  String get idUser => _idUser;

  set idUser(String value) {
    _idUser = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get urlImage => _urlImage;

  set urlImage(String value) {
    _urlImage = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get nickname => _nickname;

  set nickname(String value) {
    _nickname = value;
  }
}