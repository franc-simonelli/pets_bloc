import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/model/cat_model.dart';
import 'package:petsguide/model/punteggio_model.dart';
import 'package:petsguide/service/details_service.dart';

class FirebaseQueryService {

  getCats() async {
    List<Cats> catsList = [];
    await FirebaseFirestore.instance
        .collection('cats')
        .get().then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) { 
            Cats cat = Cats(
              id: doc.reference.id,
              razza: doc['razza'],
              descrizione: doc['descrizione'],
              image: doc['image'],
              imageCarousel: doc['imageCarousel'],
              origine: doc['origine'],
              paese: doc['paese'],
              mantello: doc['mantello'],
              taglia: doc['taglia'],
              vita: doc['vita'],
              carattere: doc['carattere'],
              aspettiPrincipali:  doc['aspettiPrincipali'],
              imageVertical: doc['imageVertical'],
              salute:  doc['salute'],
              allevamento: doc['allevamento'],
              alimentazione: doc['alimentazione'],
            );
            catsList.add(cat);
          });
        });
        return catsList;
  }

  getAllPunteggiCat(idCatSelect) async {
    List<double> listaPunteggi = [];
    await FirebaseFirestore.instance
      .collection('punteggi')
      .where('idCat', isEqualTo: idCatSelect)
      .get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          listaPunteggi.add(doc['punteggio']);
        });
      });
    return listaPunteggi;
  }
  
  getPunteggioByIdUserAndCatId(idCat) async{
    PunteggioModel punteggio = PunteggioModel();
    DetailsService detailsService = Injector().get<DetailsService>();
    await FirebaseFirestore.instance
      .collection('punteggi')
      .where('idUser', isEqualTo: await detailsService.getUserId())
      .where('idCat', isEqualTo: idCat)
      .get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          punteggio = PunteggioModel(
            idPunteggio: doc.reference.id, 
            punteggio: doc['punteggio'], 
            idUser: doc['idUser'], 
            idCat: doc['idCat']);
        });
      });
      return punteggio;  
  }
  
  updatePunteggio(punteggio, newRating) async{
    await FirebaseFirestore.instance
    .collection('punteggi')
    .doc(punteggio.idPunteggio)
    .update({
      "punteggio": newRating
    });
    // .then((value) async {
      // getPunteggioMedio(catSelected.value!.id);
      // setPunteggioInListCatPunteggi(punteggio.idCat, ratingSelected);
    // });
  }

  addPunteggio(idCat, newRating) async {
    DetailsService detailsService = Injector().get<DetailsService>();
    CollectionReference dbPunteggi = FirebaseFirestore.instance.collection('punteggi');
    await dbPunteggi.add(
      {
        "idUser": await detailsService.getUserId(),
        "punteggio": newRating,
        "idCat": idCat
      }
    );
  }
  
  getCatByIdInList(idCat, list) async {
    var cat;
    list.forEach((element) { 
      if(idCat == element.id) {
        cat = element;
      }
    });
    return cat;
  }

  mapCatPreferitiByAll(listIdPreferiti, listAll) {
    List<Cats> listaPreferiti = [];
    listIdPreferiti.forEach((element) {
      listAll.forEach((elementListAll) {
        if(elementListAll.id == element) {
          listaPreferiti.add(elementListAll);
        }
      });
    });

    return listaPreferiti;
  }
}