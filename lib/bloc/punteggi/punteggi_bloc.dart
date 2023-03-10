import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/model/cat_model.dart';
import 'package:petsguide/model/punteggio_model.dart';
import 'package:petsguide/service/punteggi_service.dart';

part 'punteggi_event.dart';
part 'punteggi_state.dart';

class PunteggiBloc extends Bloc<PunteggiEvent, PunteggiState> {
  
  PunteggiBloc() : super(PunteggiInitial()) {
    on<PunteggiLoadingEvent>((event, emit) async{
      emit(PunteggiLoading());
      PunteggiService punteggiService = Injector().get<PunteggiService>();
      List<PunteggioModel> listaPunteggi = await punteggiService.getPunteggiByIdUser();
      List<Cats> listCat = await punteggiService.getCats(listaPunteggi);
      emit(PunteggiLoaded(listCat));
    });

    on<AggiornaPunteggiEvent>((event, emit) async{
      emit(PunteggiLoading());
      List<Cats> list = event.list;

      //TODO: SAVE NEW PUNTEGGIO IN DB
      
      list.forEach((element) {
        if(element.id == event.cat.id) {
          element.punteggioUser = event.newPunteggio;
        }
      },);
      
      emit(PunteggiLoaded(list));
    });
  }
}
