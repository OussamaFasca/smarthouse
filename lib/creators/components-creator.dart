import 'package:flutter/material.dart';

import '../desginConstants.dart';

class ComponentsCreator extends StatelessWidget {

  final IconData icone;
  final String contenu;
  ComponentsCreator({this.icone,this.contenu});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: FlatButton(
        color: KolorIOne,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {},
        child: Container(
          height: 140,
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icone,
                color: Colors.white,
                size: 50,
              ),
              Text(
                contenu,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
