import 'dart:async';
import '../models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
Credenciais do Firebase:
Email: g04vermelhouff@gmail.com
Senha: UFF@alunos88
 */

class Api {

  static Future registerUser(User newUser){ //Todo: Cara, isso aqui tá muito ruim
    var completer = Completer(); //Iniciando callback
    FirebaseAuth auth = FirebaseAuth.instance; //Instancia do firebase Auth
    auth.createUserWithEmailAndPassword(email: newUser.email, password: newUser.password) //Chamando criação do user
    .then((firebaseUser) => completer.complete())
    .catchError((error) => completer.completeError(error)); //Deu ruim no Auth
    return completer.future;
  }

  static Future updateUser(User newUser){
    var completer = Completer(); //Iniciando callback
    Firestore db = Firestore.instance; //Instancia de Firestore
    db.collection("users") //Desce em Users
        .document( newUser.id ) // O nome do documento do usuário é o ID dele
        .setData(newUser.toMap())//Objeto que será gravado
        .then((firebaseUser) => completer.complete())
        .catchError((error) => completer.completeError(error)); //Deu ruim no updateUser
    return completer.future;
  }
}
//Example:
// Future lookupVersionAsFuture() {
//   var completer = Completer();
//
//   lookupVersion((version) => completer.complete(version));
//   lookupVersion((_) => completer.completeError('There was a problem!'));
//
//   return completer.future;
// }