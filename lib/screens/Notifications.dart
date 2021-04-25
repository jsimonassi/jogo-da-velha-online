import 'package:flutter/material.dart';
import 'package:jogodavelha/components/AddFriend.dart';
import 'package:jogodavelha/components/ChallengeFriend.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/models/Friends.dart';
import '../components/ModalDialog.dart';
import '../services/Api.dart';
import '../storage/NotificationsStore.dart';
import 'Lobby.dart';

///Central de notificações do App
class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _isLoading = true;

  @override
  void initState() {
    getRecentNotificationsList();
    super.initState();
  }

  getRecentNotificationsList() async {
    try {
      await NotificationStore.refreshNotificationsList();
    } catch (e) {} finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  deleteNotification(NotificationHelper notification) async {
    setState(() {//Usando um setState pra forçar o render. Gambiarra? Talvez.
      NotificationStore.listRecentNotifications.remove(notification);
    });
    await Api.deleteNotification(notification.notification.id);
  }

  rejectFriendRequest(NotificationHelper notification){
    deleteNotification(notification);
  }

  acceptFriendRequest(NotificationHelper notification) async{
    try{
      Friend newFriend = new Friend(notification.user.id, DateTime.now().millisecondsSinceEpoch.toString());
      await Api.addFriend(newFriend);
      showDialog(
          context: context,
          builder: (_) => new ModalDialog(AppMessages.modalFriendTitle, AppMessages.addWithSucces,
                  () => {if (Navigator.canPop(context)) Navigator.pop(context)}));
    }catch(e){
      showDialog(
          context: context,
          builder: (_) => new ModalDialog(AppMessages.error, AppMessages.undefinedError,
                  () => {if (Navigator.canPop(context)) Navigator.pop(context)}));
      print(e);
    }finally{
      deleteNotification(notification);
    }
  }

  acceptChallenge(NotificationHelper notification){
    deleteNotification(notification);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => Lobby(""))); //Todo: Checar isso com multiplas partidas
  }

  buildListView(){
    if(NotificationStore.listRecentNotifications.length <= 0){
      return Text("Sem novas notificações",
      style: TextStyle(
        color: Colors.white,
      ),);
    }
    return ListView.builder(
        itemCount: NotificationStore.listRecentNotifications == null?0:NotificationStore.listRecentNotifications.length,
        itemBuilder:( BuildContext context, int index) {
          return (NotificationStore.listRecentNotifications[index].notification.type == 0?
                  AddFriend(NotificationStore.listRecentNotifications[index].user,
                  () {deleteNotification(NotificationStore.listRecentNotifications[index]);},
                  () {rejectFriendRequest(NotificationStore.listRecentNotifications[index]);},
                  () {acceptFriendRequest(NotificationStore.listRecentNotifications[index]);}):

                  ChallengeFriend(NotificationStore.listRecentNotifications[index].user,
                  () {deleteNotification(NotificationStore.listRecentNotifications[index]);},
                  () {rejectFriendRequest(NotificationStore.listRecentNotifications[index]);},
                  () {acceptChallenge(NotificationStore.listRecentNotifications[index]);}));
        }
    );
  }

  loadingIndicator(){
    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        CircularProgressIndicator(),
        Expanded(child: Container())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                AppMessages.notificationsScreenTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Expanded(
                child: _isLoading? loadingIndicator():buildListView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
