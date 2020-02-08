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


class Garden extends StatefulWidget {
  @override
  _GardenState createState() => _GardenState();
}

class _GardenState extends State<Garden> {

  //mes objets
  final firebaseController = Realtime();
  LoadingScreen loadingscreen = LoadingScreen();



  bool visibility = false;

  //Real Values

  String RealValueTemp = "";
  String RealValueHumidity = "";

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
                    image: AssetImage("images/growth.png"),
                  ),
                  Text(
                    "Garden",
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
                        contenu: "Temperature",
                        valeur: RealValueTemp,
                        photo: "images/hot.png",
                        couleur: Colors.orangeAccent,
                        fonction: ()=> showToast(context,"What do you expect me to do ?","Sorry"),
                      ),
                      ComponentsCreator(
                        contenu: "Humidity",
                        valeur: RealValueHumidity,
                        photo: "images/humidity.png",
                        couleur: Colors.lightBlueAccent,
                        fonction: ()=> showToast(context,"What do you expect me to do ?","Sorry"),
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


  void NetworkingInit() async {

    setState(() {
      visibility = true;
    });

    String Temp = await firebaseController.getData("General", "Temperature");
    String Humidity = await firebaseController.getData("Garden", "Humidity");

    setState(() {


      RealValueTemp = Temp;
      RealValueHumidity = Humidity;
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


    String Temp = await firebaseController.getData("General", "Temperature");
    String Humidity = await firebaseController.getData("Garden", "Humidity");

    setState(() {
      RealValueTemp = Temp;
      RealValueHumidity = Humidity;
    });
  }

}


