import 'package:flutter/material.dart';

import '../../../config/colors/colors.dart';
import '../../../core/conostants/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double? width;
  final double? elevation;
  final double? height;
  final double? radius;
  final Color? color;
  final Color? borderColor;

  const CustomButton(
      {super.key, required this.onPressed,
        required this.child,
        this.width,
        this.elevation,
        this.height,
        this.color,
        this.borderColor,
        this.radius});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: color ?? colorTheme,
      height: height ?? Value.screenHeight * .055,
      minWidth: width ?? Value.screenWidth,

      child: MaterialButton(
        elevation: elevation,
        color: color ?? colorTheme,
        disabledColor: color ?? colorTheme,
        disabledElevation: elevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 10))),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}




class ElevatedButtons extends StatelessWidget{
  final VoidCallback onPressed;
  final Widget child;
  final OutlinedBorder? shape;
  final Size? fixedSize;
  final BorderSide? side;
  final Color? backgroundColor;
   const ElevatedButtons({super.key, required this.onPressed,
     required this.child, this.shape, this.fixedSize, this.side,
     this.backgroundColor,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape,
          fixedSize: fixedSize,
          side: side,
          backgroundColor: backgroundColor
        ),
        child: child);
  }

}