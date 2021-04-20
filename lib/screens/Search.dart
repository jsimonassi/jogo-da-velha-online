import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/components/ModalDialog.dart';
import 'package:jogodavelha/components/SearchResult.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/models/FriendRequest.dart';
import 'package:jogodavelha/models/Friends.dart';
import '../constants/Messages.dart';
import '../storage/CurrentUser.dart';
import '../models/User.dart';
import '../services/Api.dart';

///Tela chamada no menu de "Play", mas é uma tela que busca e lista os usuários/amigos.
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _controllerInput = TextEditingController();
  bool _isLoading = false;
  List<User> _searchedUsers = [];
  List<User> _friendsList = [];

  @override
  void initState() {
    getFriends();
    super.initState();
  }

  getFriends() async {
    var response = await Api.getFriendsByUser(CurrentUser.user);
    if(response != null && response.isNotEmpty){
      setState(() {
        _friendsList = response;
      });
    }
  }

  sendFriendRequest(User newFriend) async {
    try {
      FriendRequest newRequest = new FriendRequest(
          CurrentUser.user.id, newFriend.id, newFriend.pushId, null);
      await Api.sendFriendRequest(newRequest);
      showDialog(
          context: context,
          builder: (_) => new ModalDialog(AppMessages.friendRequestSend, "Aguarde " + newFriend.nickname+" aceitar sua solicitação.",
                  () => {if (Navigator.canPop(context)) Navigator.pop(context)}));
    } catch (e) {
      print("Deu ruim $e");
    }
  }

  searchUsers() async{
    try{
      var key = _controllerInput.text;
      if(key.isEmpty) return;
      setState(() {
        _isLoading = true;
        _searchedUsers = [];
      });
      var usersResponse = await Api.getUsersByKey(key);
      if(usersResponse != null && usersResponse.isNotEmpty){
        setState(() {
          _searchedUsers = usersResponse;
        });
      }
    }catch(e){
      print(e); //Todo: Tratar Exceptions
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  removeFriend(User friend) async {
    try{
      await Api.removeFriend(friend);
      setState(() {
        _friendsList.remove(friend);
      });
    }catch(e){
      print(e);
    }
  }

  bool isFriend(User user){
    for(int i = 0; i< _friendsList.length; i++){
      if(_friendsList[i].id == user.id){
        return true;
      }
    }
    //return _friendsList.contains(user);
    return false;
  }

  buildListView(){
    return ListView.builder(
        itemCount: _searchedUsers.length,
        itemBuilder:( BuildContext context, int index) {
          return SearchResult(_searchedUsers[index].urlImage, _searchedUsers[index].nickname,
              _searchedUsers[index].name, _searchedUsers[index].wins,
              _searchedUsers[index].losses, AppMessages.addFriendButtonMsg, () {sendFriendRequest(_searchedUsers[index]);}, () => {}, !isFriend(_searchedUsers[index]));
        }
    );
  }

  buildListViewForFriends(){
    return ListView.builder(
        itemCount: _friendsList.length,
        itemBuilder:( BuildContext context, int index) {
          return SearchResult(_friendsList[index].urlImage, _friendsList[index].nickname,
              _friendsList[index].name, _friendsList[index].wins,
              _friendsList[index].losses, AppMessages.removeFriendButtonMsg, () {removeFriend(_friendsList[index]);}, () => {}, true);
        }
    );
  }

  progressIndicator(){
    if(_isLoading){
      return LinearProgressIndicator(
        backgroundColor: Colors.black,
      );
    }
    return SizedBox(
      height: 3,
    );
  }

  drawnSearchList(){
    if(_searchedUsers.isEmpty){
      return SizedBox(height: 0,width: 0);
    }
    return Expanded(child: buildListView());
  }

  drawnFriendsSearchList(){
    if(_friendsList.isEmpty){
      return SizedBox(height: 0,width: 0);
    }
    return Expanded(child: buildListViewForFriends());

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
                  Container(
                    height: 60,
                    width: size.width,
                    color: Colors.black,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget> [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.whiteLowOpcacity,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              )
                          ),
                          padding: EdgeInsets.only(
                            left: 15,
                          ),
                          height: 50,
                          width: size.width * 0.7,
                          child: TextFormField(
                            controller: _controllerInput,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),
                                labelText: AppMessages.searchPlaceholder,
                                labelStyle: TextStyle(
                                  color: AppColors.whiteLowOpcacity,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                )
                            ),
                            style: TextStyle( //Texto escrito pelo usário
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          width: size.width*0.2,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.backgroundLoading,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              )
                          ),
                          child: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {searchUsers();},
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  progressIndicator(),
                  drawnSearchList(),
                  Container(
                    color: AppColors.backgroundGrey1,
                    width: size.width,
                    height: _friendsList.isEmpty? 0: 20, //Tem cara de gambiarra
                    child: Text(
                    AppMessages.friendsList,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  drawnFriendsSearchList()
                ]),
          ),
        )
    );
  }
}




