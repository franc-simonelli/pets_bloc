part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginGoogleEvent extends LoginEvent {
  const LoginGoogleEvent();
}

class LogoutEvent extends LoginEvent {
  const LogoutEvent();
}
