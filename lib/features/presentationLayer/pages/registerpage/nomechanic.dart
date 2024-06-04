import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechanic/features/data/repositiory/userregisterrepository.dart';
import 'package:imechanic/features/presentationLayer/bloc/userregister/user_register_bloc.dart';
import 'package:imechanic/features/presentationLayer/widget/buttons.dart';

import '../../../../core/util/images.dart';
import '../../widget/imagepicker.dart';
import '../../widget/textformfield.dart';
import '../loginpage/loginpage.dart';

class NoMechanic extends StatefulWidget {
  NoMechanic({super.key});

  @override
  State<NoMechanic> createState() => _NoMechanicState();
}

class _NoMechanicState extends State<NoMechanic> {
  late UserRegisterBloc userRegisterBloc;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conformPasswordController =
      TextEditingController();
  XFile? profileImage;

  errorText(txt) {
    print("Invalid, $txt");
  }

  @override
  void initState() {
    super.initState();
    userRegisterBloc = UserRegisterBloc(UserRegisterRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.pop(context);
            },
            child: Image.asset(Images.backIcon)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              TextFormFields(
                controller: fullNameController,
                hint: 'Full Name',
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.text,
                enabledBorderSide: const BorderSide(color: Colors.grey),
                focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                validators: (String value) {
                  return value.trim().isNotEmpty
                      ? null
                      : errorText('Enter your  Full Name!');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFields(
                controller: emailController,
                hint: 'Email',
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                enabledBorderSide: const BorderSide(color: Colors.grey),
                focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                validators: (String value) {
                  return value.trim().isNotEmpty
                      ? null
                      : errorText('Enter your  Email!');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFields(
                controller: numberController,
                hint: 'Mobile Number',
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.number,
                enabledBorderSide: const BorderSide(color: Colors.grey),
                focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                validators: (String value) {
                  return value.trim().isNotEmpty
                      ? null
                      : errorText('Enter your  Mobile Number!');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFields(
                controller: userNameController,
                hint: 'User Name',
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.text,
                enabledBorderSide: const BorderSide(color: Colors.grey),
                focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                validators: (String value) {
                  return value.trim().isNotEmpty
                      ? null
                      : errorText('Enter your  User Name!');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFields(
                controller: passwordController,
                hint: 'Password',
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.text,
                enabledBorderSide: const BorderSide(color: Colors.grey),
                focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                validators: (String value) {
                  return value.trim().isNotEmpty
                      ? null
                      : errorText('Enter your  Password!');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFields(
                controller: conformPasswordController,
                hint: 'Conform Password',
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.text,
                enabledBorderSide: const BorderSide(color: Colors.grey),
                focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                validators: (String value) {
                  return value.trim().isNotEmpty
                      ? null
                      : errorText('Enter your  Conform Password!');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              profileImage != null
                  ? Image.file(
                      File(profileImage!.path),
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              ElevatedButtons(
                onPressed: () {
                  profileImages();
                },
                side: const BorderSide(color: Color(0xffc1262c)),
                fixedSize: const Size(300, 50),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Text('Attach image',
                    style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocListener<UserRegisterBloc, UserRegisterState>(
                bloc: userRegisterBloc,
                listener: (context, state) {
                  if (state is UserRegisterLoadedState) {
                    if (kDebugMode) {
                      print("Signed In successfully!");
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  } else if (state is UserRegisterErrorState) {
                    print(state.errorMessage);
                  }
                },
                child: BlocBuilder<UserRegisterBloc, UserRegisterState>(
                  bloc: userRegisterBloc,
                  builder: (context, state) {
                    return ElevatedButtons(
                      onPressed: () {
                        userRegisterBloc.add(UserRegisterSubmitEvent(
                            fullNameController: fullNameController,
                            userNameController: userNameController,
                            emailAddressController: emailController,
                            numberController: numberController,
                            passwordController: passwordController,
                            conformPasswordController:
                                conformPasswordController));
                      },
                      fixedSize: const Size(350, 50),
                      backgroundColor: const Color(0xffc1262c),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: (state is UserRegisterLoadingState)
                          ? const CircularProgressIndicator(
                              color: Colors.green,
                            )
                          : const Text('Submit',
                              style: TextStyle(color: Colors.white)),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  profileImages() async {
    try {
      XFile? result =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (result == null) return;
      setState(() {
        profileImage = result;
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
