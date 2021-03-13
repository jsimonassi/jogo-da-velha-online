import 'dart:async';
import '../models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Api {

  static Future createUser(User newUser){ //Todo: Cara, isso aqui tá muito ruim
    var completer = Completer(); //Iniciando callback
    FirebaseAuth auth = FirebaseAuth.instance; //Instancia do firebase Auth
    auth.createUserWithEmailAndPassword(email: newUser.email, password: newUser.password) //Chamando criação do user
    .then((firebaseUser) => () { //Guardando no banco
        Firestore db = Firestore.instance; //Instancia de Firestore
        db.collection("users") //Desce em Users
        .document( firebaseUser.user.uid ) // O nome do documento do usuário é o ID dele
        .setData(newUser.toMap()) //Objeto que será gravado
        .then((value) => completer.complete()) //Deu bom, retorna callback
        .catchError((error) => completer.completeError(error)); //Deu ruim no Firestore
    })
    .catchError((error) => completer.completeError(error)); //Deu ruim no Auth
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