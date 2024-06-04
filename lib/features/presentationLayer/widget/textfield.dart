import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFields extends StatelessWidget{
  final TextEditingController controller;
  final String hint;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final BorderSide? enabledBorderSide;
  final BorderSide? focusedBorderSide;
  final String? Function(String) validators;
  final Widget? suffixIcon;
  final bool? obscureText;

  const TextFields({super.key, required this.hint,  this.minLines,
     this.maxLines, required this.keyboardType, this.enabledBorderSide,
    required this.controller,this.focusedBorderSide, this.maxLength, this.suffixIcon,
    this.obscureText=false, required this.validators, });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText!,
      controller: controller,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderSide: enabledBorderSide!
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: focusedBorderSide!
        ),
        hintText: hint,

      ),

    );

  }

}