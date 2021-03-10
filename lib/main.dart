import 'package:flutter/material.dart';
import 'file:///C:/Users/joao.farias/Documents/jogo-da-velha-online/lib/screens/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primaryColor: Colors.black),
      home: new HomePage(),
    );
  }
}
