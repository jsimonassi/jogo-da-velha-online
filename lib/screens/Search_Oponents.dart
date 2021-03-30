import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/components/SearchResult.dart';
import 'package:jogodavelha/services/Api.dart';

import '../constants/Messages.dart';
import '../constants/Messages.dart';
import '../storage/CurrentUser.dart';
import '../storage/CurrentUser.dart';
import '../storage/CurrentUser.dart';

class Search_Oponents extends StatefulWidget {
  //Todo: Mudar para Statefull
  //Todo: Não usar AppBar, Fazer tudo no body (O componente do bernardo tem um exemplo de row)
  // Todo: DataSearch não precisa ser uma classe

  @override
  _Search_OponentsState createState() => _Search_OponentsState();
}

class _Search_OponentsState extends State<Search_Oponents> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(AppMessages.searchTitle),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //Todo: Buscar jogador pela string passada
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body: Column(
          //padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          children: <Widget>[
            SizedBox(
              height: 30.00,
            ),
            SearchResult(
                CurrentUser.user.urlImage,
                CurrentUser.user.nickname,
                CurrentUser.user.name,
                4,
                3,
                AppMessages.redButtonAdd,
                () => {},
                () => {})
          ]),
      //decoration: BoxDecoration(
      //image: DecorationImage(
      //image: AssetImage("assets/bg_gradient.jpg"),
      //fit: BoxFit.cover,
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final PlayersList = ['gustavo', 'leo'];
  final RecentSearches = ['berna'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        height: 100.00,
        width: 100.00,
        child: SearchResult(
            CurrentUser.user.urlImage,
            CurrentUser.user.nickname,
            CurrentUser.user.name,
            4,
            3,
            AppMessages.redButtonAdd,
            () => {},
            () => {}));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? RecentSearches
        : PlayersList;

    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                showResults(context);
              },
              leading: Icon(Icons.account_circle),
              title: Text(suggestionList[index]),
            ));
  }
}
