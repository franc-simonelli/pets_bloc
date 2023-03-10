import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import 'package:petsguide/bloc/tab_bloc/tab_event.dart';
import 'package:petsguide/bloc/tab_bloc/tab_state.dart';
import 'package:petsguide/model/tab_model.dart';
import 'package:petsguide/repository/repository.dart';



class TabBloc extends Bloc<TabEvent, TabState> {

  List<TabModel> tab = [];

  TabBloc() : super(TabInitialState()) {

    on<TabInitial>((event, emit) {
      emit(TabIndexState(0));
    });
    
    on<TabChangeIndexEvent>((event, emit) {
      int newIndex = event.index;
      emit(TabViewLoaded(tab, newIndex));
    });

    on<GetTabView>((event, emit) async{
      Repository repository = Injector().get<Repository>();
      tab = await repository.getTab();
      int currentIndex = 0;
      emit(TabViewLoaded(tab, currentIndex));
      // emit(TabIndexState(newIndex));
    });
  }

}