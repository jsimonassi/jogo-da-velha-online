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

  static Future<AuthResult> registerUser(User newUser) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance; //Instancia do firebase Auth
      var firebaseUser = await auth.createUserWithEmailAndPassword(email: newUser.email,
          password: newUser.password); //Chamando criação do user
      return firebaseUser;
    }catch(e){
      return e;
    }
  }

  static Future<void> updateUser(User newUser) async {
    try{
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db.collection("users") //Desce em Users
          .document( newUser.id ) // O nome do documento do usuário é o ID dele
          .setData(newUser.toMap());
    }catch(e){
      return e;
    }
  }

  static Future<String> uploadPicture() async {

  }
}