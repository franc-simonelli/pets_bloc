import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/model/cat_model.dart';
import 'package:petsguide/model/preferiti_model.dart';
import 'package:petsguide/service/preferiti_service.dart';


part 'preferiti_event.dart';
part 'preferiti_state.dart';

class PreferitiBloc extends Bloc<PreferitiEvent, PreferitiState> {
  
  PreferitiBloc() : super(PreferitiInitial()) {
    on<CheckIsFavoriteEvent>((event, emit,) async {
      emit(PreferitiLoading());
      PreferitiService preferitiService = Injector().get<PreferitiService>();
      PreferitiModel preferito = await preferitiService.checkIsPreferito(event.cat.id);
      if(preferito.id != '') {
        emit(IsFavoriteState(preferito));
      } else {
        emit(IsNotFavoriteState());
      }
    });

    on<AddFavorite>((event, emit,) async {
      PreferitiService preferitiService = Injector().get<PreferitiService>();
      await preferitiService.addPunteggio(event.cat.id);
      PreferitiModel preferito = await preferitiService.checkIsPreferito(event.cat.id);
      emit(IsFavoriteState(preferito));
    });

    on<RemoveFavorite>((event, emit,) async {

      PreferitiModel preferito = event.preferito;
      emit(IsNotFavoriteState());
    });
  }
}
