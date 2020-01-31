import 'package:flutter/material.dart';

void showToast(BuildContext context,String Contenu,String buttonName) {

  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(
        Contenu,
      ),
      action: SnackBarAction(
        label: buttonName,
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ),
  );
}