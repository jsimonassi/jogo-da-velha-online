import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/screens/Edit.dart';
import 'package:jogodavelha/screens/Search.dart';
import 'package:jogodavelha/storage/NotificationsStore.dart';
import '../screens/Home.dart';
import '../screens/Notifications.dart';

///Bottom menu da aplicação.
///Gerencia os contextos gerais das rotas.
///Obs: Não temos um arquivos de rotas configurado explicitamente.
///O fluxo de mudança de tela é feito semelhante ao android nativo,
///isto é, adicionando e removendo telas da stack.
class MenuNavigation extends StatefulWidget {

  @override
  _MenuNavigationState createState() =>  _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {

  int _currentIndex = 0;
  bool _hasNotification = false;

  @override
  void initState() {
    if(NotificationStore.listRecentNotifications.length > 0){
      setState(() {
        _hasNotification = true;
      });
    }else{
      setState(() {
        _hasNotification = false;
      });
    }
    super.initState();
  }

  getNotificationIcon(){
    if(_hasNotification){
      return new Stack(
          children: <Widget>[
            new Icon(Icons.notifications),
            new Positioned(  // draw a red marble
              top: 0.0,
              right: 0.0,
              child: new Icon(Icons.brightness_1, size: 10.0, //Todo: Deve ser exibido baseado na lista de notificações
                  color: Colors.redAccent),
            )
          ]
      );
    }

    return new Icon(Icons.notifications);
  }

  final tabs = [
    Center(child: Home()),
    Center(child: Search()),
    Center(child: Notifications()),
    Center(child: EditPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.redPrimary,
            primaryColor: AppColors.bottomNavegationWhite,
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.yellow))
          ),// sets the inactive color of the `BottomNavigationBar`
          child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: 'Play',
              backgroundColor: Colors.red
          ),
            BottomNavigationBarItem(
                icon: getNotificationIcon(),
                label: 'Notificações',
                backgroundColor: Colors.red
            ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Perfil',
              backgroundColor: Colors.red,
          ),
          ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      ),
    );
    throw UnimplementedError();
  }
}