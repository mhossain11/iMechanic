part of 'mechanic_register_bloc.dart';

sealed class MechanicRegisterEvent extends Equatable {
  const MechanicRegisterEvent();
}

class MechanicRegisterSubmitEvent extends MechanicRegisterEvent{
  final TextEditingController fullNameController ;
  final TextEditingController userNameController ;
  final TextEditingController emailAddressController ;
  final TextEditingController numberController ;
  final TextEditingController  passwordController ;
  final TextEditingController conformPasswordController ;
  final String dropdownValue;
  final File? proofImage;
  final File? profileImage;

  const MechanicRegisterSubmitEvent(
  {required this.fullNameController,
    required this.userNameController,
    required this.emailAddressController,
    required this.numberController,
    required this.passwordController,
    required this.conformPasswordController,
    required this.dropdownValue,
    this.proofImage,
    this.profileImage});

  @override
  List<Object?> get props => [fullNameController,
    userNameController,
    emailAddressController,
    numberController,
    passwordController,
    conformPasswordController,
    dropdownValue,
    proofImage,
    profileImage];

}