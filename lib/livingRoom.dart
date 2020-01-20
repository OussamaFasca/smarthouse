import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house/Firebase/real-time-database.dart';
import 'package:smart_house/design/loading-screen.dart';
import 'creators/components-creator.dart';
import 'creators/simple-button-creator.dart';
import 'design/desginConstants.dart';

class LivingRoom extends StatefulWidget {
  @override
  _LivingRoomState createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {

  //mes objets
  final firebaseController = Realtime();
  LoadingScreen loadingscreen = LoadingScreen();

  //mes variables
  Color KouleurLight= Colors.grey;
  Color KouleurServo= Colors.grey;
  bool visibility = false;
  String RealValueLight = "";
  String RealValueTemp ="";
  String RealValueServo="";

  //mes fonctions
  void testAuxoLight(bool auxo) {
    if (auxo) {
      setState(() {
        KouleurLight = Colors.amberAccent;
      });
    } else {
      setState(() {
        KouleurLight = Colors.grey;
      });
    }
  }
  void testAuxoServo(bool auxo) {
    if (auxo) {
      setState(() {
        KouleurServo = Colors.pinkAccent;
      });
    } else {
      setState(() {
        KouleurServo = Colors.grey;
      });
    }
  }

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage("images/sofa.png"),
                ),
                Text(
                  "Livingroom",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "4 devices",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: Visibility(
                    child: loadingscreen.spinkitActive,
                    visible: visibility,
                  ),
                  height: 60,
                  width: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ComponentsCreator(
                      contenu: "Light",
                      valeur: RealValueLight,
                      photo: "images/idea.png",
                      couleur: KouleurLight,
                      fonction: () async {
                        setState(() {
                          visibility = true;
                        });
                        bool auxo = await firebaseController.syncData("Light","Off","On");
                        String auxi = await firebaseController.getData("Light");
                        setState(() {
                          RealValueLight = auxi;
                          testAuxoLight(auxo);
                          visibility = false;
                        });
                      },
                    ),
                    ComponentsCreator(
                      contenu: "Temperature",
                      valeur: RealValueTemp,
                      photo: "images/hot.png",
                      couleur: Colors.orangeAccent,
                      fonction: () async {
                        setState(() {
                          visibility = true;
                        });
                        String auxi = await firebaseController.getData("Temperature");
                        setState(() {
                          RealValueTemp = auxi;
                          visibility = false;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ComponentsCreator(
                      contenu: "Fan",
                      valeur: "Running",
                      photo: "images/fan.png",
                    ),
                    ComponentsCreator(
                      contenu: "Door",
                      valeur: RealValueServo,
                      photo: "images/door.png",
                      couleur: KouleurServo,
                      fonction: () async {
                        setState(() {
                          visibility = true;
                        });
                        bool auxo = await firebaseController.syncData("Servo","180","90");
                        String auxi = await firebaseController.getData("Servo");
                        if(auxi == "180")
                          {
                            auxi="Closed";
                          }
                        else
                          {
                            auxi="Opened";
                          }
                        setState(() {
                          RealValueServo = auxi;
                          testAuxoServo(auxo);
                          visibility = false;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
