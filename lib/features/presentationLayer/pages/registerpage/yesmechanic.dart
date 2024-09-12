import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechanic/core/conostants/responsivescreen.dart';
import 'package:imechanic/features/data/repositiory/mechanicregisterrepository.dart';
import 'package:imechanic/features/presentationLayer/bloc/mechanicregisterbloc/mechanic_register_bloc.dart';
import 'package:imechanic/features/presentationLayer/cubit/username/user_name_cubit.dart';
import 'package:imechanic/features/presentationLayer/pages/loginpage/loginpage.dart';
import 'package:imechanic/features/presentationLayer/widget/imagepicker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '../../../../config/colors/colors.dart';
import '../../../../core/util/images.dart';
import '../../../data/repositiory/usernamerepository.dart';
import '../../widget/buttons.dart';
import '../../widget/other/popupicon.dart';
import '../../widget/other/snackbars.dart';
import '../../widget/textformfield.dart';

class YesMechanic extends StatefulWidget {
  const YesMechanic({super.key});

  @override
  State<YesMechanic> createState() => _YesMechanicState();
}

class _YesMechanicState extends State<YesMechanic> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MultiSelectController controller = MultiSelectController();
  final TextEditingController specialistController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController  passwordController = TextEditingController();
  final TextEditingController conformPasswordController = TextEditingController();
  final MultiSelectController multiController = MultiSelectController();
  final List<String> selectedOption = [];

  late UserNameCubit userNameCubit;
  String dropdownValue ='';
  String specialistDropdownValue ='';
  File? proofImage;
  File? profileImage;
  List<String> nameList = [];
  late ImagePickers imagePickers ;
 late MechanicRegisterBloc machanicRegiterBloc ;
  String errorText = "Invalid";
  late bool filter = false;
  bool isUsernameVisible= false;
  bool isNameShowVisible= false;
  bool isPassVisible= false;
  bool isChecked = false;
  bool isImgVisible= false;
  bool isSpecialistVisible= false;
  bool isProImgVisible= false;

  @override
  void initState() {
    super.initState();
    userNameCubit = UserNameCubit(UserNameRepository());
    imagePickers = ImagePickers();
    userNameCubit.fetchNameData();
    setState(() {
      machanicRegiterBloc = MechanicRegisterBloc(mechanicRegisterRepository: MechanicRegisterRepository(),
      );
    });

  }
  search() {
    print(nameList.toString());
    filter = nameList.contains(userNameController.text);

  }

  @override
  void dispose() {
    specialistController.clear();
    emailAddressController.clear();
    passwordController.clear();
    conformPasswordController.clear();
    fullNameController.clear();
    userNameController.clear();
    numberController.clear();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$',);
    if (value=="") {
      return 'Email cannot be empty';
    } /*else if (!emailRegex.hasMatch(value.toString())) {
      return 'Enter a valid email';
    }*/
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Responsive.setScreenSize(context);
   // print(Responsive.screenHeight * .06);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register as professional mechanic user',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
        backgroundColor: themeColor,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.pop(context);
            },
            child: Image.asset(Images.backIcon,color: Colors.white,)),
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
                const Gap(20),
                SizedBox(
                  child: TextFormFields(
                    controller: fullNameController,
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: themeColor,
                    keyboardType: TextInputType.text,
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
                  child: TextFormFields(
                    controller: emailAddressController,
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: themeColor,
                    keyboardType: TextInputType.emailAddress,
                    levelText: const Text('Email'),
                    validators:(String? value){
                        if (value=="") {
                        return 'Email cannot be empty';
                        } else{
                        return null;
                        }

                        },
                  ),
                ),
                const Gap(10),
                SizedBox(
                  child: TextFormFields(
                    controller:numberController,
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: themeColor,
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
                const Gap(10),
                Row(
                  children: [
                    SizedBox(
                      child: BlocBuilder<UserNameCubit, UserNameState>(
                        bloc: userNameCubit,
                        builder: (context, state) {
                          if (state is UserNameLoadedCubitState) {
                            nameList.clear();
                            for (var i = 0;
                            i < state.usernameModel.data!.userName!.length;
                            i++) {
                              nameList.add(state
                                  .usernameModel.data!.userName![i].name!
                                  .toString());
                            }
                            return SizedBox(
                              width: Responsive.screenWidth*.85,
                              child: TextFormFields(
                                controller: userNameController,
                                onChanged: (value) {
                                  setState(() {
                                    search();
                                  });
                                },
                                minLines: 1,
                                maxLines: 1,
                                cursorColor: themeColor,
                                keyboardType: TextInputType.text,
                                levelText: const Text('User name'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    userNameController.clear();
                                    setState(() {
                                      filter = false;
                                    });
                                  },
                                  icon: userNameController.text.isNotEmpty
                                      ? const Icon(
                                    Icons.clear,
                                    color: Colors.black12,
                                  )
                                      : const SizedBox(),
                                ),
                                validators: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a username';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            );
                          } else if (state is UserNameErrorCubitState) {
                            return Text(state.errorMessage);
                          }
                          return SizedBox(
                            width: Responsive.screenWidth*.85,
                            child: TextFormFields(
                              controller: userNameController,
                              onChanged: (value) {
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
                              levelText: const Text('User name'),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  userNameController.clear();
                                  setState(() {
                                    filter = false;
                                  });
                                },
                                icon: userNameController.text.isNotEmpty
                                    ? const Icon(
                                  Icons.clear,
                                  color: Colors.black12,
                                )
                                    : const SizedBox(),
                              ),
                              validators: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a username';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8),
                      child: SizedBox(
                        width: Responsive.screenWidth *.05,
                        height: 30,
                        child: InkWell(
                            onTap: (){
                              setState(() {
                                isUsernameVisible =  !isUsernameVisible;
                                Timer.periodic(const Duration(seconds: 5), (timer){
                                  setState(() {
                                    isUsernameVisible=false;
                                    timer.cancel();
                                  });

                                });
                              });
                            },
                            child: const Icon(Icons.info_rounded,color: Colors.grey,)),


                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    filter == false
                        ? const Text('')
                        : const Text(
                      'User name is exist!',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                Visibility(
                    visible: isUsernameVisible,
                    child: const Text('User names can incorporate spaces, numbers, and certain special characters such as periods(.), hyphens(-), apostrophes(\'), underscores(_) sign. Examples of usernames include johndoe, jdoe65, jdlovestofish, alwayssunnyinphilly',style: TextStyle(color: themeColor),)
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Responsive.screenWidth*.85,
                      child: TextFormFields(
                        controller: passwordController,
                        minLines: 1,
                        maxLines: 1,
                        onChanged: (value){
                          value.length ==1 ? isPassVisible = false:isPassVisible;
                        },
                        cursorColor: themeColor,
                        keyboardType: TextInputType.text,
                        levelText: const Text('Password'),
                        validators: (String? value) {
                          RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if(value!.isEmpty){
                            return 'Please enter a password';
                          }
                          if(value.length<8){
                            return ("Password Must be more than 8 characters");
                          }if(!regex.hasMatch(value)){
                            return ("Password should contain upper,lower,digit and Special character ");
                          }

                          return null;

                        },
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8),
                      child: SizedBox(
                        width: Responsive.screenWidth*.05,
                        height: 30,
                        child: InkWell(
                            onTap: (){
                              setState(() {
                                isPassVisible =  !isPassVisible;
                                 Timer.periodic(const Duration(seconds: 5), (timer){
                                  setState(() {
                                    isPassVisible=false;                                    timer.cancel();
                                  });

                                });
                              });
                            },

                            child: const Icon(Icons.info_rounded,color: Colors.grey,)),


                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: isPassVisible,
                  child: const Text('Passwords should contain at least 1 uppercase letter,1 lowercase letter and 1 numerical character and also Symbol characters are encouraged (e.g. @#%^&!.)',style: const TextStyle(color: themeColor)),),
                const Gap(10),
                SizedBox(
                  child: TextFormFields(
                    controller: conformPasswordController,
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.text,
                    levelText: const Text('Conform Password'),
                    validators: (String? value) {
                      if(value!.isEmpty){
                        return 'Please enter a password';
                      }else if(value != conformPasswordController.text){
                        return ("Password not match ");
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                const Gap(10),
                Center(child: dropDownButtons()),
                const Gap(10),
                Row(
                  children: [
                    specialistDropDownButtons(),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: Responsive.screenWidth*.05,
                        height: 30,
                        child: InkWell(
                            onTap: (){
                              setState(() {
                                isSpecialistVisible =  !isSpecialistVisible;
                                Timer.periodic(const Duration(seconds: 5), (timer){
                                  setState(() {
                                    isSpecialistVisible=false;
                                    timer.cancel();
                                  });

                                });
                              });
                            },
                            child: const Icon(Icons.info,color: Colors.grey)),


                      ),
                    )
                  ],
                ),
                Visibility(
                    visible:  isSpecialistVisible,
                    child: const Text('You can select highest three car names! ',style: TextStyle(color: themeColor),)),
                const Gap(10),
                Stack(
                  children: [
                    Center(
                      child: profileImage != null
                          ? Image.file(
                        profileImage!, width: 160, height: 160, fit: BoxFit.cover,)
                          : const SizedBox(),
                    ),
                    Visibility(
                      visible: profileImage != null,
                      child: Positioned(
                          left: 215,
                          child: IconButton(
                            icon: const Icon(Icons.clear,color: Colors.grey,), onPressed: () {

                            setState(() {
                              // userRegisterController.profileImage = XFile(userRegisterController.profileImage!.path.isEmpty ?'':'');
                            });



                          },

                          )),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    SizedBox(
                      width: Responsive.screenWidth*.85,
                      height: 50,
                      child: ElevatedButtons(
                          onPressed: () {
                            profileImages();
                          },
                          side: const BorderSide(color: themeColor),
                          fixedSize: const Size(300, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child:const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.person,color: themeColor,),
                              SizedBox(width: 5,),
                              Text('Attach profile image', style: TextStyle(color: Colors.black)) ,
                            ],
                          )
                      ),
                    ),
                    const Gap(10),
                    SizedBox(
                      width: Responsive.screenWidth*.05,
                      height: 50,
                      child:  InkWell(
                          onTap: (){
                            setState(() {
                              isProImgVisible =  !isProImgVisible;
                              Timer.periodic(const Duration(seconds: 5), (timer){
                                setState(() {
                                  isProImgVisible=false;
                                  timer.cancel();
                                });

                              });
                            });
                          },
                          child: const Icon(Icons.info,color: Colors.grey)),


                    )
                  ],
                ),
                Visibility(
                    visible:  isProImgVisible,
                    child: const Text('Please upload image. jpeg, png ')),


                const Gap(10),
                Stack(
                  children: [
                    Center(
                      child:profileImage != null
                          ? Image.file(
                        profileImage!, width: 160, height: 160, fit: BoxFit.cover,)
                          : const SizedBox(),
                    ),
                    Visibility(
                      visible: profileImage != null,
                      child: Positioned(
                          left: 215,
                          child: IconButton(
                            icon: const Icon(Icons.clear,color: Colors.grey,), onPressed: () {

                            setState(() {
                              // userRegisterController.profileImage = XFile(userRegisterController.profileImage!.path.isEmpty ?'':'');
                            });



                          },

                          )),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    SizedBox(
                      width: Responsive.screenWidth*.85,
                      height: 50,
                      child:  ElevatedButtons(
                        onPressed: () {
                          imageGallery();
                        },
                        side: const BorderSide(color: themeColor),
                        fixedSize: const Size(300, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child:const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.image_outlined,color: themeColor,),
                            SizedBox(width: 5,),
                            Text('Attach proof', style: TextStyle(color: Colors.black)),
                          ],
                        ) ,
                      ),
                    ),
                    Gap(10),
                    SizedBox(
                      width: Responsive.screenWidth*.05,
                      height: 30,
                      child: InkWell(
                          onTap: (){
                            setState(() {
                              isImgVisible =  !isImgVisible;
                              Timer.periodic(const Duration(seconds: 5), (timer){
                                setState(() {
                                  isImgVisible=false;
                                  timer.cancel();
                                });

                              });
                            });
                          },
                          child: const Icon(Icons.info,color: Colors.grey)),


                    )
                  ],
                ),
                Visibility(
                    visible: isImgVisible,
                    child:const Text('Please upload image. jpeg, png,',style: TextStyle(color: themeColor))),


                const Gap(10),
                BlocListener<MechanicRegisterBloc, MechanicRegisterState>(
                  bloc:  machanicRegiterBloc,
                  listener: (context, state) {

                    if(state is MechanicRegisterLoadedState){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    } else if(state is MechanicRegisterErrorState){
                      print(state.errorMessage);
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
                            if(_formKey.currentState!.validate() && isChecked == true && dropdownValue!=0){

                              machanicRegiterBloc.add(MechanicRegisterSubmitEvent(
                                fullNameController: fullNameController, userNameController: userNameController,
                                emailAddressController: emailAddressController, numberController: numberController, passwordController: passwordController, conformPasswordController: conformPasswordController, dropdownValue: dropdownValue,
                                profileImage: profileImage,proofImage: proofImage, ));
                            }else if(dropdownValue.isEmpty){
                              SnackBars.showSnackBar(
                                  context: context,
                                  content: 'please fill up your experience level !!',
                                  durationSec: 3,
                                  success: false,
                                  routeAction: null);
                            }
                            else {
                              SnackBars.showSnackBar(
                                  context: context,
                                  content: 'Please provide required information!!',
                                  durationSec: 3,
                                  success: false,
                                  routeAction: null);

                            }

                          },
                          fixedSize: const Size(330, 50),
                          backgroundColor: themeColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child:(state is MechanicRegisterLoadingState) ? const CircularProgressIndicator(color: Colors.green,):const Text('Submit', style: TextStyle(color: Colors.white)) ,
                        );
                      },
                    ),
                  ),
                ),

                const Gap(15) ,
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: Responsive.screenWidth * .90,
                        height: Responsive.screenHeight * .25 ,
                        child:    SingleChildScrollView(
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("SUBSCRIPTIONS",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                                  SizedBox(height: 10,),
                                  Text('Surefix membership subscriptions are payable by credit or debit card using our secure online payment service. Please allow up to 3 working days for transactions to be processed. At the end of each period we will automatically renew your membership from the card details you have supplied, however you can cancel at any time. If your card details expire before your renewal is due, we will send you an e-mail to update your card details.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
                                  SizedBox(height: 8,),
                                  Text('To unsubscribe at any time, just e-mail us your username and we will remove your details from our database, your card will not be debited and you will not be sent a reminder to renew your membership.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
                                  SizedBox(height: 8,),
                                  Text('MEMBERSHIP POLICY & USER GUIDE LINES',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                                  Text('By using Surefix you are agreeing to our terms & conditions and to abide by our user rules & policy. We only grant Pro mechanic access to experienced & qualified mechanics to ensure that the faults & fixes posted are genuine and correct. To enable all users to benefit from our data, we expect everyone to follow our guidelines when posting any queries or fixes, so that the integrity of the information is maintained at all times.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('When posting faults or fixes, please enter details in all applicable fields such as make, model, engine and fault codes. Also add photos and videos so as to help users save time in identifying where the fault lies and the proposed fix. For the benefit of all follow the principle of identifying cause & effect.ONLY POST A FIX IF IT DEFINATELY CURED THE FAULT on the vehicle you worked on and has not re-occurred. The ethos of this site is not to post maybe and possible fixes, as all users are experienced mechanics and will be able to fault find themselves. Please bear in mind before posting that Surefix is here to SAVE all users time and effort, so if your post is not a definite fix don\'t post it until it is.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text(' In order to maintain high standards, we would ask members to follow a few basic rules when posting faults on this site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('As a technician you MUST NOT promote your equipment, products or services on any part of this site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('1) Please keep your technical posting relevant to the UK automotive industry & specific to fault finding.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2) Please do not post messages that may be interpreted as OFFENSIVE or LIABLE towards any automotive company/manufacturer/individual or motor trade organization, national or global.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('3) Please remember that your professional image and source of income relies on CUSTOMERS so please treat them with respect',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('4) Please make sure the vehicle is or has recently been in your workshop. Then ONLY post once you have carried out all the relevant test and checks with the equipment and technical information at your disposal. Please do not pre-post about problems (i.e. The vehicle is booked in next week, have you had this problem before etc.). Once you have repaired the vehicle, then please POST the FIX at the bottom of your original message. Please do not start a fresh post about a FIX',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('5) For your security, please do not share your personal contact details or information anywhere on this site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('6) If you feel that some of the content is OFFENSIVE then please contact Surefix and we will review the content and if required we will DELETE when possible. Surefix reserve the right to remove any posts that we feel are not relevant to this site, or are of a poor technical quality and lack relevant information about the tests you have carried out prior to posting.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('7) Copyright of all messages posted belongs to Surefix, please do not copy, or reproduce any of the technical information without prior consent from us.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('8) Surefix cannot be held responsible for the accuracy of the information posted, the posting member is solely responsible for the content of that post and must be treated as for information purposes only. ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('TERMS & CONDITIONS.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                                  Text('By visiting our website or mobile app (referred to as site), you are confirming that you have read and accepted all of the following terms and conditions:',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('Definitions',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('1.1 In these terms and conditions the following words have the following meanings: ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('1.2 Feedback & ratings means users comments regarding other users of Surefix;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('1.3 Subscription fee means the sum payable every month or annually by you to us;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('1.4 User means a person, firm or company (collectively and/or individually as the context admits) that has been issued with a username and password for accessing www.surefixai.co.uk or mobile app;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('1.5 Username and password means the username and password issued to you to allow you or your business to access the site;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('1.6 Website means the website located at www.surefixai.co.uk;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('1.7 We/Us/Our means  Surefix Ltd a company registered in England and Wales under company number 15754497 , whose registered office is, 74 Dukes Brow Blackburn BB2 6DH;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('1.8 You/Your/Yourself means a person using the site or receiving our emails.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('Username and password',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('2.1 If you believe there has been any breach of security including (but not limited to) the disclosure, theft or unauthorised use of your username or password, you agree to notify us immediately in writing by email to support@surefixai.co.uk or by first class post to our place of business (as set out in clause 1 above).',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.2 Your username and password are unique to you and are issued on the express understanding that they are for the intended user only. The sharing of user names and passwords and accounts is expressly prohibited.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.3 You will be liable for all use of the site made by you or anyone else using your username and password and you are solely responsible for preventing unauthorised use of your username and password.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.4 We may include your username and password in email that we send to you, it is therefore important that you are careful not to forward those emails onto others as this would result in that person having access to your username and password. If you believe this may have happened you agree to notify us immediately in accordance with 2.1.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('Feedback',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('3.1 We provide a feedback & rating facility so that users may inform others about the experiences they have had whilst communicating with other Surefix users.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('3.2 You must not take any actions that may undermine the integrity of the feedback & rating system. Feedback & ratings posted on the site by users is solely the opinion and responsibility of the person posting that message. We are not responsible for feedback & rating left by users.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('3.3 You are responsible for any feedback & ratings that you leave about others. You must not post any feedback or ratings that is unlawful, threatening, abusive, libellous, indecent, infringes the rights of third parties or which includes any other form of illegal content.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('Subscription Fees',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('4.1 Subscription fees are normally collected on a monthly basis by direct debit.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('4.2 We reserve the right to suspend or terminate your right to access and to use the site at any time if we are unable to collect a payment.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('4.3 If you wish to cancel your subscription to Surefix you must give notice in writing to us at our place of business or by email to admin@surefixai.co.uk.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('Use of information relating to other users',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('5.1 You hereby agree only to contact other users regarding the posting of queries and fixes on the site and not to use contact details of other users for any other purpose. Misuse of the site will result in a breach of these terms and conditions and may result in termination of membership.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('5.2 You hereby agree not to disclose any contact details of any user to any third party who is not a user.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('5.3 You hereby agree to indemnify us and hold us harmless from and against all losses, costs (including reasonable costs on a full indemnity basis), claims, demands, actions, liabilities and expenses in connection with any breach of paragraph 5.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('Termination',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('6.1 We reserve the right to suspend or terminate your right to access and use of the site at any time. We also reserve the right to cease your posts at any time. Such rights may be exercised without notice.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('6.2 If you wish to cancel your subscription to Surefix you must give notice in writing to us at our place of business or by email to admin@surefixai.co.uk.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('Limitation of liability and disclaimer',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('7.1 We give no warranties in respect of the site or any posts thereon, or any e-mails . The site is provided on an "as is", "as available" basis and although we make every effort we do not guarantee the accuracy, timeliness, completeness, performance or fitness for a particular purpose of the posts or the answers provided thereon. All implied warranties are excluded by these terms and conditions to the fullest extent that they may be excluded by law.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('7.2 We make no warranty that the website is free from infection by viruses or anything else that has contaminating or destructive properties.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('7.3 We will not be liable for any damages (including without limitation, damages for loss of profits) arising in contract, tort or otherwise from your use or inability to use the site or any content or from any action taken (or refrained from being taken) as a result of using the site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('7.4 Although every effort has been made to ensure the accuracy of information on this site, neither we, nor any of our employees, suppliers or users make any warranty, expressed or implied, or assume any legal liability (to the fullest extent permitted by law) or responsibility for the accuracy or completeness of any information contained on the site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('7.5 The site contains material and posts submitted by third parties to us. Such third parties are responsible for ensuring that material submitted for inclusion on the site is subject to these terms and conditions. We do not accept liability in respect of any posts or material submitted by third parties.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('7.6 Every effort is made to ensure that this site is accessed and used only by professional mechanics of the motor trade. However we strongly advise that you check and test any recommendations made as to their suitability for your vehicle & purpose before final implementation.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('7.7 We reserve the right to revise the site or withdraw access to part or all of it at any time.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('Privacy Policy',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('8.1 You acknowledge and agree to be bound by the terms of our privacy policy. A copy of which can be found below.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('Changes to these Terms and Conditions',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('9.1 From time to time we may change these terms and conditions. It is your responsibility to refer to our terms and conditions on a regular basis. By accessing the site you are agreeing to be bound by the terms and conditions as varied or amended from time to time.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('Database theft',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('10.1 Our database is protected by law. The establishment of our database has involved, and its maintenance and development continues to involve, extensive work, including the collection of raw data, the design of the database, the selection and verification of data for inclusion in the database and the insertion and arrangement of selected data in the database. The cost of establishing the database and of continuing to obtain, verify and present its contents is considerable.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('10.2 No permission to copy, reproduce, modify or download the site (or any part of it) is given.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('10.3 We put you on notice that we will instruct our Solicitors to bring an action against you for any unauthorised use of the data on the site. Such unauthorised use includes, but is not limited to, the copying of the content, the extraction and/or re-utilisation of the whole or of a part, of the contents of the database and utilising the same whether acting by yourself, your servants, agents, associated companies, or otherwise howsoever and (to the extent permitted by law) in another site or similar portal that serves the motor trade or sites of similar functionality.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('External links and banner Advertisements',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('11.1 Where this site is hypertext linked to any site operated by any third party, we accept no responsibility or liability arising in respect of any content on such a site. When You access any other site from the site you understand that it is independent from the site and that we have no control over the content or availability of that site. The inclusion of a hypertext link on the site to any other site does not mean that we endorse or accept any responsibility for the content, or the use of, such a site and we shall not be liable for any loss or damage caused or alleged to be caused by or in connection with use of or reliance on any content, goods, services available on or through any other site or resource.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('11.2 Third party banner advertisements, pop-up advertisements and other virtual advertising may be experienced whilst browsing the site. Such third party advertisements may not have been approved by us and may appear on the site without our knowledge or consent, and we accept no responsibility or liability in respect of the content or display of any such third party advertisements.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('11.3 We do not permit any links to be made to the website without our written permission.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('Trademarks and Copyright',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('12.1 The word or mark "Surefix" however represented, including stylised representations, all associated logos and symbols, and combinations of any of the foregoing with another word or mark, used on the site, are the trade marks of Surefix AI Limited or one of its associated companies.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('12.2 The trade marks, domain name www.surefixai.co.uk  and copyright in the site and its materials, including the database are the property of Surefix AI Limited unless otherwise stated.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('General',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('13.1 If any part of these terms and conditions is unenforceable (including any provision in which we exclude or limit our liability) the enforceability of any other part of these conditions will not be affected.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('13.2 Except for our directors, employees or representatives, a person who is not a party to this agreement has no right under the Contracts (Rights of Third Parties) Act 1999 to enforce these terms and conditions but this does not affect any right or remedy of a third party that exists or is available apart from that Act.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('13.3 These terms and conditions shall be governed by and construed in accordance with English law and the English courts shall have jurisdiction to resolve any disputes between us.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('13.4 These terms and conditions, together with our privacy policy, set out the whole of our agreement relating to your use of the site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('13.5 Failure by either party to exercise any right or remedy under these terms and conditions does not constitute a waiver of that right or remedy.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('13.6 You may contact us in the case of queries by email to admin@surefixai.co.uk or by post to Our place of business at Surefix AI Ltd , 74 Dukes Brow, Blackburn BB2 6DH',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('Privacy Policy ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('This Privacy Policy sets out the data processing practices carried out through the use of the Internet and any other electronic communications networks by Surefix. If you have any requests concerning your personal information or any queries with regard to these practices please contact us at admin@surefixai.co.uk ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('Information Collected',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('1.1 We collect personal information from users of the site through the use of our online information request and every time you email us your details. We also collect information about the pages of the site you visit.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('1.2 Our Websites registration form requires users to give us contact and personal information (like their name and email address). We use customer contact information from the registration form to send the user information about our company, to contact the user when necessary and is also used to send you advertisements compiled by other users registered with us.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('Information Collected',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('1.3 We collect information automatically about your visit to the site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2. Use of Personal Information',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  SizedBox(height: 8,),
                                  Text('2.1 We process personal information collected via the site for the purposes of: ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.1.1 providing and personalising our services;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.1.2 dealing with your inquiries and requests;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.1.3 administering orders and accounts relating to our suppliers or customers;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.1.4 maintaining information as a reference tool or general resource;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.1.5 carrying out market research campaigns;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.1.6 providing you with information about our services.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('2.2 Please send us an email to admin@Surefixai.co.uk clearly marked "Unsubscribe" if you do not wish to receive information about our services. ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.3 Your details are not displayed or released to other users of our system, neither do we release them to external third parties (non Surefix Subscribers) (except where legally obliged to do so). ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('2.4 The site gives users the option to remove their information from our database and prevent future communications or to no longer receive our services. You can send email to admin@Surefixai.co.uk clearly marked "Unsubscribe" or you can send mail to the following postal address: Surefix AI Ltd 74 Dukes Brow, Blackburn, BB2 6DH and supply sufficient details for us to positively identify your account.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('3. Use of Cookies',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('3.1 We use cookies to keep track of your progress and information entered by you, as you navigate through the site. We use cookies to deliver content specific to your interests based on information which you have entered and to save your password so you do not have to re-enter it for each page you visit. Because our security relies on cookies, the site will not allow you to log in with this facility disabled. We use "per-session" cookies which means that we do not continue to monitor them after you have left our site and you are not obliged to retain them on your computer once you have left our site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('4. Other websites and mobile Apps (referred to as site/s)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text(' 4.1 Any sites which are linked from the site are outside our control and are not covered by this Privacy Policy. If you access other sites using the links provided, the operators of these sites may collect information from you which will be used by them in accordance with their privacy policy, which may differ from ours.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('5. Access right',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('5.1 You have a right to access the personal data held about you. To obtain a copy of the information we hold about you, please write to us at: Surefix AI Ltd, 74 Dukes Brow BB2 6DH with  a cheque in the sum of £10.00 payable to Surefix AI Limited',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  Text('5.2 The site gives users the following options for changing and modifying information previously provided. You can either logon to our  site using your username and password or send an email to support@surefixai.co.uk  or you can send mail to the postal address above. ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('6. Internet-based transfers',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('6.1 Given that the Internet is a global environment, using the Internet to collect and process personal data necessarily involves the transmission of data on an international basis. Therefore, by using the site and communicating electronically with us, you acknowledge and agree to our processing of personal data in this way. ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
                                  SizedBox(height: 8,),
                                  Text('7. Queries',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                  Text('7.1 If you have any questions about this privacy statement, the practices of the site, or your dealings with this site, you can send email to admin@surefixai.co.uk  or you can send mail to the following postal address: Surefix AI Ltd 74 Dukes Brow, Blackburn, BB2 6DH and supply sufficient details for us to positively identify your account.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),

                                  const SizedBox(height: 10,),
                                  Row(children: [
                                    SizedBox(
                                      width: Responsive.screenWidth*.80,
                                      height: 50,
                                      child:
                                      CheckboxListTile(
                                          value: isChecked ,
                                          title: const Text("I have read the T&C"),
                                          activeColor: Colors.black,
                                          onChanged: (onChanged){
                                            setState(() {
                                              isChecked = !isChecked;

                                            });
                                          }

                                      ),
                                    ),
                                  ],),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
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
   return DropdownButtonFormField(
       icon: const Icon(Icons.arrow_drop_down),
       value: dropdownValue,
       decoration: const InputDecoration(
         border: OutlineInputBorder(
             borderSide: BorderSide(
               width: .5,
               color:Colors.grey,
             )
         ),
         enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(
               width: .5,
               color:Colors.grey,
             )
         ),
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

       });
  }
  /*Widget specialistDropDownButtons(){
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
  }*/
  Widget multiSpecialistDropDownButtons(){
    return SizedBox(
      width: Responsive.screenWidth*.85,
      child: MultiSelectDropDown(

        clearIcon: const Icon(Icons.clear),
        controller: controller,
        onOptionSelected: (options) {
          print(options.toString());
          selectedOption.clear();
          setState(() {
            for(var i=0;i< controller.selectedOptions.length;i++){
              selectedOption.add(controller.selectedOptions[i].value);
            }
          });
          print('s:${selectedOption.toString()}');

        },
        borderColor: Colors.black,
        borderRadius: 4,
        focusedBorderWidth: 2,
        options: const <ValueItem>[
          ValueItem(label: 'Abarth', value: 'Abarth'),
          ValueItem(label: 'AC', value: 'AC'),
          ValueItem(label: 'Aixam', value: 'Aixam'),
          ValueItem(label: 'AK', value: 'AK'),
          ValueItem(label: 'Alfa Romeo', value: 'Alfa Romeo'),
          ValueItem(label: 'Alpine', value: 'Alpine'),
          ValueItem(label: 'Ariel', value: 'Ariel'),
          ValueItem(label: 'Aston Martin', value: 'Aston Martin'),
          ValueItem(label: 'Auburn', value: 'Auburn'),
          ValueItem(label: 'Audi', value: 'Audi'),
          ValueItem(label: 'Austin', value: 'Austin'),
          ValueItem(label: 'Beauford', value: 'Beauford'),
          ValueItem(label: 'Bentley', value: 'Bentley'),
          ValueItem(label: 'BMW', value: 'BMW'),
          ValueItem(label: 'Bristol', value: 'Bristol'),
          ValueItem(label: 'Bugatti', value: 'Bugatti'),
          ValueItem(label: 'Buick', value: 'Buick'),
          ValueItem(label: 'BYD', value: 'BYD'),
          ValueItem(label: 'Cadillac', value: 'Cadillac'),
          ValueItem(label: 'Caterham', value: 'Caterham'),
          ValueItem(label: 'Chesil', value: 'Chesil'),
          ValueItem(label: 'Chevrolet', value: 'Chevrolet'),
          ValueItem(label: 'Chrysler', value: 'Chrysler'),
          ValueItem(label: 'Citroen', value: 'Citroen'),
          ValueItem(label: 'Corvette', value: 'Corvette'),
          ValueItem(label: 'CUPRA', value: 'CUPRA'),
          ValueItem(label: 'Custom Vehicle', value: 'Custom Vehicle'),
          ValueItem(label: 'Dacia', value: 'Dacia'),
          ValueItem(label: 'Daewoo', value: 'Daewoo'),
          ValueItem(label: 'Daihatsu', value: 'Daihatsu'),
          ValueItem(label: 'Daimler', value: 'Daimler'),
          ValueItem(label: 'Datsun', value: 'Datsun'),
          ValueItem(label: 'Dax', value: 'Dax'),
          ValueItem(label: 'De Tomaso', value: 'De Tomaso'),
          ValueItem(label: 'DFSK', value: 'DFSK'),
          ValueItem(label: 'Dodge', value: 'Dodge'),
          ValueItem(label: 'DS AUTOMOBILES', value: 'DS AUTOMOBILES'),
          ValueItem(label: 'Ferrari', value: 'Ferrari'),
          ValueItem(label: 'Fiat', value: 'Fiat'),
          ValueItem(label: 'Fisker', value: 'Fisker'),
          ValueItem(label: 'Ford', value: 'Ford'),
          ValueItem(label: 'Gardner Douglas', value: 'Gardner Douglas'),
          ValueItem(label: 'Genesis', value: 'Genesis'),
          ValueItem(label: 'GMC', value: 'GMC'),
          ValueItem(label: 'Great Wall', value: 'Great Wall'),
          ValueItem(label: 'GWM ORA', value: 'GWM ORA'),
          ValueItem(label: 'Hillman', value: 'Hillman'),
          ValueItem(label: 'Honda', value: 'Honda'),
          ValueItem(label: 'Hummer', value: 'Hummer'),
          ValueItem(label: 'Hyundai', value: 'Hyundai'),
          ValueItem(label: 'INEOS', value: 'INEOS'),
          ValueItem(label: 'Infiniti', value: 'Infiniti'),
          ValueItem(label: 'Isuzu',value: 'Isuzu'),
          ValueItem(label: 'Jaguar',value: 'Jaguar'),
          ValueItem(label: 'Jeep',value: 'Jeep'),
          ValueItem(label: 'Jensen',value: 'Jensen'),
          ValueItem(label: 'KGM',value: 'KGM'),
          ValueItem(label: 'Kia',value: 'Kia'),
          ValueItem(label: 'KTM',value: 'KTM'),
          ValueItem(label: 'Lada' ,value: 'Lada'),
          ValueItem(label: 'Lamborghini',value: 'Lamborghini'),
          ValueItem(label: 'Lancia',value: 'Lancia'),
          ValueItem(label: 'Land Rover',value: 'Land Rover'),
          ValueItem(label: 'LEVC',value: 'LEVC'),
          ValueItem(label: 'Lexus' ,value: 'Lexus'),
          ValueItem(label: 'Leyland',value: 'Leyland'),
          ValueItem(label: 'Ligier',value: 'Ligier'),
          ValueItem(label: 'Lincoln',value: 'Lincoln'),
          ValueItem(label: 'Lister',value: 'Lister'),
          ValueItem(label: 'Locust',value: 'Locust'),
          ValueItem(label: 'London Taxis International',value: 'London Taxis International'),
          ValueItem(label: 'Lotus',value: 'Lotus'),
          ValueItem(label: 'Mahindra',value: 'Mahindra'),
          ValueItem(label: 'Marcos',value: 'Marcos'),
          ValueItem(label: 'Maserati',value: 'Maserati'),
          ValueItem(label: 'MAXUS',value: 'MAXUS'),
          ValueItem(label: 'Maybach',value: 'Maybach'),
          ValueItem(label: 'Mazda',value: 'Mazda'),
          ValueItem(label: 'McLaren',value: 'McLaren'),
          ValueItem(label: 'Mercedes-Benz',value: 'Mercedes-Benz'),
          ValueItem(label: 'Mercury',value: 'Mercury'),
          ValueItem(label: 'MEV',value: 'MEV'),
          ValueItem(label: 'MG',value: 'MG'),
          ValueItem(label: 'MINI',value: 'MINI'),
          ValueItem(label: 'Mitsubishi',value: 'Mitsubishi'),
          ValueItem(label: 'Mitsuoka',value: 'Mitsuoka'),
          ValueItem(label: 'MOKE',value: 'MOKE'),
          ValueItem(label: 'Morgan',value: 'Morgan'),
          ValueItem(label: 'Morris',value: 'Morris'),
          ValueItem(label: 'Nardini',value: 'Nardini'),
          ValueItem(label: 'NG',value: 'NG'),
          ValueItem(label: 'Nissan',value: 'Nissan'),
          ValueItem(label: 'Noble',value: 'Noble'),
          ValueItem(label: 'Omoda',value: 'Omoda'),
          ValueItem(label: 'Opel',value: 'Opel'),
          ValueItem(label: 'Pagani',value: 'Pagani'),
          ValueItem(label: 'Perodua',value: 'Perodua'),
          ValueItem(label: 'Peugeot',value: 'Peugeot'),
          ValueItem(label: 'PGO',value: 'PGO'),
          ValueItem(label: 'Pilgrim',value: 'Pilgrim'),
          ValueItem(label: 'Plymouth',value: 'Plymouth'),
          ValueItem(label: 'Polaris',value: 'Polaris'),
          ValueItem(label: 'Polestar',value: 'Polestar'),
          ValueItem(label: 'Pontiac',value: 'Pontiac'),
          ValueItem(label: 'Porsche',value: 'Porsche'),
          ValueItem(label: 'Proton',value: 'Proton'),
          ValueItem(label: 'Radical',value: 'Radical'),
          ValueItem(label: 'Rage',value:' Rage'),
          ValueItem(label: 'Reliant',value: 'Reliant'),
          ValueItem(label: 'Renault',value:' Renault'),
          ValueItem(label: 'Replica',value: 'Replica'),
          ValueItem(label: 'Robin Hood',value: 'Robin Hood'),
          ValueItem(label: 'Rolls-Royce',value: 'Rolls-Royce'),
          ValueItem(label: 'Rover',value: 'Rover'),
          ValueItem(label: 'Royale',value: 'Royale'),
          ValueItem(label: 'Saab',value: 'Saab'),
          ValueItem(label: 'SEAT',value: 'SEAT'),
          ValueItem(label: 'Sebring',value: 'Sebring'),
          ValueItem(label: 'Shelby',value: 'Shelby'),
          ValueItem(label: 'Singer',value: 'Singer'),
          ValueItem(label: 'Skoda',value: 'Skoda'),
          ValueItem(label: 'Smart',value: 'Smart'),
          ValueItem(label: 'SsangYong',value: 'SsangYong'),
          ValueItem(label: 'Subaru',value: 'Subaru'),
          ValueItem(label:' Sunbeam',value: 'Sunbeam'),
          ValueItem(label: 'Suzuki',value: 'Suzuki'),
          ValueItem(label: 'Tesla',value: 'Tesla'),
          ValueItem(label:' Tiger',value: 'Tiger'),
          ValueItem(label:'Toyota',value: 'Toyota'),
          ValueItem(label: 'Triumph',value: 'Triumph'),
          ValueItem(label: 'TVR',value: 'TVR'),
          ValueItem(label: 'Ultima',value: 'Ultima'),
          ValueItem(label: 'Vauxhall',value: 'Vauxhall'),
          ValueItem(label: 'Volkswagen',value: 'Volkswagen'),
          ValueItem(label: 'Volvo',value: 'Volvo'),
          ValueItem(label:' Westfield', value: 'Westfield'),
          ValueItem(label: 'Zenos',value: 'Zenos'),




        ],
        maxItems: 3,
        hint: 'Select specialist makes',
        hintStyle: const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500),
        selectionType: SelectionType.multi,
        chipConfig: const ChipConfig(wrapType: WrapType.scroll),
        dropdownHeight: 300,
        optionTextStyle: const TextStyle(fontSize: 16),
        selectedOptionIcon: const Icon(Icons.check_circle),

      ),
    );

  }
  Widget specialistDropDownButtons(){
    return SizedBox(
      width: Responsive.screenWidth*.85,
      child: MultiSelectDropDown(

        clearIcon: const Icon(Icons.clear),
        controller: multiController,
        onOptionSelected: (options) {
          print(options.toString());
          selectedOption.clear();
          setState(() {
            for(var i=0;i< multiController.selectedOptions.length;i++){
              selectedOption.add(controller.selectedOptions[i].value);
            }
          });
          print('s:${selectedOption.toString()}');

        },
        borderColor: Colors.black,
        borderRadius: 4,
        focusedBorderWidth: 2,
        options: const <ValueItem>[
          ValueItem(label: 'Abarth', value: 'Abarth'),
          ValueItem(label: 'AC', value: 'AC'),
          ValueItem(label: 'Aixam', value: 'Aixam'),
          ValueItem(label: 'AK', value: 'AK'),
          ValueItem(label: 'Alfa Romeo', value: 'Alfa Romeo'),
          ValueItem(label: 'Alpine', value: 'Alpine'),
          ValueItem(label: 'Ariel', value: 'Ariel'),
          ValueItem(label: 'Aston Martin', value: 'Aston Martin'),
          ValueItem(label: 'Auburn', value: 'Auburn'),
          ValueItem(label: 'Audi', value: 'Audi'),
          ValueItem(label: 'Austin', value: 'Austin'),
          ValueItem(label: 'Beauford', value: 'Beauford'),
          ValueItem(label: 'Bentley', value: 'Bentley'),
          ValueItem(label: 'BMW', value: 'BMW'),
          ValueItem(label: 'Bristol', value: 'Bristol'),
          ValueItem(label: 'Bugatti', value: 'Bugatti'),
          ValueItem(label: 'Buick', value: 'Buick'),
          ValueItem(label: 'BYD', value: 'BYD'),
          ValueItem(label: 'Cadillac', value: 'Cadillac'),
          ValueItem(label: 'Caterham', value: 'Caterham'),
          ValueItem(label: 'Chesil', value: 'Chesil'),
          ValueItem(label: 'Chevrolet', value: 'Chevrolet'),
          ValueItem(label: 'Chrysler', value: 'Chrysler'),
          ValueItem(label: 'Citroen', value: 'Citroen'),
          ValueItem(label: 'Corvette', value: 'Corvette'),
          ValueItem(label: 'CUPRA', value: 'CUPRA'),
          ValueItem(label: 'Custom Vehicle', value: 'Custom Vehicle'),
          ValueItem(label: 'Dacia', value: 'Dacia'),
          ValueItem(label: 'Daewoo', value: 'Daewoo'),
          ValueItem(label: 'Daihatsu', value: 'Daihatsu'),
          ValueItem(label: 'Daimler', value: 'Daimler'),
          ValueItem(label: 'Datsun', value: 'Datsun'),
          ValueItem(label: 'Dax', value: 'Dax'),
          ValueItem(label: 'De Tomaso', value: 'De Tomaso'),
          ValueItem(label: 'DFSK', value: 'DFSK'),
          ValueItem(label: 'Dodge', value: 'Dodge'),
          ValueItem(label: 'DS AUTOMOBILES', value: 'DS AUTOMOBILES'),
          ValueItem(label: 'Ferrari', value: 'Ferrari'),
          ValueItem(label: 'Fiat', value: 'Fiat'),
          ValueItem(label: 'Fisker', value: 'Fisker'),
          ValueItem(label: 'Ford', value: 'Ford'),
          ValueItem(label: 'Gardner Douglas', value: 'Gardner Douglas'),
          ValueItem(label: 'Genesis', value: 'Genesis'),
          ValueItem(label: 'GMC', value: 'GMC'),
          ValueItem(label: 'Great Wall', value: 'Great Wall'),
          ValueItem(label: 'GWM ORA', value: 'GWM ORA'),
          ValueItem(label: 'Hillman', value: 'Hillman'),
          ValueItem(label: 'Honda', value: 'Honda'),
          ValueItem(label: 'Hummer', value: 'Hummer'),
          ValueItem(label: 'Hyundai', value: 'Hyundai'),
          ValueItem(label: 'INEOS', value: 'INEOS'),
          ValueItem(label: 'Infiniti', value: 'Infiniti'),
          ValueItem(label: 'Isuzu',value: 'Isuzu'),
          ValueItem(label: 'Jaguar',value: 'Jaguar'),
          ValueItem(label: 'Jeep',value: 'Jeep'),
          ValueItem(label: 'Jensen',value: 'Jensen'),
          ValueItem(label: 'KGM',value: 'KGM'),
          ValueItem(label: 'Kia',value: 'Kia'),
          ValueItem(label: 'KTM',value: 'KTM'),
          ValueItem(label: 'Lada' ,value: 'Lada'),
          ValueItem(label: 'Lamborghini',value: 'Lamborghini'),
          ValueItem(label: 'Lancia',value: 'Lancia'),
          ValueItem(label: 'Land Rover',value: 'Land Rover'),
          ValueItem(label: 'LEVC',value: 'LEVC'),
          ValueItem(label: 'Lexus' ,value: 'Lexus'),
          ValueItem(label: 'Leyland',value: 'Leyland'),
          ValueItem(label: 'Ligier',value: 'Ligier'),
          ValueItem(label: 'Lincoln',value: 'Lincoln'),
          ValueItem(label: 'Lister',value: 'Lister'),
          ValueItem(label: 'Locust',value: 'Locust'),
          ValueItem(label: 'London Taxis International',value: 'London Taxis International'),
          ValueItem(label: 'Lotus',value: 'Lotus'),
          ValueItem(label: 'Mahindra',value: 'Mahindra'),
          ValueItem(label: 'Marcos',value: 'Marcos'),
          ValueItem(label: 'Maserati',value: 'Maserati'),
          ValueItem(label: 'MAXUS',value: 'MAXUS'),
          ValueItem(label: 'Maybach',value: 'Maybach'),
          ValueItem(label: 'Mazda',value: 'Mazda'),
          ValueItem(label: 'McLaren',value: 'McLaren'),
          ValueItem(label: 'Mercedes-Benz',value: 'Mercedes-Benz'),
          ValueItem(label: 'Mercury',value: 'Mercury'),
          ValueItem(label: 'MEV',value: 'MEV'),
          ValueItem(label: 'MG',value: 'MG'),
          ValueItem(label: 'MINI',value: 'MINI'),
          ValueItem(label: 'Mitsubishi',value: 'Mitsubishi'),
          ValueItem(label: 'Mitsuoka',value: 'Mitsuoka'),
          ValueItem(label: 'MOKE',value: 'MOKE'),
          ValueItem(label: 'Morgan',value: 'Morgan'),
          ValueItem(label: 'Morris',value: 'Morris'),
          ValueItem(label: 'Nardini',value: 'Nardini'),
          ValueItem(label: 'NG',value: 'NG'),
          ValueItem(label: 'Nissan',value: 'Nissan'),
          ValueItem(label: 'Noble',value: 'Noble'),
          ValueItem(label: 'Omoda',value: 'Omoda'),
          ValueItem(label: 'Opel',value: 'Opel'),
          ValueItem(label: 'Pagani',value: 'Pagani'),
          ValueItem(label: 'Perodua',value: 'Perodua'),
          ValueItem(label: 'Peugeot',value: 'Peugeot'),
          ValueItem(label: 'PGO',value: 'PGO'),
          ValueItem(label: 'Pilgrim',value: 'Pilgrim'),
          ValueItem(label: 'Plymouth',value: 'Plymouth'),
          ValueItem(label: 'Polaris',value: 'Polaris'),
          ValueItem(label: 'Polestar',value: 'Polestar'),
          ValueItem(label: 'Pontiac',value: 'Pontiac'),
          ValueItem(label: 'Porsche',value: 'Porsche'),
          ValueItem(label: 'Proton',value: 'Proton'),
          ValueItem(label: 'Radical',value: 'Radical'),
          ValueItem(label: 'Rage',value:' Rage'),
          ValueItem(label: 'Reliant',value: 'Reliant'),
          ValueItem(label: 'Renault',value:' Renault'),
          ValueItem(label: 'Replica',value: 'Replica'),
          ValueItem(label: 'Robin Hood',value: 'Robin Hood'),
          ValueItem(label: 'Rolls-Royce',value: 'Rolls-Royce'),
          ValueItem(label: 'Rover',value: 'Rover'),
          ValueItem(label: 'Royale',value: 'Royale'),
          ValueItem(label: 'Saab',value: 'Saab'),
          ValueItem(label: 'SEAT',value: 'SEAT'),
          ValueItem(label: 'Sebring',value: 'Sebring'),
          ValueItem(label: 'Shelby',value: 'Shelby'),
          ValueItem(label: 'Singer',value: 'Singer'),
          ValueItem(label: 'Skoda',value: 'Skoda'),
          ValueItem(label: 'Smart',value: 'Smart'),
          ValueItem(label: 'SsangYong',value: 'SsangYong'),
          ValueItem(label: 'Subaru',value: 'Subaru'),
          ValueItem(label:' Sunbeam',value: 'Sunbeam'),
          ValueItem(label: 'Suzuki',value: 'Suzuki'),
          ValueItem(label: 'Tesla',value: 'Tesla'),
          ValueItem(label:' Tiger',value: 'Tiger'),
          ValueItem(label:'Toyota',value: 'Toyota'),
          ValueItem(label: 'Triumph',value: 'Triumph'),
          ValueItem(label: 'TVR',value: 'TVR'),
          ValueItem(label: 'Ultima',value: 'Ultima'),
          ValueItem(label: 'Vauxhall',value: 'Vauxhall'),
          ValueItem(label: 'Volkswagen',value: 'Volkswagen'),
          ValueItem(label: 'Volvo',value: 'Volvo'),
          ValueItem(label:' Westfield', value: 'Westfield'),
          ValueItem(label: 'Zenos',value: 'Zenos'),




        ],
        maxItems: 3,
        hint: 'Select specialist makes',
        hintStyle: const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500),
        selectionType: SelectionType.multi,
        chipConfig: const ChipConfig(wrapType: WrapType.scroll),
        dropdownHeight: 300,
        optionTextStyle: const TextStyle(fontSize: 16),
        selectedOptionIcon: const Icon(Icons.check_circle),

      ),
    );

  }
}