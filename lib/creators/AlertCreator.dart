import 'dart:io';
import 'package:flutter/material.dart';

CreateAlertDialog(BuildContext context)
{
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("You are about to exit the app, are you sure ?"),
        actions: <Widget>[
          MaterialButton(
            onPressed: () => exit(0),
            child: Text(
              "Yes",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                )),
          ),
        ],
      );
    },
  );
}