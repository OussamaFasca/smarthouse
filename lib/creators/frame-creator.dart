import 'package:flutter/material.dart';

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
      onPressed: fonction,
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
