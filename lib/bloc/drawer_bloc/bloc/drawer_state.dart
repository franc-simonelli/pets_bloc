part of 'drawer_bloc.dart';

abstract class DrawerState extends Equatable {
}

class DrawerInitial extends DrawerState {
  DrawerInitial();

  @override
  List<Object> get props => [];

}
class UserState extends DrawerState {
  final LoggedUser user;
  UserState(this.user);
  
  @override
  List<Object?> get props => [user];
}
