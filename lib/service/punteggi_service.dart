import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/bloc/home_bloc/home_bloc.dart';
import 'package:petsguide/model/cat_model.dart';
import 'package:petsguide/model/punteggio_model.dart';
import 'package:petsguide/repository/repository.dart';

import 'secure_service.dart';

class PunteggiService {

  Future<List<PunteggioModel>> getPunteggiByIdUser() async{
 
    List<PunteggioModel> listPunteggi = [];

    PunteggioModel punteggio = PunteggioModel();
      Cats cat = Cats();
      await FirebaseFirestore.instance
      .collection('punteggi')
      .where('idUser', isEqualTo: await getUserId())
      .get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async{
          punteggio = PunteggioModel(
            idPunteggio: doc.reference.id, 
            punteggio: doc['punteggio'], 
            idUser: doc['idUser'], 
            idCat: doc['idCat']
          );
          listPunteggi.add(punteggio);
      });
    });
    return listPunteggi;
  }

  getUserId() async{
    SecureService secureService = Injector().get<SecureService>();
    return await secureService.getUserId();
  }

  Future<List<Cats>>getCats(listPunteggi) async{
    List<Cats> allCats = [];
    List<Cats> listCatMyScore = [];
    Repository repository = Injector().get<Repository>();
    allCats = await repository.getAllCats();

    // final homeBloc = HomeBloc();
    // allCats = homeBloc.getListAllCats;
    listPunteggi.forEach((element) {
      for(int i=0; i<allCats.length; i++) {
        if(element.idCat == allCats[i].id) {
          Cats cat = Cats();
          cat = allCats[i];
          cat.punteggioUser = element.punteggio;
          listCatMyScore.add(cat);
        }
      }
    });
    return listCatMyScore;
  }
}