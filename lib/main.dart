import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house/kidsroom.dart';

import 'package:smart_house/kitchen.dart';
import 'package:smart_house/livingRoom.dart';
import 'package:smart_house/welcome-screen.dart';

import 'bedroom.dart';
import 'garden.dart';
import 'guets.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatelessWidget {
  static List<String> id = [
    "welcome-screen",
    "livingRoom",
    "kitchen",
    "garden",
    "bedroom",
    "kidsroom",
    "guests"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: id[0],
      routes: {
        id[0]: (context) => WelcomeScreen(),
        id[1]: (context) => LivingRoom(),
        id[2]: (context) => Kitchen(),
        id[3]: (context) => Garden(),
        id[4]: (context) => Bedroom(),
        id[5]: (context) => Kidsroom(),
        id[6]: (context) => Guest(),
      },
    );
  }
}
