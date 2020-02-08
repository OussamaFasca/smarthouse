import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:smart_house/design/desginConstants.dart';
import 'package:smart_house/main.dart';
import 'creators/AlertCreator.dart';
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
              Image(
                width: 50,
                color: Colors.white,
                image: AssetImage("images/Logo.png"),
              ),
              SimpleButtonCreator(
                icone: Icons.close,
                fonction: () => CreateAlertDialog(context),
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
              SizedBox(
                width: 250.0,
                child: ColorizeAnimatedTextKit(
                    text: ["Soya", "Smart House"],
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      fontFamily: "Horizon",
                      fontWeight: FontWeight.w300,
                    ),
                    colors: [
                      Colors.white,
                      Colors.purpleAccent,
                      Colors.deepPurple,
                      Colors.tealAccent,
                    ],
                    textAlign: TextAlign.center,
                    alignment:
                        AlignmentDirectional.topStart // or Alignment.topLeft
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
