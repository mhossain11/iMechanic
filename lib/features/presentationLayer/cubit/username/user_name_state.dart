part of 'user_name_cubit.dart';

sealed class UserNameState extends Equatable {
  const UserNameState();
}

final class UserNameInitialCubitState extends UserNameState {
  @override
  List<Object> get props => [];
}
class UserNameLoadingCubitState extends UserNameState{
  @override
  List<Object?> get props => [];

}
class UserNameLoadedCubitState extends UserNameState {
  final UsernameModel usernameModel;
  const UserNameLoadedCubitState(this.usernameModel);

  @override
  List<Object?> get props => [usernameModel];

}

class UserNameErrorCubitState extends UserNameState{
  String errorMessage;
  UserNameErrorCubitState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];

}
