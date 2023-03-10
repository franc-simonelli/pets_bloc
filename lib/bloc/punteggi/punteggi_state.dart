part of 'punteggi_bloc.dart';

abstract class PunteggiState extends Equatable {
  const PunteggiState();
  
  @override
  List<Object> get props => [];
}

class PunteggiInitial extends PunteggiState {}

class PunteggiLoading extends PunteggiState {}

class PunteggiLoaded extends PunteggiState {
  final List<Cats> listCat;
  PunteggiLoaded(this.listCat);
}


