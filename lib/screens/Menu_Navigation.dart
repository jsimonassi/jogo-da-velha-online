import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/Home.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() =>  _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  final tabs = [
    Center(child: Text('Home')),
    Center(child: Text('Play')),
    Center(child: Text('Perfil'))
  ]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation'),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.red
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              title: Text('Play'),
              backgroundColor: Colors.red
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
              backgroundColor: Colors.red
          ),

          ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
    throw UnimplementedError();
  }
}