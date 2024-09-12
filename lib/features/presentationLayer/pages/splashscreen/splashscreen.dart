import 'dart:async';

import 'package:flutter/material.dart';
import "dart:math" show pi;
import '../homepage/homepage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double>animation;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds:3 ),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homepage()));
    });
    controller = AnimationController(vsync: this,duration: const Duration(seconds: 3));
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();

  }
final double pi = 3.1415926535897932;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 300,
                color:Colors.white,

                child: Image.asset('assets/animations/SurefixAICarAnimation.gif')),
          ),
        ],
      ),
    );
  }
}
