import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Search_Oponents extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Pesquisar"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed:(){
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              child: new GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 9.0,
                    mainAxisSpacing: 9.0),
                itemCount: buttonsList.length,
                itemBuilder: (context, i) => new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    onPressed: buttonsList[i].enabled
                        ? () => playGame(buttonsList[i])
                        : null,
                    child: new Text(
                      buttonsList[i].text,
                      style:
                      new TextStyle(color: Colors.amber, fontSize: 20.0),
                    ),
                    color: buttonsList[i].bg,
                    disabledColor: buttonsList[i].bg,
                  ),
                ),
              ),
            ),
            new RaisedButton(
              child: new Text(
                "Reset",
                style: new TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.red,
              padding: const EdgeInsets.all(20.0),
              onPressed: resetGame,
            )
          ],
        ));
  }
    );
  }

}

class DataSearch extends SearchDelegate<String> {
  final listaJogadores = ['gustavo', 'leo'];
  final buscaRecentes = ['berna'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = "";
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(
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
    return Container(
      child: Text('oi'),
      color: Colors.red,
      height: 100.00,
      width: 395.00,
    );
  }
}