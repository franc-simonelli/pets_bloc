import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/model/caratteristiche_model.dart';
import 'package:petsguide/model/punteggio_model.dart';
import 'package:petsguide/service/firebase_query_service.dart';
import 'package:petsguide/service/secure_service.dart';

class DetailsService {
  List<CaratteristicheModel> caratteristiche = [];

  getCaratteristiche(cat) {
    List<String> listCaratteristiche = cat.aspettiPrincipali!.split(",");
      listCaratteristiche.forEach((element) {
        CaratteristicheModel carat = CaratteristicheModel(  
          punteggio: getPunteggioCaratteristica(element),
          descrizione: getDescrizione(element, 1)
        ); 
        caratteristiche.add(carat);
      });
    return caratteristiche;
  }

  getPunteggioCaratteristica(element) {
    return traformToInt(element, 0);
  }

  getDescrizione(String element, int index) {
    return getSubstring(element, index);
  }

  traformToInt(element, index) {
    return int.parse(element[index]);
  }

  getSubstring(string, index) {
    return string.substring(index);
  }

  getPunteggioMedio(idCatSelect) async{
    List<double> listaPunteggi = [];
    double punteggioMedio = 0.0;
    FirebaseQueryService firebaseQueryService = Injector().get<FirebaseQueryService>();
    listaPunteggi = await firebaseQueryService.getAllPunteggiCat(idCatSelect);
    
    if(listaPunteggi.isNotEmpty) {
      listaPunteggi.forEach((element) { 
        punteggioMedio += element;
      });
      punteggioMedio = punteggioMedio / listaPunteggi.length;
      punteggioMedio = double.parse(punteggioMedio.toStringAsFixed(1));
    }
    else {
      punteggioMedio = 0;
    }
    return punteggioMedio;
  }

  getUserId() async{
    SecureService secureService = Injector().get<SecureService>();
    return await secureService.getUserId();
  }
}