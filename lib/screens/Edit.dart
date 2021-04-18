import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jogodavelha/models/User.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/screens/Login.dart';
import 'package:jogodavelha/storage/Storage.dart';
import '../components/RedButton.dart';
import '../components/GreyButton.dart';
import '../services/Api.dart';
import '../storage/CurrentUser.dart';
import 'package:jogodavelha/components/ModalDialog.dart';
import 'package:jogodavelha/components/Loading.dart';

///Tela de edição das informações do usuário
class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  //controllers
  TextEditingController _controllerName = TextEditingController(text: CurrentUser.user.name);
  TextEditingController _controllerEmail = TextEditingController(text: CurrentUser.user.email);
  TextEditingController _controllerNickname = TextEditingController(text: CurrentUser.user.nickname);
  TextEditingController _controllerPassword = TextEditingController(text:CurrentUser.user.password);
  File _image;
  bool _enabled = false;
  String _imageLocalProvider;
  String _imageUrlPath;

  TextEditingController _controller = new TextEditingController();


  bool validateInfos(){
    //Todo: Melhorar esse tratamentop horrível kjkk
    return _controllerName.text.isNotEmpty && _controllerEmail.text.isNotEmpty &&
        _controllerNickname.text.isNotEmpty && _controllerPassword.text.isNotEmpty?
    true :
    false;
  }


  void updateUser(BuildContext context) async{
    User userBackUp =  CurrentUser.user;
    try{
      if(validateInfos()){
        Loading.enableLoading(context);

        CurrentUser.user.name = _controllerName.text;
        CurrentUser.user.nickname =  _controllerNickname.text;

        if( _imageLocalProvider!=null){
          CurrentUser.user.urlImage = await Api.uploadPicture(CurrentUser.user, File(_imageLocalProvider));
        }
        await Api.updateUser(CurrentUser.user);
        Loading.disableLoading(context);

        showDialog(
            context: context,
            builder: (_) => new ModalDialog(AppMessages.updateSuccess,'',
                    () => {if (Navigator.canPop(context)) Navigator.pop(context)}));
      }
    }
    catch(e)
    {
      CurrentUser.user = userBackUp;
      Loading.disableLoading(context);
      showDialog(
          context: context,
          builder: (_) => new ModalDialog(AppMessages.error, e.message,
                  () => {if (Navigator.canPop(context)) Navigator.pop(context)}));
    }

  }

  getProfileImage(){
    if(CurrentUser.user.urlImage != null)
      return NetworkImage(CurrentUser.user.urlImage);
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

  void logOut() async{
    try{
     await Api.logOut();
     await Storage.clearAll();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) =>  LoginPage()), (Route<dynamic> route) => false);
    }
    catch(e){
    print("erroooor");
    }
  }


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              top:10,
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
                    AppMessages.editAccount,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "Roboto", // TODO: Checar pq não está alterando
                    ),
                  )
              ),
              SizedBox(
                height: size.height*0.05,
              ),
              GestureDetector(
                onTap: () => {_pickerImage()},
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: getProfileImage(),
                  maxRadius: 50.0,
                ),
              ),
              SizedBox(
                height:size.height*0.05,
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
                height:size.height*0.025,
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
                child: TextFormField(enabled: _enabled,
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
                  style: theme.textTheme.subtitle1.copyWith(
                    color: theme.disabledColor,
                  ),
                ),
              ),
              SizedBox(
                height:size.height*0.025,
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
                height:size.height*0.025,
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
                child: TextFormField(enabled: _enabled,
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
                  style: theme.textTheme.subtitle1.copyWith(
                    color: theme.disabledColor,
                  ),
                ),
              ),
              SizedBox(
                height:size.height*0.05,
              ),
            RedButton(AppMessages.saveAccountButton, () => {updateUser(context)}),
              SizedBox(
                height:size.height*0.03,
              ),
              GreyButton(AppMessages.exitAccountButton, () => {logOut()}),
            ],
          ),
        )
    );
  }
}
//CircularProgressIndicator