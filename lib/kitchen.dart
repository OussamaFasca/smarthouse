import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house/creators/AlertCreator.dart';
import 'package:smart_house/creators/toastCreator.dart';
import 'Firebase/real-time-database.dart';
import 'creators/components-creator.dart';
import 'creators/simple-button-creator.dart';
import 'design/desginConstants.dart';
import 'design/loading-screen.dart';


class Kitchen extends StatefulWidget {
  @override
  _KitchenState createState() => _KitchenState();
}


class _KitchenState extends State<Kitchen>  {

  //mes objets
  final firebaseController = Realtime();
  LoadingScreen loadingscreen = LoadingScreen();


  //Colors
  Color KouleurLight= Colors.grey;
  Color KouleurBuzzer= Colors.grey;
  Color KouleurGas= Colors.grey;


  bool visibility = false;
  bool listner = false;

  //Real Values
  String RealValueLight = "";
  String RealValueTemp ="";
  String RealValueBuzzer="";
  String RealValueGas="";



  //initil state
  @override
  void initState(){
    // TODO: implement initState
    NetworkingInit();

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
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("images/kitchen.png"),
                  ),
                  Text(
                    "Kitchen",
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
                        },
                      ),
                      ComponentsCreator(
                        contenu: "Temperature",
                        valeur: RealValueTemp,
                        photo: "images/hot.png",
                        couleur: Colors.orangeAccent,
                        fonction: ()=>showToast(context),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ComponentsCreator(
                        contenu: "Gas",
                        valeur: RealValueGas,
                        photo: "images/fire.png",
                        couleur: KouleurGas,
                        fonction: () async
                        {
                          setState(() {
                            visibility = true;
                          });
                          await NetworkingGas();
                        },
                      ),
                      ComponentsCreator(
                        contenu: "Buzzer",
                        valeur: RealValueBuzzer,
                        photo: "images/bell.png",
                        couleur: KouleurBuzzer,
                        fonction: () async {
                          setState(() {
                            visibility = true;
                          });
                          await NetworkingBuzzer();
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
  void testAuxoBuzzer(bool auxo) {
    if (auxo) {
      setState(() {
        KouleurBuzzer = Colors.pinkAccent;
      });
    } else {
      setState(() {
        KouleurBuzzer = Colors.grey;
      });
    }
  }
  void testAuxoGas(bool auxo) {
    if (auxo) {
      setState(() {
        KouleurGas = Colors.lightBlueAccent;
      });
    } else {
      setState(() {
        KouleurGas = Colors.grey;
      });
    }
  }

  Future NetworkingBuzzer() async {
    bool auxo = await firebaseController.syncData("Kitchen","Buzzer","Off","On");
    String auxi = await firebaseController.getData("Kitchen","Buzzer");
    setState(() {
      RealValueBuzzer = auxi;
      testAuxoBuzzer(auxo);
      visibility = false;
    });
  }

  Future NetworkingGas() async {
    bool auxo = await firebaseController.syncData("Kitchen","Gas","No","Yes");
    String auxi = await firebaseController.getData("Kitchen","Gas");
    if(auxi == "No")
    {
      auxi="No gas";
    }
    else
    {
      auxi="Gas !";
    }
    setState(() {
      RealValueGas = auxi;
      testAuxoGas(auxo);
      visibility = false;
    });
  }

  Future NetworkingTemp() async {
    String auxi = await firebaseController.getData("Kitchen","Temperature");
    setState(() {
      RealValueTemp = auxi;
      visibility = false;
    });
  }

  Future NetworkingLight() async {
    bool auxo = await firebaseController.syncData("Kitchen","Light","Off","On");
    String auxi = await firebaseController.getData("Kitchen","Light");
    setState(() {
      RealValueLight = auxi;
      testAuxoLight(auxo);
      visibility = false;
    });
  }

  void NetworkingInit() async {

    Color Kouleurgas = Colors.grey;

    setState(() {
      visibility = true;
    });
    String Light = await firebaseController.getData("Kitchen","Light");
    String Temp = await firebaseController.getData("Kitchen","Temperature");
    String Gas  = await firebaseController.getData("Kitchen","Gas");
    String Buzzer = await firebaseController.getData("Kitchen","Buzzer");
    if(Gas == "No") {Gas="No gas";} else {Gas="Gas !"; Kouleurgas= Colors.lightBlueAccent;}


    setState(() {
      testAuxoLight(convertToBool(Light, "On"));
      testAuxoBuzzer(convertToBool(Buzzer, "On"));
      testAuxoGas(convertToBool(Gas, "Yes"));
      KouleurGas = Kouleurgas ;
      RealValueBuzzer = Buzzer;
      RealValueGas = Gas;
      RealValueLight = Light;
      RealValueTemp = Temp;
      visibility = false;
    });
  }

  bool convertToBool(String etat,String High) {
    if(etat==High)
    {
      return true;
    }
    else
    {
      return false;
    }
  }


}

