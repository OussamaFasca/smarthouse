import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house/Firebase/real-time-database.dart';
import 'package:smart_house/creators/AlertCreator.dart';
import 'package:smart_house/creators/toastCreator.dart';
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

  //Colors
  Color KouleurLight = Colors.grey;
  Color KouleurServo = Colors.grey;
  Color KouleurFan = Colors.grey;

  bool visibility = false;

  //Real Values
  String RealValueLight = "";
  String RealValueTemp = "";
  String RealValueServo = "";
  String RealValueFan = "";

  //initil state
  @override
  void initState() {
    // TODO: implement initState
    NetworkingInit();
    final oneSec = const Duration(seconds: 2);
    Timer.periodic(oneSec, (Timer t) => NetworkingInitNoAnimation());

    super.initState();
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
                fonction: () => CreateAlertDialog(context),
              ),
            ],
          ),
        ),
        backgroundColor: KolorIOne,
        body: Builder(
            builder: (context) => Container(
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
                      fontSize: 40,
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
                          await NetworkingLight();
                          NetworkingInit();
                        },
                      ),
                      ComponentsCreator(
                        contenu: "Temperature",
                        valeur: RealValueTemp,
                        photo: "images/hot.png",
                        couleur: Colors.orangeAccent,
                        fonction: ()=> showToast(context),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ComponentsCreator(
                        contenu: "Fan",
                        valeur: RealValueFan,
                        photo: "images/fan.png",
                        couleur: KouleurFan,
                        fonction: () async {
                          setState(() {
                            visibility = true;
                          });
                          await NetworkingFan();
                          NetworkingInit();
                        },
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
                          await NetworkingDoor();
                          NetworkingInit();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  void testAuxoFan(bool auxo) {
    if (auxo) {
      setState(() {
        KouleurFan = Colors.lightBlueAccent;
      });
    } else {
      setState(() {
        KouleurFan = Colors.grey;
      });
    }
  }

  Future NetworkingDoor() async {
    bool auxo =
        await firebaseController.syncData("LivingRoom", "Servo", "180", "90");
    String auxi = await firebaseController.getData("LivingRoom", "Servo");
    if (auxi == "180") {
      auxi = "Closed";
    } else {
      auxi = "Opened";
    }
    setState(() {
      RealValueServo = auxi;
      testAuxoServo(auxo);
      visibility = false;
    });
  }

  Future NetworkingFan() async {
    bool auxo =
        await firebaseController.syncData("LivingRoom", "Fan", "Off", "On");
    String auxi = await firebaseController.getData("LivingRoom", "Fan");
    setState(() {
      RealValueFan = auxi;
      testAuxoFan(auxo);
      visibility = false;
    });
  }

  Future NetworkingLight() async {
    bool auxo = await firebaseController.syncData("LivingRoom", "Light", "Off", "On");
    String auxi = await firebaseController.getData("LivingRoom", "Light");
    setState(() {
      RealValueLight = auxi;
      testAuxoLight(auxo);
      visibility = false;
    });
  }

  void NetworkingInit() async {
    Color Kouleurservo = Colors.grey;

    setState(() {
      visibility = true;
    });
    String Light = await firebaseController.getData("LivingRoom", "Light");
    String Temp = await firebaseController.getData("General", "Temperature");
    String Servo = await firebaseController.getData("LivingRoom", "Servo");
    String Fan = await firebaseController.getData("LivingRoom", "Fan");
    if (Servo == "180") {
      Servo = "Closed";
    } else {
      Servo = "Opened";
      Kouleurservo = Colors.pinkAccent;
    }

    setState(() {
      testAuxoLight(convertToBool(Light, "On"));
      testAuxoServo(convertToBool(Servo, "90"));
      testAuxoFan(convertToBool(Fan, "On"));
      KouleurServo = Kouleurservo;
      RealValueServo = Servo;
      RealValueFan = Fan;
      RealValueLight = Light;
      RealValueTemp = Temp;
      visibility = false;
    });
  }

  bool convertToBool(String etat, String High)
  {
    if (etat == High)
    {
      return true;
    }
    else
      {
      return false;
      }
  }

  void NetworkingInitNoAnimation() async {
    Color Kouleurservo = Colors.grey;

    String Light = await firebaseController.getData("LivingRoom", "Light");
    String Temp = await firebaseController.getData("General", "Temperature");
    String Servo = await firebaseController.getData("LivingRoom", "Servo");
    String Fan = await firebaseController.getData("LivingRoom", "Fan");
    if (Servo == "180") {
      Servo = "Closed";
    } else {
      Servo = "Opened";
      Kouleurservo = Colors.pinkAccent;
    }

    setState(() {
      testAuxoLight(convertToBool(Light, "On"));
      testAuxoServo(convertToBool(Servo, "90"));
      testAuxoFan(convertToBool(Fan, "On"));
      KouleurServo = Kouleurservo;
      RealValueServo = Servo;
      RealValueFan = Fan;
      RealValueLight = Light;
      RealValueTemp = Temp;
      //visibility = false;
    });
  }

}
