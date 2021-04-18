import 'package:jogodavelha/constants/Messages.dart';

///Classe que modela um usuário.
///Obs: Um bot usado na partida local também é um usuário (Ver storage/History)
class User {
  //Atributos do usuário podem ser alterados, desde que seja alterado o toMap()
  String _id;
  String _name;
  String _nickname;
  String _email;
  String _urlImage;
  String _password;
  String _pushId;
  int _wins = 0;
  int _losses = 0;

  //Contrutor padrão. Crie outros, se necessário.
  User();

  //Firebase Firestore recebe um map. É preciso sobrescrever o método toMap
  //pra retornar o que a gente quer. Quase um json
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "id" : this._id,
      "name" : this._name,
      "email" : this._email,
      "nickname": this._nickname,
      "urlImage": this._urlImage,
      "password": this._password,
      "push_id": this._pushId,
      "wins": this._wins,
      "losses": this._losses,
    };
    return map;
  }

  User mapToUser(Map<String, dynamic> mapUser){
    User user = new User();
    user.name = mapUser["name"];
    user.password = mapUser["password"];
    user.email = mapUser["email"];
    user.nickname = mapUser["nickname"];
    user.urlImage = mapUser["urlImage"];
    user.id = mapUser["id"];
    user.wins = mapUser["wins"];
    user.losses = mapUser["losses"];
    user.pushId = mapUser["push_id"];
    return user;
  }


  String get id => _id;

  set id(String value) {
    _id = value;
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

  int get losses => _losses;

  set losses(int value) {
    _losses = value;
  }

  int get wins => _wins;

  set wins(int value) {
    _wins = value;
  }

  String get pushId => _pushId;

  set pushId(String value) {
    _pushId = value;
  }
}