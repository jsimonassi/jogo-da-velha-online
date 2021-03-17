import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search_Oponents extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisar"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed:(){
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      drawer: Drawer(),
    );
  }

}

class DataSearch extends SearchDelegate<String>{
  final listaJogadores =[];
  final buscaRecentes =[];
  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(icon: Icon(Icons.clear), onPressed:() {
        query = "";
      })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow,
      progress:transitionAnimation,
    ),
    onPressed: (){
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      height: 100.00,
      width: 100.00,
      child: Card(
        color: Colors.red,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList=query.isEmpty?buscaRecentes:listaJogadores.where((p)=>p.startsWith(query)).toList();
    
    return ListView.builder(itemBuilder: (context,index)=>ListTile(
      onTap: (){
        showResults(context);
      },
      leading: Icon(Icons.person),
      title: RichText(text:TextSpan(
        text: suggestionList[index].substring(0,query.length),
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        children: [TextSpan(
          text:suggestionList[index].substring(query.length),
          style: TextStyle(color :Colors.grey)
        )],
        )
      ),
    ),
      itemCount:suggestionList.length,
    );
  }
  
}