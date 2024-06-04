import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/loginModel.dart';
import '../../../data/repositiory/loginrepository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  LoginBloc(this._loginRepository, this.emailController, this.passwordController) : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async{

      emit(LoginLoadingState());
      try{
        final user = await _loginRepository.getUser(emailController,passwordController);
        emit(LoginLoadedState(user));
      }catch(e){
        emit(LoginErrorState(e.toString()));
      }


    });
  }
}
