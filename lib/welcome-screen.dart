import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:smart_house/design/desginConstants.dart';
import 'package:smart_house/main.dart';
import 'creators/frame-creator.dart';
import 'creators/simple-button-creator.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: KolorIOne,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SimpleButtonCreator(
                icone: Icons.arrow_back,
                fonction: () => Navigator.pop(context),
              ),
              SimpleButtonCreator(
                icone: Icons.close,
                fonction: () => exit(0),
              ),
            ],
          ),
        ),
        backgroundColor: KolorIOne,
        body: Container(
          decoration: BoxDecoration(
            gradient: MyGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 250.0,
                child: ColorizeAnimatedTextKit(
                    onTap: () {
                      print("Tap Event");
                    },
                    text: [
                      "Welcome To",
                      "Faskoub"
                    ],
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontFamily: "Horizon",
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200,
                    ),
                    colors: [
                      Colors.white,
                      Colors.purpleAccent,
                      Colors.deepPurple,
                      Colors.tealAccent,
                    ],
                    textAlign: TextAlign.center,
                    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FrameCreator(
                      photo: "images/sofa.png",
                      contenu: "living room",
                      fonction: () {
                        Navigator.pushNamed(context, MainScreen.id[1]);
                      },
                    ),
                    FrameCreator(
                      photo: "images/kitchen.png",
                      contenu: "Kitchen",
                      fonction: () {
                        Navigator.pushNamed(context, MainScreen.id[2]);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FrameCreator(
                      photo: "images/growth.png",
                      contenu: "Garden",
                      fonction: () {
                        Navigator.pushNamed(context, MainScreen.id[3]);
                      },
                    ),
                    FrameCreator(
                      photo: "images/bed.png",
                      contenu: "Bedroom",
                      fonction: () {
                        Navigator.pushNamed(context, MainScreen.id[4]);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FrameCreator(
                      photo: "images/bear.png",
                      contenu: "Kids room",
                      fonction: () {
                        Navigator.pushNamed(context, MainScreen.id[5]);
                      },
                    ),
                    FrameCreator(
                      photo: "images/meetingroom.png",
                      contenu: "Guests room",
                      fonction: () {
                        Navigator.pushNamed(context, MainScreen.id[6]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


