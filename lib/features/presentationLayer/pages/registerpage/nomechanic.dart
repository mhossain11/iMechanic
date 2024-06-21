import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechanic/features/data/repositiory/usernamerepository.dart';
import 'package:imechanic/features/data/repositiory/userregisterrepository.dart';
import 'package:imechanic/features/presentationLayer/cubit/username/user_name_cubit.dart';
import 'package:imechanic/features/presentationLayer/widget/buttons.dart';

import '../../../../core/util/images.dart';
import '../../../data/models/usernameModel.dart';
import '../../bloc/userregisterbloc/user_register_bloc.dart';
import '../../widget/other/popupicon.dart';
import '../../widget/textformfield.dart';
import '../loginpage/loginpage.dart';

class NoMechanic extends StatefulWidget {
  NoMechanic({super.key});

  @override
  State<NoMechanic> createState() => _NoMechanicState();
}

class _NoMechanicState extends State<NoMechanic> {
  late UserNameCubit userNameCubit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late UserRegisterBloc userRegisterBloc;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conformPasswordController =
      TextEditingController();
  XFile? profileImage;
  bool filter = false;
  List<UserName>nameList=[];
  String errorText = "Invalid";

  search(){
    filter =nameList.contains(userNameController.text);
  }
  @override
  void initState() {
    super.initState();
    userNameCubit = UserNameCubit(UserNameRepository());
    userNameCubit.fetchNameData();
    userRegisterBloc = UserRegisterBloc(UserRegisterRepository());
  }

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
    emailController.dispose();
    userNameController.dispose();
    conformPasswordController.dispose();
    fullNameController.dispose();
    numberController.dispose();
    passwordController.dispose();
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
            child: Image.asset(Images.backIcon,color: Colors.red,)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 40,),
                SizedBox(
                  height: 50,
                  child: TextFormFields(
                    controller:fullNameController,
                    hint: 'Enter full Name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.text,
                    enabledBorderSide: const BorderSide(color: Colors.grey),
                    focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                    levelText: const Text('Full name'),
                    validators: (String? value) {
                      if(value!.isEmpty){
                        return 'Please enter a full name';
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  child: TextFormFields(
                    controller: emailController,
                    hint: 'Enter valid Email',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.emailAddress,
                    enabledBorderSide: const BorderSide(color: Colors.grey),
                    focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                    levelText: const Text('Email'),
                    validators: (String? value) {
                      if(value!.isEmpty){
                        return 'Please enter a email address';
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  child: TextFormFields(
                    controller:numberController,
                    hint: 'Enter mobile number',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.number,
                    enabledBorderSide: const BorderSide(color: Colors.grey),
                    focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                    levelText: const Text('Mobile Number'),
                    validators: (String? value) {
                      if(value!.isEmpty){
                        return 'Please enter a mobile number';
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                BlocBuilder<UserNameCubit, UserNameState>(
                  bloc: userNameCubit,
  builder: (context, state) {
    if(state is UserNameLoadedCubitState){
      //nameList.add(state.usernameModel!.data!.userName!)
    return SizedBox(
    height: 50,
    child: TextFormFields(
    controller: userNameController,
    onChanged: (value){
    setState(() {
    search();
    });
    },
    hint: 'User Name',
    hintStyle: TextStyle(color: Colors.grey[400]),
    minLines: 1,
    maxLines: 1,
    cursorColor: Colors.red,
    keyboardType: TextInputType.text,
    enabledBorderSide: const BorderSide(color: Colors.grey),
    focusedBorderSide: const BorderSide(color: Colors.blueAccent),
    levelText: const Text('User name'),
    suffixIcon: IconButton(
    onPressed: () {
    userNameController.clear();
    setState(() {
    filter=false;
    });
    },
    icon: userNameController.text.isNotEmpty? const Icon(Icons.clear,color: Colors.black12,):const SizedBox(),

    ),
    validators: (String? value) {
    if(value!.isEmpty){
    return 'Please enter a username';
    }else{
    return null;
    }
    },
    ),
    );
    }else if(state is UserNameErrorCubitState){
      return  Text(state.errorMessage);
    }
    return const SizedBox();
  },
),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // if( userRegisterController.nameList.where((element)=>element.toLowerCase().startsWith(searchText)).toList())
                    filter == false? const Text('')
                        :const Text('User name is exist!',style: TextStyle(color: Colors.red),)
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    SizedBox(
                      width: 345,
                      height: 50,
                      child: TextFormFields(
                        controller: passwordController,
                        hint: 'Enter password',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        minLines: 1,
                        maxLines: 1,
                        cursorColor: Colors.red,
                        keyboardType: TextInputType.text,
                        enabledBorderSide: const BorderSide(color: Colors.grey),
                        focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                        levelText: const Text('Password'),
                        validators: (String? value) {
                          if(value!.isEmpty){
                            return 'Please enter a password';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                        width: 20,
                        height: 30,
                        child:   PopupIcons(
                            icon: Icons.info_rounded,
                            color: Color(0xffe1306c),
                            text: '8 Character Password ')

                    )
                  ],
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 345,
                  height: 50,
                  child: TextFormFields(
                    controller:conformPasswordController,
                    hint: 'Enter conform password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.text,
                    enabledBorderSide: const BorderSide(color: Colors.grey),
                    focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                    levelText: const Text('Conform Password'),
                    validators: (String? value) {
                      if(value!.isEmpty){
                        return 'Please enter a conform password';
                      }else{
                        return null;
                      }
                    },
                  ),
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
                          if (_formKey.currentState!.validate()) {

                        userRegisterBloc.add(UserRegisterSubmitEvent(
                        fullNameController: fullNameController,
                        userNameController: userNameController,
                        emailAddressController: emailController,
                        numberController: numberController,
                        passwordController: passwordController,
                        conformPasswordController:
                        conformPasswordController));
                      }

                          },
                          fixedSize: const Size(350, 50),
                          backgroundColor: const Color(0xffc1262c),
                          shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: (state is UserRegisterLoadingState)
                          ? const CircularProgressIndicator(
                          color: Colors.green,
                          )
                              : const Text('Submit',style: TextStyle(color: Colors.white)),
                      );
                    },
                  ),
                )
              ],
            ),
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
