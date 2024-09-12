
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../config/colors/colors.dart';
import '../../../../core/conostants/responsivescreen.dart';
import '../../widget/other/snackbars.dart';



class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  void initState() {
    super.initState();
  }


  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$',);
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() == true) {
     // emailSend(context: context);
     /* Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PinCodeVerifyScreen(),
        ),
      );*/
    }else{
      SnackBars.showSnackBar(
          context: context,
          content: 'please enter your email address',
          durationSec: 3,
          success: false,
          routeAction: null);
    }
  }

  @override
  void dispose() {
    emailController.clear();
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
                Text('Your Email Address',
                    style: theme.textTheme.titleLarge),
                const Gap(5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'A 4 digits verification code will be sent to your email address',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                const Gap(16),
                TextFormField(
                  controller:emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                  const InputDecoration(hintText: 'Enter your email'),
                  validator: _validateEmail,
                ),
                const Gap(24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _submit();
                    },
                    child: const Text('Verify Email'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
