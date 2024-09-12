import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imechanic/config/colors/colors.dart';
import '../../../../core/conostants/responsivescreen.dart';
import '../../widget/buttons.dart';
import '../loginpage/loginpage.dart';
import '../registerpage/registerpage.dart';
import 'aobutusscreen.dart';
import 'contactscreen.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    Responsive.setScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomButton(
                  height: 50,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUsScreen()));
                  },
                  color: Colors.white,
                  child: const Text('About Us',style: TextStyle(color: Colors.grey),)),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: CustomButton(
                  height: 50,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactUsScreen()));
                  },
                  color: Colors.white,
                  child: const Text('Contact Us',style: TextStyle(color: Colors.grey),)),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
          width: Responsive.screenWidth * .75,
          child: Image.asset('assets/images/others/surefix.png',
            fit: BoxFit.fitWidth,),),


          const Gap(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            CustomButton(
              height: 50,
              width: Responsive.screenWidth * .75,
              elevation: 4,
              color: themeColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const RegisterPage()));
              }, child: const Text('Register',style: TextStyle(color: Colors.white),),

            ),
          ],),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButtons(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()));
                  },

                    minimumSize: Size(Responsive.screenWidth * .75, 50),
                    backgroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black,
                    side: const BorderSide(color: themeColor,width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),

                  child: const Text('Log In',style: TextStyle(color: themeColor),))
            ],
          ),
          const Gap(10),


        ],
      ),
    );
  }
}
