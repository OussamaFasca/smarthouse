import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_house/desginConstants.dart';
import 'package:smart_house/main.dart';
import 'creators/frame-creator.dart';
import 'creators/simple-button-creator.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    Key key,
  }) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                      fonction: () {},
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
                      fonction: () {},
                    ),
                    FrameCreator(
                      photo: "images/bed.png",
                      contenu: "Bedroom",
                      fonction: () {},
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
                      photo: "images/toilet.png",
                      contenu: "Bathroom",
                      fonction: () {},
                    ),
                    FrameCreator(
                      photo: "images/meetingroom.png",
                      contenu: "Guest Room",
                      fonction: () {},
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
