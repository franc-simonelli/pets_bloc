part of 'punteggi_bloc.dart';

abstract class PunteggiEvent extends Equatable {
  const PunteggiEvent();

  @override
  List<Object> get props => [];
}

class PunteggiLoadingEvent extends PunteggiEvent {

}

class AggiornaPunteggiEvent extends PunteggiEvent {
  final list;
  final cat;
  final newPunteggio;
  const AggiornaPunteggiEvent(this.list, this.cat, this.newPunteggio);
}
