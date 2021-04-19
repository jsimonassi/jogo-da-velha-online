import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/screens/MenuNavigation.dart';
import 'package:jogodavelha/screens/ResetPassword.dart';
import 'package:jogodavelha/screens/SignUp.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../constants/Colors.dart';
import '../components/RedButton.dart';
import '../components/ModalDialog.dart';
import '../services/Api.dart';
import '../components/Loading.dart';

///Tela de Login e ponto de entrada da aplicação
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  bool _errorMenssagesIsVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _errorMenssagesIsVisible = false;
    });
    super.initState();
  }

  bool validateInfos() {
    return _controllerEmail.text.isNotEmpty &&
        _controllerPassword.text.isNotEmpty;
  }

  void initLoginFlux(BuildContext context) async {
    Loading.enableLoading(context);
    try {
      if (validateInfos()) {
        await Api.loginWithEmailAndPassword(
            _controllerEmail.text, _controllerPassword.text);
        if (CurrentUser.user != null) {
          Loading.disableLoading(context);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) => MenuNavigation()), (Route<dynamic> route) => false);
        }
        else{
          Loading.disableLoading(context);
          showDialog(
              context: context,
              builder: (_) => new ModalDialog(AppMessages.error, AppMessages.undefinedUser,
                      () => {if (Navigator.canPop(context)) Navigator.pop(context)}));
        }
      } else {
        setState(() {
          _errorMenssagesIsVisible = true;
        });
      }
    } catch (e) {
      Loading.disableLoading(context);
      showDialog(
          context: context,
          builder: (_) => new ModalDialog(AppMessages.error, e.message,
              () => {if (Navigator.canPop(context)) Navigator.pop(context)}));
    } finally {}
  }

  void initSignUpFlux() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => SignUpPage()));
  }

  void initResetPasswordFlux(){
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => ResetPassword()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/images/logo-small.png"),
            ),
            SizedBox(
              //Apenas para colocar um espaço entre a imagem e o input
              height: 80,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteLowOpcacity,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
                    )),
                style: TextStyle(
                  //Texto escrito pelo usário
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
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
                    contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                    labelText: AppMessages.passwordPlaceholder,
                    labelStyle: TextStyle(
                      color: AppColors.whiteLowOpcacity,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )),
                style: TextStyle(
                  //Texto escrito pelo usário
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
              height: 40,
            ),
            RedButton(AppMessages.initLogin, () => {initLoginFlux(context)}),
            Container(
                alignment: Alignment.center,
                child: TextButton(
                  child: Text(
                    AppMessages.resetPassword,
                    style: TextStyle(
                        color: Colors.white),
                  ),
                  onPressed: () {initResetPasswordFlux();},
                )),
            Container(
              height: 1,
              color: AppColors.whiteLowOpcacity,
            ),
            Container(
                alignment: Alignment.center,
                child: TextButton(
                  child: Text(
                    AppMessages.singUpMessage,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => {initSignUpFlux()},
                ))
          ],
        ) /* add child content here */,
      ),
    );
  }
}
