part of 'user_register_bloc.dart';

sealed class UserRegisterState extends Equatable {
  const UserRegisterState();
}

final class UserRegisterInitialState extends UserRegisterState {
  @override
  List<Object> get props => [];
}

final class UserRegisterLoadingState extends UserRegisterState {
  @override
  List<Object> get props => [];
}
final class UserRegisterLoadedState extends UserRegisterState {
 final UserRegisterModel userRegisterModel;
 const UserRegisterLoadedState(this.userRegisterModel);
  @override
  List<Object> get props => [userRegisterModel];
}

final class UserRegisterErrorState extends UserRegisterState {
  final String errorMessage;
  const UserRegisterErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}