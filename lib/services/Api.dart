import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/models/Message.dart';
import 'package:jogodavelha/models/FriendRequest.dart';
import 'package:jogodavelha/models/Notification.dart';
import 'package:jogodavelha/storage/NotificationsStore.dart';
import 'package:jogodavelha/storage/RecentMatch.dart';
import '../storage/CurrentUser.dart';
import '../models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/LobbyModel.dart';
import '../models/Match.dart';
import '../storage/Bot.dart';
import 'package:uuid/uuid.dart';
import '../models/FriendRequest.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

/*
Credenciais do Firebase e OneSignal:
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
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      if (error.contains('ERROR_EMAIL_ALREADY_IN_USE')) {
        throw FormatException(AppMessages.emailAlreadyInUse);
      }
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> updateUser(User newUser) async {
    //Todo: Deve retornar user
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      OSPermissionSubscriptionState status = await OneSignal.shared.getPermissionSubscriptionState();
      if(status != null){
        newUser.pushId = status.subscriptionStatus.userId;
      }
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
      StorageUploadTask task =
          storage.ref().child(user.id + ".jpg").putFile(image);
      var dowurl = await (await task.onComplete).ref.getDownloadURL();
      return dowurl.toString();
    } catch (e) {
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
      await NotificationStore.refreshNotificationsList();
      return CurrentUser.user;
    } catch (e) {
      String error = e.code != null ? e.code : '';
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
      if (infos == null) {
        return null;
      } //Usuário não encontrado
      User user = new User();
      user.name = infos["name"];
      user.password = infos["password"];
      user.email = infos["email"];
      user.nickname = infos["nickname"];
      user.urlImage = infos["urlImage"];
      user.id = infos["id"];
      user.wins = infos["wins"];
      user.losses = infos["losses"];
      user.pushId = infos["push_id"];
      return user;
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<List<User>> getUsersByKey(String key) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance.collection("users").where("name", isGreaterThanOrEqualTo: key).getDocuments();//Todo: Pesquisa muitooo ruim - Firebase dificultou aqui
      var list = querySnapshot.documents;
      if (list.isEmpty) return null;
      List<User> response = [];
      for (int i = 0; i < list.length; i++) {
        if(list[i].data["id"] != CurrentUser.user.id) {
          User user = new User();
          user.name = list[i].data["name"];
          user.password = list[i].data["password"];
          user.email = list[i].data["email"];
          user.nickname = list[i].data["nickname"];
          user.urlImage = list[i].data["urlImage"];
          user.id = list[i].data["id"];
          user.wins =list[i].data["wins"];
          user.losses = list[i].data["losses"];
          user.pushId = list[i].data["push_id"];
          response.add(user);
        }
      }
      return response;
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> updateLobby(LobbyModel newLobby) async {
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db
          .collection("lobbys") //Desce em Users
          .document(
              newLobby.token) // O nome do documento do usuário é o ID dele
          .setData(newLobby.toMap());
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> addChat(Message message) async {
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db
          .collection("messages") //Desce em messages
          .document(message.idGame)
          .collection("game_messages")
          .document(Uuid().v4()) // O nome do documento de mensagens
          .setData(message.toMap());
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Stream<QuerySnapshot> createListenerForChat(String matchToken) {
    try {
      return Firestore.instance
          .collection("messages")
          .document(matchToken)
          .collection("game_messages")
          .snapshots();
    } catch (e) {
      String error = e.code != null ? e.code : '';
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
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<List<LobbyModel>> getLobbys() async {
    try {
      QuerySnapshot querySnapshot =
          await Firestore.instance.collection("lobbys").getDocuments();
      var list = querySnapshot.documents;

      if (list.isEmpty)
        return null; //Se lista está vazia, return nulo pra criar um novo lobby

      List<LobbyModel> response = [];
      for (int i = 0; i < list.length; i++) {
        Map<String, dynamic> infos =
            list[i].data; //Tranforma resultado em um MAp
        var newLobby = LobbyModel();
        newLobby.token = infos["token"];
        newLobby.player1 = infos["player1"];
        newLobby.player2 = infos["player2"];
        response.add(newLobby);
      }
      return response;
    } catch (e) {
      String error = e.code != null ? e.code : '';
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
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> updateMatch(Match newMatch) async {
    //Todo: Deve retornar user
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db
          .collection("matches") //Desce em Users
          .document(
              newMatch.matchtoken) // O nome do documento do usuário é o ID dele
          .setData(newMatch.toMap());
    } catch (e) {
      return e;
    }
  }

  static Future<List<Match>> getMatches(User user) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance.collection("matches").where("player1id", isEqualTo: user.id).getDocuments();//Partidas que eu sou Player 1
      var list = querySnapshot.documents;
      QuerySnapshot querySnapshot2 = await Firestore.instance.collection("matches").where("player2id", isEqualTo: user.id).getDocuments();//Partidas que eu sou Player 2
      list.addAll(querySnapshot2.documents);//Junta os dois resultados (Única forma que encontrei de fazer um or. Deve ter algo mais elegante que isso).
      if (list.isEmpty) return null;
      List<Match> response = [];
      for (int i = 0; i < list.length; i++) {
        Map<String, dynamic> infos = list[i].data;
        var newMatch = Match();
        newMatch.player1Id = infos["player1id"];
        newMatch.player2Id = infos["player2id"];
        newMatch.winner = infos["winner"];
        newMatch.timestamp = infos["timestamp"];
        newMatch.matchtoken = infos["matchtoken"];
        newMatch.playerOfTheRound = infos["player_of_the_round"];
        newMatch.plays = new Map<String, dynamic>.from(
            infos["plays"]); //Casting para o tipo map
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
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> sendFriendRequest(FriendRequest request) async {
    try {
      await sendPushNotification(request); //Envia pushNotification para o usuário do amiguinho
      Notification notification = new Notification(0, request.idUserFrom, request.idUserTo, "Quer ser seu amigo.", null); //Envia notificação para o BD para ser recuperada posteriormente
      await addNotification(notification);
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> sendPushNotification(FriendRequest request) async {
    try {
      if(request.idNotificationUserTo == null) return;
      return await OneSignal.shared.postNotification(
        OSCreateNotification(playerIds: [request.idNotificationUserTo],
            content: CurrentUser.user.nickname + AppMessages.friendRequestReceivedBody,
            heading: AppMessages.friendRequestReceivedTitle,
            bigPicture: "https://firebasestorage.googleapis.com/v0/b/jogo-da-velha-ac9b0.appspot.com/o/notification.png?alt=media&token=dc3003a7-b00a-47ec-b61d-75885c39d3bf",
            androidSmallIcon: "https://firebasestorage.googleapis.com/v0/b/jogo-da-velha-ac9b0.appspot.com/o/logo.png?alt=media&token=679d2efe-fcfa-4b83-9e5e-7d40f38f8817",
            androidLargeIcon: "https://firebasestorage.googleapis.com/v0/b/jogo-da-velha-ac9b0.appspot.com/o/logo.png?alt=media&token=679d2efe-fcfa-4b83-9e5e-7d40f38f8817",
        )
      );
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

  static Future<void> addNotification(Notification notification) async {
    try {
      if(notification.userTo != null){
        Firestore db = Firestore.instance; //Instancia de Firestore
        await db
            .collection("notifications") //Desce em Users
            .document(notification.id) // O nome do documento do usuário é o ID dele
            .setData(notification.toMap());
      }
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }


  static Future<List<Notification>> getNotifications(User user) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection("notifications")
          .where("to", isEqualTo: user.id)
          .getDocuments();
      var list = querySnapshot.documents;
      if (list.isEmpty) return null;
      List<Notification> response = [];
      for (int i = 0; i < list.length; i++) {
        Map<String, dynamic> infos = list[i].data;
        var newNotification = new Notification(infos["type"], infos["from"], infos["to"], infos["text"], infos["id"]);
        response.add(newNotification);
      }
      return response;
    } catch (e) {
      print(e);
      throw FormatException(e.code);
    }
  }

  static Future<void> deleteNotification(String notificationId) async {
    try {
      Firestore db = Firestore.instance; //Instancia de Firestore
      return await db
          .collection("notifications") //Desce em Users
          .document(notificationId) // O nome do documento do usuário é o ID dele
          .delete();
    } catch (e) {
      String error = e.code != null ? e.code : '';
      print("Errorrr $e");
      throw FormatException(AppMessages.undefinedError); //Exception não mapeada
    }
  }

}
