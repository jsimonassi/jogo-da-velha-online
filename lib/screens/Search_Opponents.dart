import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/components/SearchResult.dart';
import 'package:jogodavelha/models/FriendRequest.dart';
import '../constants/Messages.dart';
import '../constants/Messages.dart';
import '../storage/CurrentUser.dart';
import '../storage/CurrentUser.dart';
import '../storage/CurrentUser.dart';
import '../storage/Bot.dart';
import '../models/User.dart';
import '../services/Api.dart';

class SearchOpponents extends StatefulWidget {
  @override
  _SearchOpponentsState createState() => _SearchOpponentsState();
}

class _SearchOpponentsState extends State<SearchOpponents> {

  sendFriendRequest(User newFriend) async{
    try{
      FriendRequest newRequest = new FriendRequest(CurrentUser.user.id, newFriend.id, null);
      await Api.sendFriendRequest(newRequest);
      print("Deu bom");
    }catch(e){
      print("Deu ruim $e");
    }
  }

  searchFriendsRequest() async { //Deve retornar a lista de requisições do usuário
    try{
      var response = await Api.getFriendRequests(CurrentUser.user);
      print("Deu bom");

    }catch(e){
      print("Deu ruim $e");
    }
  }

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
            SearchResult(CurrentUser.user.urlImage, CurrentUser.user.nickname, CurrentUser.user.name, 4, 3,
                AppMessages.redButtonAdd, ()=>{sendFriendRequest(Bot.botInfos)}, () {sendFriendRequest(Bot.botInfos);}),
            SearchResult(CurrentUser.user.urlImage, CurrentUser.user.nickname, CurrentUser.user.name, 4, 3,
                AppMessages.redButtonAdd, ()=>{}, () {sendFriendRequest(Bot.botInfos);}),
            SearchResult(CurrentUser.user.urlImage, CurrentUser.user.nickname, CurrentUser.user.name, 4, 3,
                AppMessages.redButtonAdd, ()=>{}, () {sendFriendRequest(Bot.botInfos);}),
            TextButton(onPressed: (){sendFriendRequest(Bot.botInfos);}, child: Text("Nova requisição")),
            TextButton(onPressed: (){searchFriendsRequest();}, child: Text("Adicionar amigos")), //Todo: Ficar na tela que abre depois que chega a notificação
          ]),
          //decoration: BoxDecoration(
            //image: DecorationImage(
              //image: AssetImage("assets/bg_gradient.jpg"),
              //fit: BoxFit.cover,


        );
  }
}

class DataSearch extends SearchDelegate<String> {
  final listaJogadores = ['gustavo', 'leo'];
  final buscaRecentes = ['berna'];

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
    return ListView.builder(
        itemCount: listaJogadores.length,
        itemBuilder: (context, indice){
          SearchResult(CurrentUser.user.urlImage, listaJogadores[indice], CurrentUser.user.name, 4, 3,
              AppMessages.redButtonAdd, ()=>{}, ()=>{});
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchResult(CurrentUser.user.urlImage, CurrentUser.user.nickname, CurrentUser.user.name, 4, 3,
        AppMessages.redButtonAdd, ()=>{}, ()=>{});

  }
}





