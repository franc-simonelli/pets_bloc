part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {}

class LoadCatDetailsEvent extends DetailsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetCaratteristicheEvent extends DetailsEvent {
  final Cats cat;
  GetCaratteristicheEvent(this.cat);
  
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetPunteggioMedioEvent extends DetailsEvent {
  final String id;
  // final double? rating;
  GetPunteggioMedioEvent(this.id);
  
  @override
  List<Object?> get props => [id];
}

class GetInitialRatingEvent extends DetailsEvent {
  final String id;
  GetInitialRatingEvent(this.id);
  
  @override
  List<Object?> get props => [id];
}

class SetNewPunteggioEvent extends DetailsEvent {
  final double rating;
  final String idCat;
  SetNewPunteggioEvent(this.rating, this.idCat);
  
  @override
  List<Object?> get props => [rating, idCat];
}



