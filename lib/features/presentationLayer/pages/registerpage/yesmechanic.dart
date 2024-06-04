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
  File? proofImage;
  File? profileImage;
  late ImagePickers imagePickers ;
 late MechanicRegisterBloc machanicRegiterBloc ;
  errorText(txt){
   print("Invalid, $txt");
 }

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

                TextFormFields(
                  controller: fullNameController,
                  hint: 'Full Name',
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  enabledBorderSide: const BorderSide(color: Colors.grey),
                  focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                  validators: (String value) {
                    return value.isNotEmpty
                        ? null
                        : errorText('Enter your  Full Name!');
                    },
                ),
                const SizedBox(height: 10,),
                TextFormFields(
                  controller: emailAddressController,
                  hint: 'Email',
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  enabledBorderSide: const BorderSide(color: Colors.grey),
                  focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                  validators: (String value) {
                    return value.isNotEmpty
                        ? null
                        : errorText('Enter your  Email!');
                    },
                ),
                const SizedBox(height: 10,),
                TextFormFields(
                  controller: numberController,
                  hint: 'Mobile Number',
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  enabledBorderSide: const BorderSide(color: Colors.grey),
                  focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                  validators: (String value) {
                    return value.isNotEmpty
                        ? null
                        : errorText('Enter your  Mobile Number!');
                    },
                ),
                const SizedBox(height: 10,),
                TextFormFields(
                  controller: userNameController,
                  hint: 'User Name',
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  enabledBorderSide: const BorderSide(color: Colors.grey),
                  focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                  validators: (String value) {
                    return value.isNotEmpty
                        ? null
                        : errorText('Enter your  User Name!');
                    },
                ),
                const SizedBox(height: 10,),
                TextFormFields(
                  controller: passwordController,
                  hint: 'Password',
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  enabledBorderSide: const BorderSide(color: Colors.grey),
                  focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                  validators: (String value) {
                    return value.isNotEmpty
                        ? null
                        : errorText('Enter your  password!');
                    },
                ),
                const SizedBox(height: 10,),
                TextFormFields(
                  controller: conformPasswordController,
                  hint: 'Conform Password',
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  enabledBorderSide: const BorderSide(color: Colors.grey),
                  focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                  validators: (String value) {
                    return value.isNotEmpty
                        ? null
                        : errorText('Enter your  Conform Password!');
                    },
                ),
                const SizedBox(height: 10,),
                 Center(child: dropDownButtons()),
                const SizedBox(height: 5,),
                specialistTextInput(),
                const SizedBox(height: 10,),
                profileImage != null
                    ? Image.file(profileImage!, width: 160, height: 160, fit: BoxFit.cover,)
                    : const SizedBox(),
                const SizedBox(height: 10,),
                ElevatedButtons(
                  onPressed: () {
                    setState(() {
                      profileImages();
                    });
                  },
                  side: const BorderSide(color: Color(0xffc1262c)),
                  fixedSize: const Size(300, 50),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child:const Text('Attach profile image', style: TextStyle(color: Colors.black)) ,
                ),
                const SizedBox(height: 10,),
                proofImage != null
                    ? Image.file(
                  proofImage!, width: 160, height: 160, fit: BoxFit.cover,)
                    : const SizedBox(),
                const SizedBox(height: 10,),
            ElevatedButtons(
              onPressed: () {
                setState(() {
                  imageGallery();
                });
              },
              side: const BorderSide(color: Color(0xffc1262c)),
              fixedSize: const Size(300, 50),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child:const Text('Attach proof', style: TextStyle(color: Colors.black)) ,
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
            : errorText('Enter your Specialist makes');
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
}