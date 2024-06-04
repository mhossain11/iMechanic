part of 'view_own_post_cubit.dart';

sealed class ViewOwnPostCubitState extends Equatable {
  const ViewOwnPostCubitState();
}

final class ViewOwnPostInitialCubitState extends ViewOwnPostCubitState {
  @override
  List<Object> get props => [];
}

final class ViewOwnPostLoadingCubitState extends ViewOwnPostCubitState {
  @override
  List<Object> get props => [];
}
final class ViewOwnPostLoadedCubitState extends ViewOwnPostCubitState {
  final UserdataModel userdataModel;
  const ViewOwnPostLoadedCubitState(this.userdataModel);
  @override
  List<Object> get props => [userdataModel];
}
final class ViewOwnPostErrorCubitState extends ViewOwnPostCubitState {
  final String errorMessage;
  const ViewOwnPostErrorCubitState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
