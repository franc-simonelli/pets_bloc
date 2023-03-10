part of 'details_bloc.dart';

abstract class DetailsState extends Equatable{}

class DetailsInitial extends DetailsState {
  @override
  List<Object?> get props => [];
}

class CatDetailsLoadedState extends DetailsState {
  List<CaratteristicheModel> caratteristiche;
  CatDetailsLoadedState(this.caratteristiche);
  
  @override
  List<Object?> get props => [caratteristiche];
}

class GetPunteggioMedioState extends DetailsState {
  final double punteggioMedio;
  GetPunteggioMedioState(this.punteggioMedio);
  
  @override
  List<Object?> get props => [punteggioMedio];
}

class GetInitialRatingState extends DetailsState {
  final double initialRating;
  GetInitialRatingState(this.initialRating);
  
  @override
  List<Object?> get props => [initialRating];
}

class LoadingSetPunteggioState extends DetailsState {
  @override
  List<Object?> get props => [];
}

class IsFavoriteState extends DetailsState {
  @override
  List<Object?> get props => [];
}

class IsNotFavoriteState extends DetailsState {
  @override
  List<Object?> get props => [];
}