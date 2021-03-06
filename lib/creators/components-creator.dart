import 'package:flutter/material.dart';

import '../design/desginConstants.dart';

class ComponentsCreator extends StatelessWidget {

  final String contenu;
  final String valeur;
  final String photo;
  final Function fonction;
  final Color couleur;
  ComponentsCreator({this.contenu,this.valeur,this.photo,this.fonction,this.couleur});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FlatButton(
        color: KolorIOne,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: fonction,
        child: Container(
          height: 140,
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                contenu,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w200
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image(
                  width: 50,
                  image: AssetImage("$photo"),
                  color: couleur,
                ),
              ),
              Text(
                valeur,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
