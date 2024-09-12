import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imechanic/config/colors/colors.dart';
import 'package:imechanic/features/presentationLayer/widget/app_text_style.dart';
import 'package:imechanic/features/presentationLayer/pages/registerpage/yesmechanic.dart';
import 'package:imechanic/features/presentationLayer/widget/buttons.dart';
import '../../../../core/conostants/responsivescreen.dart';
import 'nomechanic.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.setScreenSize(context);
    return Scaffold(
      appBar: AppBar(title: const Text(''),iconTheme: const IconThemeData(
        color: themeColor
      ),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: Text('Are You a Professional mechanic?',style: h3Style,)),
          const Gap(10),
          ElevatedButtons(
            fixedSize:  Size(Responsive.screenWidth * .75,50),
            side: const BorderSide(color:  themeColor),
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const YesMechanic()));
          }, child:const Text('Yes',style: TextStyle(color: Colors.black)) ,
          ),
          const Gap(10),
          ElevatedButtons(
            fixedSize: Size(Responsive.screenWidth * .75,50),
            side: const BorderSide(color:  themeColor),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NoMechanic()));
          }, child: const Text('No',style: TextStyle(color: Colors.black))
          ),

        ],
      ),
    );

  }
}
