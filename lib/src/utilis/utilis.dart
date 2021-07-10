import 'package:flutter/material.dart';
//import 'dart:async';

bool isEmailQweb(String s) {
  if (s.isEmpty) return false;

  // Pattern pattern = r'^[a-z0-9_-]{3,15}$';
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  /*
    if (regExp.hasMatch(s)) {
      return true;
    } else {
      return false;
    }
    */
  return (regExp.hasMatch(s)) ? true : false;
}

void showAlertQweb(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Informacion Incorrecta"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
