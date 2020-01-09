import 'package:flutter/cupertino.dart';

const KolorIOne = Color(0xFF0F2027);
const KolorTwo = Color(0xFF203A43);
const KolorThree = Color(0xFF2C5364);

const MyGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.1, 0.5, 0.9],
  colors: [
    // Colors are easy thanks to Flutter's Colors class.
    //Color(0xFF411DC5),
    KolorIOne,
    KolorTwo,
    KolorThree,
  ],
);
