import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:imechanic/features/data/models/loginModel.dart';

import '../../../data/models/userregisterModel.dart';
import '../../../data/repositiory/userregisterrepository.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
 final UserRegisterRepository userRegisterRepository;
  UserRegisterBloc(this.userRegisterRepository) : super(UserRegisterInitialState()) {
    on<UserRegisterEvent>((event, emit) async{
      if(event is UserRegisterSubmitEvent){
        emit(UserRegisterLoadingState());
       try{
         final repo =await UserRegisterRepository().userCreateAccount(
             numberController: event.numberController,userNameController: event.userNameController,
           fullNameController: event.fullNameController,conformPasswordController: event.conformPasswordController,
           passwordController: event.passwordController,emailAddressController: event.emailAddressController,
             profileImage: event.profileImage,
         );
         emit(UserRegisterLoadedState(repo));

       }catch(e){
         emit(UserRegisterErrorState(e.toString()));
       }

      }
    });
  }
}
