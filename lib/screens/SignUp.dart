import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jogodavelha/models/User.dart';
import '../Constants/Messages.dart';
import '../Constants/Colors.dart';
import '../components/RedButton.dart';
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
  File _image;
  String _tempImageUrl;


  bool validateInfos(){
    //Todo: Melhorar esse tratamentop horrível kjkk
    return _controllerName.text.isNotEmpty && _controllerEmail.text.isNotEmpty &&
        _controllerNickname.text.isNotEmpty && _controllerPassword.text.isNotEmpty?
     true :
     false;
  }

  void registerUserInfos(User newUser) async {
    var result = await Api.registerUser(newUser);
    if (result.user.uid != null){
      newUser.id = result.user.uid;
      Api.updateUser(newUser);
    }
  }

  void generateUser(BuildContext context){
    if(validateInfos()){//Todo: Mover ações para dentro dos services
      User newUser = new User();
      newUser.name = _controllerName.text;
      newUser.nickname =  _controllerNickname.text;
      newUser.email = _controllerEmail.text;
      newUser.password = _controllerPassword.text;
      registerUserInfos(newUser);
    }
  }

  Future<void> _pickerImage() async { //Todo: Apenas rascunho
    PickedFile selectedImage = await ImagePicker().getImage(source: ImageSource.gallery); //Rapaz, esse flutter é bom mesmo
    setState(() {
      _image = File(selectedImage.path);
      if( _image != null ){

        //Recuperar url da imagem

      }
    });

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
            GestureDetector(
              onTap: () => {_pickerImage()},
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: _tempImageUrl == null? 
                ExactAssetImage("assets/profile-icon.png"):
                NetworkImage(_tempImageUrl),
                maxRadius: 80.0,
              ),
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
                  generateUser(context);
                },
                child: RedButton(AppMessages.newAccountButton)
            ),
          ],
        ),
      )
    );
  }
}
//CircularProgressIndicator