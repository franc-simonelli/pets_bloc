import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/service/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginGoogleEvent>((event, emit) async{
      emit(const LoginLoading(true));

      LoginService loginService = Injector().get<LoginService>();
      final result = await loginService.signInwithGoogle();

      emit(LoginSuccess());
      
    });

    on<LogoutEvent>((event, emit) async{
      LoginService loginService = Injector().get<LoginService>();
      final result = await loginService.signInwithGoogle();
    });
  }
}
