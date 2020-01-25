import 'package:firebase_database/firebase_database.dart';


class Realtime {

  final DBref = FirebaseDatabase.instance.reference();


  Stream<String> ListnerData()
  {
     DBref.child("LivingRoom").onChildChanged.listen((Event event){
      DataSnapshot snapshot=event.snapshot;
      print("change false : ${snapshot.value}");
      return snapshot.value;
    });

  }



  void writeData(String room,String composant ,String valeur) async
  {
    await DBref.child(room).update({
      '$composant' : '$valeur'
    });
  }

  Future<String> getData(String room,String composant) async
  {
    String result= (await DBref.child("$room/$composant").once()).value;
    print(result);
    return result;
  }

  Future<bool> syncData(String room,String composant,String LowValue,String HighValue) async
  {
    String aux = await getData(room,composant);
    if(aux == LowValue) // tester if off
    {
      writeData(room, composant,HighValue); // passer On
      return true;
    }
    else
    {
      writeData(room, composant,LowValue); // passer off
      return false;
    }
  }

}