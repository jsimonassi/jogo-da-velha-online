import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/models/User.dart';
import '../Constants/messages.dart';
import '../Constants/colors.dart';
import '../Constants/messages.dart';
import '../components/red_button.dart';
import '../services/Api.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //controllers
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNickname = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  bool validateInfos(){
    //Todo: Melhorar esse tratamentop horrível kjkk
    return _controllerName.text.isNotEmpty && _controllerEmail.text.isNotEmpty &&
        _controllerNickname.text.isNotEmpty && _controllerPassword.text.isNotEmpty?
     true :
     false;
  }

  void registerNewUser(BuildContext context){
    if(validateInfos()){//Todo: Mover ações para dentro dos services
      print("iniciando adição");
      User newUser = new User();
      newUser.name = _controllerName.text;
      newUser.nickname =  _controllerNickname.text;
      newUser.email = _controllerEmail.text;
      newUser.password = _controllerPassword.text;

      Api.registerUser(newUser) //Todo: Checar como fazer promisses em Dart
          .then((firebaseUser) => () {
            newUser.id = firebaseUser.user.uid;
            print("Cheguei aqui!!!");
            Api.updateUser(newUser)
                .then((value) => print("Fluxo finalizado"))
                .catchError((error) => print("Erro ao adicionar no bd: $error"));
          }).catchError((error) => print("Deu erro $error" ));
      //Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top:40,
            left: 40,
            right: 40
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
              child:Text(
                AppMessages.newAccount,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "Roboto", // TODO: Checar pq não está alterando
                ),
              )
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox( //TODO: SizedBox aceita onPressed?
                height: 150,
                width: 150,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                )
            ),
            SizedBox(
              height: 50,
            ),
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
              child: TextFormField(
                controller: _controllerName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    labelText: AppMessages.namePlaceholder,
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
            SizedBox(
              height: 20,
            ),
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
              child: TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    labelText: AppMessages.emailPlaceholder,
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
            SizedBox(
              height: 20,
            ),
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
              child: TextFormField(
                controller: _controllerNickname,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    labelText: AppMessages.nickNamePlaceholder,
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
            SizedBox(
              height: 20,
            ),
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
              child: TextFormField(
                controller: _controllerPassword,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    labelText: AppMessages.passwordPlaceholder,
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
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: (){
                  registerNewUser(context);
                },
                child: RedButton(AppMessages.initLogin)
            ),
          ],
        ),
      )
    );
  }
}
