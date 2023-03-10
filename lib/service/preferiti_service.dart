import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/model/preferiti_model.dart';
import 'package:petsguide/service/secure_service.dart';

class PreferitiService {

  Future<PreferitiModel> checkIsPreferito(idCat) async{
 
    bool isCheck = false;
    PreferitiModel preferito = PreferitiModel();
    await FirebaseFirestore.instance
      .collection('preferiti')
      .where('idUser', isEqualTo: await getUserId())
      .where('idCat', isEqualTo: idCat)
      .get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async{
          preferito = PreferitiModel(
            id: doc.reference.id,
            idUser: doc['idUser'], 
            idCat: doc['idCat']
          );
      });
    });
    // if(preferito.idCat != '' && preferito.idUser != '') {
    //   isCheck = true;
    // } else {
    //   isCheck = false;
    // }
    return preferito;
  }

  addPunteggio(idCat) async {
    CollectionReference dbPreferiti = FirebaseFirestore.instance.collection('preferiti');
    await dbPreferiti.add(
      {
        "idUser": await getUserId(),
        "idCat": idCat
      }
    );
  }



  getUserId() async{
    SecureService secureService = Injector().get<SecureService>();
    return await secureService.getUserId();
  }
}