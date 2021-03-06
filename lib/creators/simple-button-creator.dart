import 'package:flutter/material.dart';
import 'package:smart_house/design/desginConstants.dart';

class SimpleButtonCreator extends StatelessWidget {

  final IconData icone;
  final Function fonction;

  SimpleButtonCreator({this.icone,this.fonction});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      color: KolorTwo,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: fonction,
      child: Icon(
        icone,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
