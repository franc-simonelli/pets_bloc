part of 'preferiti_bloc.dart';

abstract class PreferitiEvent extends Equatable {
  const PreferitiEvent();

  @override
  List<Object> get props => [];
}

class CheckIsFavoriteEvent extends PreferitiEvent {
  final Cats cat;
  const CheckIsFavoriteEvent(this.cat);
}

class AddFavorite extends PreferitiEvent {
  final Cats cat;
  const AddFavorite(this.cat);
}

class RemoveFavorite extends PreferitiEvent {
  final PreferitiModel preferito;
  const RemoveFavorite(this.preferito);
}

