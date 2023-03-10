import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/model/logged_user_mode.dart';
import 'package:petsguide/service/drawer_service.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial()) {

    on<LoadUserEvent>((event, emit) async {
      DrawerService drawerService = Injector().get<DrawerService>();
      LoggedUser user = await drawerService.getUser();

      emit(UserState(user));
    });
  }
}

