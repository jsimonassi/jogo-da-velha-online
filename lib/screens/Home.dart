import 'package:flutter/material.dart';
import 'package:jogodavelha/components/History.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/models/LobbyModel.dart';
import 'package:jogodavelha/screens/PreMatch.dart';
import 'package:jogodavelha/storage/RecentMatch.dart';
import 'package:marquee_text/marquee_text.dart';
import '../storage/CurrentUser.dart';
import '../storage/Bot.dart';
import '../components/RedButton.dart';
import '../screens/Lobby.dart';

///Tela de Home da aplicação.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _isLoading = true;

  @override
  void initState() {
    getRecentMatchesList();
    super.initState();
  }
  startTraining(){
    LobbyModel trainingLobby = new LobbyModel();
    trainingLobby.player1 = CurrentUser.user.id;
    trainingLobby.player2 = Bot.botInfos.id;
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => PreMatch(trainingLobby)));
  }

  getRecentMatchesList() async {
    if(RecentMatch.listRecentMatches.isEmpty){
      await RecentMatch.getMacthes();
    }
    setState(() {
      _isLoading = false;
    });
  }

  buildListView(){
    return ListView.builder(
        itemCount: RecentMatch.listRecentMatches == null?0:RecentMatch.listRecentMatches.length,
        itemBuilder:( BuildContext context, int index) {
          return History(RecentMatch.listRecentMatches[index].player1, RecentMatch.listRecentMatches[index].player2, RecentMatch.listRecentMatches[index].match);
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
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  width: size.width,
                  height: size.height * 0.15,
                  color: AppColors.backgroundGrey2,
                  child: Image.asset(
                    "assets/images/logo-small.png",
                    width: size.width * 0.4,
                  )),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  color: AppColors.backgroundGrey1,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        backgroundImage: CurrentUser.user.urlImage == null?
                        ExactAssetImage("assets/images/profile-icon.png") : NetworkImage(CurrentUser.user.urlImage),
                        maxRadius: 36.0,
                        backgroundColor: AppColors.backgroundGrey2,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 200,
                        child: MarqueeText(
                          text: AppMessages.hello + CurrentUser.user.nickname,
                          speed: 30,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              decoration: TextDecoration.none),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width * 0.8,
                child: RedButton(AppMessages.newGame, () => {Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) => Lobby()))}),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width * 0.8,
                margin: EdgeInsets.only(bottom: 10),
                child: RedButton(AppMessages.newTraining, () {startTraining();}),
              ),
              Expanded(
                child: _isLoading? loadingIndicator():buildListView(),
              )
            ],
          ),
        ),
      ) ,
    );

  }
}
