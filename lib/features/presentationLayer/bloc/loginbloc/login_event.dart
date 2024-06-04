part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonEvent extends LoginEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
