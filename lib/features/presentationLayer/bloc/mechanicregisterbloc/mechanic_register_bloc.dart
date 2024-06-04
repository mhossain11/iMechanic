import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechanic/features/data/models/mechanicregisterModel.dart';
import 'package:imechanic/features/data/repositiory/mechanicregisterrepository.dart';

import '../../../data/models/loginModel.dart';

part 'mechanic_register_event.dart';
part 'mechanic_register_state.dart';

class MechanicRegisterBloc extends Bloc<MechanicRegisterEvent, MechanicRegisterState> {
  final MechanicRegisterRepository mechanicRegisterRepository;

  MechanicRegisterBloc({required this.mechanicRegisterRepository}) : super(MechanicRegisterInitialState()) {

    on<MechanicRegisterEvent>((event, emit) async{
        if(event is MechanicRegisterSubmitEvent){
          emit(MechanicRegisterLoadingState());

          try{
            final mechanicRegister =await mechanicRegisterRepository.mechanicCreateAccount(
                emailAddressController:event.emailAddressController,passwordController: event.passwordController,
                conformPasswordController: event.conformPasswordController,fullNameController: event.fullNameController,
                userNameController: event.userNameController,numberController: event.numberController,dropdownValue:event.dropdownValue,
                proofImage: event.proofImage,profileImage: event.profileImage);

              emit(MechanicRegisterLoadedState(mechanicRegister));
          }catch(e){
            emit(MechanicRegisterErrorState(e.toString()));
          }
        }
    });
  }
}
