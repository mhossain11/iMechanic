import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/usernameModel.dart';
import '../../../data/repositiory/usernamerepository.dart';

part 'user_name_state.dart';

class UserNameCubit extends Cubit<UserNameState> {
  UserNameRepository userNameRepository;
  UserNameCubit(this.userNameRepository) : super(UserNameInitialCubitState());

  fetchNameData()async{
    emit(UserNameLoadingCubitState());
    try{
      final userResponse =await userNameRepository.userNameList();
      emit(UserNameLoadedCubitState(userResponse));
    }catch(e){
      emit(UserNameErrorCubitState(e.toString()));
    }
  }
}
