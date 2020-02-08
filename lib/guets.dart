import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Firebase/real-time-database.dart';
import 'creators/AlertCreator.dart';
import 'creators/components-creator.dart';
import 'creators/simple-button-creator.dart';
import 'creators/toastCreator.dart';
import 'design/desginConstants.dart';
import 'design/loading-screen.dart';



class Guest extends StatefulWidget {
  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> {

  //mes objets
  final firebaseController = Realtime();
  LoadingScreen loadingscreen = LoadingScreen();

  //Colors
  Color KouleurLight = Colors.grey;


  bool visibility = false;

  //Real Values
  String RealValueLight = "";
  String RealValueTemp = "";

  //initil state
  @override
  void initState() {
    // TODO: implement initState
    NetworkingInit();
    final oneSec = const Duration(milliseconds: 500);
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
                    image: AssetImage("images/meetingroom.png"),
                  ),
                  Text(
                    "Guests Room",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "2 devices",
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
                        fonction: ()=> showToast(context,"What do you expect me to do ?","Sorry"),

                      )
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

  Future NetworkingLight() async {
    bool auxo = await firebaseController.syncData("GuestsRoom", "Light", "Off", "On");
    String auxi = await firebaseController.getData("GuestsRoom", "Light");
    setState(() {
      RealValueLight = auxi;
      testAuxoLight(auxo);
      visibility = false;
    });
  }

  void NetworkingInit() async {

    setState(() {
      visibility = true;
    });
    String Light = await firebaseController.getData("GuestsRoom", "Light");
    String Temp = await firebaseController.getData("General", "Temperature");

    setState(() {
      testAuxoLight(convertToBool(Light, "On"));
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

    String Light = await firebaseController.getData("GuestsRoom", "Light");
    String Temp = await firebaseController.getData("General", "Temperature");

    setState(() {
      testAuxoLight(convertToBool(Light, "On"));
      RealValueLight = Light;
      RealValueTemp = Temp;
    });
  }
}

