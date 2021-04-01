import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/models/FriendRequest.dart';
import 'package:jogodavelha/screens/Lobby.dart';
import '../storage/CurrentUser.dart';
import '../models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/LobbyModel.dart';
import '../models/Match.dart';
import '../storage/Bot.dart';
import '../models/FriendRequest.dart';

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
      String error = e.code != null? e.code : '';
      print("Errorrr $e");
      if (error.contains('ERROR_EMAIL_ALREADY_IN_USE')) {
        throw FormatException(AppMessages.emailAlreadyInUse);
      }
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> updateUser(User newUser) async { //Todo: Deve retornar user
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

  static Future<String> uploadPicture(User user, File image) async {
    try {
        FirebaseStorage storage = FirebaseStorage.instance;
        //Upload da imagem
        StorageUploadTask task = storage.ref().child(user.id+ ".jpg").putFile(image);
        var dowurl = await (await task.onComplete).ref.getDownloadURL();
        return dowurl.toString();
    }catch(e){
      return e;
    }
  }

  static Future<User> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance; //Instancia do firebase Auth
      var result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
        CurrentUser.user = await getUser(result.user.uid); //Set usuário atual
        Bot.botInfos = Bot.generateBot();
        return CurrentUser.user;
    } catch (e) {
      String error = e.code != null? e.code : '';
      print("Errorrr $e");
      if (error.contains('ERROR_INVALID_EMAIL')) {
        throw FormatException(AppMessages.invalidEmail);
      } else if (error.contains('ERROR_WRONG_PASSWORD')) {
        throw FormatException(AppMessages.invalidPassword);
      }
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
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
      if(infos == null){return null;} //Usuário não encontrado
      User user = new User();
      user.name = infos["name"];
      user.password = infos["password"];
      user.email = infos["email"];
      user.nickname = infos["nickname"];
      user.urlImage = infos["urlImage"];
      user.id = infos["id"];
      return user;
    } catch (e) {
      String error = e.code != null? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> updateLobby(LobbyModel newLobby) async {
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db
          .collection("lobbys") //Desce em Users
          .document(newLobby.token) // O nome do documento do usuário é o ID dele
          .setData(newLobby.toMap());
    } catch (e) {
      String error = e.code != null? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> deleteLobby(LobbyModel lobby) async {
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db
          .collection("lobbys") //Desce em Users
          .document(lobby.token) // O nome do documento do usuário é o ID dele
          .delete();
    }  catch (e) {
      String error = e.code != null? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<List<LobbyModel>> getLobbys() async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance.collection("lobbys").getDocuments();
      var list = querySnapshot.documents;

      if(list.isEmpty) return null; //Se lista está vazia, return nulo pra criar um novo lobby

      List<LobbyModel> response = [];
      for(int i =0; i < list.length; i++){
        Map<String, dynamic> infos = list[i].data; //Tranforma resultado em um MAp
        var newLobby = LobbyModel();
        newLobby.token = infos["token"];
        newLobby.player1 = infos["player1"];
        newLobby.player2 = infos["player2"];
        response.add(newLobby);
      }
      return response;
    }  catch (e) {
      String error = e.code != null? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Stream<DocumentSnapshot> createListenerForLobby(LobbyModel lobby) {
    try {
      return Firestore.instance
          .collection("lobbys")
          .document(lobby.token)
          .snapshots();
    }  catch (e) {
      String error = e.code != null? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> updateMatch(Match newMatch) async { //Todo: Deve retornar user
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db
          .collection("matches") //Desce em Users
          .document(newMatch.matchtoken) // O nome do documento do usuário é o ID dele
          .setData(newMatch.toMap());
    } catch (e) {
      return e;
    }
  }

  static Future<List<Match>> getMatches(User user) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance.collection("matches").where("player1", isEqualTo: user.id).getDocuments();
      var list = querySnapshot.documents;
      if(list.isEmpty) return null;
      List<Match> response = [];
      for(int i =0; i < list.length; i++){
        Map<String, dynamic> infos = list[i].data;
        var newMatch = Match();
        newMatch.player1Id = infos["player1"];
        newMatch.player2Id = infos["player2"];
        newMatch.winner = infos["winner"];
        newMatch.timestamp = infos["timestamp"];
        newMatch.matchtoken = infos["matchtoken"];
        newMatch.playerOfTheRound = infos["player_of_the_round"];
        newMatch.plays = new Map<String, dynamic>.from(infos["plays"]); //Casting para o tipo map
        response.add(newMatch);
      }
      return response;
    } catch (e) {
      print(e);
      throw FormatException(e.code);
    }
  }

  static Stream<DocumentSnapshot> createListenerForMatch(Match match) {
    try {
      return Firestore.instance
          .collection("matches")
          .document(match.matchtoken)
          .snapshots();
    }  catch (e) {
      String error = e.code != null? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }


  static Future<void> sendFriendRequest(FriendRequest request) async {
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db
          .collection("friendRequests") //Desce em Users
          .document(request.token) // O nome do documento do usuário é o ID dele
          .setData(request.toMap());
    } catch (e) {
      String error = e.code != null? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<List<FriendRequest>> getFriendRequests(User user) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance.collection("friendRequests").where("to", isEqualTo: user.id).getDocuments();
      var list = querySnapshot.documents;
      if(list.isEmpty) return null;
      List<FriendRequest> response = [];
      for(int i =0; i < list.length; i++){
        Map<String, dynamic> infos = list[i].data;
        var newFriendRequest = FriendRequest(infos["from"], infos["to"], infos["id"]);
        response.add(newFriendRequest);
      }
      return response;
    } catch (e) {
      print(e);
      throw FormatException(e.code);
    }
  }

  static Future<void> sendFriendRequest(FriendRequest request) async {
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db
          .collection("friendRequests") //Desce em Users
          .document(request.token) // O nome do documento do usuário é o ID dele
          .setData(request.toMap());
    } catch (e) {
      String error = e.code != null? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

}
