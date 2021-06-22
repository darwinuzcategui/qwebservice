import 'package:flutter/material.dart';

void showAlertQweb(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Informacion Incorrecta"),
          content: Text(message),
          actions: <Widget> [
            TextButton(
            child: Text("Ok"),
            onPressed: ()=>Navigator.of(context).pop(), 
            )
          ],
        );
      });
}
