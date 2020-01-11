import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'creators/components-creator.dart';
import 'creators/simple-button-creator.dart';
import 'design/desginConstants.dart';

class Kidsroom extends StatelessWidget {
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
                  image: AssetImage("images/bear.png"),
                ),
                Text(
                  "Kids room",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "2 device",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ComponentsCreator(contenu: "Light",valeur: "OFF",photo: "images/idea.png",),
                    ComponentsCreator(contenu: "Temperature",valeur: "25",photo: "images/hot.png",),
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

