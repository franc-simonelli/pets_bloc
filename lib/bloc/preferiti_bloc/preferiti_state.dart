part of 'preferiti_bloc.dart';

abstract class PreferitiState extends Equatable {
  const PreferitiState();
  
  @override
  List<Object> get props => [];
}

class PreferitiInitial extends PreferitiState {}

class PreferitiLoading extends PreferitiState {}

class IsFavoriteState extends PreferitiInitial {
  late final PreferitiModel preferito;
  IsFavoriteState(this.preferito);
}

class IsNotFavoriteState extends PreferitiInitial {}


