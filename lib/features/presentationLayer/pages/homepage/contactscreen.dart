import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surefix_ai/views/Dashboard/homepage.dart';

import '../../helpers/ProjectResource.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact us',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: themeColor,
        leading:IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Homepage()));
            //Navigator.of(context).pop();
          },
          icon: Image.asset(Images.backIcon,color: Colors.white,),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          const Text('For technical queries please email',textAlign: TextAlign.center,maxLines: 1,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
          const Text('support@surefixai.co.uk',textAlign: TextAlign.center,maxLines: 2,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
          const SizedBox(height: 10,),
          const Text('For subscription and trial offers please email',textAlign: TextAlign.center,maxLines: 2,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
          const Text('admin@surefixai.co.uk',textAlign: TextAlign.center,maxLines: 2,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
          const SizedBox(height: 20,),
          const Text('We aim to respond to all emails within 24 hours, however due to differing time zones and public holidays, there can occasionally be delays.',textAlign: TextAlign.left,maxLines: 3,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
          const SizedBox(height: 20,),
          SizedBox(
            width: MediaQuery.sizeOf(context).width ,
            height: 200,
            child: const Card(
              //shadowColor: Colors.red,
              color: Colors.white,
              elevation: 0,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text('Surefix AI Ltd',textAlign: TextAlign.center,maxLines: 2,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                  SizedBox(height: 10,),
                  Text('www.surefixai.co.uk',textAlign: TextAlign.center,maxLines: 2,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                  SizedBox(height: 10,),
                  Text('Tel +44 1254 677707',textAlign: TextAlign.center,maxLines: 2,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                  SizedBox(height: 10,),
                  Text('Company registration number 15754497',textAlign: TextAlign.center,maxLines: 2,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                  SizedBox(height: 10,),
                  Text('VAT number (Applied For)',textAlign: TextAlign.center,maxLines: 2,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
