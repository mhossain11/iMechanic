import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imechanic/features/data/models/userdataModel.dart';

import '../../../data/repositiory/viewownpostrepositiory.dart';

part 'view_own_post_state.dart';

class ViewOwnPostCubit extends Cubit<ViewOwnPostCubitState> {
  ViewOwnPostRepository viewOwnPostRepository;
  ViewOwnPostCubit(this.viewOwnPostRepository) : super(ViewOwnPostInitialCubitState());


  fetchData()async{
    emit(ViewOwnPostLoadingCubitState());
    try{
      final userResponse =await viewOwnPostRepository.getOrgDashboardData();
      emit(ViewOwnPostLoadedCubitState(userResponse));
    }catch(e){
      emit(ViewOwnPostErrorCubitState(e.toString()));
    }
  }

}
