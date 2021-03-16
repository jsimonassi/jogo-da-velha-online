import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jogodavelha/constants/Messages.dart';
import '../storage/CurrentUser.dart';
import '../models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
Credenciais do Firebase:
Email: g04vermelhouff@gmail.com
Senha: UFF@alunos88
 */

class Api {
  static Future<AuthResult> registerUser(User newUser) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance; //Instancia do firebase Auth
      var firebaseUser = await auth.createUserWithEmailAndPassword(
          email: newUser.email,
          password: newUser.password); //Chamando criação do user
      return firebaseUser;
    } catch (e) {
      return e;
    }
  }

  static Future<void> updateUser(User newUser) async {
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db
          .collection("users") //Desce em Users
          .document(newUser.id) // O nome do documento do usuário é o ID dele
          .setData(newUser.toMap());
    } catch (e) {
      return e;
    }
  }

  // static Future<String> uploadPicture(User user, File image) async {
  //   try {
  //       FirebaseStorage storage = FirebaseStorage.instance;
  //       //Upload da imagem
  //       StorageUploadTask task = storage.ref().child(user.id+ ".jpg").putFile(
  //           image);
  //       task.onComplete.then((StorageTaskSnapshot snapshot) => () async {
  //         String url = await snapshot.ref.getDownloadURL();
  //         print(" Esse é o URL: $url");
  //       });
  //   }catch(e){
  //     return e;
  //   }
  // }

  static Future<User> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance; //Instancia do firebase Auth
      var result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        CurrentUser.user = await getUser(result.user.uid); //Set usuário atual
        return CurrentUser.user;
      }
    } catch (e) {
      //Todo:retornar erros aqui
      String error = e.code;
      print("Errorrr $error");
      if (error.contains('ERROR_INVALID_EMAIL')) {
        throw FormatException(AppMessages.invalidEmail);
      } else if (error.contains('ERROR_WRONG_PASSWORD')) {
        throw FormatException(AppMessages.invalidPassword);
      }
      throw FormatException(error); //Exception não mapeada
    }
  }

  static Future<User> getUser(String uid) async {
    try {
      DocumentSnapshot snapshot = await Firestore.instance
          .collection("users")
          .document(uid)
          .get(); //Busca o arquivo
      Map<String, dynamic> infos =
          snapshot.data; //Tranforma resultado em um MAp
      User user = new User();
      user.name = infos["name"];
      user.password = infos["password"];
      user.email = infos["email"];
      user.nickname = infos["email"];
      user.urlImage = infos["urlImage"];
      user.id = infos["id"];
      return user;
    } catch (e) {
      throw FormatException(e.code);
    }
  }
}
