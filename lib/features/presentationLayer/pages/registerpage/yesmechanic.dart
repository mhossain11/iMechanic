import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechanic/features/data/repositiory/mechanicregisterrepository.dart';
import 'package:imechanic/features/presentationLayer/bloc/mechanicregisterbloc/mechanic_register_bloc.dart';
import 'package:imechanic/features/presentationLayer/pages/loginpage/loginpage.dart';
import 'package:imechanic/features/presentationLayer/widget/imagepicker.dart';

import '../../../../core/util/images.dart';
import '../../widget/buttons.dart';
import '../../widget/other/popupicon.dart';
import '../../widget/textformfield.dart';

class YesMechanic extends StatefulWidget {
  const YesMechanic({super.key});

  @override
  State<YesMechanic> createState() => _YesMechanicState();
}

class _YesMechanicState extends State<YesMechanic> {
  //final List<GlobalObjectKey<FormState>> _formKey = List.generate(10, (index) => GlobalObjectKey<FormState>(index));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController specialistController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController  passwordController = TextEditingController();
  final TextEditingController conformPasswordController = TextEditingController();
  String dropdownValue ='';
  String specialistDropdownValue ='';
  File? proofImage;
  File? profileImage;
  late ImagePickers imagePickers ;
 late MechanicRegisterBloc machanicRegiterBloc ;
  String errorText = "Invalid";

  @override
  void initState() {
    super.initState();
    imagePickers = ImagePickers();
    setState(() {
      machanicRegiterBloc = MechanicRegisterBloc(mechanicRegisterRepository: MechanicRegisterRepository(),
      );
    });

  }
  @override
  void dispose() {
    specialistController.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
    conformPasswordController.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('dropdownValue2:$dropdownValue');
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  child: TextFormFields(
                    controller: fullNameController,
                    hint: 'Enter full Name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.text,
                    enabledBorderSide: const BorderSide(color: Colors.grey),
                    focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                    levelText: const Text('Full name'),
                    validators: (String value) {
                      return value.isNotEmpty
                          ? null
                          : errorText;
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  child: TextFormFields(
                    controller: emailAddressController,
                    hint: 'Enter valid Email',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.emailAddress,
                    enabledBorderSide: const BorderSide(color: Colors.grey),
                    focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                    levelText: const Text('Email'),
                    validators: (String value) {
                      return value.isNotEmpty
                          ? null
                          : errorText;
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
                    validators: (String value) {
                      return value.isNotEmpty
                          ? null
                          : errorText;
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  child: TextFormFields(
                    controller: userNameController,
                    hint: 'Enter user name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.text,
                    enabledBorderSide: const BorderSide(color: Colors.grey),
                    focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                    levelText: const Text('User Name'),
                    validators: (String value) {
                      return value.isNotEmpty
                          ? null
                          : errorText;
                    },
                  ),
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
                        validators: (String value) {
                          return value.isNotEmpty
                              ? null
                              : errorText;
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
                  height: 50,
                  child: TextFormFields(
                    controller: conformPasswordController,
                    hint: 'Enter conform password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.text,
                    enabledBorderSide: const BorderSide(color: Colors.grey),
                    focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                    levelText: const Text('Conform Password'),
                    validators: (String value) {
                      return value.isNotEmpty
                          ? null
                          : errorText;
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Center(child: dropDownButtons()),
                const SizedBox(height: 10,),
                // specialistTextInput(),
                Center(child: specialistDropDownButtons()),
                const SizedBox(height: 10,),
                profileImage != null
                    ? Image.file(
                  profileImage!, width: 160, height: 160, fit: BoxFit.cover,)
                    : const SizedBox(),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    SizedBox(
                      width: 345,
                      height: 50,
                      child: ElevatedButtons(
                          onPressed: () {
                            profileImages();
                          },
                          side: const BorderSide(color: Color(0xffc1262c)),
                          fixedSize: const Size(300, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child:const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 5,),
                              Text('Attach profile image', style: TextStyle(color: Colors.black)) ,
                            ],
                          )
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
                proofImage != null
                    ? Image.file(
                  proofImage!, width: 160, height: 160, fit: BoxFit.cover,)
                    : const SizedBox(),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    SizedBox(
                      width: 345,
                      height: 50,
                      child:  ElevatedButtons(
                        onPressed: () {
                          imageGallery();
                          /* setState(() {
                      imagePickers.imageGallery(image);
                    });*/
                        },
                        side: const BorderSide(color: Color(0xffc1262c)),
                        fixedSize: const Size(300, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child:const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.image_outlined),
                            SizedBox(width: 5,),
                            Text('Attach proof', style: TextStyle(color: Colors.black)),
                          ],
                        ) ,
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
                BlocListener<MechanicRegisterBloc, MechanicRegisterState>(
                  bloc:  machanicRegiterBloc,
               listener: (context, state) {
                    if(_formKey.currentState!.validate()){
                      if(state is MechanicRegisterLoadedState){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      } else if(state is MechanicRegisterErrorState){
                        print(state.errorMessage);
                      }
                    }
                 },
            child: BlocListener<MechanicRegisterBloc, MechanicRegisterState>(
              bloc:  machanicRegiterBloc,
            listener: (context, state) {
              if(state is MechanicRegisterLoadedState){
                if (kDebugMode) {
                  print("Signed In successfully!");
                }
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
              }else if(state is MechanicRegisterErrorState){
                print(state.errorMessage);
              }
            },
            child: BlocBuilder<MechanicRegisterBloc, MechanicRegisterState>(
                bloc:  machanicRegiterBloc,
                builder: (context, state) {
                  return ElevatedButtons(
                    onPressed: () {
                      machanicRegiterBloc.add(MechanicRegisterSubmitEvent(
                           fullNameController: fullNameController, userNameController: userNameController,
                        emailAddressController: emailAddressController, numberController: numberController, passwordController: passwordController, conformPasswordController: conformPasswordController, dropdownValue: dropdownValue,
                        profileImage: profileImage,proofImage: proofImage, ));
                    },
                    fixedSize: const Size(350, 50),
                    backgroundColor: const Color(0xffc1262c),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child:(state is MechanicRegisterLoadingState) ? const CircularProgressIndicator(color: Colors.green,):const Text('Submit', style: TextStyle(color: Colors.white)) ,
                  );
            },
          ),
          ),
          ),



              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget specialistTextInput() {
    return TextFormFields(
      controller: specialistController,
      hint: 'Specialist makes',
      maxLength: 300,
      keyboardType: TextInputType.text,
      enabledBorderSide: const BorderSide(color: Colors.grey),
      focusedBorderSide: const BorderSide(color: Colors.red),
      validators: (String value) {
        return value.isNotEmpty
            ? null
            : errorText;
      },

    );
  }
  imageGallery() async{

    try{
      XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(result == null) return;
      setState(() {
        proofImage = File(result.path);
      });
    }catch(e){
      print(e.toString());
    }

  }
  profileImages() async{

    try{
      XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(result == null) return;
      setState(() {
        profileImage = File(result.path);
      });
    }catch(e){
      print(e.toString());
    }

  }
 Widget dropDownButtons(){
   return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField(
          icon: const Icon(Icons.arrow_drop_down),
          value: dropdownValue,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            // labelText: 'experience level'
          ),
          items: const [
            DropdownMenuItem(value: '',child: Text('Your experience level',style: TextStyle(color: Colors.grey),)),
            DropdownMenuItem(value: '0',child: Text('Mechanic')),
            DropdownMenuItem(value: '1',child: Text('Senior')),
            DropdownMenuItem(value: '2',child: Text('Master technician')),

          ],
          onChanged: (String? newValue){
            setState(() {
              dropdownValue = newValue!;
            });

          }),
    );
  }
  Widget specialistDropDownButtons(){
    return DropdownButtonFormField(
        icon: const Icon(Icons.arrow_drop_down),
        value: specialistDropdownValue,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          // labelText: 'experience level'
        ),
        //which do you specialist in car?
        items: const [
          DropdownMenuItem(value: '',child: Text('Select specialist car name',style: TextStyle(color: Colors.grey),)),
          DropdownMenuItem(value: '0',child: Text('Mechanic')),
          DropdownMenuItem(value: '1',child: Text('Senior')),
          DropdownMenuItem(value: '2',child: Text('Master technician')),

        ],
        onChanged: (String? newValue){
          setState(() {
            dropdownValue = newValue!;
          });

        });
  }
}