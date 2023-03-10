import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/bloc/home_bloc/home_event.dart';
import 'package:petsguide/bloc/home_bloc/home_state.dart';
import 'package:petsguide/model/cat_model.dart';
import 'package:petsguide/repository/repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  List<Cats> listAllCats = [];

  List<Cats> get getListAllCats => listAllCats;

  HomeBloc() :super(HomeInitialState()) {
    
    on<LoadAllCats>((event, emit) async {
      emit(LoadingAllCatsState());
      Repository repository = Injector().get<Repository>();
      listAllCats = await repository.getAllCats();
      List<Cats> peloCorto = await repository.getCatsPeloCorto();
      List<Cats> peloMedio = await repository.getCatsPeloMedio();
      List<Cats> peloLungo = await repository.getCatsPeloLungo();
      List<Cats> carousel = await repository.getCatsCarousel();
      emit(LoadAllCatsState(peloCorto, peloMedio, peloLungo, carousel));

    },);

  }

}