part of 'drawer_bloc.dart';

abstract class DrawerEvent extends Equatable {
  const DrawerEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEvent extends DrawerEvent {
  const LoadUserEvent();
}