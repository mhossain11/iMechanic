part of 'mechanic_register_bloc.dart';

sealed class MechanicRegisterState extends Equatable {
  const MechanicRegisterState();
}

final class MechanicRegisterInitialState extends MechanicRegisterState {
  @override
  List<Object> get props => [];
}

final class MechanicRegisterLoadingState extends MechanicRegisterState {
  @override
  List<Object> get props => [];
}

final class MechanicRegisterLoadedState extends MechanicRegisterState {
 final MechanicRegisterModel mechanicRegisterModel;
 const MechanicRegisterLoadedState(this.mechanicRegisterModel);
  @override
  List<Object> get props => [mechanicRegisterModel];
}

final class MechanicRegisterErrorState extends MechanicRegisterState {
  final String errorMessage;
  const MechanicRegisterErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}