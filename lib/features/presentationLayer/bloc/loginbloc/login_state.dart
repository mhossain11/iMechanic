part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

final class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState{
  @override
  List<Object?> get props => [];

}

class LoginLoadedState extends LoginState {
  final LoginModel loginModel;
  const LoginLoadedState(this.loginModel);

  @override
  List<Object?> get props => [loginModel];

}

class LoginErrorState extends LoginState{
  String errorMessage;
  LoginErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];

}