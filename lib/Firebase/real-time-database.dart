import 'package:firebase_database/firebase_database.dart';

class Realtime {

  final DBref = FirebaseDatabase.instance.reference();

  void writeData(String composant, String valeur) async
  {
    await DBref.child(composant).set({
      'etat_$composant' : '$valeur'
    });
  }

  Future<String> getData(String composant) async
  {
    String result= (await DBref.child("$composant/etat_$composant").once()).value;
    print(result);
    return result;
  }

  Future<bool> syncData(String composant,String LowValue,String HighValue) async
  {
    String aux = await getData(composant);
    if(aux == LowValue) // tester if off
    {
      writeData(composant, HighValue); // passer On
      return true;
    }
    else
    {
      writeData(composant, LowValue); // passer off
      return false;
    }
  }


}