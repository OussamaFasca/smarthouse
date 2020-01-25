import 'package:flutter/material.dart';

void showToast(BuildContext context) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(
        "What do you expect me to do ?",
      ),
      action: SnackBarAction(
        label: "Sorry",
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ),
  );
}