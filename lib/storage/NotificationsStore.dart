import 'package:jogodavelha/models/Notification.dart';
import 'package:jogodavelha/services/Api.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../models/User.dart';

class NotificationStore{
  static List<NotificationHelper> listRecentNotifications =[]; //Contem a notificação e o usuário que mandou

  static Future<bool> refreshNotificationsList() async { //Isso seria quebra de modularização? Talvez seja melhor morrer isso para o Api.dart
    var response = await Api.getNotifications(CurrentUser.user); //Pega as  notificações do usário logado
    if (response != null) {
      listRecentNotifications = [];
      for(int i = 0; i < response.length; i++){
        User user = await Api.getUser(response[i].userFrom);//Quem enviou a notificação
        Notification notification = response[i];
        listRecentNotifications.add(new NotificationHelper(notification, user));
      }
      return true;
    }
    return false;
    }
}

class NotificationHelper{
  Notification notification;
  User user;

  NotificationHelper(this.notification, this.user);
}