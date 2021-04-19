import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Messages.dart';
import 'package:jogodavelha/screens/MenuNavigation.dart';
import 'package:jogodavelha/screens/SignUp.dart';
import 'package:jogodavelha/storage/CurrentUser.dart';
import '../constants/Colors.dart';
import '../components/RedButton.dart';
import '../components/ModalDialog.dart';
import '../services/Api.dart';
import '../components/Loading.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  bool _isLoading = false;
  bool _errorMenssagesIsVisible = false;
  TextEditingController _controllerEmail = TextEditingController();

  bool validateInfos(){
    return _controllerEmail.text.isNotEmpty && _controllerEmail.text.contains("@");
  }

  void sendResetPasswordEmail() async {
    try{
      setState(() {
        _isLoading = true;
        _errorMenssagesIsVisible = false;
      });
      if(validateInfos()){
        await Api.resetPassword(_controllerEmail.text);
        showDialog(
            context: context,
            builder: (_) => new ModalDialog(AppMessages.emailSendTitle, AppMessages.emailSendMsg,
                    () => {if (Navigator.canPop(context)) Navigator.pop(context)}));
      }else{
        setState(() {
          _errorMenssagesIsVisible = true;
        });
      }
    }catch(e){
      print(e);
      showDialog(
          context: context,
          builder: (_) => new ModalDialog(AppMessages.error, e.toString(),
                  () => {if (Navigator.canPop(context)) Navigator.pop(context)}));
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: size.width * 0.1, right: size.width * 0.1),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Row( //Como não estamos trabalhando com AppBar, dividi a tela e 3 partes para conseguir esse efeito de arrow back
              children: <Widget>[
                Container(
                  child: IconButton(
                      icon: new Icon(Icons.arrow_back, color: Colors.white,),
                      onPressed: () {Navigator.of(context).pop(true);} //Remove a tela da pilha de execução
                  ),
                  width: size.width * 0.1,
                ),
                Container(
                  width: size.width * 0.6,
                  alignment: Alignment.center,
                  child: Text(
                    AppMessages.resetPasswordTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "Roboto", // TODO: Checar pq não está alterando
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.1,
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                top: size.height * 0.08,
                bottom: size.height * 0.03,
              ),
              child: Text(
                AppMessages.resetPasswordDesc,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
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
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                    labelText: AppMessages.emailPlaceholder,
                    labelStyle: TextStyle(
                      color: AppColors.whiteLowOpcacity,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )),
                style: TextStyle(
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
                  style: TextStyle(color: AppColors.redPrimary, fontSize: 13),
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            RedButton(AppMessages.emailSendBtn, () {sendResetPasswordEmail();}),
            Expanded(child: Container()),
            Visibility(
              visible: _isLoading,
                child: Container(
                  child: CircularProgressIndicator(),
            )),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
