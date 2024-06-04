import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositiory/loginrepository.dart';
import '../../bloc/loginbloc/login_bloc.dart';
import '../../widget/buttons.dart';
import '../../widget/textformfield.dart';
import '../dashboard/dashboard.dart';

final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {  

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginBloc loginBloc;

 String? validateEmail(String value){
   if (value.isEmpty|| !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
     return 'Please enter correct email';
   }else{
     return null;
   }
 }
 static validatePassword(String value) {
   if (value.isEmpty) {
     return 'Password is required'.toString();
   } else if (value.length < 5) {
     return 'Password must be at least 8 characters'.toString();
   }
   return null;
 }
 
 @override
  void initState() {
   loginBloc= LoginBloc(LoginRepository(), emailController, passwordController);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffc1262c),
        /*leading:InkWell(
        onTap: () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.pop(context);
    },
    child: Image.asset(Images.backIcon)),*/
    ),
      backgroundColor: const Color(0xffc1262c),
      body: SingleChildScrollView(
        child: Form(
          key:_formKey ,
          child: Column(
            children: [
              const SizedBox(height: 80,),
              Center(
                child: Container(
                  width: 325,
                  height: 380,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius
                      .circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormFields(
                          controller: emailController,
                          hint: 'Email',
                          minLines: 1,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          enabledBorderSide: const BorderSide(color: Colors.grey),
                          focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                          suffixIcon: const Icon(Icons.email),
                          validators: (value) {
                            return  validateEmail(value);

                          },

                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormFields(
                          obscureText: true,
                          controller: emailController,
                          hint: 'Password',
                          minLines: 1,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          enabledBorderSide: const BorderSide(color: Colors.grey),
                          focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                          suffixIcon: const Icon(Icons.visibility),
                          validators: (String value) {
                            return validatePassword(value)== null ?
                            "Please enter your valid password!" : "Invalid";
                          },

                        ),
                      ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                              onTap: (){},
                              child:  const Text('Reset password?',textAlign: TextAlign.end,style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                      BlocListener<LoginBloc, LoginState>(
                        bloc: loginBloc,
                      listener: (context, state) {

                        if (_formKey.currentState!.validate()){
                          if(state is LoginLoadedState){
                            if (state.loginModel.data!.type.toString() == 'mechanic') {
                             /*showToast(
                                  "Signed In successfully!".toString().toUpperCase(),
                                  false, 'center');*/
                           //   Navigator.push(context, SlideRightRoute(page: const MechanicDashboardScreen()));


                            } else {
                              /*ProjectResource.showToast(
                                  "Signed In successfully!".toString().toUpperCase(),
                                  false,
                                  'center');*/
                              print("Signed In successfully!");
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Dashboard()));

                            }
                          }
                          else if(state is LoginErrorState){
                            /*ProjectResource.showToast(
                                "Error!".toString().toUpperCase(),
                                false,
                                'center');*/
                            print('Error!');
                          }
                        }


                       },
                        child: BlocBuilder<LoginBloc, LoginState>(
                        bloc: loginBloc,
                      builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButtons(
                          onPressed: (){
                            loginBloc.add(LoginButtonEvent());

                        },
                          //textStyle: const ,
                          fixedSize: const Size(350, 50),
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child:(state is LoginLoadingState) ? const CircularProgressIndicator(color: Colors.green,):
                          const Text('LogIn',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),


                        ),
                      );
  },
),
)
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
