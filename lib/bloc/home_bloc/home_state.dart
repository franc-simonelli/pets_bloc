import 'package:petsguide/model/cat_model.dart';

abstract class HomeState {
}

class HomeInitialState extends HomeState {}

class LoadingAllCatsState extends HomeState {}

class LoadAllCatsState extends HomeState {
  List<Cats> catsPeloCorto = [];
  List<Cats> catsPeloMedio = [];
  List<Cats> catsPeloLungo = [];
  List<Cats> catsCarousel = [];

  LoadAllCatsState(this.catsPeloCorto, this.catsPeloMedio, this.catsPeloLungo, this.catsCarousel);
}

class LoadCatDetailsState extends HomeState {
  Cats cat = Cats();
  LoadCatDetailsState(this.cat);
}

// class LoadCatsPeloCortoState extends HomeState {
//   List<Cats> catsPeloCorto = [];
//   LoadCatsPeloCortoState(this.catsPeloCorto);
// }

// class LoadCatsPeloMedioState extends HomeState {
//   List<Cats> catsPeloMedio = [];
//   LoadCatsPeloMedioState(this.catsPeloMedio);
// }

// class LoadCatsPeloLungoState extends HomeState {
//   List<Cats> catsPeloLungo = [];
//   LoadCatsPeloLungoState(this.catsPeloLungo);
// }