import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../../../config/colors/colors.dart';
import '../../../../core/conostants/responsivescreen.dart';
import '../../../../core/util/images.dart';
import 'homepage.dart';



class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.setScreenSize(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title: const Text('About Us',style: TextStyle(color: Colors.white)),
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
      ) ,

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: const Center(
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                    shadowColor: Colors.red,
                    child: Text('Surefix designed by mechanics for mechanics',textAlign: TextAlign.center,maxLines: 2,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25),)),
              ),
            ),
            const Gap(15),
            Container(
              color: Colors.white,
              child: const Padding(padding: EdgeInsets.all(10.0),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text('Our focus is on addressing the number one headache for both car owners and workshops,',maxLines:3,textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
                  Text('diagnostic fault code fixes.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                  SizedBox(height: 10,),
                  Text('Providing a confirmed first time fix means more satisfied customers and more profitable workshops.',textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
                  SizedBox(height: 10,),
                  Text('Our mobile app is quick and easy to use, utilising Advanced Artificial Intelligence to provide easy to use solutions for vehicle diagnostic, and repairs. Surefix AI uses repair information from millions of repair documents, and mechanic submitted confirmed fixes that provide a way to quickly diagnose fault codes and repair cars.',textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
                  SizedBox(height: 10,),
                  Text('If our AI technology doesn’t resolve your problem, you can chat directly with professional mechanics with specialist experience and diagnostic fault finding knowledge with your car using our CI (Collaborative Intelligence) technology. Our unique CI technology provides mechanic to mechanic support so you can chat directly with someone who are expert of your exact fault and has fixed it.',textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
                  SizedBox(height: 10,),
                  Text('Take advantage of our free trial offer and use Surefix AI free for 90 days.',textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                ],
              ),
              )
            )
          ],
        ),
      ),

    );
  }
}
