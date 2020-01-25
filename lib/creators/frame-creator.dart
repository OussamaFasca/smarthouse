import 'package:flutter/material.dart';

class FrameCreator extends StatelessWidget {
  final String photo;
  final String contenu;
  final Function fonction;

  FrameCreator({this.photo, this.contenu, this.fonction});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 0.5,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: fonction,
      child: Column(
        children: <Widget>[
          Image(
            width: 90,
            image: AssetImage("$photo"),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "$contenu",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
