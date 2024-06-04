import 'package:flutter/material.dart';
import 'package:imechanic/features/presentationLayer/widget/app_text_style.dart';
import 'package:imechanic/features/presentationLayer/pages/registerpage/yesmechanic.dart';
import 'package:imechanic/features/presentationLayer/widget/buttons.dart';
import 'package:imechanic/features/presentationLayer/widget/dropdownbutton.dart';

import 'nomechanic.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: Text('Are You a Professional mechanic?',style: h3Style,)),
          const SizedBox(height: 10,),
          ElevatedButtons(
            fixedSize: const Size(300,50),
            side: const BorderSide(color: Color(0xffc1262c)),
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const YesMechanic()));
          }, child:const Text('Yes',style: TextStyle(color: Colors.black)) ,
          ),
          const SizedBox(height: 5,),
          ElevatedButtons(
            fixedSize: const Size(300,50),
            side: const BorderSide(color: Color(0xffc1262c)),
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
