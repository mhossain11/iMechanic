part of 'user_register_bloc.dart';

sealed class UserRegisterEvent extends Equatable {
  const UserRegisterEvent();
}

class UserRegisterSubmitEvent extends UserRegisterEvent{
  final TextEditingController fullNameController ;
  final TextEditingController userNameController ;
  final TextEditingController emailAddressController ;
  final TextEditingController numberController ;
  final TextEditingController  passwordController ;
  final TextEditingController conformPasswordController ;
  final File? profileImage;

  const UserRegisterSubmitEvent(
      {required this.fullNameController,
        required this.userNameController,
        required this.emailAddressController,
        required this.numberController,
        required this.passwordController,
        required this.conformPasswordController,

        this.profileImage});

  @override
  List<Object?> get props => [fullNameController,
    userNameController,
    emailAddressController,
    numberController,
    passwordController,
    conformPasswordController,
    profileImage
  ];

}
