
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../config/colors/colors.dart';
import '../../../../core/conostants/responsivescreen.dart';
import '../../widget/other/snackbars.dart';
import '../loginpage/loginpage.dart';
import 'reset_password_screen.dart';

class PinCodeVerifyScreen extends StatefulWidget {
  const PinCodeVerifyScreen({super.key});

  @override
  State<PinCodeVerifyScreen> createState() => _PinCodeVerifyScreenState();
}

class _PinCodeVerifyScreenState extends State<PinCodeVerifyScreen> {
  final TextEditingController _pinCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _correctPin = '1234';


  String? _validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN cannot be empty';
    }
    if (value.length != 4) { // Assuming the PIN length is 4
      return 'PIN must be 4 digits';
    }
    /*if (value == _correctPin) {
      return 'Incorrect PIN';
    }*/
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        ),
      );
    }else{
      SnackBars.showSnackBar(
          context: context,
          content: 'please enter confirm pin',
          durationSec: 3,
          success: false,
          routeAction: null);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pinCodeController.clear();
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
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Gap(100),
                Text('Pin Verification', style: theme.textTheme.titleLarge),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    autoDisposeControllers: false,
                    controller: _pinCodeController,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    validator: _validatePin,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 45,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.black87,
                      selectedFillColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    backgroundColor: Colors.transparent,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
                const Gap(24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _submit();
                    },
                    child: const Text('Verify Code'),
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
