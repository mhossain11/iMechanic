
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../config/colors/colors.dart';
import '../../../../core/conostants/responsivescreen.dart';
import '../../widget/other/snackbars.dart';
import '../loginpage/loginpage.dart';



class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
   final TextEditingController _passwordController = TextEditingController();
   final TextEditingController _retypepasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   String? _validateConfirmPassword(String? value) {
     if (value == null || value.isEmpty) {
       return 'Please confirm your password';
     }
     if (value.length < 6) {
       return 'Password must be at least 6 characters long';
     }
     return null;
   }

   void _submit() {
       if (_formKey.currentState?.validate() == true) {
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) =>  LoginPage(),
           ),
         );
       }else{
         SnackBars.showSnackBar(
             context: context,
             content: 'please enter confirm password',
             durationSec: 3,
             success: false,
             routeAction: null);
       }
   }

  @override
  void dispose() {
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.setScreenSize(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 65,
          //title: const Text("Login"),
          backgroundColor:Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.of(context).pop();

              },
              child: const Icon(Icons.arrow_back,color: themeColor,))
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Gap(100),
                Text('Reset Password', style: theme.textTheme.titleLarge),
                const Gap(5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Password must have 8 letters with number combination',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                const Gap(16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration:
                  const InputDecoration(hintText: 'Your new password'),
                  validator: _validateConfirmPassword,
                ),
                const Gap(24),
                TextFormField(
                  controller: _retypepasswordController,
                  obscureText: true,
                  decoration:
                  const InputDecoration(hintText: 'Re-type Your password'),
                  validator: _validateConfirmPassword,
                ),
                const Gap(24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      _submit();
                    },
                    child: const Text('Reset Password'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>  const LoginPage(),
                            ),
                                //(route) => false,
                          );
                        },
                        child: const Text('Sign In')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
