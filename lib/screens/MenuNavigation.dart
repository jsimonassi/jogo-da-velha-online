import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/screens/Edit.dart';
import 'package:jogodavelha/screens/Search_Opponents.dart';
import '../screens/Home.dart';

class MenuNavigation extends StatefulWidget {

  @override
  _MenuNavigationState createState() =>  _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {

  int _currentIndex = 0;

  final tabs = [
    Center(child: Home()),
    Center(child: SearchOpponents()),
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
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: 'Play',
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
              backgroundColor: Colors.red
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