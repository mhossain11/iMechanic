part of 'user_name_cubit.dart';

sealed class UserNameState extends Equatable {
  const UserNameState();
}

final class UserNameInitial extends UserNameState {
  @override
  List<Object> get props => [];
}
