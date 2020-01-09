import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house/livingRoom.dart';
import 'package:smart_house/welcome-screen.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatelessWidget {

  static List<String> id = [
    "welcome-screen","livingRoom"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: id[0],
      routes: {
        id[0] : (context) => WelcomeScreen(),
        id[1] : (context) => LivingRoom(),
      },
    );
  }
}



