
import 'package:flutter/widgets.dart';

class Responsive {
  static double screenWidth = 0;
  static double screenHeight = 0;
static void setScreenSize(BuildContext context){
     screenWidth = MediaQuery.sizeOf(context).width;
     screenHeight = MediaQuery.sizeOf(context).height;
  }
}