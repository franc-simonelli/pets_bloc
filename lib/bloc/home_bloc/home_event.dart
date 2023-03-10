import 'package:petsguide/model/cat_model.dart';

abstract class HomeEvent {}

class HomeInitial extends HomeEvent {}

class LoadAllCats extends HomeEvent {
  LoadAllCats();
}

class GetCatProva extends HomeEvent {}

class SetCatEvent extends HomeEvent {
  final Cats cat;
  SetCatEvent(this.cat);
}

class GetCatEvent extends HomeEvent {}