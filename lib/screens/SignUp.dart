import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jogodavelha/models/User.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/constants/Colors.dart';
import '../components/RedButton.dart';
import '../services/Api.dart';
import '../storage/CurrentUser.dart';
import '../components/ModalDialog.dart';
import '../screens/MenuNavigation.dart';
import '../components/Loading.dart';

///Tela de criação de criação de conta.
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
  bool _errorMenssagesIsVisible = false;
  String _imageUrlPath;
  String _imageLocalProvider;


  bool validateInfos(){
    if(_controllerName.text.isEmpty  || _controllerNickname.text.isEmpty ||
      !_controllerEmail.text.contains("@") || _controllerPassword.text.length < 6){
      setState(() {
        _errorMenssagesIsVisible = true;
      });
      return false;
    }
    return true;
  }

  void registerUserInfos(User newUser, context) async {
    try {
      Loading.enableLoading(context);
      var result = await Api.registerUser(newUser);
      if (result.user.uid != null) {
        newUser.id = result.user.uid;
        if(_imageLocalProvider != null){
          String path = await Api.uploadPicture(newUser, File(_imageLocalProvider));
          newUser.urlImage = path;
        }
        await Api.updateUser(newUser);
        CurrentUser.user = newUser;
        Loading.disableLoading(context);
        showDialog(
            context: context,
            builder: (_) => new ModalDialog(AppMessages.saveSuccess, '',
                    () {
              if (Navigator.canPop(context)){
                    Navigator.pop(context);
                    }
                    Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (BuildContext context) => MenuNavigation()), (Route<dynamic> route) => false);
            }));
      }
    }catch(e){
      Loading.disableLoading(context);
      showDialog(
          context: context,
          builder: (_) => new ModalDialog(AppMessages.error, e.message,
                  () => {if (Navigator.canPop(context)) Navigator.pop(context)}));
    }finally{
      //Todo: O loading deveria parar aqui, mas precisamos remove-lo antes de exibir uma outra modal
    }
  }

  void generateUser(BuildContext context){
    if(validateInfos()){//Todo: Mover ações para dentro dos services
      User newUser = new User();
      newUser.name = _controllerName.text;
      newUser.nickname =  _controllerNickname.text;
      newUser.email = _controllerEmail.text;
      newUser.password = _controllerPassword.text;
      registerUserInfos(newUser, context);
    }
  }

  getProfileImage(){
    if(_imageUrlPath != null)
      return NetworkImage(_imageUrlPath);
    else if(_imageLocalProvider != null)
      return FileImage(File(_imageLocalProvider));
    return ExactAssetImage("assets/images/profile-icon.png");
  }

  Future<void> _pickerImage() async { //Todo: Apenas rascunho
    PickedFile selectedImage = await ImagePicker().getImage(source: ImageSource.gallery); //Rapaz, esse flutter é bom mesmo
    setState(() {
       _imageLocalProvider = selectedImage.path;
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
            image: AssetImage("assets/images/bg_gradient.jpg"),
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
                backgroundImage: getProfileImage(),
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
            Visibility(
              visible: _errorMenssagesIsVisible,
              child: Container(
                padding: EdgeInsets.only(right: 10, top: 2),
                child: Text(
                  AppMessages.inputBlank,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: AppColors.redPrimary, fontSize: 11),
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
            Visibility(
              visible: _errorMenssagesIsVisible,
              child: Container(
                padding: EdgeInsets.only(right: 10, top: 2),
                child: Text(
                  AppMessages.invalidEmailFormat,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: AppColors.redPrimary, fontSize: 11),
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
            Visibility(
              visible: _errorMenssagesIsVisible,
              child: Container(
                padding: EdgeInsets.only(right: 10, top: 2),
                child: Text(
                  AppMessages.inputBlank,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: AppColors.redPrimary, fontSize: 11),
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
            Visibility(
              visible: _errorMenssagesIsVisible,
              child: Container(
                padding: EdgeInsets.only(right: 10, top: 2),
                child: Text(
                  AppMessages.invalidPasswordFormat,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: AppColors.redPrimary, fontSize: 11),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RedButton(AppMessages.newAccountButton, () => {generateUser(context)})
          ],
        ),
      )
    );
  }
}
//CircularProgressIndicator