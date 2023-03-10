import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/model/caratteristiche_model.dart';
import 'package:petsguide/model/cat_model.dart';
import 'package:petsguide/service/details_service.dart';
import 'package:petsguide/service/firebase_query_service.dart';
part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {

  Cats cat = Cats();
  late String idCat;
  List<CaratteristicheModel> caratteristiche = [];
  double punteggioMedio = 0.0;
  double initialRating = 0.0;
  

  DetailsBloc() : super(DetailsInitial()) {
   
    on<GetCaratteristicheEvent>((event, emit) async {
      cat = event.cat;
      DetailsService detailsService = Injector().get<DetailsService>();
      caratteristiche = await detailsService.getCaratteristiche(cat);
      emit(CatDetailsLoadedState(caratteristiche));
    });

    on<GetPunteggioMedioEvent>((event, emit) async {
      emit(LoadingSetPunteggioState());

      idCat = event.id;

      DetailsService detailsService = Injector().get<DetailsService>();
      punteggioMedio = await detailsService.getPunteggioMedio(idCat);
      emit(GetPunteggioMedioState(punteggioMedio));
    });

    on<GetInitialRatingEvent>((event, emit) async {
      FirebaseQueryService firebaseQueryService = Injector().get<FirebaseQueryService>();
      var punteggio = await firebaseQueryService.getPunteggioByIdUserAndCatId(event.id);
      initialRating = punteggio.punteggio.toDouble();
      emit(GetInitialRatingState(initialRating));

    });

    on<SetNewPunteggioEvent>((event, emit,) async {
      emit(LoadingSetPunteggioState());

      FirebaseQueryService firebaseQueryService = Injector().get<FirebaseQueryService>();
      DetailsService detailsService = Injector().get<DetailsService>();
      var punteggio = await firebaseQueryService.getPunteggioByIdUserAndCatId(event.idCat);

      if(punteggio.idPunteggio != '' && punteggio.idPunteggio != null) {
        await firebaseQueryService.updatePunteggio(punteggio, event.rating);
      } else {
        await firebaseQueryService.addPunteggio(event.idCat, event.rating);
      }
      punteggioMedio = await detailsService.getPunteggioMedio(event.idCat);

      emit(GetPunteggioMedioState(punteggioMedio));

    });
  }

}
