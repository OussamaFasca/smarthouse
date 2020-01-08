import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house/desginConstants.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Container(
          color: Kblue,
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
                      fonction: () {},
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

class FrameCreator extends StatelessWidget {
  final String photo;
  final String contenu;
  final Function fonction;

  FrameCreator({this.photo, this.contenu, this.fonction});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 0.5,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      onPressed: fonction(),
      child: Column(
        children: <Widget>[
          Image(
            width: 100,
            image: AssetImage("$photo"),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "$contenu",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
