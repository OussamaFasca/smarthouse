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



  //buzzer Control
  bool bizo = true;
  bool biza = true;

  //mes objets
  final firebaseController = Realtime();
  LoadingScreen loadingscreen = LoadingScreen();


  //Colors

  Color KouleurBuzzer= Colors.grey;
  Color KouleurGas= Colors.grey;


  bool visibility = false;
  bool listner = false;

  //Real Values

  String RealValueTemp ="";
  String RealValueBuzzer="";
  String RealValueGas="";



  //initil state
  @override
  void initState(){

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
                    "3 devices",
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
                        fonction: ()=>showToast(context,"What do you expect me to do ?","Sorry"),
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
                        fonction: (){
                          showToast(context,"What do you expect me to do ?","Sorry");
                        },
                      ),
                      ComponentsCreator(
                        contenu: "Buzzer",
                        valeur: RealValueBuzzer,
                        photo: "images/bell.png",
                        couleur: KouleurBuzzer,
                        fonction: () async {
                          if(bizo)
                          {
                            showToast(context,"You can't activate me","Okay");
                          }
                          else
                            {
                              setState(() {
                                visibility = true;
                              });
                              await NetworkingBuzzer();
                              NetworkingInit();
                            }
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

  Future NetworkingBuzzer() async
  {
    String auxi = await firebaseController.getData("Kitchen","Buzzer");
    if(auxi == "On")
      {
        bool auxo = await firebaseController.syncData("Kitchen","Buzzer","Off","On");
        setState(() {
          RealValueBuzzer = auxi;
          testAuxoBuzzer(auxo);
          visibility = false;
        });
      }
    else
      {
        bizo = true;
      }
  }

  Future NetworkingGas() async {
    bool auxo;
    String auxi = await firebaseController.getData("Kitchen","Gas");
    if(auxi == "No")
    {
      auxi="No gas";
      auxo = true;
    }
    else
    {
      auxi="Gas !";
      auxo = false;
    }
    setState(() {
      RealValueGas = auxi;
      testAuxoGas(auxo);
      visibility = false;
    });
  }


  void NetworkingInit() async {

    Color Kouleurgas = Colors.grey;

    setState(() {
      visibility = true;
    });

    String Temp = await firebaseController.getData("General","Temperature");
    String Gas  = await firebaseController.getData("Kitchen","Gas");
    String Buzzer = await firebaseController.getData("Kitchen","Buzzer");
    if(Gas == "No") {Gas="No gas";} else {Gas="Gas !"; Kouleurgas= Colors.lightBlueAccent;}
    if(Buzzer == "On")
      {
        bizo = false;
      }
    else
      {
        bizo = true;
      }


    setState(() {

      testAuxoBuzzer(convertToBool(Buzzer, "On"));
      testAuxoGas(convertToBool(Gas, "Yes"));
      KouleurGas = Kouleurgas ;
      RealValueBuzzer = Buzzer;
      RealValueGas = Gas;

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

  void NetworkingInitNoAnimation() async {

    Color Kouleurgas = Colors.grey;


    String Temp = await firebaseController.getData("General","Temperature");
    String Gas  = await firebaseController.getData("Kitchen","Gas");
    String Buzzer = await firebaseController.getData("Kitchen","Buzzer");
    if(Gas == "No")
    {
      Gas="No gas";
      firebaseController.writeData("Kitchen", "Buzzer", "Off");
    }
    else
      {
        Gas="Gas !";
        Kouleurgas= Colors.lightBlueAccent;
        firebaseController.writeData("Kitchen", "Buzzer", "On");

      }
    if(Buzzer == "On")
    {
      bizo = false;
    }
    else
    {
      bizo = true;
    }


    setState(() {

      testAuxoBuzzer(convertToBool(Buzzer, "On"));
      testAuxoGas(convertToBool(Gas, "Yes"));
      KouleurGas = Kouleurgas ;
      RealValueBuzzer = Buzzer;
      RealValueGas = Gas;
      RealValueTemp = Temp;
    });
  }


}

