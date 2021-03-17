import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/screens/MenuNavigation.dart';
import 'package:jogodavelha/screens/SignUp.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../constants/Colors.dart';
import '../components/RedButton.dart';
import '../components/ModalDialog.dart';
import '../services/Api.dart';

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

  void initLoginFlux() async {
    try {
      if (validateInfos()) {
        await Api.loginWithEmailAndPassword(
            _controllerEmail.text, _controllerPassword.text);
        if (CurrentUser.user != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => MenuNavigation()));
        }
        else{
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/logo-small.png"),
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
            InkWell(
                onTap: () {
                  initLoginFlux();
                },
                child: RedButton(AppMessages.initLogin)),
            Container(
                alignment: Alignment.center,
                child: TextButton(
                  child: Text(
                    AppMessages.singUpMessage,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  onPressed: () => {initSignUpFlux()},
                ))
          ],
        ) /* add child content here */,
      ),
    );
  }
}
