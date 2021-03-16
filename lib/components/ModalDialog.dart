import 'package:flutter/material.dart';
import 'package:jogodavelha/constants/Colors.dart';
import 'package:jogodavelha/constants/Messages.dart';

class ModalDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  ModalDialog(this.title, this.content, this.callback, [this.actionText = AppMessages.ok]);
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text(title,
      style: TextStyle(
       color: Colors.black,
      )),
      content: new Text(content,
      style: TextStyle(
          color: Colors.black
      ),),
      backgroundColor: Colors.white,

      actions: <Widget>[
        new TextButton(
          onPressed: callback,
          child: new Text(actionText,
          style: TextStyle(
            color: AppColors.redSecondary
          )),
        )
      ],
    );
  }
}
