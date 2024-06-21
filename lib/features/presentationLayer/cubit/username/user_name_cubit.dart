import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_name_state.dart';

class UserNameCubit extends Cubit<UserNameState> {
  UserNameCubit() : super(UserNameInitial());
}
