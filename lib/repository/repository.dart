// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:math';

import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petsguide/constants/cats_list.dart';
import 'package:petsguide/model/caratteristiche_model.dart';
import 'package:petsguide/model/cat_model.dart';
import 'package:petsguide/model/tab_model.dart';
import 'package:petsguide/service/firebase_query_service.dart';

class Repository {
  List<Cats> allCats = [];
  List<Cats> catsPeloCorto = [];
  List<Cats> catsPeloMedio = [];
  List<Cats> catsPeloLungo = [];
  List<Cats> catsCarousel = [];
  Cats catDetails = Cats();
  List<CaratteristicheModel> caratteristiche = [];

  final List<TabModel> tab = [
    TabModel(id: '1', icon: FontAwesomeIcons.house, text: 'Origine'),
    TabModel(id: '2', icon: FontAwesomeIcons.book, text: 'Descrizione'),
    TabModel(id: '3', icon: FontAwesomeIcons.temperatureFull, text: 'Carattere'),
    TabModel(id: '4', icon: FontAwesomeIcons.heart, text: 'Salute'),
    TabModel(id: '5', icon: FontAwesomeIcons.utensils, text: 'Alimentazione'),
    TabModel(id: '6', icon: FontAwesomeIcons.tractor, text: 'Allevamento'),
    TabModel(id: '7', icon: FontAwesomeIcons.circleExclamation, text: 'Aspetti'),
  ];

  getTab() {
    return tab;
  }

  getAllCats() async {
    if(allCats.isEmpty) {
      FirebaseQueryService firebaseQueryService = Injector().get<FirebaseQueryService>();
      allCats = await firebaseQueryService.getCats();
      allCats.sort(((a, b) => a.razza!.compareTo(b.razza!)));
    }
    return allCats;
  }

  getCatsPeloCorto() async{
    catsPeloCorto = [];
    catsPeloCorto = await changeFilterCats(0);
    return catsPeloCorto;
  }

  getCatsPeloMedio() async{
    catsPeloMedio = [];
    catsPeloMedio = await changeFilterCats(1);
    return catsPeloMedio;
  }

  getCatsPeloLungo() async{
    catsPeloLungo = [];
    catsPeloLungo = await changeFilterCats(2);
    return catsPeloLungo;
  }

  getCatsCarousel() {
    catsCarousel = [];
    Random random = Random();
    while(catsCarousel.length != 5) {
      int randomNumber = random.nextInt(allCats.length); 
      if(!catsCarousel.contains(allCats[randomNumber])) {
        catsCarousel.add(allCats[randomNumber]);
      }
    }
    return catsCarousel;
  }

  changeFilterCats(tabIndex) {
    List mantelli = INDEXPELO;
    String mantello = '';
    mantelli.forEach((element) {
      if(element['id'] == tabIndex) {
        mantello = element['mantello'];
      } 
    },    
    );
    List<Cats> list = [];
    allCats.forEach((element) {
      if(element.mantello == mantello) {
        list.add(element);
      }
    });
    return list;
  }

  setCat(cat) {
    catDetails = cat;
  }

  getCat() {
    return catsPeloCorto;
  }
}
  